No Volume Warnings — Pixel 10 / KernelSU
=======================================

Release ZIP
-----------

Install only this package:

NoVolumeWarning-LightningZahah.zip

What it does
------------

This module disables Android's high-volume / safe-media-volume warning on Pixel 10.
It installs a static framework overlay at:

system/product/overlay/NoVolumeWarnings.apk

KernelSU installation
---------------------

1. Download NoVolumeWarning-LightningZahah.zip to your phone.
2. Open the KernelSU app.
3. Open Modules.
4. Tap Install from storage.
5. Select NoVolumeWarning-LightningZahah.zip.
6. Wait for installation to finish.
7. Reboot.
8. Confirm that the module is enabled in KernelSU.

KernelSU mounting note
----------------------

KernelSU setups that do not mount module system paths by default may require a mounting
helper module such as meta-overlayfs or meta-hybrid_mount before this module can take
effect.

Implementation
--------------

The overlay targets the Android framework package and sets:

config_safe_media_volume_enabled=false
config_safe_sound_dosage_enabled=false

The module also includes these properties:

audio.safemedia.bypass=true
audio.safemedia.force=false
audio.safemedia.csd.force=false
