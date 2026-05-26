import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../components/SlideLeftPopup.dart';
import '../components/dropdown_searchable.dart';
import 'EditRevenueCenter.dart';
import 'ValidateMenu.dart';
class StatItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const StatItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28,vertical: 16),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5FD),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: const Color(0xFF0A7BC1),
              size: 28,
            ),
          ),

          const SizedBox(width: 18),

          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Color(0xFF0A7BC1),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  value,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0B2341),
                    height: 1,
                    fontFeatures: const [
                      FontFeature.tabularFigures(),
                      FontFeature.liningFigures(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RevenueCenterCards extends StatefulWidget {
  const RevenueCenterCards({super.key});

  @override
  State<RevenueCenterCards> createState() => _RevenueCenterCardsState();
}

class _RevenueCenterCardsState extends State<RevenueCenterCards> {
  final TextEditingController searchController = TextEditingController();

  String selectedAirport = 'ATL';
  String selectedCuisine = 'All';
  int currentPage = 1;
  final int itemsPerPage = 6;
  bool get isFilterApplied =>
      searchController.text.trim().isNotEmpty ||
          selectedAirport != 'ATL' ||
          selectedCuisine != 'All';

  final List<Map<String, dynamic>> items = [
    {
      "title": "Atlanta Bread",
      "cuisine": "American",
      "concept": "QSR",
      "location": "Terminal 2 East, Gate 18,\nPre–Security",
    },
    {
      "title": "Popeyes",
      "cuisine": "American",
      "concept": "QSR",
      "location": "Terminal 2 East, Gate 18,\nPre–Security",
    },
    {
      "title": "Famous Familia Pizzeria",
      "cuisine": "American",
      "concept": "Quick_Casual",
      "location": "Terminal 1, Gate 5,\nPre–Security",
    },
    {
      "title": "Baja Fresh",
      "cuisine": "American",
      "concept": "Quick_Casual",
      "location": "Terminal 2, Gate 34, Post-\nSecurity",
    },
    {
      "title": "We Juice It",
      "cuisine": "American",
      "concept": "Other",
      "location": "Terminal 2 East, Gate 18,\nPre–Security",
    },
    {
      "title": "Phillips Breakfast",
      "cuisine": "American",
      "concept": "Other",
      "location": "Terminal 2 East, Gate 18,\nPre–Security",
    },
    {
      "title": "Atlanta Bread",
      "cuisine": "American",
      "concept": "QSR",
      "location": "Terminal 2 East, Gate 18,\nPre–Security",
    },
    {
      "title": "Popeyes",
      "cuisine": "American",
      "concept": "QSR",
      "location": "Terminal 2 East, Gate 18,\nPre–Security",
    },
    {
      "title": "xyz Familia Pizzeria",
      "cuisine": "American",
      "concept": "Quick_Casual",
      "location": "Terminal 1, Gate 5,\nPre–Security",
    },
    {
      "title": "adsf Fresh",
      "cuisine": "India",
      "concept": "Quick_Casual",
      "location": "Terminal 2, Gate 34, Post-\nSecurity",
    },
    {
      "title": "We sip It",
      "cuisine": "American",
      "concept": "Other",
      "location": "Terminal 2 East, Gate 18,\nPre–Security",
    },
    {
      "title": "prestige Breakfast",
      "cuisine": "American",
      "concept": "Other",
      "location": "Terminal 2 East, Gate 18,\nPre–Security",
    },
  ];
  List<Map<String, dynamic>> get paginatedItems {
    final startIndex = (currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    return items.sublist(
      startIndex,
      endIndex > items.length ? items.length : endIndex,
    );
  }
  int get totalPages => (items.length / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            /// FILTER SECTION
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const LabelText("Select Airport"),
                const SizedBox(width: 10),

                SizedBox(
                  //width: 130,
                  child: CustomDropdown(
                    value: selectedAirport,
                    items: const ['ATL', 'LAX', 'JFK'],
                    onChanged: (v) {
                      setState(() => selectedAirport = v!);
                    },
                  ),
                ),

                const SizedBox(width: 18),

                const LabelText("Select Cuisine"),
                const SizedBox(width: 10),

                SizedBox(
                  //width: 130,
                  child: CustomDropdown(
                    value: selectedCuisine,
                    items: const ['All', 'American', 'Italian'],
                    onChanged: (v) {
                      setState(() => selectedCuisine = v!);
                    },
                  ),
                ),

                const SizedBox(width: 18),

                const LabelText("Search"),
                const SizedBox(width: 10),

                Expanded(
                  child: SizedBox(
                    height: 42,
                    child: TextField(
                      controller: searchController,
                      onChanged: (_) => setState(() {}),
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF0A2C57),
                      ),
                      decoration: InputDecoration(
                        hintText: "Search",
                        hintStyle: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF8CA3B8),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          size: 20,
                          color: Color(0xFF8CA3B8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFD3DFEA),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFFD3DFEA),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: Color(0xFF0090DA),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /// SEARCH BUTTON
                SizedBox(
                  width: 110,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: isFilterApplied ? () {} : null,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFFB7C7D6),
                      disabledBackgroundColor: const Color(0xFFE3EDF4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Search",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isFilterApplied
                            ? Colors.white
                            : const Color(0xFF8CA3B8),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 14),

                /// CLEAR BUTTON
                SizedBox(
                  width: 120,
                  height: 42,
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        selectedAirport = 'ATL';
                        selectedCuisine = 'All';
                        searchController.clear();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Color(0xFFFF7A1A),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Clear All",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFFFF7A1A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// GRID
            LayoutBuilder(
              builder: (context, constraints) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: paginatedItems.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,

                    /// FIX OVERFLOW HERE
                    childAspectRatio: constraints.maxWidth > 1400
                        ? 1.45
                        : constraints.maxWidth > 1100
                        ? 1.28
                        : 1.12,
                  ),
                  itemBuilder: (context, index) {
                    return RevenueCard(
                      item: paginatedItems[index],

                      onUpdate: (updatedItem) {
                        final originalIndex =
                        items.indexOf(paginatedItems[index]);

                        setState(() {
                          items[originalIndex] = updatedItem;
                        });
                      },

                      onDelete: (deletedItem) {
                        setState(() {
                          items.remove(deletedItem);
                        });
                      },
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 28),

            /// FOOTER
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Text(
                      "Items Per Page",
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF0A2C57),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Container(
                      width: 72,
                      height: 38,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: const Color(0xFFD3DFEA),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "06",
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF0A2C57),
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 20,
                            color: Color(0xFF0A2C57),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                /// PAGINATION
                Row(
                  children: [
                    PageButton(
                      icon: Icons.chevron_left,
                      disabled: currentPage == 1,
                      onTap: () {
                        if (currentPage > 1) {
                          setState(() {
                            currentPage--;
                          });
                        }
                      },
                    ),

                    const SizedBox(width: 10),

                    NumberButton(
                      text: "01",
                      active: currentPage == 1,
                    ),

                    const SizedBox(width: 10),

                    NumberButton(
                      text: "02",
                      active: currentPage == 2,
                    ),

                    const SizedBox(width: 10),

                    PageButton(
                      icon: Icons.chevron_right,
                      disabled: currentPage == 2,
                      onTap: () {
                        if (currentPage < 2) {
                          setState(() {
                            currentPage++;
                          });
                        }
                      },
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RevenueCard extends StatefulWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) onUpdate;
  final Function(Map<String, dynamic>) onDelete;

  const RevenueCard({
    super.key,
    required this.item,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<RevenueCard> createState() => _RevenueCardState();
}

class _RevenueCardState extends State<RevenueCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE1EDF5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP HEADER
          Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "ATL",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF0090DA),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFDDF8E9),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "ACTIVE",
                  style: TextStyle(
                    fontSize: 8,
                    color: Color(0xFF18B663),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          /// TITLE ROW
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F6FD),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.storefront_outlined,
                  size: 22,
                  color: Color(0xFF0090DA),
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(
                    widget.item["title"],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      height: 1.3,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0A2C57),
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 8),
              PopupMenuButton<String>(
                tooltip: "",
                color: const Color(0xFF001F46),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                offset: const Offset(-10, 45),
                constraints: const BoxConstraints(
                  minWidth: 240,
                ),

                // ACTIONS
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      SlideLeftPopup.show(
                        context,
                        content: RevenueCenterPage(
                        revenueData: widget.item,
                          onSave: (updatedItem) {
                            widget.onUpdate(updatedItem);
                          },

                          onDelete: () {
                            widget.onDelete(widget.item);
                            Navigator.pop(context);
                          },
                        )
                      );
                      break;

                    case 'menus':
                      SlideLeftPopup.show(
                        context,
                        content: const ValidateMenu(),
                      );
                      break;

                    case 'comp':
                      debugPrint("View Comp Establishments clicked");
                      break;

                    case 'price':
                      debugPrint("Launch Price Analysis clicked");
                      break;
                  }
                },

                // MENU ITEMS
                itemBuilder: (context) => [
                  popupItem(
                    value: 'edit',
                    icon: Icons.edit_outlined,
                    title: "Edit Revenue Center Details",
                  ),

                  popupItem(
                    value: 'menus',
                    icon: Icons.menu_book_outlined,
                    title: "View Menus",
                  ),

                  popupItem(
                    value: 'comp',
                    icon: Icons.handshake_outlined,
                    title: "View Comp Establishments",
                  ),

                  popupItem(
                    value: 'price',
                    icon: Icons.monetization_on_outlined,
                    title: "Launch Price Analysis",
                    isLast: true,
                  ),
                ],

                // BUTTON UI
                icon: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDFF2FB),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    size: 14,
                    color: Color(0xFF0090DA),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          DetailRow(
            icon: Icons.room_service_outlined,
            text: "Cuisine : ${widget.item["cuisine"]}",
          ),

          const SizedBox(height: 10),

          DetailRow(
            icon: Icons.restaurant_menu,
            text: "Concept Type : ${widget.item["concept"]}",
          ),

          const SizedBox(height: 10),

          DetailRow(
            icon: Icons.location_on_outlined,
            text: widget.item["location"],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> popupItem({
    required String value,
    required IconData icon,
    required String title,
    bool isLast = false,
  }) {
    return PopupMenuItem<String>(
      value: value, // IMPORTANT
      height: 42,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: isLast ? 8 : 0,
        ),
        decoration: isLast
            ? BoxDecoration(
          border: Border.all(
            color: const Color(0xFF174B7A),
          ),
          borderRadius: BorderRadius.circular(10),
        )
            : null,
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 18,
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const DetailRow({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: const Color(0xFF0090DA),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              height: 1.25,
              color: Color(0xFF0A2C57),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class LabelText extends StatelessWidget {
  final String text;

  const LabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(),
    );
  }
}

class NumberButton extends StatelessWidget {
  final String text;
  final bool active;

  const NumberButton({
    super.key,
    required this.text,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: active
            ? const Color(0xFF0090DA)
            : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: active
              ? const Color(0xFF0090DA)
              : const Color(0xFFD3DFEA),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: active
              ? Colors.white
              : const Color(0xFF0A2C57),
        ),
      ),
    );
  }
}

class PageButton extends StatelessWidget {
  final IconData icon;
  final bool disabled;
  final VoidCallback? onTap;

  const PageButton({
    super.key,
    required this.icon,
    this.disabled = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: disabled ? null : onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: disabled
              ? const Color(0xFFE8F2F8)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFD3DFEA),
          ),
        ),
        child: Icon(
          icon,
          size: 22,
          color: disabled
              ? Colors.white
              : const Color(0xFF0090DA),
        ),
      ),
    );
  }
}
