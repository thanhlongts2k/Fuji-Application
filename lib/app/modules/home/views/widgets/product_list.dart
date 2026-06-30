import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/app/modules/home/controllers/home_controller.dart';
import 'package:getx_skeleton/app/modules/home/views/detail_product_view.dart';
import 'package:getx_skeleton/app/services/api_call_status.dart';

import '../../../../../config/theme/theme_extensions/employee_list_item_theme_data.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    var theme = Theme.of(context);
    var employeeItemTheme = theme.extension<EmployeeListItemThemeData>();
    return Obx(() {
      if (homeController.apiCallStatus == ApiCallStatus.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (homeController.apiCallStatus == ApiCallStatus.error) {
        return const Center(child: Text("Failed to load products"));
      } else if (homeController.apiCallStatus == ApiCallStatus.success &&
          homeController.products.isNotEmpty) {
        return SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Products',
                      style: theme.textTheme.displaySmall,
                    ),
                    const Spacer(),
                    Text(
                      'View All',
                      style:
                          theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              5.verticalSpace,
              ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeController.products.length,
                  itemBuilder: (ctx, index) {
                    var product = homeController.products[index];
                    return GestureDetector(
                      onTap: () => Get.to(() =>
                          ProductDetailScreen(sku: product.sku.toString())),
                      child: Container(
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.h, vertical: 5.h),
                        decoration: BoxDecoration(
                          color: employeeItemTheme?.backgroundColor ??
                              Colors.white, // Sử dụng employeeItemTheme.
                          border: Border(
                            top: BorderSide(
                              color: Get.isDarkMode
                                  ? const Color(0xFF414141)
                                  : const Color(0xFFF6F6F6),
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 75.h,
                              width: 75.h,
                              decoration: BoxDecoration(
                                color: employeeItemTheme?.backgroundColor ??
                                    Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: CachedNetworkImage(
                                  imageUrl: product.images![0].src!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => const Center(
                                    child: CupertinoActivityIndicator(),
                                  ), // Hiển thị khi đang tải hình
                                  errorWidget: (context, url, error) {
                                    if (error is HttpException &&
                                        error.message.contains('404')) {
                                      return const Icon(
                                          Icons.image_not_supported,
                                          color: Colors.grey);
                                    } else {
                                      return const Icon(Icons.error,
                                          color: Colors.red);
                                    }
                                  },
                                ),
                              ),
                            ),
                            17.horizontalSpace,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(product.name.toString(),
                                    style: employeeItemTheme?.nameTextStyle ??
                                        theme.textTheme.bodyLarge,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis),
                                4.verticalSpace,
                                Row(
                                  children: [
                                    Text('${product.sku}',
                                        style: employeeItemTheme
                                                ?.subtitleTextStyle ??
                                            theme.textTheme.bodySmall),
                                    // Text('\$${product.price}',
                                    //     style: employeeItemTheme
                                    //             ?.subtitleTextStyle ??
                                    //         theme.textTheme.bodySmall),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        );
      } else {
        return const Center(child: Text("No products available"));
      }
    });
  }
}
