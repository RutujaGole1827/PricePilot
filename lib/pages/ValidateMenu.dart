import 'dart:convert';

import 'package:flutter/material.dart';


class ValidateMenu extends StatefulWidget {
  const ValidateMenu({super.key});

  @override
  State<ValidateMenu> createState() => _ValidateMenuState();
}

class _ValidateMenuState extends State<ValidateMenu> {
  final List<MenuItemModel> menuItems = [
    MenuItemModel(
      category: 'Breakfast',
      name: 'Bacon Bleu Burger',
      description: '',
      price: '9.25',
    ),
    MenuItemModel(
      category: 'Breakfast',
      name: 'Juicy Lucy Cheese Burger',
      description: '',
      price: '14.00',
    ),
  ];

  String selectedStatus = 'Select Status';

  void addRow() {
    setState(() {
      menuItems.add(
        MenuItemModel(
          category: '',
          name: '',
          description: '',
          price: '',
        ),
      );
    });
  }

  void deleteRow(int index) {
    setState(() {
      menuItems.removeAt(index);
    });
  }

  void saveData() {
    final List<Map<String, dynamic>> jsonData =
    menuItems.map((e) => e.toJson()).toList();

    final String jsonString = jsonEncode(jsonData);

    debugPrint(jsonString);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Menu data saved as JSON',
          style: TextStyle(fontSize: 14),
        ),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Material(
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.52,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
              ),
            ],
          ),

          child: Column(
            children: [
              /// HEADER
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xffE6EAF0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Validate Menus",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff15355B),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 22),
                    ),
                  ],
                ),
              ),

              /// BODY
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      /// TOP SECTION
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  const Text(
                                    "ATL",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10),
                                    child: Text(
                                      "/",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  const Text(
                                    "Atlanta Bread",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// STATUS DROPDOWN
                            Row(
                              children: [
                                const Text(
                                  "Mark as",
                                  style: TextStyle(fontSize: 14),
                                ),
                                const SizedBox(width: 10),

                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8),height: 32,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: const Color(0xffD7E1EC),
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: selectedStatus,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                      ),
                                      items: const [
                                        DropdownMenuItem(
                                          value: 'Select Status',
                                          child: Text('Select Status'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Approved',
                                          child: Text('Approved'),
                                        ),
                                        DropdownMenuItem(
                                          value: 'Rejected',
                                          child: Text('Rejected'),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedStatus = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// URL + FLOW
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                  children: [
                                    WidgetSpan(
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 6),
                                        child: Icon(
                                          Icons.link,
                                          size: 16,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Menu Source URL\n',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                      'https://order.toasttab.com/online/super-taco-mack',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    "Validated Flow",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "• Rebecca G. validated the menu",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "• Rebecca G. validated the menu",
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 8,),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 18,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xffF7FAFC),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xffE5EAF0),
                                ),
                              ),
                              child: const Text(
                                "Validated Count 02",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// TABLE HEADER
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xffF8FAFC),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xffE5EAF0),
                            ),
                          ),
                          child: const Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Category",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),

                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Name *",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 12),

                              Expanded(
                                flex: 4,
                                child: Text(
                                  "Description",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              SizedBox(width: 13),

                              Expanded(
                                flex: 2,
                                child: Text(
                                  "Price *",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),

                              SizedBox(width: 10),
                              SizedBox(width: 100),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      /// LIST
                      ListView.builder(
                        itemCount: menuItems.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = menuItems[index];

                          return Padding(
                            padding: const EdgeInsets.only(
                              bottom: 4,
                              left: 6,
                              right: 6,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              /*decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0xffE5EAF0),
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),*/
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: _textField(
                                      controller: item.categoryController,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    flex: 4,
                                    child: _textField(
                                      controller: item.nameController,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    flex: 4,
                                    child: _textField(
                                      controller: item.descriptionController,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  Expanded(
                                    flex: 2,
                                    child: _textField(
                                      controller: item.priceController,
                                    ),
                                  ),

                                  const SizedBox(width: 10),

                                  /// ACTIONS
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: addRow,
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffDDF7EA),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 8),

                                      InkWell(
                                        onTap: () => deleteRow(index),
                                        child: Container(
                                          height: 32,
                                          width: 32,
                                          decoration: BoxDecoration(
                                            color: const Color(0xffE7F3FB),
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: const Icon(
                                            Icons.delete_outline,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 24),

                    ],
                  ),
                ),
              ),
              /// FOOTER (MATCHED STYLE)
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 6,
          ),
          child:Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: saveData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF7A1A),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 18,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
        ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuItemModel {
  final TextEditingController categoryController;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController priceController;

  MenuItemModel({
    required String category,
    required String name,
    required String description,
    required String price,
  })  : categoryController = TextEditingController(text: category),
        nameController = TextEditingController(text: name),
        descriptionController = TextEditingController(text: description),
        priceController = TextEditingController(text: price);

  Map<String, dynamic> toJson() {
    return {
      "category": categoryController.text,
      "name": nameController.text,
      "description": descriptionController.text,
      "price": priceController.text,
    };
  }
}

Widget _textField({
  TextEditingController? controller,
}) {
  return TextField(
    controller: controller,
    style: const TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w400,
    ),
    decoration: InputDecoration(
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xffD7E1EC),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Colors.blue,
        ),
      ),
    ),
  );
}