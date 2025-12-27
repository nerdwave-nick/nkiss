Hardware Specific Packages
==========================

| Group   | Component  | Package Name        | Purpose                                                      |
|---------|------------|---------------------|--------------------------------------------------------------|
| General | common     | linux-firmware      | firmware for hardware                                        |
| CPU     | amd cpu    | amd-ucode           | microcode updates for AMD CPUs                               |
|         | intel cpu  | intel-ucode         | microcode updates for Intel CPUs                             |
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

For nvidia GPUs we'll also run a bunch of services to ensure no freezez/crashes on suspend/resume.

Things to do after
------------------

Hardware is very individual, so this won't be a perfect setup. You may need to install thermald for some intel cpus, tlp for others, or if you don't have a laptop you might want to look into other things. TLP will also be useful for battery control on most hardware, but some (for example Acer notebooks) don't work with it. Basically **RTFM**.
