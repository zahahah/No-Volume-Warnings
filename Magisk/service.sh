#!/system/bin/sh

# Intentionally conservative.
# This file is not included in the recommended PropsOnly package.
# If included by an experimental package, it logs only and does not mutate Android's
# SoundDoseHelper-owned global state.

MODLOG="$MODDIR/log"
echo "$(date '+%Y-%m-%d %H:%M:%S') No Volume Warnings module loaded; no service mutations applied" >> "$MODLOG"
