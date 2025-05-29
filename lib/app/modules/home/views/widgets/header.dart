import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/home/views/profile_view.dart';
import 'package:getx_skeleton/config/theme/my_theme.dart';
import 'package:getx_skeleton/config/translations/localization_service.dart';

import '../../../../../config/theme/theme_extensions/header_container_theme_data.dart';
import '../../../../../config/translations/strings_enum.dart';
import 'dart:math' as math;

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 100.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          //----------------white circles decor----------------//
          Positioned(
            right: 0,
            top: -125.h,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.05),
              radius: 111,
            ),
          ),
          Positioned(
            right: -7.w,
            top: -160.h,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.05),
              radius: 111,
            ),
          ),
          Positioned(
            right: -21.w,
            top: -195.h,
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.05),
              radius: 111,
            ),
          ),

          //----------------Data row----------------//
          Positioned(
            bottom: 10,
            right: 16.w,
            left: 16.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ProfileView(),
                      ),
                    );
                  },
                  child: Container(
                    height: 62.h,
                    width: 62.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.white, width: 1)),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: double.infinity,
                    ),
                  ),
                ),
                9.horizontalSpace,
             const  Text(
                  'FUJI TECHNOLOGY',
                  style: TextStyle(
                    fontFamily:
                        'Montserrat', // hoặc Roboto nếu không import font ngoài
                    fontWeight: FontWeight.bold,
                    fontSize: 22, // điều chỉnh theo nhu cầu
                    color: Color(0xFFFF0000), // Màu đỏ giống logo
                    letterSpacing: 1.5,
                  ),
                ),
                const Spacer(),

                //----------------Theme Button----------------//
                // InkWell(
                //   onTap: () => MyTheme.changeTheme(),
                //   child: Ink(
                //     child: Container(
                //       height: 39.h,
                //       width: 39.h,
                //       decoration: theme.extension<HeaderContainerThemeData>()?.decoration,
                //       child: SvgPicture.asset(
                //         Get.isDarkMode ? 'assets/vectors/moon.svg' : 'assets/vectors/sun.svg',
                //         fit: BoxFit.none,
                //         color: Colors.white,
                //         height: 10,
                //         width: 10,
                //       ),
                //     ),
                //   ),
                // ),

                // 10.horizontalSpace,

                //----------------Language Button----------------//
                InkWell(
                  onTap: () => LocalizationService.updateLanguage(
                    LocalizationService.getCurrentLocal().languageCode == 'ja'
                        ? 'en'
                        : 'ja',
                  ),
                  child: Ink(
                    child: Container(
                      height: 39.h,
                      width: 39.h,
                      decoration: theme
                          .extension<HeaderContainerThemeData>()
                          ?.decoration,
                      child: Image.asset(
                        LocalizationService.getCurrentLocal().languageCode ==
                                'ja'
                            ? 'assets/images/en.png'
                            : 'assets/images/jp.png',
                        fit: BoxFit.cover,
                        height: 10,
                        width: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
