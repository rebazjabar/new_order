import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:order/api_connection/api_connection.dart';
import 'package:order/controllers/country_controller.dart';
import 'package:order/controllers/size_controller.dart';
import 'package:order/models/store_order_model.dart';
import 'package:order/screen/websites_screen.dart';
import 'package:print_color/print_color.dart';
import 'package:http/http.dart' as http;

class NewOrder extends StatefulWidget {
  final String? url;

  const NewOrder({Key? key, this.url}) : super(key: key);

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  int count = 0;
  CountryController? countryController = Get.put(CountryController());
  SizeController? sizeController = Get.put(SizeController());

  String enteredText = '';
  var formKey = GlobalKey<FormState>();

  var linkController = TextEditingController();

  var descriptionController = TextEditingController();

  void postData() async {
    try {
      var headers = {
        'Accept': 'application/json',
      };
      Store storeModel = Store(data: Data(url: linkController.text));

      final response = await http.post(
        Uri.parse(API.hostConnectStore),
        headers: headers,
        body: storeModel.toJson(),
      );

      if (response.statusCode == 200) {
        print('POST request successful');
      } else {
        print('Failed to send POST request');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
  }

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemprorary = File(image.path);
      setState(() {
        this.image = imageTemprorary;
      });
    } on PlatformException catch (e) {
      print('Fail to pick image: $e');
    }
  }

  void increment() {
    setState(() {
      count++;
    });
  }

  void decrement() {
    setState(() {
      count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Order'), centerTitle: true, actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
            icon: Icon(FontAwesomeIcons.earth),
            onPressed: () {},
          ),
        )
      ]),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 30, 30, 8),
                      child: Column(
                        children: [
                          Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  //This Filed use for Links
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text('Link'),
                                  ),
                                  TextFormField(
                                    // controller: linkController,
                                    initialValue: widget.url,
                                    validator: (value) =>
                                        value == '' ? 'Please add link' : null,
                                    decoration: InputDecoration(
                                        suffixIcon: const Icon(
                                          Icons.list_alt,
                                          color: Color.fromARGB(
                                              255, 158, 158, 158),
                                        ),
                                        hintText: 'https://example.com',
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.white60)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.orange)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: Colors.white60)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 6),
                                        fillColor:
                                            Color.fromARGB(36, 158, 158, 158),
                                        filled: true),
                                  ),

                                  const SizedBox(
                                    height: 18,
                                  ),
//THIS container use for dropdown City
                                  Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Text('Country'),
                                  ),
                                  Obx(
                                    () => countryController!.loading.value
                                        ? Center(
                                            child: CircularProgressIndicator())
                                        : DecoratedBox(
                                            decoration: BoxDecoration(
                                                color: Color.fromARGB(
                                                    36, 158, 158, 158),
                                                borderRadius:
                                                    BorderRadius.circular(8)),
                                            child: DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                isExpanded: true,
                                                value: countryController!
                                                    .initialCountry.value,
                                                onChanged: (value) {
                                                  countryController!
                                                      .initialCountry
                                                      .value = value;
                                                  Print.green(value);
                                                },
                                                items: countryController!
                                                    .countryData
                                                    .map<
                                                        DropdownMenuItem<
                                                            dynamic>>(
                                                  (city) {
                                                    return DropdownMenuItem<
                                                        dynamic>(
                                                      value: city['name'],
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10),
                                                        child:
                                                            Text(city['name']),
                                                      ),
                                                    );
                                                  },
                                                ).toList(),
                                              ),
                                            ),
                                          ),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
//THIS container use for dropdown Size and image uploader
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(right: 40),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(4),
                                                child: Text('Size'),
                                              ),
                                              Obx(
                                                () => sizeController!
                                                        .loading.value
                                                    ? Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : DecoratedBox(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    36,
                                                                    158,
                                                                    158,
                                                                    158),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                        child:
                                                            DropdownButtonHideUnderline(
                                                          child: DropdownButton(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            isExpanded: true,
                                                            value:
                                                                sizeController!
                                                                    .initialSize
                                                                    .value,
                                                            onChanged: (value) {
                                                              sizeController!
                                                                  .initialSize
                                                                  .value = value;
                                                              Print.green(
                                                                  value);
                                                            },
                                                            items: sizeController!
                                                                .sizeData!
                                                                .map<
                                                                    DropdownMenuItem<
                                                                        dynamic>>(
                                                              (city) {
                                                                return DropdownMenuItem<
                                                                    dynamic>(
                                                                  value: city[
                                                                      'name'],
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            10),
                                                                    child: Text(
                                                                        city[
                                                                            'name']),
                                                                  ),
                                                                );
                                                              },
                                                            ).toList(),
                                                          ),
                                                        ),
                                                      ),
                                              ),
                                              const SizedBox(
                                                height: 18,
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(4),
                                                child: Text('Quantity'),
                                              ),
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    color: Color.fromARGB(
                                                        36, 158, 158, 158)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    IconButton(
                                                        onPressed: () {
                                                          decrement();
                                                        },
                                                        icon: Icon(
                                                            FontAwesomeIcons
                                                                .minus)),
                                                    Text("$count"),
                                                    IconButton(
                                                        onPressed: () {
                                                          increment();
                                                        },
                                                        icon: Icon(
                                                            FontAwesomeIcons
                                                                .plus)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      DottedBorder(
                                        child: MaterialButton(
                                            onPressed: () => pickImage(),
                                            child: image != null
                                                ? Image.file(
                                                    image!,
                                                    width: 120,
                                                    height: 140,
                                                  )
                                                : const Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 50, bottom: 50),
                                                    child: Column(
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .cloudArrowUp,
                                                          size: 24,
                                                          color: Color.fromARGB(
                                                              171,
                                                              158,
                                                              158,
                                                              158),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          child: Text(
                                                              'Upload Image'),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),
                                  //This Filed use for Description

                                  TextField(
                                    onChanged: (value) {
                                      setState(() {
                                        enteredText = value;
                                      });
                                    },
                                    maxLines: 4,
                                    // controller: noteController,
                                    decoration: InputDecoration(
                                        labelText: 'Description',
                                        counterText:
                                            '${enteredText.length.toString()} /500',
                                        border: InputBorder.none,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                color: Colors.white60)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                color: Colors.orange)),
                                        disabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            borderSide: const BorderSide(
                                                color: Colors.white60)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 6),
                                        fillColor:
                                            Color.fromARGB(36, 158, 158, 158),
                                        filled: true),
                                  ),
                                  const SizedBox(
                                    height: 18,
                                  ),

                                  //the end of Column
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),

                  //This is for Order Button
                  Material(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {
                        Print.green(widget.url);

                        postData();
                        // if (formKey.currentState!
                        //     .validate()) {
                        // loginUserNow();
                        // }
                      },
                      borderRadius: BorderRadius.circular(5),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 80,
                        ),
                        child: Text(
                          'Place order',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
