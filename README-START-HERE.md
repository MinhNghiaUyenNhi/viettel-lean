# Viettel NR3053 Lean Router + 32X6 Lean AP

## Intended roles
- NR3053: primary router / PPPoE, IPv4 NAT, DHCP/DNS, firewall, LuCI, Dropbear, MediaTek HNAT/WARP, Wi-Fi.
- 32X6: wired AP / bridge. Same router-capable core packages remain as recovery fallback; turn off unused DHCP **in running UCI config**, not by deleting package, so router can be repurposed. Never auto-force a LAN IP at firmware build time.

## Scope of cleanup
Remove Aurora, Adblock, UPnP, DDNS, Tailscale, WireGuard, EQOS and related configuration/bootstrap injection. Preserve MTK core, switch, driver, roaming possibilities, ZRAM, LuCI, SSH, default-settings-vn, TurboACC, firewall, DHCP and PPPoE. No kernel/DTS/bootloader or NAND layout changes. No default disabling IPv6 inside kernel.

## Apply in GitHub
1. Fork the exact quytttb source revision corresponding to your stable firmware, create branch `viettel-lean`.
2. Extract contents of this ZIP and **merge folders** into the repository root; do not replace whole repository with ZIP contents. Commit the changes.
3. GitHub repository > Actions > `NR3053 Lean (firmware only)` or `32X6 Lean (firmware only)` > Run workflow > select `viettel-lean`.
4. If successful, download artifact, read `*-resolved.config`, `*-package-manifest.txt` and `*-lean-sha256sums.txt`. Ensure profile and sysupgrade.itb belong to exact device.
5. Do not flash until original matching source+feed revisions, partition layout, recoverability and image metadata are verified. Full GitHub build and device tests NOT performed in this environment.

## Important
These workflows deliberately use `./scripts/feeds update -a` from original prepare-build.sh; feeds may advance, so a build today may differ from the old stable firmware even if revision text matches. For reproducible production firmware, pin feeds revisions and action dependencies. `actions/checkout@v4` and `upload-artifact@v4` tags are not SHA-pinned in this prototype.

## 32X6 AP setup (post-flash)
- Connect to it locally first (LAN cable). Verify its management IP and access to LuCI/SSH **before** changing DHCP.
- Set LAN to a reserved/static address in upstream LAN, set gateway/DNS to NR3053, disable DHCP server on 32X6, and connect LAN-to-LAN; do not attach its WAN port as routed WAN. On the upstream DHCP subnet, avoid duplicate IP.
- If changing from a router config, **do not** blindly restore all previous UCI networking and VPN/service files with sysupgrade `-c`; use verified settings.
- 802.11r/k/v and 802.11s are different; this firmware retains existing driver/hostapd selection but does not guarantee 802.11s support. Verify real features on the device.

## Validation
- Compare `ubus call system board`, `/proc/mtd`, `ubinfo -a` and source device image layout.
- NR3053: ensure PPPoE comes up, LAN DHCP, firewall4, Wi-Fi + HNAT path, LuCI/SSH.
- 32X6: ensure LAN bridge, clients obtain IP/DNS from NR3053, Wi-Fi associations/roaming, LuCI/SSH accessible after restart.
- Measure steady-state `free`, `top`, throughput before and after, not just VSZ.
