import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:order/api_connection/api_connection.dart';
import 'package:order/screen/new_order.dart';
import 'package:order/service/website_link.dart';
import 'package:print_color/print_color.dart';

class Websites extends StatefulWidget {
  @override
  _WebsitesState createState() => _WebsitesState();
}

class _WebsitesState extends State<Websites> {
  List<Map<String, dynamic>> data = [];
  String currentUrl = '';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(API.hostConnectCountries).replace(
      queryParameters: {'with_shops': 'true'},
    ));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      setState(() {
        data = List<Map<String, dynamic>>.from(jsonData['data'][0]['shops']);
      });
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              // color: Color.fromARGB(255, 132, 202, 235),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // controller: firstNameController,
                    // validator: (value) =>
                    //     value == '' ? 'Please Write First Name' : null,
                    autovalidateMode: AutovalidateMode.disabled,

                    autofocus: false,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color.fromARGB(255, 158, 158, 158),
                        ),
                        hintText: 'Search...',
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.white60)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.orange)),
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide:
                                const BorderSide(color: Colors.white60)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 6),
                        fillColor: const Color.fromARGB(36, 158, 158, 158),
                        filled: true),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Color.fromARGB(47, 158, 158, 158),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2,
                ),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = data[1];
                  Print.green(item['image_url']);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        currentUrl = item['link'];
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WebViewData(url: item['link']),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              if (item['image_url'] != null)
                                Image.network(
                                  item['image_url'],
                                  fit: BoxFit.cover,
                                )
                              else
                                Text(item['link']),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
