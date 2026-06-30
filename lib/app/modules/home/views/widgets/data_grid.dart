import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/home/app_guide_view.dart';
import 'package:getx_skeleton/app/modules/home/product_view.dart';

import '../../../../../config/translations/strings_enum.dart';

class DataGridModelMock {
  final String title;
  final String iconPath;
  final Color backgroundColor;
  final Color iconBackgroundColor;

  DataGridModelMock({
    required this.title,
    required this.iconPath,
    required this.backgroundColor,
    required this.iconBackgroundColor,
  });
}

class DataGrid extends StatelessWidget {
  DataGrid({super.key});

  final List<DataGridModelMock> data = [
    DataGridModelMock(
      title: Strings.catalogues.tr,
      iconPath: 'assets/vectors/absent.svg',
      backgroundColor: const Color(0xFFFEF0EF),
      iconBackgroundColor: const Color(0xFFF9928A),
    ),
    DataGridModelMock(
      title: Strings.appGuide.tr,
      iconPath: 'assets/vectors/tasks.svg',
      backgroundColor: const Color.fromARGB(255, 243, 243, 246),
      iconBackgroundColor: const Color.fromARGB(255, 236, 205, 30),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return GridView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 11.w,
        mainAxisSpacing: 10.h,
        mainAxisExtent: 100.h,
      ),
      itemBuilder: (ctx, index) {
        var gridData = data[index];
        return GestureDetector(
          onTap: () {
            if (gridData.title == Strings.catalogues.tr) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const ProductsListScreen(),
                ),
              );
            } else if (gridData.title == Strings.appGuide.tr) {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => const AppGuideScreen(),
                ),
              );
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: gridData.backgroundColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 37.h,
                  width: 37.h,
                  decoration: BoxDecoration(
                    color: gridData.iconBackgroundColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: SvgPicture.asset(
                    gridData.iconPath,
                    height: 19.h,
                    color: Colors.white,
                    fit: BoxFit.none,
                  ),
                ),
                8.verticalSpace,
                Text(gridData.title, style: theme.textTheme.titleSmall),
              ],
            ),
          ),
        );
      },
    );
  }
}
