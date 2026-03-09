# Toruz UI Library

<p align="center">
  <img src="https://img.shields.io/badge/Version-1.0.0-blue?style=for-the-badge" alt="Version">
  <img src="https://img.shields.io/badge/Platform-Roblox-red?style=for-the-badge" alt="Platform">
  <img src="https://img.shields.io/badge/Status-Active-green?style=for-the-badge" alt="Status">
</p>

**Toruz** là một thư viện UI (UI Library) mạnh mẽ, tối giản và mượt mà dành cho các nhà phát triển Script trên Roblox. Được thiết kế theo phong cách hiện đại (Fluent/Dark Mode), hỗ trợ tốt cho cả PC và Mobile.

---

## ✨ Tính năng nổi bật

* **🚀 Hiệu năng cao:** Tối ưu hóa bộ nhớ, không gây giật lag (lag-free).
* **📱 Mobile Friendly:** Hỗ trợ kéo thả (Draggable) và kích thước nút bấm chuẩn cho thiết bị di động.
* **🔍 Dropdown + Search:** Tìm kiếm các tùy chọn cực nhanh trong danh sách dài.
* **🎨 Thiết kế Pro:** Bo góc, hiệu ứng chuyển động (Tween) mượt mà và bảng màu tối sang trọng.
* **🛠️ Dễ sử dụng:** Cấu trúc hàm đơn giản, dễ dàng tích hợp vào bất kỳ Script nào.

---

## 📖 Hướng dẫn sử dụng

Để sử dụng thư viện này trong Script của bạn, hãy sử dụng đoạn mã `loadstring` dưới đây:

```lua
local Lib = loadstring(game:HttpGet("[https://raw.githubusercontent.com/torudz/Toruz/main/main.lua](https://raw.githubusercontent.com/torudz/Toruz/main/main.lua)"))()

-- Khởi tạo Menu chính
local Window = Lib:CreateWindow("Toruz")

-- Thêm các Tab vào Sidebar
Window:AddTab("Main", "🏠")
Window:AddTab("Combat", "⚔️")

-- Thêm đoạn văn bản hướng dẫn
Window:AddParagraph("Thông báo", "Chào mừng bạn đến với phiên bản thử nghiệm!")

-- Thêm nút Bật/Tắt (Toggle)
Window:AddToggle("Auto Farm", function(state)
    print("Trạng thái Auto Farm:", state)
end)

-- Thêm danh sách chọn (Dropdown) tích hợp Tìm kiếm
Window:AddDropdown("Chọn Đảo", {"Đảo Khỉ", "Đảo Hải Tặc", "Đảo Tuyết"}, function(selected)
    print("Bạn đã chọn:", selected)
end)
