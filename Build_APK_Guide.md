# Hướng dẫn build APK Fuji Application

## 1. Mục tiêu tài liệu

Tài liệu này dùng cho các trường hợp:

- build APK release trên chính máy hiện tại
- clone source sang máy mới rồi chạy/build lại
- xử lý các lỗi thường gặp liên quan Flutter, Gradle, Kotlin, Firebase và signing

Tài liệu này ưu tiên Android build release:

- `flutter build apk --release`

## 2. Trạng thái build đã xác nhận

Project này đã build APK release thành công với bộ công cụ sau:

- Flutter `3.24.0`
- Dart `3.5.0`
- Android SDK `35.0.0`
- Java `17`
- Gradle wrapper `7.6.3`
- Android Gradle Plugin `7.4.2`
- Kotlin Gradle Plugin `1.8.21`

Lệnh đã build thành công:

```powershell
& "C:\Users\nbt17\fvm\versions\3.24.0\bin\flutter.bat" build apk --release
```

APK output:

- `build/app/outputs/flutter-apk/app-release.apk`

## 3. Trước khi bắt đầu

### 3.1 Không dùng bừa `flutter` global

Project này đã từng lỗi vì máy có nhiều bản Flutter, trong đó `flutter` trên PATH đang trỏ tới bản cũ.

Ví dụ lỗi thực tế đã gặp:

- PATH trỏ về Flutter `2.10.5`
- project cần Flutter `3.24.0`
- kết quả là lỗi Gradle plugin, Kotlin metadata, app plugin loader, local.properties bị ghi sai

Vì vậy trước khi build, luôn kiểm tra:

```powershell
where flutter
where dart
flutter --version
```

Nếu `flutter --version` không ra đúng bản mong muốn, không dùng `flutter` global.

### 3.2 Flutter nên dùng cho project này

Ưu tiên:

- Flutter `3.24.0`

Nếu máy đã cài FVM nhưng lệnh `fvm flutter` bị lỗi, có thể gọi trực tiếp:

```powershell
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" --version
```

Trên máy mới, có 2 cách dùng:

1. Cài FVM, cài Flutter `3.24.0`, rồi sửa PATH cho đúng.
2. Không phụ thuộc PATH, gọi thẳng file `flutter.bat` bằng đường dẫn tuyệt đối.

Khuyến nghị thực dụng cho máy mới:

- build bằng đường dẫn tuyệt đối trước
- sau khi ổn định mới tối ưu PATH/FVM

## 4. Checklist môi trường trên máy mới

Máy mới clone repo về cần có tối thiểu:

- Git
- Flutter `3.24.0`
- Dart đi kèm Flutter
- Android Studio hoặc Android SDK command line
- Android SDK platform phù hợp
- Java `17`

Kiểm tra bằng:

```powershell
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" doctor -v
```

Kỳ vọng:

- Flutter OK
- Android toolchain OK
- Android licenses accepted
- Java OK

Nếu `flutter doctor -v` báo `flutter` hoặc `dart` trên PATH đang trỏ sang SDK khác, chưa phải lỗi chết người, nhưng phải cẩn thận khi chạy lệnh.

## 5. Clone source và chuẩn bị project

### 5.1 Clone repo

```powershell
git clone <repo-url>
cd Fuji-Application
```

### 5.2 Lấy package

Nên dùng đúng Flutter SDK:

```powershell
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" pub get
```

### 5.3 Tạo file `.env`

Project này dùng `flutter_dotenv`.

Tạo `.env` từ file mẫu:

```powershell
Copy-Item .env.example .env
```

Điền các biến cần thiết:

```env
FUJI_BASE_URL=https://fuji.technology/wp-json/wc/v3
FUJI_WC_CONSUMER_KEY=your_consumer_key
FUJI_WC_CONSUMER_SECRET=your_consumer_secret
```

Lưu ý:

- thiếu `.env` có thể làm app lỗi khi gọi API
- `.env` không nên commit lên git
- `.env` trong Flutter không phải cơ chế bảo mật tuyệt đối, vì dữ liệu vẫn đi vào app build

## 6. Cấu hình Android bắt buộc phải kiểm tra

Phần này là nơi máy mới hay fail nhất.

### 6.1 `android/local.properties`

File này thường được tạo theo máy local và không nên tin tuyệt đối khi clone từ máy khác.

Phải kiểm tra ít nhất 2 dòng:

```properties
sdk.dir=C:\\Users\\<your-user>\\AppData\\Local\\Android\\sdk
flutter.sdk=C:\\Users\\<your-user>\\fvm\\versions\\3.24.0
```

Ý nghĩa:

- `sdk.dir`: đường dẫn Android SDK trên máy đang build
- `flutter.sdk`: đường dẫn Flutter SDK thật đang dùng

Sai file này có thể gây:

- Gradle dùng nhầm Flutter cũ
- build fail với lỗi plugin loader
- build fail với lỗi Kotlin/Gradle không tương thích

Nếu file đang trỏ về SDK của máy cũ, sửa lại theo máy hiện tại.

### 6.2 `android/key.properties`

File này dùng cho Android release signing.

Ví dụ cấu trúc:

```properties
storePassword=your_store_password
keyPassword=your_key_password
keyAlias=upload
storeFile=../key/keystore.jks
```

Lưu ý rất quan trọng:

- không nên để `storeFile` là đường dẫn tuyệt đối của máy cũ
- nên dùng đường dẫn tương đối nếu có thể

Khuyến nghị:

```properties
storeFile=../key/keystore.jks
```

Nếu file vẫn để kiểu:

```properties
storeFile=D:/old-machine/somewhere/keystore.jks
```

thì máy mới gần như chắc chắn sẽ build fail khi signing release.

### 6.3 `key/keystore.jks`

Project cần file keystore thật để ký bản release.

Kiểm tra:

- file có tồn tại không
- đúng file cần dùng cho app production không
- password và alias trong `android/key.properties` có khớp không

Nếu clone từ git mà repo không chứa keystore, cần lấy keystore từ người quản lý project hoặc nơi lưu secret nội bộ.

Nếu mất keystore production:

- không nên tạo keystore mới ngay
- phải xác nhận với team/product owner trước
- vì keystore mới có thể làm bạn không update được app cũ trên Google Play

## 7. Firebase Android

### 7.1 File bắt buộc

Android release cần:

- `android/app/google-services.json`

### 7.2 Package name phải khớp

App Android hiện tại build với:

- `applicationId "com.fuji.fujitech"`
- `namespace "com.fuji.fujitech"`

Vì vậy `google-services.json` phải chứa client đúng package:

- `com.fuji.fujitech`

Nếu không đúng sẽ gặp lỗi:

- `No matching client found for package name 'com.fuji.fujitech'`

### 7.3 Lấy `google-services.json` ở đâu

Nếu đã có app Android trong Firebase cho package `com.fuji.fujitech`, lấy file như sau:

1. Vào Firebase Console.
2. Chọn đúng Firebase project của app.
3. Vào `Project settings`.
4. Ở tab `General`, kéo tới phần `Your apps`.
5. Chọn Android app có package `com.fuji.fujitech`.
6. Tải `google-services.json`.
7. Chép file vào:

```text
android/app/google-services.json
```

Lưu ý:

- Google Play Console không phải nơi phát hành `google-services.json`
- file này lấy từ Firebase Console, không phải từ Play Console
- Play Console chỉ giúp xác nhận package app đã phát hành

### 7.4 Nếu chưa có Firebase app đúng package

Nếu trong Firebase chưa có app Android với package `com.fuji.fujitech`, phải:

1. Tạo Android app mới trong đúng Firebase project.
2. Nhập package name chính xác: `com.fuji.fujitech`
3. Tải lại `google-services.json`
4. Chép vào `android/app/google-services.json`

## 8. Android config hiện tại của project

Các giá trị quan trọng hiện đang được project dùng:

### 8.1 `android/app/build.gradle`

- `namespace "com.fuji.fujitech"`
- `applicationId "com.fuji.fujitech"`
- `compileSdk 34`
- `targetSdk 34`
- `minSdk 23`
- release signing đọc từ `android/key.properties`

### 8.2 `android/settings.gradle`

- Android Gradle Plugin `7.4.2`
- Kotlin plugin `1.8.21`
- Google Services plugin `4.3.15`

### 8.3 `android/gradle/wrapper/gradle-wrapper.properties`

- Gradle wrapper `7.6.3`

Không nên tự ý hạ các version này nếu chưa hiểu tác động, vì project đã từng lỗi do mismatch giữa:

- Flutter
- Gradle
- AGP
- Kotlin

## 9. Trình tự build APK release chuẩn

### 9.1 Bước 1: xác nhận Flutter đúng bản

```powershell
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" --version
```

### 9.2 Bước 2: xác nhận môi trường Android

```powershell
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" doctor -v
```

### 9.3 Bước 3: cài package

```powershell
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" pub get
```

### 9.4 Bước 4: kiểm tra file local/config

Phải có và đúng:

- `.env`
- `android/local.properties`
- `android/key.properties`
- `key/keystore.jks`
- `android/app/google-services.json`

### 9.5 Bước 5: build release

```powershell
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" build apk --release
```

Nếu thành công, output nằm ở:

```text
build/app/outputs/flutter-apk/app-release.apk
```

## 10. Sau khi build xong, kiểm tra gì

Ít nhất nên kiểm tra nhanh:

- app có cài được trên máy Android không
- mở app có crash startup không
- login hoạt động không
- register hoạt động không
- reset password gửi mail được không
- scan barcode/QR có mở đúng màn sản phẩm không
- tải dữ liệu sản phẩm có ra không
- mở PDF `Catalogue` và `App Guide` có được không
- logout có hoạt động không

Nếu có thiết bị Android qua USB, có thể cài nhanh bằng:

```powershell
adb install -r build\app\outputs\flutter-apk\app-release.apk
```

## 11. Các lỗi đã gặp thực tế và cách xử lý

Phần này rất quan trọng cho máy mới.

### 11.1 Lỗi app plugin loader cũ

Ví dụ:

```text
You are applying Flutter's app_plugin_loader Gradle plugin imperatively using the apply script method
```

Nguyên nhân:

- project Android còn dùng kiểu `apply from:` cũ
- hoặc đang bị Flutter/Gradle cũ can thiệp

Cách xử lý:

- dùng cấu hình Gradle plugin DSL mới
- đảm bảo project đang build bằng Flutter mới, không phải Flutter 2.x trên PATH

### 11.2 Lỗi Gradle quá thấp so với Kotlin plugin

Ví dụ:

```text
Kotlin Gradle Plugin <-> Gradle compatibility issue
Please update the Gradle version to at least Gradle 7.6.3
```

Nguyên nhân:

- Gradle wrapper quá cũ
- Kotlin plugin cao hơn mức Gradle hiện tại chịu được

Cách xử lý:

- giữ `gradle-wrapper.properties` ở `7.6.3`
- không để build chạy bằng cấu hình cũ sinh ra từ Flutter cũ

### 11.3 Lỗi `Language version 1.4 is no longer supported`

Nguyên nhân:

- build dùng nhầm toolchain Kotlin/Gradle cũ
- hoặc included build từ Flutter SDK cũ

Cách xử lý:

- xác nhận `flutter.sdk` trong `android/local.properties` trỏ đúng Flutter `3.24.0`
- chạy build bằng Flutter `3.24.0`

### 11.4 Lỗi thiếu `google-services.json`

Ví dụ:

```text
File google-services.json is missing
```

Cách xử lý:

- lấy file từ đúng Firebase project
- chép vào `android/app/google-services.json`

### 11.5 Lỗi `No matching client found for package name`

Nguyên nhân:

- file `google-services.json` không chứa client cho package `com.fuji.fujitech`

Cách xử lý:

- vào Firebase Console
- tải lại file đúng app Android package `com.fuji.fujitech`

### 11.6 Lỗi `minSdkVersion 21 cannot be smaller than version 23 declared in library [:firebase_auth]`

Nguyên nhân:

- `firebase_auth` hiện yêu cầu `minSdk` cao hơn

Cách xử lý:

- project này hiện đã dùng `minSdk 23`
- nếu ai clone về mà thấy lại `21`, sửa `android/app/build.gradle` về `23`

### 11.7 Lỗi Kotlin metadata incompatible nhưng vẫn build xong

Đã từng xuất hiện kiểu:

```text
Module was compiled with an incompatible version of Kotlin
```

nhưng build vẫn ra APK.

Diễn giải thực tế:

- nếu cuối log có `Built build\\app\\outputs\\flutter-apk\\app-release.apk` thì APK đã được build thành công
- không nên chỉ nhìn vài dòng error ở giữa log
- phải nhìn kết luận cuối cùng của lệnh

Tuy nhiên nếu lỗi này xuất hiện thường xuyên, vẫn nên kiểm tra lại:

- Flutter SDK thực đang dùng
- Gradle wrapper
- Kotlin plugin version
- cache Gradle

### 11.8 `fvm flutter` bị lỗi kernel binary

Ví dụ đã gặp:

```text
Can't load Kernel binary: Invalid kernel binary format version
```

Nguyên nhân:

- FVM global cài bằng Dart cũ
- Dart đang chạy không tương thích với FVM đã cài

Cách xử lý thực dụng:

- đừng phụ thuộc `fvm flutter` ngay
- gọi trực tiếp `flutter.bat` trong thư mục FVM version

Ví dụ:

```powershell
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" pub get
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" build apk --release
```

## 12. Nếu clone sang máy khác mà vẫn không build được

Đi theo checklist này, không nhảy bước:

1. Kiểm tra `flutter --version` và `where flutter`.
2. Xác nhận có Flutter `3.24.0`.
3. Chạy `doctor -v` bằng đúng Flutter đó.
4. Kiểm tra `android/local.properties`.
5. Kiểm tra `.env`.
6. Kiểm tra `android/app/google-services.json`.
7. Kiểm tra `android/key.properties`.
8. Kiểm tra `key/keystore.jks`.
9. Chạy lại `pub get`.
10. Build lại bằng đường dẫn Flutter tuyệt đối.

Nếu vẫn fail, hãy chụp đúng:

- lệnh đã chạy
- 30 đến 50 dòng cuối log
- nội dung các file:
  - `android/local.properties`
  - `android/key.properties`
  - package name trong `android/app/build.gradle`

Không nên chỉ gửi 1 dòng `BUILD FAILED`, vì như vậy không đủ để xác định lỗi thật nằm ở:

- Flutter SDK
- Gradle
- Firebase
- signing
- Android SDK

## 13. Khuyến nghị để repo ổn định hơn về sau

- Chuẩn hóa toàn team dùng cùng 1 bản Flutter, ưu tiên `3.24.0` hoặc nâng đồng loạt có kiểm soát.
- Không để `key.properties` chứa đường dẫn tuyệt đối theo máy cá nhân.
- Không commit secret thật nếu repo có thể chia sẻ rộng.
- Lưu `google-services.json` đúng theo chiến lược nội bộ: commit nếu policy cho phép, hoặc quản lý bằng secret store/private channel.
- Ghi rõ quy trình setup máy mới trong onboarding nội bộ.

## 14. Lệnh mẫu hoàn chỉnh cho máy Windows mới

```powershell
git clone <repo-url>
cd Fuji-Application
Copy-Item .env.example .env
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" doctor -v
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" pub get
& "C:\Users\<your-user>\fvm\versions\3.24.0\bin\flutter.bat" build apk --release
```

Trước khi chạy lệnh build cuối, nhớ kiểm tra lại:

- `android/local.properties`
- `android/key.properties`
- `key/keystore.jks`
- `android/app/google-services.json`
- `.env`

## 15. Kết luận ngắn

Build APK của project này không khó ở phần code Flutter, mà khó ở phần môi trường:

- đúng Flutter SDK
- đúng Android SDK / Java
- đúng Firebase file
- đúng signing config

Nếu 4 phần đó đúng, lệnh build release sẽ chạy ổn và cho ra:

- `build/app/outputs/flutter-apk/app-release.apk`
