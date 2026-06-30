import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/auth/views/register_view.dart';
import 'package:getx_skeleton/app/modules/auth/views/resetpassword_view.dart';
import 'package:getx_skeleton/config/theme/theme_extensions/header_container_theme_data.dart';
import 'package:getx_skeleton/config/translations/localization_service.dart';
import 'package:getx_skeleton/config/translations/strings_enum.dart';
import '../controllers/auth_controller.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  _AuthViewState createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  final AuthController authController = Get.put(AuthController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  String? validateInput(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.errorFieldEmpty.tr;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Nền gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.white],
              ),
            ),
          ),

          // Nội dung chính
          Positioned.fill(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50),
                      // App Logo
                      Image.asset(
                        'assets/images/logo.png', // Replace with your app's logo
                        height: 150,
                      ),
                      const SizedBox(height: 30),
                      // Email Input
                      TextFormField(
                        controller: emailController,
                        validator: validateInput,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          labelText: Strings.labelEmail.tr,
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.black),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Password Input
                      TextFormField(
                        controller: passwordController,
                        validator: validateInput,
                        decoration: InputDecoration(
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                          labelText: Strings.labelPassword.tr,
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.black),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        obscureText: _obscureText,
                        style: theme.textTheme.displayLarge?.copyWith(
                          color: Colors.black,
                          fontSize: 12.sp,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Hiển thị trạng thái loading hoặc nút Login
                      Obx(() {
                        return authController.isLoading.value
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    authController.login(
                                      emailController.text.trim(),
                                      passwordController.text.trim(),
                                    );
                                  } else {
                                    Get.snackbar(
                                        'Error', Strings.errorFillAllFields.tr);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                child: Text(Strings.buttonLogin.tr,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              );
                      }),
                      const SizedBox(height: 10),
                      // Register Button
                      TextButton(
                        onPressed: () {
                          Get.to(() => const RegisterView());
                        },
                        child: Text(
                          Strings.promptRegister.tr,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => ResetPasswordView());
                        },
                        child: Text(
                          Strings.promptForgotPassword.tr,
                          style: const TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Nút chuyển đổi ngôn ngữ
          Positioned(
            top: 50.h, // Cách trên 20 đơn vị theo tỷ lệ màn hình
            right: 20.w, // Cách phải 20 đơn vị theo tỷ lệ màn hình
            child: InkWell(
              onTap: () => LocalizationService.updateLanguage(
                LocalizationService.getCurrentLocal().languageCode == 'ja'
                    ? 'en'
                    : 'ja',
              ),
              child: Ink(
                child: Container(
                  height: 39.h,
                  width: 39.h,
                  decoration:
                      theme.extension<HeaderContainerThemeData>()?.decoration,
                  child: Image.asset(
                    LocalizationService.getCurrentLocal().languageCode == 'ja'
                        ? 'assets/images/en.png'
                        : 'assets/images/jp.png',
                    fit: BoxFit.cover,
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
