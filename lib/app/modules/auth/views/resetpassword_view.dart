import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/config/translations/strings_enum.dart';
import '../controllers/auth_controller.dart';

class ResetPasswordView extends StatelessWidget {
  ResetPasswordView({super.key});

  final AuthController authController = Get.find<AuthController>();
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    authController.resetSuccessState();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          Strings.resetPassword.tr,
        ),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 100),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Text(
                  Strings.enterEmailToReset.tr,
                  style: TextStyle(fontSize: 16.sp, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                // Email Input
                TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return Strings.pleaseEnterEmail.tr;
                    }
                    if (!GetUtils.isEmail(value)) {
                      return Strings.invalidEmailFormat.tr;
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: Strings.labelEmail.tr,
                    prefixIcon: const Icon(Icons.email, color: Colors.black),
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
                ),
                const SizedBox(height: 30),
                // Reset Password Button with Loading & Success State
                Obx(() {
                  if (authController.isLoading.value) {
                    return const CircularProgressIndicator(); // Hiển thị loading
                  } else if (authController.isSuccess.value) {
                    return Column(
                      children: [
                        const Icon(Icons.check_circle,
                            color: Colors.green, size: 50),
                        const SizedBox(height: 10),
                        Text(
                          Strings.passwordResetEmailSent.tr,
                          style: const TextStyle(
                              color: Colors.green, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  }
                  return ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        authController
                            .resetPassword(emailController.text.trim());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 80),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text(Strings.resetPasswordButton.tr,
                        style: const TextStyle(color: Colors.white)),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
