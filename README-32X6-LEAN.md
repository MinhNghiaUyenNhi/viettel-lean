# Viettel 32X6 Lean — source overlay

Áp dụng lên source quytttb giống bản đã gửi, giữ nguyên layout 32X6: DTS `mt7981b-viettel-32x6`, `IMAGE_SIZE := 114688k`, NAND 2 KiB page/128 KiB eraseblock và cách đóng gói sysupgrade.itb.

- Để cài **cả NR3053 Lean và 32X6 Lean**, chép toàn bộ nội dung ZIP đè lên source gốc, giữ cấu trúc thư mục. Các file NR3053 Lean V2 cũng được đi kèm.
- Có hai workflow tách biệt trong Actions: `NR3053 Lean (firmware only)` và `32X6 Lean (firmware only)`. Chọn đúng workflow cho từng máy.
- Với 32X6, `VIETTEL_32X6_LEAN=1` bỏ tải Aurora và các first-boot scripts UPnP/Adblock/DDNS; `make defconfig` được kiểm tra bởi `verify-32x6-lean.sh`.
- Package được giữ: MTK Wi-Fi, HNAT, WARP, LuCI, SSH, PPPoE, Vietnamese LuCI, TurboACC và ZRAM; bỏ theme Aurora, Tailscale, UPnP, DDNS, WireGuard, Adblock, EQOS.
- Giữ nguyên bootloader, DTS, NAND parameters. Không gộp profile hoặc đổi IMAGE_SIZE giữa hai thiết bị.
- Build chưa được thử nghiệm trong GitHub Actions. KIỂM TRA manifest, artifact, flash layout và khả năng recovery của 32X6 trước khi sysupgrade. Không flash 32X6 với firmware NR3053 hay ngược lại.
- ZIP GitHub tải về không chứa .git metadata, không bảo đảm cùng revision với router đang chạy. Đối chiếu 32X6 firmware hiện tại trước khi flash.
