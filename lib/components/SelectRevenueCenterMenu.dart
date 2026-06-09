import 'package:flutter/material.dart';

class SelectRevenueCenterMenu extends StatefulWidget {
  const SelectRevenueCenterMenu({super.key});

  @override
  State<SelectRevenueCenterMenu> createState() =>
      _SelectRevenueCenterMenuState();
}

class _SelectRevenueCenterMenuState
    extends State<SelectRevenueCenterMenu> {
  final Color primaryColor = const Color(0xffFF7A1A);

  final TextStyle smallTextStyle = const TextStyle(
    fontSize: 13,
    color: Color(0xff15355B),
    fontWeight: FontWeight.w500,
  );

  final TextEditingController searchController =
  TextEditingController();

  String selectedCategory = "Breakfast";
  bool foodExpanded = true;
  bool beveragesExpanded = false;
  bool grabGoExpanded = false;

  final Map<String, List<String>> menuData = {
    "Breakfast": [
      "Bacon Bleu",
      "Donut French Toast",
      "Chicken Flatbread",
      "The E&O Cheeseburger",
      "Chicken Tenders",
      "Trukey Club",
      "Meatball Sub",
    ],
    "Salads": [
      "Caesar Salad",
      "Greek Salad",
      "Garden Salad",
    ],
    "Sandwiches": [
      "Veg Sandwich",
      "Chicken Sandwich",
      "Tuna Melt",
    ],
    "Beverages": [
      "Cold Coffee",
      "Orange Juice",
      "Lemon Tea",
    ],
    "Grab & Go": [
      "Protein Box",
      "Fruit Cup",
      "Veg Wrap",
    ],
  };

  final Set<String> selectedItems = {};

  @override
  Widget build(BuildContext context) {
    final filteredItems =
    menuData[selectedCategory]!
        .where(
          (e) => e.toLowerCase().contains(
        searchController.text
            .toLowerCase(),
      ),
    )
        .toList();

    return Center(
      child: Material(
        color: Colors.white,
        child: Container(
          width: 760,
          height: 760,
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
                  horizontal: 24,
                  vertical: 22,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffE6EAF0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select Revenue Center Menu Item",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff15355B),
                      ),
                    ),

                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 26,
                        color: Color(0xff15355B),
                      ),
                    ),
                  ],
                ),
              ),

              /// BODY
              Expanded(
                child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// LEFT PANEL
                    Container(
                      width: 220,
                      color: const Color(0xffEEF5FB),
                      padding: const EdgeInsets.all(14),

                      child: SingleChildScrollView(
                        child: Column(
                          children: [

                            /// ================= FOOD =================

                            InkWell(
                              onTap: () {
                                setState(() {
                                  foodExpanded = !foodExpanded;
                                });
                              },

                              child: buildExpandableTile(
                                title: "Food",
                                isHeader: true,
                                isExpanded: foodExpanded,
                              ),
                            ),

                            if (foodExpanded) ...[

                              const SizedBox(height: 6),

                              buildCategoryTile(
                                title: "Breakfast",
                                count: 10,
                              ),

                              buildCategoryTile(
                                title: "Salads",
                                count: 10,
                              ),

                              buildCategoryTile(
                                title: "Sandwiches",
                                count: 8,
                              ),
                            ],

                            const SizedBox(height: 10),

                            /// ================= BEVERAGES =================

                            InkWell(
                              onTap: () {
                                setState(() {
                                  beveragesExpanded =
                                  !beveragesExpanded;
                                });
                              },

                              child: buildExpandableTile(
                                title: "Beverages",
                                isExpanded:
                                beveragesExpanded,
                              ),
                            ),

                            if (beveragesExpanded) ...[

                              const SizedBox(height: 6),

                              buildCategoryTile(
                                title: "Beverages",
                                count: 3,
                              ),
                            ],

                            const SizedBox(height: 10),

                            /// ================= GRAB & GO =================

                            InkWell(
                              onTap: () {
                                setState(() {
                                  grabGoExpanded =
                                  !grabGoExpanded;
                                });
                              },

                              child: buildExpandableTile(
                                title: "Grab & Go",
                                isExpanded:
                                grabGoExpanded,
                              ),
                            ),

                            if (grabGoExpanded) ...[

                              const SizedBox(height: 6),

                              buildCategoryTile(
                                title: "Grab & Go",
                                count: 3,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    /// RIGHT PANEL
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(18),

                        child: Column(
                          children: [

                            /// SEARCH
                            TextField(
                              controller:
                              searchController,
                              onChanged: (_) {
                                setState(() {});
                              },
                              style: smallTextStyle,
                              decoration:
                              InputDecoration(
                                hintText:
                                "Search By Item",
                                hintStyle:
                                const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                                prefixIcon:
                                const Icon(
                                  Icons.search,
                                  size: 22,
                                  color:
                                  Color(0xff15355B),
                                ),
                                contentPadding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                                border:
                                OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      12),
                                ),
                                enabledBorder:
                                OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      12),
                                  borderSide:
                                  const BorderSide(
                                    color: Color(
                                        0xffD7E1EC),
                                  ),
                                ),
                                focusedBorder:
                                OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      12),
                                  borderSide:
                                  BorderSide(
                                    color:
                                    primaryColor,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            /// ITEM LIST
                            Expanded(
                              child:
                              ListView.separated(
                                itemCount:
                                filteredItems
                                    .length,
                                separatorBuilder:
                                    (_, __) =>
                                const Divider(
                                  height: 1,
                                  color: Color(
                                      0xffE6EAF0),
                                ),
                                itemBuilder:
                                    (context, index) {
                                  final item =
                                  filteredItems[
                                  index];

                                  final isSelected =
                                  selectedItems
                                      .contains(
                                      item);

                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (isSelected) {
                                          selectedItems
                                              .remove(
                                              item);
                                        } else {
                                          selectedItems
                                              .add(
                                              item);
                                        }
                                      });
                                    },

                                    child:
                                    Container(
                                      padding:
                                      const EdgeInsets
                                          .symmetric(
                                        horizontal:
                                        10,
                                        vertical:
                                        16,
                                      ),

                                      child: Row(
                                        children: [

                                          /// CHECK ICON
                                          Container(
                                            height:
                                            18,
                                            width:
                                            18,
                                            decoration:
                                            BoxDecoration(
                                              color: isSelected
                                                  ? Colors.green//const Color( 0xffDCEAF7)
                                                  : Color( 0xffDCEAF7),
                                              shape: BoxShape
                                                  .circle,
                                            ),

                                            child:
                                            Icon(
                                              Icons
                                                  .check,
                                              size:
                                              13,
                                              color:
                                              isSelected
                                                  ? Colors.white
                                                  : const Color(
                                                  0xff15355B),
                                            ),
                                          ),

                                          const SizedBox(
                                              width:
                                              14),

                                          Expanded(
                                            child:
                                            Text(
                                              item,
                                              style:
                                              const TextStyle(
                                                fontSize:
                                                13,
                                                fontWeight:
                                                FontWeight.w500,
                                                color:
                                                Color(0xff15355B),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// FOOTER
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 20,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Color(0xffE6EAF0),
                    ),
                  ),
                ),

                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.end,
                  children: [

                    /// CLEAR
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          selectedItems.clear();
                          searchController.clear();
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor:
                        const Color(0xff98A2B3),
                        side: const BorderSide(
                          color: Color(0xff98A2B3),
                        ),
                        minimumSize:
                        const Size(120, 48),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              14),
                        ),
                      ),
                      child: const Text(
                        "Clear",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    /// ADD BUTTON
                    ElevatedButton(
                      onPressed:
                      selectedItems.isEmpty
                          ? null
                          : () {
                        Navigator.pop(
                          context,
                          selectedItems
                              .toList(),
                        );
                      },
                      style:
                      ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                        selectedItems.isEmpty
                            ? const Color(
                            0xff98A2B3)
                            : const Color(0xffFF6B00),
                        minimumSize:
                        const Size(120, 48),
                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              14),
                        ),
                      ),
                      child: const Text(
                        "Add",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight:
                          FontWeight.w500,
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

  /// CATEGORY TILE
  Widget buildCategoryTile({
    required String title,
    required int count,
  }) {
    final bool isSelected =
        selectedCategory == title;

    return InkWell(
      onTap: () {
        setState(() {
          selectedCategory = title;
        });
      },

      child: Container(
        height: 42,
        margin: const EdgeInsets.only(bottom: 1),
        padding:
        const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),

        child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "$title (${count.toString().padLeft(2, '0')})",
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected
                    ? FontWeight.w600
                    : FontWeight.w500,
                color: isSelected
                    ? primaryColor
                    : const Color(0xff15355B),
              ),
            ),

            const Icon(
              Icons.keyboard_arrow_right,
              size: 18,
              color: Color(0xff15355B),
            ),
          ],
        ),
      ),
    );
  }

  /// EXPANDABLE HEADER
  Widget buildExpandableTile({
    required String title,
    required bool isExpanded,
    bool isHeader = false,
  }) {

    return Container(
      height: 42,

      padding:
      const EdgeInsets.symmetric(
        horizontal: 14,
      ),

      decoration: BoxDecoration(
        color: (isHeader || isExpanded)
            ? primaryColor
            : const Color(0xffDCEAF4),

        borderRadius:
        BorderRadius.circular(10),
      ),

      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,

        children: [

          Text(
            title,

            style: TextStyle(
              fontSize: 13,
              fontWeight:
              FontWeight.w600,
              color: (isHeader || isExpanded)
                  ? Colors.white
                  : const Color(0xff15355B),
            ),
          ),

          AnimatedRotation(
            turns: isExpanded ? 0.5 : 0,

            duration:
            const Duration(milliseconds: 250),

            child: Icon(
              Icons.keyboard_arrow_down,

              size: 20,

              color: (isHeader || isExpanded)
                  ? Colors.white
                  : const Color(0xff15355B),
            ),
          ),
        ],
      ),
    );
  }
}