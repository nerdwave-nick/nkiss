Hardware Specific Packages
==========================

| Group   | Component  | Package Name        | Purpose                                                      |
|---------|------------|---------------------|--------------------------------------------------------------|
| General | common     | linux-firmware      | firmware for hardware                                        |
| CPU     | amd cpu    | amd-ucode           | microcode updates for AMD CPUs                               |
|         | intel cpu  | intel-ucode         | microcode updates for Intel CPUs                             |
|         |            | thermald            | intel cpu necessity for temperature control                  |
| GPU     | common     | mesa                | provides OpenGL implementation                               |
|         |            | vulkan-icd-loader   | required to load Vulkan drivers.                             |
|         |            | libva               | provides VAAPI implementation                                |
|         |            | libva-utils         | provides vainfo tool to verify hardware video acceleration.  |
|         | intel gpu  | intel-media-driver  | modern hardware video acceleration (VAAPI).                  |
|         |            | vulkan-intel        | vulkan implementation for intel gpus                         |
|         |            | libva-intel-driver  | older hardware video acceleration (GMA4500-Haswell).         |
|         |            | libva-vdpau-driver  | bridge to run VDPAU apps on Intel hardware.                  |
|         | nvidia gpu | nvidia-utils        | nvidia necessity for everything more or less                 |
|         |            | nvidia-open         | open-source userspace driver for modern GPUs                 |
|         |            | nvidia              | proprietary userspace driver for legacy GPUs                 |
|         |            | nvidia-settings     | configuration tool (fan curves, etc.)                        |
|         |            | egl-wayland         | buffer management for wayland compositors on nvidia          |
|         |            | libva-nvidia-driver | translator layer allowing nvidia to use VAAPI (firefox/apps) |
|         | amd gpu    | vulkan-radeon       | the radeon vulkan driver                                     |
|         |            | libva-mesa-driver   | standard mesa vaapi implementation for amd                   |
|         |            | mesa-vdpau          | standard vdpau implementation                                |

Additional Notes
----------------

For thermald, we also need to run `systemctl enable thermald.service` to start it at boot.

For nvidia GPUs we'll also run a bunch of services to ensure no freezez/crashes on suspend/resume.
