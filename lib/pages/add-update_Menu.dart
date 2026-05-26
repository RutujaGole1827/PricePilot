import 'package:flutter/material.dart';

class AddMenuDrawer extends StatefulWidget {
  final Map<String, dynamic> restaurantData;
  final Function(Map<String, dynamic>) onSubmit;

  const AddMenuDrawer({
    super.key,
    required this.restaurantData,
    required this.onSubmit,
  });

  @override
  State<AddMenuDrawer> createState() =>
      _AddMenuDrawerState();
}

class _AddMenuDrawerState
    extends State<AddMenuDrawer> {
  final TextEditingController menuNameController =
  TextEditingController();

  List<TextEditingController> menuControllers =
  [];

  @override
  void initState() {
    super.initState();

    menuNameController.text =
        widget.restaurantData["menuName"] ?? "";

    final menus =
    widget.restaurantData["menus"];

    if (menus != null && menus is List) {
      menuControllers = menus
          .map<TextEditingController>(
            (e) => TextEditingController(
          text: e.toString(),
        ),
      )
          .toList();
    }

    if (menuControllers.isEmpty) {
      menuControllers.add(
        TextEditingController(),
      );
    }
  }
  @override
  void dispose() {
    menuNameController.dispose();

    for (var controller in menuControllers) {
      controller.dispose();
    }

    super.dispose();
  }

  InputDecoration inputDecoration(
      String hint,
      ) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Color(0xff98A7B8),
      ),
      contentPadding:
      const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xffD7E6F2),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xffD7E6F2),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xff12304F),
        ),
      ),
    );
  }

  Widget titleText(
      String title, {
        bool required = false,
      }) {
    return Padding(
      padding:
      const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight:
                FontWeight.w500,
                color:
                Color(0xff12304F),
              ),
            ),
            if (required)
              const TextSpan(
                text: " *",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Material(
        color: Colors.white,
        child: Container(
          width:
          MediaQuery.of(context)
              .size
              .width *
              0.55,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration:
                const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color:
                      Color(0xffE6EDF5),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  children: [

                    const Text(
                      "Add Menu",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                        FontWeight.w600,
                        color: Color(
                            0xff12304F),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.pop(
                            context);
                      },
                      child: const Icon(
                        Icons.close,
                        size: 26,
                        color: Color(
                            0xff12304F),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child:
                SingleChildScrollView(
                  padding:
                  const EdgeInsets.all(
                      24),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,
                    children: [

                      Text(
                        "${widget.restaurantData["airport"]}   /   ${widget.restaurantData["title"]}",
                        style:
                        const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight
                              .w500,
                          color: Color(
                              0xff12304F),
                        ),
                      ),

                      const SizedBox(
                          height: 30),

                      titleText(
                        "Menu Name",
                      ),

                      TextField(
                        controller:
                        menuNameController,
                        style:
                        const TextStyle(
                          fontSize: 13,
                        ),
                        decoration:
                        inputDecoration(
                          "",
                        ),
                      ),

                      const SizedBox(
                          height: 28),

                      titleText(
                        "Menu URL",
                        required: true,
                      ),

                      Column(
                        children:
                        List.generate(
                          menuControllers
                              .length,
                              (index) {
                            return Padding(
                              padding:
                              const EdgeInsets
                                  .only(
                                bottom: 12,
                              ),
                              child: Row(
                                children: [

                                  Expanded(
                                    child:
                                    Container(
                                      height:
                                      52,
                                      decoration:
                                      BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(
                                            12),
                                        border:
                                        Border.all(
                                          color: const Color(
                                              0xffD7E6F2),
                                        ),
                                      ),
                                      child:
                                      Row(
                                        children: [

                                          Container(
                                            width:
                                            54,
                                            decoration:
                                            const BoxDecoration(
                                              border:
                                              Border(
                                                right:
                                                BorderSide(
                                                  color:
                                                  Color(0xffD7E6F2),
                                                ),
                                              ),
                                            ),
                                            child:
                                            const Icon(
                                              Icons
                                                  .link,
                                              size:
                                              20,
                                              color:
                                              Color(0xff0077B6),
                                            ),
                                          ),

                                          Expanded(
                                            child:
                                            TextField(
                                              controller:
                                              menuControllers[
                                              index],
                                              style:
                                              const TextStyle(
                                                fontSize:
                                                13,
                                              ),
                                              decoration:
                                              const InputDecoration(
                                                border:
                                                InputBorder.none,
                                                hintText:
                                                "Add Menu URL",
                                                hintStyle:
                                                TextStyle(
                                                  fontSize:
                                                  13,
                                                  color:
                                                  Color(0xff98A7B8),
                                                ),
                                                contentPadding:
                                                EdgeInsets.symmetric(
                                                  horizontal:
                                                  14,
                                                  vertical:
                                                  14,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                      width:
                                      10),

                                  InkWell(
                                    onTap: () {
                                      setState(
                                              () {
                                            menuControllers
                                                .add(
                                              TextEditingController(),
                                            );
                                          });
                                    },
                                    child:
                                    Container(
                                      width:
                                      54,
                                      height:
                                      52,
                                      decoration:
                                      BoxDecoration(
                                        color:
                                        const Color(0xffD8F5E5),
                                        borderRadius:
                                        BorderRadius.circular(
                                            10),
                                      ),
                                      child:
                                      const Icon(
                                        Icons.add,
                                        color: Color(
                                            0xff1FA463),
                                      ),
                                    ),
                                  ),

                                  if (menuControllers
                                      .length >
                                      1)
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                        left:
                                        10,
                                      ),
                                      child:
                                      InkWell(
                                        onTap:
                                            () {
                                          setState(
                                                  () {
                                                menuControllers.removeAt(
                                                    index);
                                              });
                                        },
                                        child:
                                        Container(
                                          width:
                                          54,
                                          height:
                                          52,
                                          decoration:
                                          BoxDecoration(
                                            color:
                                            const Color(0xffFDE7E7),
                                            borderRadius:
                                            BorderRadius.circular(
                                                10),
                                          ),
                                          child:
                                          const Icon(
                                            Icons.delete_outline,
                                            color:
                                            Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                padding:
                const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                decoration:
                const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color:
                      Color(0xffE6EDF5),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [

                    OutlinedButton(
                      onPressed: () {
                        menuNameController
                            .clear();

                        setState(() {
                          menuControllers = [
                            TextEditingController(),
                          ];
                        });
                      },
                      style:
                      OutlinedButton
                          .styleFrom(
                        minimumSize:
                        const Size(
                            130, 52),
                        side:
                        const BorderSide(
                          color: Color(
                              0xffFF7A1A),
                        ),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                              16),
                        ),
                      ),
                      child: const Text(
                        "Clear",
                        style: TextStyle(
                          color: Color(
                              0xffFF7A1A),
                          fontSize: 14,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    ElevatedButton(
                      onPressed: () {

                        widget.onSubmit({
                          ...widget
                              .restaurantData,

                          "menuName":
                          menuNameController
                              .text,

                          "menus":
                          menuControllers
                              .where((e) =>
                          e.text
                              .trim()
                              .isNotEmpty)
                              .map((e) =>
                          e.text)
                              .toList(),
                        });

                        Navigator.pop(
                            context);
                      },
                      style:
                      ElevatedButton
                          .styleFrom(
                        elevation: 0,
                        backgroundColor:
                        const Color(
                            0xffFF7A1A),
                        minimumSize:
                        const Size(
                            140, 52),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius
                              .circular(
                              16),
                        ),
                      ),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                          color:
                          Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}