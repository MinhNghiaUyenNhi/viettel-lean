# NR3053 Lean overlay — source review 2026-10-13

Copy **contents** of this ZIP on top of your own fork of `quytttb/immortalwrt-mt798x-rebase` (same source revision as uploaded ZIP), with folder structure preserved. Do NOT upload this overlay as a firmware image.

Workflow: Actions > NR3053 Lean (firmware only) > Run workflow. Builds only NR3053 firmware, no bootloader. It is not tested by actual GitHub Actions build yet.

Conservative changes:
- Only NR3053 selected in dedicated defconfig; keep MTK hardware settings, TurboACC, default-settings-vn, Wi-Fi packages, HNAT, WARP.
- Remove Aurora, UPnP, DDNS, Adblock, WireGuard, EQOS and a few optional utilities.
- Skip syncing Aurora and injecting adblock/DDNS/UPnP first-boot scripts when NR3053_LEAN=1.
- Separate verifier allows lean profile and insists on retained core packages.
- Do not modify bootloader, DTS, NAND/UBI image geometry, or existing workflows.

Important: default-settings-vn retains a guarded UPnP stanza; UPnP is absent, so it has no effect. IPv6 is not forcibly stripped from firmware to avoid network regressions. Configuration/flash instructions remain separate.

WARNINGS:
- Uploaded GitHub ZIP does not preserve git commit metadata. `r0-495af17` is not enough to confirm matching source/feeds. Freeze exact revision before production use.
- Original IMAGE_SIZE=229376k must be validated against actual MTD/UBI partition. Do not flash before verifying flash layout and sysupgrade compatibility.
- `make defconfig`/GitHub build not run in this environment. Workflow and configurations are draft until a successful build and runtime checks.
- Initial deployment should generally use clean configuration (no old service definitions) after exporting relevant WAN/SSID settings. Ensure recovery procedures first.

V2: GitHub Actions runner pinned to ubuntu-24.04, verifies resolved config and checks actual firmware package manifest for selected unwanted applications.
