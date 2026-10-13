#!/usr/bin/env bash
#--------------------------------------------------------------------------
# Deploys the MPK Mini Play Remote codec and maps into Reason's Remote
# folder (macOS / Linux / *BSD).
#
#   Codecs/Lua Codecs/Akai/MPKMiniPlay.lua
#   Codecs/Lua Codecs/Akai/MPKMiniPlay.luacodec
#   Codecs/Lua Codecs/Akai/MPKMiniPlay.png
#       -> /Library/Application Support/Propellerhead Software/Remote/Codecs/Lua Codecs/Akai/
#   Maps/Akai/*.remotemap
#       -> /Library/Application Support/Propellerhead Software/Remote/Maps/Akai/
#
# On Linux with a WINE-based Reason install, set REMOTE_ROOT manually.
# Reason must be closed before running.
#--------------------------------------------------------------------------
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [[ -n "${REMOTE_ROOT:-}" ]]; then
    REMOTE_ROOT="${REMOTE_ROOT}"
elif [[ "$(uname)" == "Darwin" ]]; then
    REMOTE_ROOT="/Library/Application Support/Propellerhead Software/Remote"
else
    # Linux/BSD default; override with REMOTE_ROOT=<path>.
    REMOTE_ROOT="${HOME}/.local/share/Propellerhead Software/Remote"
fi

CODEC_DEST="${REMOTE_ROOT}/Codecs/Lua Codecs/Akai"
MAPS_DEST="${REMOTE_ROOT}/Maps/Akai"

CODEC_SRC_DIR="${REPO_ROOT}/Codecs/Lua Codecs/Akai"
MAPS_SRC="${REPO_ROOT}/Maps/Akai"

if [[ ! -d "${REMOTE_ROOT}" ]]; then
    echo "ERROR: Reason Remote folder not found: ${REMOTE_ROOT}" >&2
    echo "Set REMOTE_ROOT to the correct location and retry." >&2
    exit 1
fi
if ! ls "${CODEC_SRC_DIR}"/MPKMiniPlay.* >/dev/null 2>&1; then
    echo "ERROR: codec files not found in ${CODEC_SRC_DIR} (expected MPKMiniPlay.lua/.luacodec/.png)" >&2
    exit 1
fi
if ! ls "${MAPS_SRC}"/*.remotemap >/dev/null 2>&1; then
    echo "ERROR: no .remotemap files in ${MAPS_SRC}" >&2
    exit 1
fi

echo "Deploying to: ${REMOTE_ROOT}"

mkdir -p "${CODEC_DEST}" "${MAPS_DEST}"
for codec in "${CODEC_SRC_DIR}"/MPKMiniPlay.*; do
    cp -f "${codec}" "${CODEC_DEST}/"
    echo "  Codec  -> ${CODEC_DEST}/$(basename "${codec}")"
done

for map in "${MAPS_SRC}"/*.remotemap; do
    cp -f "${map}" "${MAPS_DEST}/"
    echo "  Map    -> ${MAPS_DEST}/$(basename "${map}")"
done

echo ""
echo "Done. Close and reopen Reason, then add 'MPK Mini Play' under"
echo "Preferences > Control Surfaces (added manually, not auto-detected)."