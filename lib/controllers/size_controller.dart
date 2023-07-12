import 'dart:convert';


import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:order/api_connection/api_connection.dart';
import 'package:print_color/print_color.dart';


class SizeController extends GetxController {
  var initialSize = "".obs;
  RxBool loading = false.obs;
  RxList<dynamic>? sizeData = <dynamic>[].obs;

  Future<List<dynamic>> getSize() async {
    loading(true);
    var headers = {
      'Accept': 'application/json',
    };
    var params = {
      'per_page': '10',
    };
    final uri = Uri.parse(API.hostConnectSize).replace(queryParameters: params);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final sizes = jsonBody['data'] as List<dynamic>;

      // Extract unique values based on 'name' field
      final uniqueSizes = sizes.toSet().toList();

      sizeData!.clear();
      sizeData!.addAll(uniqueSizes);
      initialSize.value = uniqueSizes.isNotEmpty ? uniqueSizes[0]['name'] : '';

      Print.green('Size name: ${initialSize.value}');
    } else {
      print(response.reasonPhrase);
    }

    loading(false);
    return [];
  }

  @override
  void onInit() {
    super.onInit();
    getSize();
  }
}
