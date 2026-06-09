/*
import 'package:flutter/material.dart';
import '../components/SelectRevenueCenterMenu.dart';
import '../components/SlideLeftPopup.dart';

class MenuPricingScreen extends StatefulWidget {
  final List<String> selectedMenuItems;
  final List<Map<String, dynamic>> recommendationItems;
  final int selectedCompCount;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const MenuPricingScreen({
    super.key,
    required this.selectedMenuItems,
    required this.recommendationItems,
    required this.selectedCompCount,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<MenuPricingScreen> createState() =>
      _MenuPricingScreenState();
}

class _MenuPricingScreenState
    extends State<MenuPricingScreen> {
  final Set<int> selectedRows = {};
  late List<String> selectedMenuItems;
  int currentPage = 1;
  int itemsPerPage = 1; // one menu card per page
  List<Map<String, dynamic>> get paginatedItems {
    final start = (currentPage - 1) * itemsPerPage;

    if (start >= widget.recommendationItems.length) {
      return [];
    }

    final end =
    (start + itemsPerPage) > widget.recommendationItems.length
        ? widget.recommendationItems.length
        : start + itemsPerPage;

    return widget.recommendationItems.sublist(start, end);
  }

  int get totalPages =>
      (widget.recommendationItems.length / itemsPerPage).ceil();
  @override
  void initState() {
    super.initState();
    selectedMenuItems = widget.selectedMenuItems;
  }

  bool get hasSelectedMenu =>
      selectedMenuItems.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [

          buildSearchDropdown(),

          if (!hasSelectedMenu)
            Expanded(
              child: Center(
                child: Text(
                  "Select a menu item",
                ),
              ),
            )
          else ...[
            buildSelectedMenuCard(),

            const SizedBox(height: 12),

            buildRecommendationHeader(),

            const SizedBox(height: 12),

            Expanded(
              child: buildRecommendationTable(),
            ),

            const SizedBox(height: 12),

            buildFooter(),
          ]
        ],
      ),
    );
  }

  Widget buildSearchDropdown() {
    return InkWell(
      onTap: () async {
        final result = await SlideLeftPopup.show(
          context,
          content: const SelectRevenueCenterMenu(),
        );

        if (result != null &&
            result is List<String>) {
          setState(() {
            selectedMenuItems = result;
          });
        }
      },
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xffD7E2EC),
          ),
          borderRadius:
          BorderRadius.circular(12),
        ),
        child: const Row(
          children: [
            SizedBox(width: 12),
            Expanded(
              child: Text("Search Menu"),
            ),
            Icon(Icons.keyboard_arrow_down),
            SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget buildSelectedMenuCard() {
    final firstItem = selectedMenuItems.first;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffDCE6F0),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Row(
                  children: [

                    Expanded(
                      child: Text(
                        "$firstItem - \$21.50",
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.w700,
                          color:
                          Color(0xff163A69),
                        ),
                      ),
                    ),

                    if (selectedMenuItems.length > 1)
                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                          const Color(0xffEAF5FF),
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Text(
                          "+${selectedMenuItems.length - 1} more",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight:
                            FontWeight.w600,
                            color:
                            Color(0xff1682C4),
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 4),

                const Text(
                  "Fresh avocado slices, smashed avocado, cotija cheese and pico de gallo.",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: Color(0xff6B7A90),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: const Color(0xffDDF0FB),
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(
                Icons.remove,
                size: 16,
                color: Color(0xff1682C4),
              ),
              onPressed: () {
                setState(() {
                  selectedMenuItems.clear();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRecommendationHeader() {
    return Row(
      children: [

        const Icon(
          Icons.auto_awesome,
          color: Color(0xffFF6B00),
          size: 16,
        ),

        const SizedBox(width: 6),

        Expanded(
          child: Text(
            'Recommended Menu Items For "${selectedMenuItems.first}"',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xffFF6B00),
            ),
          ),
        ),

        SizedBox(
          width: 240,
          height: 36,
          child: TextField(
            style: const TextStyle(
              fontSize: 11,
            ),
            decoration: InputDecoration(
              hintText: "Search By Item",
              hintStyle: const TextStyle(
                fontSize: 11,
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 16,
              ),
              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 6,
              ),
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRecommendationTable() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffDCE6F0),
        ),
        color: Colors.white,
      ),
      child:  LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                buildTableHeader(),
                Expanded(
                  child: ListView.builder(
                    itemCount: paginatedItems.length,
                    itemBuilder: (_, index) {
                      return buildTableRow(
                        paginatedItems[index],
                        ((currentPage - 1) * itemsPerPage) + index,
                      );
                    },
                  ),
                ),
                buildPagination(),
              ],
            );
          })
    );
  }
  Widget buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 18,
      ),
      decoration: const BoxDecoration(
        color: Color(0xffEDF5FB),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              "Item",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Description",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Comp Establishment & Address",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Price",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Action",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildTableRow(
      Map<String, dynamic> item,
      int index,
      ) {

    final selected =
    selectedRows.contains(index);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,//20,
        vertical: 6,//16,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE5E7EB),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              item["menuItem"],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Text(
              item["description"] ??
                  "Warm nutella, maple syrup, fresh berries",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                height: 1.3,
              ),
            ),
          ),

          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  item["restaurant"] ??
                      "Keke's Breakfast Cafe",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  item["address"] ??
                      "505 5th Ave NE, St Petersburg",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 9,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: Text(
              item["price"],
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xff163A69),
              ),
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (selected) {
                        selectedRows.remove(index);
                      } else {
                        selectedRows.add(index);
                      }
                    });
                  },
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: selected
                          ? const Color(0xff22B573)
                          : const Color(0xffD7F4E8),
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xffFFEAEA),
                    borderRadius:
                    BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget buildPagination() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [

          const Text(
            "Items Per Page",
            style: TextStyle(fontSize: 11),
          ),

          const SizedBox(width: 10),

          Container(
            width: 60,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xffDCE6F0),
              ),
              borderRadius:
              BorderRadius.circular(8),
            ),
            child: Text(
              itemsPerPage.toString(),
            ),
          ),

          const Spacer(),

          IconButton(
            icon: const Icon(
              Icons.chevron_left,
            ),
            onPressed: currentPage > 1
                ? () {
              setState(() {
                currentPage--;
              });
            }
                : null,
          ),

          ...List.generate(
            totalPages,
                (index) {
              final page = index + 1;

              return InkWell(
                onTap: () {
                  setState(() {
                    currentPage = page;
                  });
                },
                child: Container(
                  margin:
                  const EdgeInsets.symmetric(
                      horizontal: 4),
                  width: 32,
                  height: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: currentPage == page
                        ? const Color(0xff1682C4)
                        : Colors.white,
                    border: Border.all(
                      color:
                      const Color(0xffDCE6F0),
                    ),
                    borderRadius:
                    BorderRadius.circular(8),
                  ),
                  child: Text(
                    page.toString(),
                    style: TextStyle(
                      fontSize: 11,
                      color: currentPage == page
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),

          IconButton(
            icon: const Icon(
              Icons.chevron_right,
            ),
            onPressed: currentPage < totalPages
                ? () {
              setState(() {
                currentPage++;
              });
            }
                : null,
          ),
        ],
      ),
    );
  }
  Widget buildFooter() {
    return Row(
      children: [
        OutlinedButton(
          onPressed: widget.onBack,
          child: const Text("Back"),
        ),

        const Spacer(),

        Text(
          "${selectedRows.length.toString().padLeft(2, '0')} Selected",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Color(0xff163A69),
          ),
        ),

        const SizedBox(width: 20),

        SizedBox(
          width: 140,
          height: 42,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor:
              const Color(0xffFF6B00),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(10),
              ),
            ),
            onPressed: widget.onNext,
            child: const Text(
              "Next",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}*/
import 'package:flutter/material.dart';
import '../components/SelectRevenueCenterMenu.dart';
import '../components/SlideLeftPopup.dart';

class MenuPricingScreen extends StatefulWidget {
  final List<String> selectedMenuItems;
  final List<Map<String, dynamic>> recommendationItems;
  final int selectedCompCount;
  final VoidCallback onBack;
  final VoidCallback onNext;

  const MenuPricingScreen({
    super.key,
    required this.selectedMenuItems,
    required this.recommendationItems,
    required this.selectedCompCount,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<MenuPricingScreen> createState() => _MenuPricingScreenState();
}

class _MenuPricingScreenState extends State<MenuPricingScreen> {
  final Set<int> selectedRows = {};
  late List<String> selectedMenuItems;

  int currentPage = 1;
  int itemsPerPage = 5;

  @override
  void initState() {
    super.initState();
    selectedMenuItems = widget.selectedMenuItems;
  }

  List<Map<String, dynamic>> get paginatedItems {
    final start = (currentPage - 1) * itemsPerPage;
    final end = (start + itemsPerPage).clamp(0, widget.recommendationItems.length);
    return widget.recommendationItems.sublist(start, end);
  }

  int get totalPages =>
      (widget.recommendationItems.length / itemsPerPage).ceil();

  bool get hasSelectedMenu => selectedMenuItems.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          buildSearchDropdown(),
          const SizedBox(height: 10),

          if (!hasSelectedMenu)
            const Expanded(
              child: Center(
                child: Text("Select a menu item"),
              ),
            )
          else ...[
            buildSelectedMenuCard(),
            const SizedBox(height: 10),
            buildRecommendationHeader(),
            const SizedBox(height: 10),
            Expanded(child: buildRecommendationTable()),
            const SizedBox(height: 10),
            buildFooter(),
          ]
        ],
      ),
    );
  }

  // ================= SEARCH =================
  Widget buildSearchDropdown() {
    return InkWell(
      onTap: () async {
        final result = await SlideLeftPopup.show(
          context,
          content: const SelectRevenueCenterMenu(),
        );

        if (result is List<String>) {
          setState(() => selectedMenuItems = result);
        }
      },
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffD7E2EC)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          children: [
            Expanded(child: Text("Search Menu", style: TextStyle(fontSize: 12))),
            Icon(Icons.keyboard_arrow_down, size: 18),
          ],
        ),
      ),
    );
  }

  // ================= SELECTED CARD =================
  Widget buildSelectedMenuCard() {
    final first = selectedMenuItems.first;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDCE6F0)),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$first - \$21.50",
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (selectedMenuItems.length > 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xffEAF5FF),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "+${selectedMenuItems.length - 1}",
                style: const TextStyle(fontSize: 10),
              ),
            )
        ],
      ),
    );
  }

  // ================= HEADER =================
  Widget buildRecommendationHeader() {
    return Row(
      children: [
        const Icon(Icons.auto_awesome, size: 14, color: Color(0xffFF6B00)),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            "Recommended Items",
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }

  // ================= TABLE =================
  Widget buildRecommendationTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xffDCE6F0)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          buildTableHeader(),

          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: 900, // prevents overflow
                child: ListView.builder(
                  itemCount: paginatedItems.length,
                  itemBuilder: (_, i) {
                    final index =
                        (currentPage - 1) * itemsPerPage + i;
                    return buildRow(paginatedItems[i], index);
                  },
                ),
              ),
            ),
          ),

          buildPagination(),
        ],
      ),
    );
  }

  // ================= HEADER ROW =================
  Widget buildTableHeader() {
    return Container(
      padding: const EdgeInsets.all(8),
      color: const Color(0xffEDF5FB),
      child: const Row(
        children: [
          Expanded(flex: 2, child: Text("Item", style: TextStyle(fontSize: 11))),
          Expanded(flex: 3, child: Text("Description", style: TextStyle(fontSize: 11))),
          Expanded(flex: 3, child: Text("Comp", style: TextStyle(fontSize: 11))),
          Expanded(child: Text("Price", style: TextStyle(fontSize: 11))),
          Expanded(child: Center(child: Text("Action", style: TextStyle(fontSize: 11)))),
        ],
      ),
    );
  }

  // ================= ROW =================
  Widget buildRow(Map<String, dynamic> item, int index) {
    final selected = selectedRows.contains(index);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xffEEE))),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(item["menuItem"],
                style: const TextStyle(fontSize: 11),
                overflow: TextOverflow.ellipsis),
          ),
          Expanded(
            flex: 3,
            child: Text(
              item["description"] ?? "—",
              style: const TextStyle(fontSize: 10),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              item["restaurant"] ?? "—",
              style: const TextStyle(fontSize: 10),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Expanded(
            child: Text(item["price"],
                style: const TextStyle(fontSize: 11)),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selected
                          ? selectedRows.remove(index)
                          : selectedRows.add(index);
                    });
                  },
                  child: buildActionButton(
                    Icons.check,
                    selected
                        ? Colors.green
                        : Colors.grey.shade400,
                    isActive: selected,
                  ),
                ),
                const SizedBox(width: 6),
                buildActionButton(
                  Icons.close,
                  selected
                      ? Colors.redAccent
                      : Colors.red,
                  isActive: false,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ================= PAGINATION =================
  Widget buildPagination() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Text("Page $currentPage / $totalPages",
              style: const TextStyle(fontSize: 11)),

          const Spacer(),

          IconButton(
            icon: const Icon(Icons.chevron_left),
            onPressed: currentPage > 1
                ? () => setState(() => currentPage--)
                : null,
          ),

          IconButton(
            icon: const Icon(Icons.chevron_right),
            onPressed: currentPage < totalPages
                ? () => setState(() => currentPage++)
                : null,
          ),
        ],
      ),
    );
  }

  // ================= FOOTER =================
  Widget buildFooter() {
    return Row(
      children: [
        /*OutlinedButton(
          onPressed: widget.onBack,
          child: const Text("Back", style: TextStyle(fontSize: 12)),
        ),*/
        OutlinedButton(
          onPressed: widget.onBack,
          style: OutlinedButton.styleFrom(
            backgroundColor: const Color(0xFFFFFFFF),
            foregroundColor: const Color(0xFFFF7A00), // text color
            side: const BorderSide(
              color: Color(0xFFFF7A00), // orange border
              width: 1.5,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            minimumSize: const Size(140, 44),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          child: const Text("Previous"),
        ),
        const Spacer(),
        Text(
          "${selectedRows.length} Selected",
          style: const TextStyle(fontSize: 14,
            fontWeight: FontWeight.w600,),
        ),
        const SizedBox(width: 10),
        /*ElevatedButton(
          onPressed: widget.onNext,
          child: const Text("Next", style: TextStyle(fontSize: 12)),
        )*/
        InkWell(
          onTap: () {
            if (selectedMenuItems.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Select at least one menu"),
                ),
              );
              return;
            }

            widget.onNext();
          },
          child: Container(
            height: 32,
            width: 120,
            decoration: BoxDecoration(
              color: const Color(0xffFF6B00),
              borderRadius:
              BorderRadius.circular(10),
            ),
            child: const Center(
              child: Text(
                "Next",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
Widget buildActionButton(
    IconData icon,
    Color color, {
      bool isActive = false,
    }) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 180),
    height: 30,
    width: 30,
    decoration: BoxDecoration(
      color: isActive
          ? color
          : color.withOpacity(.10),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(
        color: isActive
            ? color
            : color.withOpacity(.25),
      ),
    ),
    child: Icon(
      icon,
      size: 15,
      color:
      isActive ? Colors.white : color,
    ),
  );
}