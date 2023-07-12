import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:order/api_connection/api_connection.dart';

class CountryController extends GetxController {
  var initialCountry = "Turkey".obs;

  RxBool loading = false.obs;
  RxList<dynamic> countryData = <dynamic>[].obs;

  Future<List<dynamic>> getCountry() async {
    loading(true);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer token'
    };
    var params = {
      'per_page': '10',
      'with_shops': '1',
    };
    final uri =
        Uri.parse(API.hostConnectCountries).replace(queryParameters: params);

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final cities = jsonBody['data'] ;
      countryData.assignAll(cities);
    } else {
      print(response.reasonPhrase);
    }

    loading(false);
    return [];
  }

  @override
  void onInit() {
    super.onInit();
    getCountry();
  }
}
