#!/usr/bin/env bash
set -euo pipefail
cfg="${1:-.config}"
[[ -s "$cfg" ]] || { echo "Missing $cfg" >&2; exit 1; }
for sym in CONFIG_TARGET_mediatek CONFIG_TARGET_mediatek_filogic CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_viettel_nr3053 CONFIG_PACKAGE_kmod-mt_wifi CONFIG_PACKAGE_kmod-mediatek_hnat CONFIG_PACKAGE_kmod-warp CONFIG_PACKAGE_luci-app-mtwifi-cfg CONFIG_PACKAGE_luci-app-turboacc-mtk CONFIG_PACKAGE_luci-i18n-base-vi CONFIG_PACKAGE_zram-swap; do
  grep -qx "$sym=y" "$cfg" || { echo "Missing required: $sym" >&2; exit 1; }
done
if grep -q '^CONFIG_TARGET_DEVICE_mediatek_filogic_DEVICE_viettel_32x6=y$' "$cfg"; then echo '32X6 unexpectedly selected' >&2; exit 1; fi
for pkg in luci-theme-aurora luci-app-aurora-config luci-app-upnp miniupnpd luci-app-ddns ddns-scripts luci-app-adblock luci-proto-wireguard wireguard-tools luci-app-eqos-mtk tailscale; do
 if grep -qx "CONFIG_PACKAGE_$pkg=y" "$cfg"; then echo "Unexpected package: $pkg" >&2; exit 1; fi
done
echo 'NR3053 Lean config verified.'
