#!/usr/bin/env python3

import subprocess
import re
import sys

RESET = '\033[0m'
RED = '\033[0;31m'
GREEN = '\033[0;32m'
DGREY = '\033[2;37m'


def eprint(*args, **kwargs):
    print(*args, file=sys.stderr, **kwargs)


def print_e(string):
    eprint(f"{RESET}{RED}:: {string}{RESET}")


def print_g(string):
    eprint(f"{RESET}{DGREY}:: {string}{RESET}")


def print_s(string):
    eprint(f"{RESET}{GREEN}:: {string}{RESET}")


# base packages for any system
COMMON_PACKAGES = [
    "linux-firmware",
    "mesa",
    "vulkan-icd-loader",
    "libva",
    "libva-utils"
]


class HardwareDetector:
    def _run_cmd(self, cmd: list) -> str:
        try:
            res = subprocess.run(cmd, capture_output=True, text=True)
            return res.stdout if res.returncode == 0 else ""
        except (subprocess.CalledProcessError):
            return ""

    def get_cpu_microcode(self) -> set:
        """detects cpu vendor for microcode."""
        pkgs = set()
        out = self._run_cmd(["lscpu"]).lower()

        if "genuineintel" in out:
            pkgs.add("intel-ucode")
        elif "authenticamd" in out:
            pkgs.add("amd-ucode")

        return pkgs

    def get_gpu_drivers(self) -> set:
        """detects gpu via lspci hex ids."""
        pkgs = set()

        # lspci -n : Numeric IDs
        # -d ::03xx : Class 03 (Display Controller)
        out = self._run_cmd(["lspci", "-n", "-d", "::03xx"])
        if not out:
            print_e("Failed to run lspci")

        for line in out.splitlines():
            # Format: "00:02.0 0300: 8086:3e92 (rev 00)"
            match = re.search(r'\s([0-9a-fA-F]{4}):([0-9a-fA-F]{4})', line)
            if not match:
                print_e("Failed to parse lspci output")
                continue

            vendor = match.group(1).lower()
            device = match.group(2).lower()

            if vendor == "8086":   # INTEL
                print_g("detected intel gpu")
                self._handle_intel(device, pkgs)
            elif vendor == "10de":  # NVIDIA
                print_g("detected nvidia gpu")
                self._handle_nvidia(device, pkgs)
            elif vendor == "1002":  # AMD
                print_g("detected amd gpu")
                self._handle_amd(device, pkgs)
            else:
                print_e(f"unknown vendor {vendor}")

        return pkgs

    def _handle_intel(self, device_id: str, pkgs: set):
        # 1. ANCIENT (Gen 3/4) - Pre-GMA 4500
        # 25/27 (945G), 29 (G965), 2a (GM965), a0 (Pineview)
        ancient_prefixes = ("25", "27", "29", "2a", "a0")

        # 2. LEGACY SUPPORTED (Gen 4.5 to Gen 7.5) -> i965 Driver
        # 2e (G45/GMA4500), 00 (Ironlake), 01 (Sandy/Ivy), 04/0a/0c/0d (Haswell)
        legacy_prefixes = ("2e", "00", "01", "04", "0a", "0c", "0d")

        if device_id.startswith(ancient_prefixes):
            # aint doing this, do it manually
            print_e("unknown (unsupported?) intel gpu")
            return
        elif device_id.startswith(legacy_prefixes):
            print_g("detected legacy intel gpu")
            pkgs.add("vulkan-intel")
            pkgs.add("libva-intel-driver")
            pkgs.add("libvdpau-va-gl")
        else:
            # modern (gen 8+) -> ihd driver
            print_g("detected modern intel gpu")
            pkgs.add("intel-media-driver")
            pkgs.add("vulkan-intel")
            pkgs.add("libvpl")
            pkgs.add("onevpl-intel-gpu")
            pkgs.add("libvdpau-va-gl")

    def _handle_nvidia(self, device_id: str, pkgs: set):
        # beneficial for wayland/niri
        pkgs.add("egl-wayland")
        pkgs.add("nvidia-utils")
        pkgs.add("nvidia-settings")
        pkgs.add("libva-nvidia-driver")

        # TURING (20xx/16xx) & NEWER -> Open Kernel Modules
        # prefixes: 1e, 1f, 20, 21 (16xx), 22+ (ampere/ada/blackwell)
        # note: gtx 1660 ti is 0x2182
        if device_id.startswith(("1e", "1f")) or device_id[0] != "1":
            print_g("detected modern nvidia gpu")
            pkgs.add("nvidia-open")

        # MAXWELL (9xx) & PASCAL (10xx) -> Proprietary
        # maxwell: 13, 14, 16, 17
        # pascal: 15 (gp100), 1b, 1c, 1d
        elif device_id.startswith(("13", "14", "15", "16", "17", "1b", "1c", "1d")):
            print_g("detected legacy nvidia gpu")
            pkgs.add("nvidia")

        # KEPLER (6xx/7xx) & OLDER -> Legacy (Ignored)
        # IDs: 0*, 10, 11, 12 are ignored.
        else:
            print_e("unknown (ancient?) nvidia gpu")

    def _handle_amd(self, device_id: str, pkgs: set):
        pkgs.add("vulkan-radeon")
        pkgs.add("libva-mesa-driver")
        pkgs.add("mesa-vdpau")
        pkgs.add("libvdpau-va-gl")


if __name__ == "__main__":
    detector = HardwareDetector()
    pkgs = set()

    pkgs.update(COMMON_PACKAGES)

    pkgs.update(detector.get_cpu_microcode())
    pkgs.update(detector.get_gpu_drivers())

    if pkgs:
        print(" ".join(sorted(pkgs)))
