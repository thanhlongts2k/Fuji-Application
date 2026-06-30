# Tài liệu dự án Fuji Application

## 1. Tổng quan

Fuji Application là ứng dụng Flutter dựa trên GetX, phục vụ các nhu cầu chính:

- Đăng nhập, đăng ký, quên mật khẩu bằng Firebase Authentication.
- Quét barcode/QR để lấy `sku` sản phẩm.
- Gọi WooCommerce REST API để tra cứu sản phẩm.
- Mở tài liệu PDF `Catalogue` và `App Guide` ngay trong app.
- Quản lý ngôn ngữ, theme, notification, local storage.

## 2. Công nghệ chính

- Flutter
- Dart
- GetX
- Dio
- Firebase Core / Firebase Auth / Firebase Messaging
- Hive
- SharedPreferences
- Awesome Notifications
- flutter_dotenv

## 3. Cấu trúc thư mục

```text
lib/
  app/
    components/
    data/
    modules/
    routes/
    services/
  config/
  utils/
assets/
android/
ios/
web/
test/
integration_test/
```

## 4. Cấu hình quan trọng

### 4.1 Biến môi trường

App đọc cấu hình WooCommerce từ file `.env`.

Các key hiện dùng:

```env
FUJI_BASE_URL=https://fuji.technology/wp-json/wc/v3
FUJI_WC_CONSUMER_KEY=your_consumer_key
FUJI_WC_CONSUMER_SECRET=your_consumer_secret
```

Máy mới cần copy:

```bash
cp .env.example .env
```

Sau đó điền giá trị thật trước khi chạy app hoặc build.

### 4.2 Firebase Android

File Android đang dùng:

- `android/app/google-services.json`

File này phải khớp với package name Android hiện tại:

- `com.fuji.fujitech`

Nếu không khớp sẽ gặp lỗi kiểu:

- `No matching client found for package name 'com.fuji.fujitech'`

### 4.3 Android signing

Build release dùng:

- `android/key.properties`
- `key/keystore.jks`

Lưu ý: `android/key.properties` có thể chứa đường dẫn tuyệt đối cũ, nên khi clone sang máy khác phải kiểm tra lại `storeFile`.

## 5. Luồng chạy chính của app

1. App khởi tạo Flutter binding.
2. Load `.env`.
3. Khởi tạo Firebase.
4. Khởi tạo Hive và SharedPreferences.
5. Khởi tạo FCM và local notifications.
6. Vào flow auth.
7. Sau khi đăng nhập, người dùng vào Home và có thể scan SKU hoặc mở PDF.

## 6. Nơi lưu dữ liệu hiện tại

### 6.1 Login / Register / Reset password

Hiện tại các flow này dùng:

- Firebase Authentication

Firebase Auth chịu trách nhiệm:

- tạo tài khoản
- đăng nhập
- gửi email reset password
- giữ phiên đăng nhập

### 6.2 Dữ liệu local trên máy

App hiện có local storage:

- `SharedPreferences`
  - ngôn ngữ hiện tại
  - theme mode
  - FCM token
- `Hive`
  - hạ tầng lưu object local
  - hiện có model user local nhưng chưa phải flow business chính

### 6.3 Dữ liệu sản phẩm

Thông tin sản phẩm không lưu cố định trong app, mà đang lấy từ:

- WooCommerce REST API

## 7. Lệnh thường dùng

Lấy dependency:

```bash
flutter pub get
```

Chạy test:

```bash
flutter test
```

Chạy app:

```bash
flutter run
```

## 8. Hướng dẫn build APK

Phần build Android đã được tách riêng sang tài liệu chi tiết:

- [Build_APK_Guide.md](./Build_APK_Guide.md)

Tài liệu đó bao gồm:

- yêu cầu môi trường
- setup trên máy mới
- cách dùng đúng Flutter SDK
- Firebase `google-services.json`
- `local.properties`
- `key.properties`
- keystore
- build release
- lỗi thường gặp và cách xử lý

## 9. Các rủi ro kỹ thuật cần biết

- Global `flutter` trên PATH có thể đang trỏ vào bản Flutter cũ, gây lỗi Gradle/Kotlin/build.
- Firebase Android config rất dễ lệch package name nếu lấy sai `google-services.json`.
- `key.properties` có thể chứa đường dẫn tuyệt đối từ máy cũ.
- Mobile app không nên giữ secret quá nhạy cảm ở client lâu dài; `.env` chỉ giúp tách cấu hình khỏi source code, không phải cơ chế bảo mật tuyệt đối.
- Dự án hiện vẫn có sự pha trộn giữa `Dio + BaseClient` và `http`, nên khi mở rộng tính năng cần chuẩn hóa dần.

## 10. Tóm tắt

Codebase hiện đã build APK release được, nhưng điểm dễ vướng nhất khi clone sang máy khác là:

- sai Flutter SDK
- sai PATH
- thiếu hoặc sai `google-services.json`
- sai `key.properties` / keystore
- thiếu `.env`

Khi cần build Android release, dùng tài liệu riêng ở [Build_APK_Guide.md](./Build_APK_Guide.md) làm nguồn hướng dẫn chính.
