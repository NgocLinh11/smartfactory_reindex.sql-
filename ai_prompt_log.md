# LỊCH SỬ TRA CỨU VÀ BẢO VỆ PHƯƠNG ÁN (AI PROMPT LOG)

### 1. Tra cứu tính toán kích thước Byte trong MySQL InnoDB
* **Câu hỏi:** Kích thước Byte của từng kiểu dữ liệu trong bảng `SensorLogs` được tính như thế nào?
* **Kết quả:**
  * `sensor_id` (`INT`): 4 Bytes
  * `recorded_at` (`DATETIME`): 5 Bytes
  * `temperature` (`DECIMAL(5,2)`): 3 Bytes
  * `humidity` (`DECIMAL(5,2)`): 3 Bytes
  * `status` (`VARCHAR(20)`): 21 Bytes (`utf8mb4`)
  * **Tổng kích thước Fat Index:** ~36 Bytes/bản ghi.
  * **Tổng kích thước Lean Index:** 9 Bytes/bản ghi (tiết kiệm ~75% không gian Index).

---

### 2. Chuẩn bị câu hỏi bảo vệ vấn đáp (Cloud Financial Controller)

#### Câu 1: Nếu bảng là "Countries" (Danh mục quốc gia) ít khi sửa thì Covering Index có phải là "tội ác" không?
* **Trả lời:** Không. Bảng `Countries` thuộc dạng Read-Heavy/Write-Rarely (đọc nhiều, ghi rất ít) và dung lượng nhỏ. Việc tạo Covering Index giúp tốc độ đọc đạt tối đa mà không gây ảnh hưởng tới hiệu năng ghi hay chi phí lưu trữ.

#### Câu 2: Khái niệm "Write Penalty" của Index là gì?
* **Trả lời:** Là chi phí thời gian và tài nguyên máy tính phát sinh khi Database phải ghi/sắp xếp lại tất cả các cây B-Tree của Secondary Index mỗi khi thực hiện `INSERT`, `UPDATE` hoặc `DELETE`.

#### Câu 3: Thay thế `VARCHAR(20)` của cột `status` thành `TINYINT` có tác dụng gì?
* **Trả lời:** `VARCHAR(20)` tốn tới 21-81 Bytes, trong khi `TINYINT` chỉ tốn 1 Byte. Việc chuyển đổi giúp giảm đáng kể `Data Length` và `Index Length`, giúp nén được nhiều bản ghi hơn trên một Data Page (16KB) của InnoDB.