import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/config/translations/strings_enum.dart';

import '../../home/views/home_view.dart';
import '../views/auth_view.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  var isLoggedIn = false.obs;
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<void> register(String email, String password, String displayName) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName(displayName);
      await userCredential.user?.reload();
      isLoggedIn(true);
      Get.offAll(() => const HomeView());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void login(String email, String password) async {
    isLoading.value = true;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      isLoggedIn(true);
      Get.offAll(() => const HomeView());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await auth.signOut();
    isLoggedIn(false);
    Get.offAll(() => const AuthView());
  }

  Future<void> resetPassword(String email) async {
    isLoading(true);
    isSuccess(false);
    try {
      await auth.sendPasswordResetEmail(email: email);
      isSuccess(true);
      Get.snackbar("Success", Strings.passwordResetEmailSentCheckInbox.tr);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    auth.authStateChanges().listen((User? user) {
      if (user != null) {
        isLoggedIn(true);
        Get.offAll(() => const HomeView());
      } else {
        isLoggedIn(false);
      }
    });
  }

  void resetSuccessState() {
    isSuccess(false);
  }

  @override
  void onClose() {
    isSuccess(false);
    super.onClose();
  }
}
