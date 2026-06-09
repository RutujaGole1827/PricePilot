import 'package:flutter/material.dart';

class CompEstablishmentsScreen extends StatefulWidget {

  final Set<String> selectedCompNames;

  final VoidCallback onNext;

  const CompEstablishmentsScreen({
    super.key,
    required this.selectedCompNames,
    required this.onNext,
  });

  @override
  State<CompEstablishmentsScreen> createState() =>
      _CompEstablishmentsScreenState();
}
class _CompEstablishmentsScreenState
    extends State<CompEstablishmentsScreen> {

  final GlobalKey statusFilterKey = GlobalKey();

  String selectedStatus = "ALL";

  final Set<String> removedCompNames = {};

  final List<String> statusOptions = [
    "ALL",
    "RELEVANT",
    "NOT RELEVANT",
    "PREVIOUSLY USED",
  ];
  final List<Map<String, dynamic>> compList = [

    {
      "name": "Sweet Maple",
      "cuisine": "American",
      "type": "Quick_Casual",
      "price": "\$\$\$\$",
      "rating": "2.50",
      "status": "RELEVANT"
    },

    {
      "name": "Lapisara Eatery",
      "cuisine": "American",
      "type": "Quick_Casual",
      "price": "\$\$\$\$",
      "rating": "2.50",
      "status": "NOT RELEVANT"
    },

    {
      "name": "Kitchen Story",
      "cuisine": "American",
      "type": "Quick_Casual",
      "price": "\$\$\$\$",
      "rating": "2.50",
      "status": "PREVIOUSLY USED"
    },

    {
      "name": "Papito Hayes",
      "cuisine": "American",
      "type": "Quick_Casual",
      "price": "\$\$\$\$",
      "rating": "2.50",
      "status": "RELEVANT"
    },
  ];
  List<Map<String, dynamic>> get filteredCompList {

    return compList.where((item) {

      if (removedCompNames.contains(item["name"])) {
        return false;
      }

      if (selectedStatus == "ALL") {
        return true;
      }

      return item["status"]
          .toString()
          .toUpperCase() ==
          selectedStatus.toUpperCase();

    }).toList();
  }
  void toggleSelection(String name) {

    setState(() {

      if (widget.selectedCompNames.contains(name)) {

        widget.selectedCompNames.remove(name);

      } else {

        widget.selectedCompNames.add(name);
      }
    });
  }
  void deleteComp(String name) {

    setState(() {

      removedCompNames.add(name);

      widget.selectedCompNames.remove(name);
    });
  }
  void showStatusPopup() async {

    final RenderBox renderBox =
    statusFilterKey.currentContext!
        .findRenderObject() as RenderBox;

    final position =
    renderBox.localToGlobal(Offset.zero);

    final selected =
    await showMenu<String>(

      context: context,

      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy +
            renderBox.size.height +
            6,
        position.dx + renderBox.size.width,
        0,
      ),

      items: statusOptions.map((status) {

        return PopupMenuItem(
          value: status,
          child: Text(status),
        );

      }).toList(),
    );

    if (selected != null) {

      setState(() {
        selectedStatus = selected;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.all(12),

      child: Column(

        children: [

          buildHeader(),

          const SizedBox(height: 12),

          Flexible(
            child: buildTable(),
          ),

          const SizedBox(height: 12),

          buildFooter(),
        ],
      ),
    );
  }
  Widget buildHeader() {

    return Row(

      children: [

        const Icon(
          Icons.auto_awesome,
          color: Color(0xffFF6B00),
        ),

        const SizedBox(width: 8),

        const Expanded(
          child: Text(
            "Recommended Comp Establishments",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xffFF6B00),
            ),
          ),
        ),

        buildFilterButton(),
      ],
    );
  }
  Widget buildTable() {

    return Container(

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius:
        BorderRadius.circular(12),

        border: Border.all(
          color: const Color(0xffDCE6F0),
        ),
      ),

      child: Column(

        children: [

          buildTableHeader(),

          Expanded(

            child: ListView.builder(

              itemCount:
              filteredCompList.length,

              itemBuilder: (_, index) {

                return buildTableRow(
                  filteredCompList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  Widget buildFooter() {
    final bool isMobile =
        MediaQuery
            .of(context)
            .size
            .width < 900;
    return Row(

      children: [

        const Spacer(),

        /// NEXT BUTTON
        if (!isMobile)
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                /// SELECTED COUNT
                Text(

                  "${widget.selectedCompNames.length}"
                      " Selected",

                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 16),

                /// NEXT BUTTON
                InkWell(
                  onTap: () {
                   /* if (selectedCompNames.isEmpty) {

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Please select at least one establishment",
                          ),
                        ),
                      );

                      return;
                    }
                    setState(() {
                      currentStep = 1;
                    });*/
                    if (widget
                        .selectedCompNames
                        .isEmpty) {

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content: Text(
                            "Select at least one establishment",
                          ),
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
                      color: widget
                          .selectedCompNames.isNotEmpty
                          ? const Color(0xffFF6B00)
                          : const Color(0xff9CA3AF),
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
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget buildFilterButton() {

    return GestureDetector(

      key: statusFilterKey,

      onTap: showStatusPopup,

      child: Container(

        height: 42,

        padding:
        const EdgeInsets.symmetric(
          horizontal: 14,
        ),

        decoration: BoxDecoration(

          borderRadius:
          BorderRadius.circular(8),

          border: Border.all(
            color: const Color(0xffD7E2EC),
          ),
        ),

        child: Row(

          children: [

            Text(selectedStatus),

            const SizedBox(width: 8),

            const Icon(
              Icons.keyboard_arrow_down,
            ),
          ],
        ),
      ),
    );
  }
  Widget buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xffEDF5FB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              "Comp Establishments",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "Cuisine",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              "Concept",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              "Price",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              "Rating",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              "Status",
              style: TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Action",
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTableRow(Map<String, dynamic> item) {
    final bool isSelected =
    widget.selectedCompNames.contains(item["name"]);

    return Container(
      margin: const EdgeInsets.only(top: 6),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xffE4EDF5),
        ),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              item["name"],
              style: const TextStyle(
                fontSize: 12,
              ),
            ),
          ),

          Expanded(
            child: Text(
              item["cuisine"],
              style: const TextStyle(fontSize: 12),
            ),
          ),

          Expanded(
            child: Text(
              item["type"],
              style: const TextStyle(fontSize: 12),
            ),
          ),

          Expanded(
            child: Text(
              item["price"],
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xffFF6B00),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Expanded(
            child: Text(
              item["rating"],
              style: const TextStyle(fontSize: 12),
            ),
          ),

          Expanded(
            child: buildStatusChip(
              item["status"],
            ),
          ),

          Expanded(
            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [

                /// SELECT BUTTON
                GestureDetector(
                  onTap: () {
                    toggleSelection(item["name"]);
                  },
                  child: buildActionButton(
                    Icons.check,
                    isSelected
                        ? Colors.green
                        : Colors.grey.shade400,
                    isActive: isSelected,
                  ),
                ),

                const SizedBox(width: 8),

                /// DELETE BUTTON
                GestureDetector(
                  onTap: () {
                    deleteComp(item["name"]);
                  },
                  child: buildActionButton(
                    Icons.close,
                    isSelected
                        ? Colors.redAccent
                        : Colors.red,
                    isActive: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  // ================= ACTION BUTTON =================

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

  // ================= CHIP =================

  Widget buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: status=="RELEVANT"? Colors.green.shade100:
        status=="NOT RELEVANT"? Colors.grey.shade100 :Colors.purple.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10,
          color: status=="RELEVANT"? Colors.green:
          status=="NOT RELEVANT"? Colors.black :Colors.purple,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

}