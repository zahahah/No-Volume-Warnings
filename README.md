# No Volume Warnings

Based on <https://github.com/IsaacOscar/No-Volume-Warnings>.

This module disables Android's high-volume / safe-media-volume warning on modern Pixel phones by
installing a product overlay.

## Download

Use only this release ZIP:

```text
NoVolumeWarning-LightningZahah.zip
```

NoVolumeWarning is the stable product-overlay build intended for
GitHub releases.


## Installation

1. Download `NoVolumeWarning-LightningZahah.zip` to your phone.
2. Open the KernelSU app.
3. Go to **Modules**.
4. Tap **Install from storage**.
5. Select `NoVolumeWarning-LightningZahah.zip`.
6. Wait for KernelSU to finish installing the module.
7. Reboot the device.
8. After reboot, confirm that the module is enabled in KernelSU.

The module will install the overlay at:

```text
system/product/overlay/NoVolumeWarnings.apk
```

KernelSU setups that do not mount module `system/` paths by default may require a
mounting helper module such as `meta-overlayfs` or `meta-hybrid_mount` before this
module can take effect.


## Building

The project builds the overlay APK with Gradle and packages the module ZIP.

### Android SDK required

Install the Android SDK command-line tools and the SDK platform used by this project:

```sh
sdkmanager "platform-tools" "platforms;android-26"
```

Make sure Gradle can find your SDK with `ANDROID_HOME` or `local.properties`:

```sh
export ANDROID_HOME=/path/to/Android/Sdk
```

Or create `Overlay/local.properties`:

```properties
sdk.dir=/path/to/Android/Sdk
```

The overlay currently compiles with `compileSdk` release 26 and targets SDK 26, as
defined in `Overlay/app/build.gradle.kts`.

### Signing key

The Gradle signing key is external and private. Point the build to your own key file:

```sh
export NVW_KEYSTORE_PROPERTIES=/path/to/keystore.properties
```

Build with Gradle directly:

```sh
cd Overlay
gradle --no-daemon --console=plain clean :app:assembleRelease
```

Or, when `fish` is installed, run:

```sh
fish ./build.fish
```

The build script packages the release as:

```text
NoVolumeWarning-LightningZahah.zip
```

## Android implementation details

The overlay targets the Android framework package and sets:

```xml
<bool name="config_safe_media_volume_enabled">false</bool>
<bool name="config_safe_sound_dosage_enabled">false</bool>
```

The module also includes these properties:

```properties
audio.safemedia.bypass=true
audio.safemedia.force=false
audio.safemedia.csd.force=false
```

The module intentionally avoids late-boot writes to Android's `audio_safe_volume_state`
and `audio_safe_csd_*` globals because those are owned by Android's `SoundDoseHelper`
on Pixel 10 / Android 16.
