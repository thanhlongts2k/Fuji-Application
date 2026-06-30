import 'package:get/get.dart';
import 'package:getx_skeleton/utils/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailController extends GetxController {
  var product = {}.obs;
  var isLoading = true.obs;

  void fetchProductDetails(String sku) async {
    final basicAuth =
        'Basic ' + base64Encode(utf8.encode('${Constants.ckUsername}:${Constants.csPassword}'));
    isLoading(true);

    try {
      final response = await http.get(
        Uri.parse('https://fuji.technology/wp-json/wc/v3/products?sku=$sku'),
        headers: {
          'Authorization': basicAuth,
        },
      );

      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        if (data.isNotEmpty) {
          product.value = data[0];
        }
      }
    } finally {
      isLoading(false);
    }
  }
}
