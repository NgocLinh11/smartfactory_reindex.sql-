-- ============================================================================
-- BÀI THỰC HÀNH: TỐI ƯU HÓA CSDL SMARTFACTORY IOT
-- Học viên: [Điền Tên Của Bạn]
-- ============================================================================

USE smartfactory_db;

-- 1. Kiểm tra cấu trúc và dung lượng Index trước khi tối ưu
SHOW TABLE STATUS LIKE 'SensorLogs';
SHOW INDEX FROM SensorLogs;

-- 2. Xóa Fat Covering Index gây nghẽn luồng Ghi (INSERT)
ALTER TABLE SensorLogs DROP INDEX idx_fat_covering;

-- 3. Tạo Lean Index tinh gọn phục vụ cho việc Lọc & Sắp xếp (sensor_id, recorded_at)
CREATE INDEX idx_lean_search ON SensorLogs(sensor_id, recorded_at);

-- 4. Kiểm tra kế hoạch thực thi câu lệnh Dashboard bằng EXPLAIN
EXPLAIN SELECT temperature, humidity, status 
FROM SensorLogs 
WHERE sensor_id = 105 AND recorded_at >= '2026-06-20';

-- 5. Kiểm tra lại dung lượng Index sau khi tối ưu
SHOW TABLE STATUS LIKE 'SensorLogs';