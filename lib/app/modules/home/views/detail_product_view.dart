import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import '../../../../config/translations/strings_enum.dart';
import '../controllers/detail_product_controller.dart';

class ProductDetailScreen extends StatelessWidget {
  final String sku;
  ProductDetailScreen({super.key, required this.sku});

  final ProductDetailController controller = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    // Gọi API để lấy chi tiết sản phẩm
    controller.fetchProductDetails(sku);

    return Scaffold(
      appBar: AppBar(
        title: Text(sku),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.product.isEmpty) {
          return Center(child: Text(Strings.noProductFound.tr));
        }

        // Hiển thị thông tin sản phẩm
        var product = controller.product;
        var imageUrl = product['images'][0]['src'];
        var name = product['name'];
        var description = product['description'];
        var shortDescription = product['short_description'];

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hiển thị hình ảnh
                imageUrl != null
                    ? CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CupertinoActivityIndicator(),
                        ), // Hiển thị khi đang tải hình
                        errorWidget: (context, url, error) {
                          if (error is HttpException &&
                              error.message.contains('404')) {
                            return const Icon(Icons.image_not_supported,
                                color: Colors.grey);
                          } else {
                            return const Icon(Icons.error, color: Colors.red);
                          }
                        },
                      )
                    : const Icon(Icons.image_not_supported),
                const SizedBox(height: 16), 
                // Hiển thị tên sản phẩm
                Text(
                  name,
                  style:
                      const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                // const SizedBox(height: 8),
                // // Hiển thị trạng thái hàng
                // Text(
                //   'Stock Status: ${stockStatus == 'instock' ? 'In Stock' : 'Out of Stock'}',
                //   style: TextStyle(
                //       color:
                //           stockStatus == 'instock' ? Colors.green : Colors.red),
                // ),
                const SizedBox(height: 16),
                // Hiển thị mô tả sản phẩm
                Html(data: shortDescription),
                Html(data: description),
          
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      }),
    );
  }
}
