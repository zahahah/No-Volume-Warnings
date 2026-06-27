#!/usr/bin/env fish

set REPO_ROOT (pwd)
set APK Overlay/app/build/outputs/apk/release/app-release.apk
set RELEASE_ZIP NoVolumeWarning-LightningZahah.zip

function require_file
    if not test -f $argv[1]
        echo "Missing required file: $argv[1]" >&2
        exit 1
    end
end

set_color -o blue
echo "Compiling No Volume Warnings overlay APK"
set_color normal

cd Overlay
if test -e /proc/sys/fs/binfmt_misc/WSLInterop # WSL, build on Windows
    set JAVA_HOME 'C:\Program Files\Android\Android Studio\jbr'
    cmd.exe /C "set JAVA_HOME=$JAVA_HOME&& gradlew.bat assembleRelease" || exit $status
else if test -x ./gradlew
    ./gradlew --no-daemon --console=plain assembleRelease || exit $status
else
    gradle --no-daemon --console=plain assembleRelease || exit $status
end
cd ..

require_file $APK

set_color -o blue
echo "Packaging release ZIP: $RELEASE_ZIP"
set_color normal

rm -rf /tmp/nvw-release-package $RELEASE_ZIP
mkdir -p /tmp/nvw-release-package/system/product/overlay
cp Magisk/module.prop Magisk/system.prop Magisk/uninstall.sh Magisk/README-KernelSU.txt /tmp/nvw-release-package/ || exit $status
cp -R Magisk/META-INF /tmp/nvw-release-package/ || exit $status
cp $APK /tmp/nvw-release-package/system/product/overlay/NoVolumeWarnings.apk || exit $status
cd /tmp/nvw-release-package
zip -r $REPO_ROOT/$RELEASE_ZIP * || exit $status
cd - >/dev/null

echo "Done: $RELEASE_ZIP"
