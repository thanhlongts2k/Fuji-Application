import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_skeleton/config/translations/strings_enum.dart';
import 'package:getx_skeleton/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ProductsListScreen extends StatefulWidget {
  const ProductsListScreen({super.key});

  @override
  State<ProductsListScreen> createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  // final ProductsController controller = Get.put(ProductsController());
  @override
  Widget build(BuildContext context) {
    // var theme = Theme.of(context);
    // var employeeItemTheme = theme.extension<EmployeeListItemThemeData>();
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.catalogues.tr),
      ),
      // body: Obx(() {
      //   if (controller.isLoading.value) {
      //     return const Center(child: CircularProgressIndicator());
      //   } else if (controller.products.isEmpty) {
      //     return const Center(child: Text('No products found.'));
      //   }

      //   return SingleChildScrollView(
      //     child: Column(
      //       mainAxisSize: MainAxisSize.min,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Padding(
      //           padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      //           child: Row(
      //             crossAxisAlignment: CrossAxisAlignment.center,
      //             children: [
      //               Text(
      //                 'Products',
      //                 style: theme.textTheme.displaySmall,
      //               ),
      //               const Spacer(),
      //               Text(
      //                 'View All',
      //                 style:
      //                     theme.textTheme.bodySmall?.copyWith(fontSize: 12.sp),
      //               ),
      //             ],
      //           ),
      //         ),
      //         5.verticalSpace,
      //         ListView.builder(
      //             padding: EdgeInsets.zero,
      //             shrinkWrap: true,
      //             physics: const NeverScrollableScrollPhysics(),
      //             itemCount: controller.products.length,
      //             itemBuilder: (ctx, index) {
      //               var product = controller.products[index];
      //               return GestureDetector(
      //                 onTap: () => Get.to(() =>
      //                     ProductDetailScreen(sku: product['sku'].toString())),
      //                 child: Container(
      //                   margin: EdgeInsets.zero,
      //                   padding: EdgeInsets.symmetric(
      //                       horizontal: 20.h, vertical: 5.h),
      //                   decoration: BoxDecoration(
      //                     color: employeeItemTheme?.backgroundColor ??
      //                         Colors.white, // Sử dụng employeeItemTheme.
      //                     border: Border(
      //                       top: BorderSide(
      //                         color: Get.isDarkMode
      //                             ? const Color(0xFF414141)
      //                             : const Color(0xFFF6F6F6),
      //                       ),
      //                     ),
      //                   ),
      //                   child: Row(
      //                     children: [
      //                       Container(
      //                         height: 75.h,
      //                         width: 75.h,
      //                         decoration: BoxDecoration(
      //                           color: employeeItemTheme?.backgroundColor ??
      //                               Colors.grey.shade200,
      //                           borderRadius: BorderRadius.circular(8),
      //                         ),
      //                         child: ClipRRect(
      //                           borderRadius: BorderRadius.circular(5),
      //                           child: CachedNetworkImage(
      //                             imageUrl:  product['images'][0]['src'],
      //                             fit: BoxFit.cover,
      //                             placeholder: (context, url) => const Center(
      //                               child: CupertinoActivityIndicator(),
      //                             ), // Hiển thị khi đang tải hình
      //                             errorWidget: (context, url, error) {
      //                               if (error is HttpException &&
      //                                   error.message.contains('404')) {
      //                                 return const Icon(
      //                                     Icons.image_not_supported,
      //                                     color: Colors.grey);
      //                               } else {
      //                                 return const Icon(Icons.error,
      //                                     color: Colors.red);
      //                               }
      //                             },
      //                           ),
      //                         ),
      //                       ),
      //                       17.horizontalSpace,
      //                       Column(
      //                         crossAxisAlignment: CrossAxisAlignment.start,
      //                         children: [
      //                           Text(product['name'].toString(),
      //                               style: employeeItemTheme?.nameTextStyle ??
      //                                   theme.textTheme.bodyLarge,
      //                               maxLines: 1,
      //                               overflow: TextOverflow.ellipsis),
      //                           4.verticalSpace,
      //                           Row(
      //                             children: [
      //                               Text('${product['sku']}',
      //                                   style: employeeItemTheme
      //                                           ?.subtitleTextStyle ??
      //                                       theme.textTheme.bodySmall),
      //                               // Text('\$${product.price}',
      //                               //     style: employeeItemTheme
      //                               //             ?.subtitleTextStyle ??
      //                               //         theme.textTheme.bodySmall),
      //                             ],
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             }),
      //       ],
      //     ),
      //   );
      // }),
      body: SfPdfViewer.asset(
        'assets/pdfs/catalogue.pdf',
        key: _pdfViewerKey,
      ),
    );
  }
}

class ProductsController extends GetxController {
  var products = [].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    final basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('${Constants.ckUsername}:${Constants.csPassword}'));
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse('https://fuji.technology/wp-json/wc/v3/products'),
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200) {
        products.value = json.decode(response.body);
      }
    } finally {
      isLoading(false);
    }
  }
}
