import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/SlideLeftPopup.dart';
import 'AddAirport.dart';
import 'ValidateMenu.dart';
import 'add-update_Menu.dart';
import 'editCompEstablishment.dart';

class Compestablishments extends StatefulWidget {
  const Compestablishments({super.key});

  @override
  State<Compestablishments> createState() => _CompestablishmentsState();
}

class _CompestablishmentsState extends State<Compestablishments> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Competition Establishments",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF1D4E89),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Competition Establishments",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF123D6A),
                        ),
                      ),
                    ],
                  ),
        
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF7A1A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      showGeneralDialog(
                        context: context,
                        barrierDismissible: true,
                        barrierLabel: "Popup",
                        barrierColor: Colors.black54,
                        transitionDuration:
                        const Duration(milliseconds: 350),
                        pageBuilder: (_, __, ___) {
                          return const Align(
                            alignment: Alignment.centerRight,
                            child: AddAirport(),
                          );
                        },
                        transitionBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final offsetAnimation = Tween<Offset>(
                            begin: const Offset(1, 0),
                            end: Offset.zero,
                          ).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOut,
                            ),
                          );
        
                          return SlideTransition(
                            position: offsetAnimation,
                            child: child,
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    label: const Text(
                      "Add New",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
        
              const SizedBox(height: 24),
        
              /// STATS
              const StatsCardUI(),
        
              const SizedBox(height: 24),
        
              /// LIST
              RestaurantList(),
            ],
          ),
        ),
      ),
    );
  }
}

class StatsCardUI extends StatelessWidget {
  const StatsCardUI({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,// Color(0xffF7F7F7),
        borderRadius: BorderRadius.circular(28),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CompStatItem(
            title: "Total",
            value: "570",
            lineColor: Color(0xffCDEFFF),
          ),
          CompStatItem(
            title: "Closed",
            value: "45",
            lineColor: Color(0xffF7D6D6),
          ),
          CompStatItem(
            title: "Relevant",
            value: "235",
            lineColor: Color(0xffC8F0E2),
          ),
          CompStatItem(
            title: "Not Relevant",
            value: "90",
            lineColor: Color(0xffF6DEC8),
          ),
          CompStatItem(
            title: "Previously Used",
            value: "130",
            lineColor: Color(0xffE4D4FF),
          ),
          CompStatItem(
            title: "New",
            value: "50",
            lineColor: Color(0xffD5D9FF),
          ),
        ],
      ),
    );
  }
}

class CompStatItem extends StatelessWidget {
  final String title;
  final String value;
  final Color lineColor;

  const CompStatItem({
    super.key,
    required this.title,
    required this.value,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 72,
          decoration: BoxDecoration(
            color: lineColor,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(width: 14),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xff0077B6),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 6),
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
      ],
    );
  }
}


/// ======================================================
/// HEADER
/// ======================================================

class CompetitionHeader extends StatelessWidget {
  const CompetitionHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),

        /// SEARCH
        Container(
          width: 240,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xffd6e7f5),
            ),
          ),
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search,
                color: Color(0xff7f8ea3),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextField(
                  style: const TextStyle(
                    fontSize: 12,
                    height: 1.2,
                  ),
                  decoration: const InputDecoration(
                    hintText: "Search..",
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontSize: 12,
                      color: Color(0xff8ba0b2),
                    ),
                    isCollapsed: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    RestaurantSearchController.instance.search(value);
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xffeef5fb),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "ENTER",
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xff8ba0b2),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),

        const SizedBox(width: 18),

        /// FILTER
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xffff7a1a),
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () {},
          icon: const Icon(
            Icons.filter_alt_outlined,
            color: Colors.white,
          ),
          label: const Text(
            "Filter",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

/// MODEL

class RestaurantModel {
  final String airport;
  final String title;
  final String website;
  final String description;
  final String cuisine;
  final String address;
  final String notes;
  final String validatedBy;
  final String validatedDate;
  final String updatedDate;
  final bool relevant;
  final bool required;

  String menuName;
  List<String> menus;

  RestaurantModel({
    required this.airport,
    required this.title,
    required this.website,
    required this.description,
    required this.cuisine,
    required this.address,
    required this.notes,
    required this.validatedBy,
    required this.validatedDate,
    required this.updatedDate,
    required this.relevant,
    required this.required,

    this.menuName = "",
    this.menus = const [],
  });
}

/// SEARCH CONTROLLER

class RestaurantSearchController {
  RestaurantSearchController._();

  static final instance =
  RestaurantSearchController._();

  Function(String value)? onSearch;

  void search(String value) {
    if (onSearch != null) {
      onSearch!(value);
    }
  }
}
/// RESTAURANT LIST

class RestaurantList extends StatefulWidget {
  const RestaurantList({super.key});

  @override
  State<RestaurantList> createState() => _RestaurantListState();
}

class _RestaurantListState extends State<RestaurantList> {
  int itemsPerPage = 6;
  int currentPage = 1;

  final List<RestaurantModel> allRestaurants = List.generate(
    22,
        (index) => RestaurantModel(
      airport: "ATL",
      title: [
        "Atlanta Bread Woodstock",
        "Urban Pie",
        "Alessio's Restaurant",
        "Bread Smyrna",
        "Grits & Eggs Kitchen",
        "Pizza Hub",
      ][index % 6],
      website: [
        "atlantabreadwoodstock.com",
        "urbanpie.com",
        "alessiospizza.com",
        "breadsmyrna.com",
        "gritseggs.com",
        "pizzahub.com",
      ][index % 6],
      description:
      "Enduring, family-run venue serving German-American cuisine & spirits in a warm casual space.",
      cuisine: [
        "American",
        "Italian",
        "Mexican",
        "Breakfast"
      ][index % 4],
      address:
      "8090 Folsom Blvd, Sacramento, CA 95826, USA",
      notes:
      "Family owned. They have German Entrees.",
      validatedBy: "Rebecca G.",
      validatedDate: "02/20/26",
      updatedDate: "03/${10 + index}/26",
      relevant: index % 2 == 0,
      required: index % 3 == 0,
    ),
  );

  List<RestaurantModel> filteredRestaurants = [];

  @override
  void initState() {
    super.initState();

    filteredRestaurants = allRestaurants;

    RestaurantSearchController.instance.onSearch = (value) {
      setState(() {
        currentPage = 1;

        filteredRestaurants = allRestaurants.where((e) {
          return e.title.toLowerCase().contains(value.toLowerCase()) ||
              e.website.toLowerCase().contains(value.toLowerCase()) ||
              e.cuisine.toLowerCase().contains(value.toLowerCase());
        }).toList();
      });
    };
  }

  int get totalPages {
    if (filteredRestaurants.isEmpty) return 1;
    return (filteredRestaurants.length / itemsPerPage).ceil();
  }

  List<RestaurantModel> get paginatedData {
    final start = (currentPage - 1) * itemsPerPage;

    if (start >= filteredRestaurants.length) {
      return [];
    }

    final end = (start + itemsPerPage)
        .clamp(0, filteredRestaurants.length);

    return filteredRestaurants.sublist(start, end);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        /// SEARCH + FILTER
        const CompetitionHeader(),

        const SizedBox(height: 20),

        LayoutBuilder(
          builder: (context, constraints) {

            int crossAxisCount = 2;

            if (constraints.maxWidth < 900) {
              crossAxisCount = 1;
            }

            return GridView.builder(
              shrinkWrap: true,
              physics:
              const NeverScrollableScrollPhysics(),
              itemCount: paginatedData.length,
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio:crossAxisCount == 1 ? 2.9 : 1.75,
              ),
              /*gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),*/
              itemBuilder: (context, index) {
                return RestaurantCard(
                  restaurant: paginatedData[index],

                  onMenuUpdated: (updatedRestaurant) {
                    setState(() {});
                  },

                  /// EDIT
                  onEdit: (restaurant, updatedData) {

                    final restaurantIndex =
                    allRestaurants.indexOf(restaurant);

                    setState(() {

                      allRestaurants[restaurantIndex] =
                          RestaurantModel(
                            airport: restaurant.airport,

                            title:
                            updatedData["name"] ??
                                restaurant.title,

                            website:
                            updatedData["website"] ??
                                restaurant.website,

                            description:
                            restaurant.description,

                            cuisine:
                            updatedData["cuisine"] ??
                                restaurant.cuisine,

                            address:
                            restaurant.address,

                            notes:
                            updatedData["notes"] ??
                                restaurant.notes,

                            validatedBy:
                            restaurant.validatedBy,

                            validatedDate:
                            restaurant.validatedDate,

                            updatedDate:
                            DateTime.now()
                                .toString()
                                .substring(0, 10),

                            relevant:
                            updatedData["status"] == "Active",

                            required:
                            restaurant.required,

                            menuName:
                            restaurant.menuName,

                            menus:
                            restaurant.menus,
                          );

                      filteredRestaurants =
                          List.from(allRestaurants);
                    });
                  },

                  /// DELETE
                  onDelete: (restaurant) {

                    setState(() {

                      allRestaurants.remove(restaurant);

                      filteredRestaurants =
                          List.from(allRestaurants);
                    });
                  },
                );
              },
            );
          },
        ),

        const SizedBox(height: 24),

        /// PAGINATION
        Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [

            /// ITEMS PER PAGE
            Row(
              children: [
                const Text(
                  "Items Per Page",
                  style: TextStyle(fontSize: 13),
                ),

                const SizedBox(width: 10),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xffd9e7f3),
                    ),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: DropdownButton<int>(
                    value: itemsPerPage,
                    underline: const SizedBox(),
                    items: [4, 6, 8, 10]
                        .map(
                          (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.toString(),
                        ),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        itemsPerPage = value!;
                        currentPage = 1;
                      });
                    },
                  ),
                ),
              ],
            ),

            /// PAGE BUTTONS
            Row(
              children: [

                /// PREV
                pageButton(
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

                const SizedBox(width: 8),

                ...List.generate(
                  totalPages,
                      (index) {
                    final page = index + 1;

                    final active =
                        currentPage == page;

                    return Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentPage = page;
                          });
                        },
                        child: Container(
                          width: 36,
                          height: 36,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: active
                                ? const Color(
                                0xff0077b6)
                                : Colors.white,
                            borderRadius:
                            BorderRadius.circular(
                                10),
                            border: Border.all(
                              color: const Color(
                                  0xffd9e7f3),
                            ),
                          ),
                          child: Text(
                            page
                                .toString()
                                .padLeft(2, '0'),
                            style: TextStyle(
                              color: active
                                  ? Colors.white
                                  : const Color(
                                  0xff0077b6),
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(width: 8),

                /// NEXT
                pageButton(
                  icon: Icons.chevron_right,
                  disabled:
                  currentPage == totalPages,
                  onTap: () {
                    if (currentPage < totalPages) {
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
    );
  }

  Widget pageButton({
    required IconData icon,
    required bool disabled,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: disabled ? null : onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: disabled
              ? const Color(0xffedf4fa)
              : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffd9e7f3),
          ),
        ),
        child: Icon(
          icon,
          color: const Color(0xff0077b6),
          size: 18,
        ),
      ),
    );
  }
}

/// ======================================================
/// CARD
/// ======================================================

class RestaurantCard extends StatelessWidget {
  final RestaurantModel restaurant;
  final Function(RestaurantModel) onMenuUpdated;
  final Function(RestaurantModel, Map<String, dynamic>) onEdit;
  final Function(RestaurantModel) onDelete;

  const RestaurantCard({
    super.key,
    required this.restaurant,
    required this.onMenuUpdated,
    required this.onEdit,
    required this.onDelete,
  });

  Future<void> launchSite(String url) async {
    final uri = Uri.parse("https://$url");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xffdceaf5),
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          /// TOP BAR
          Row(
            children: [

              Text(
                restaurant.airport,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xff0077b6),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 6),

              const Text("/"),

              const SizedBox(width: 6),

              const Icon(
                Icons.language,
                size: 14,
                color: Color(0xff0077b6),
              ),

              const SizedBox(width: 4),

              Expanded(
                child: InkWell(
                  onTap: () =>
                      launchSite(restaurant.website),
                  child: Text(
                    restaurant.website,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xff0077b6),
                      decoration:
                      TextDecoration.underline,
                    ),
                  ),
                ),
              ),

              if (restaurant.relevant)
                statusBadge(
                  "RELEVANT",
                  const Color(0xffddf8e7),
                  const Color(0xff2ca56c),
                ),

              if (!restaurant.relevant)
                statusBadge(
                  "NOT RELEVANT",
                  const Color(0xfffff1e7),
                  const Color(0xffd9822f),
                ),

              PopupMenuButton<String>(
                color: const Color(0xff03264c),
                offset: const Offset(-10, 45),
                constraints: const BoxConstraints(
                  minWidth: 120,
                ),
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xffdff2fa),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    size: 18,
                    color: Color(0xff0077b6),
                  ),
                ),
                onSelected: (value) {
                  switch (value) {
                    case 'add menu':
                      SlideLeftPopup.show(
                        context,
                        content: AddMenuDrawer(
                          restaurantData: {
                            "airport": restaurant.airport,
                            "title": restaurant.title,
                            "menuName": "",
                            "menus": [],
                          },
                          onSubmit: (data) {
                            restaurant.menuName = data["menuName"] ?? "";
                            restaurant.menus =
                            List<String>.from(data["menus"] ?? []);
                            onMenuUpdated(restaurant);
                          },
                        ),
                      );
                      break;

                    case 'validate menus':
                      SlideLeftPopup.show(
                        context,
                        content: const ValidateMenu(),
                      );
                      break;

                    case 'edit details':

                      SlideLeftPopup.show(
                        context,
                        content: EditComparableEstablishment(
                          establishmentData: {
                            "name": restaurant.title,
                            "website": restaurant.website,
                            "notes": restaurant.notes,
                            "cuisine": restaurant.cuisine,
                            "conceptType": "QSR",
                            "status":
                            restaurant.relevant
                                ? "Active"
                                : "Inactive",
                            "atmosphere": "Casual",
                          },
                          /// SAVE
                          onSave: (updatedData) {
                            onEdit(
                              restaurant,
                              updatedData,
                            );
                          },
                          /// DELETE
                          onDelete: () {
                            onDelete(restaurant);
                            Navigator.pop(context);
                          },
                        ),
                      );
                      break;

                  }
                },
                itemBuilder: (context) => [
                  popupItem(
                    Icons.add,
                    "Add Menu",
                  ),
                  popupItem(
                    Icons.check_circle_outline,
                    "Validate Menus",
                  ),
                  popupItem(
                    Icons.edit_outlined,
                    "Edit Details",
                  ),
                ],
              )
            ],
          ),

          const SizedBox(height: 14),

          /// TITLE
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              Container(
                width: 42,
                height: 42,
                decoration: const BoxDecoration(
                  color: Color(0xffdff2fa),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.storefront_outlined,
                  size: 18,
                  color: Color(0xff0077b6),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Expanded(
                          child: Text(
                            restaurant.title,
                            maxLines: 1,
                            overflow:
                            TextOverflow
                                .ellipsis,
                            style:
                            const TextStyle(
                              fontSize: 17,
                              fontWeight:
                              FontWeight
                                  .w700,
                              color: Color(
                                  0xff12304f),
                            ),
                          ),
                        ),

                        const Text(
                          "\$\$",
                          style: TextStyle(
                            color: Colors.orange,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 6),

                    Text(
                      restaurant.description,
                      maxLines: 2,
                      overflow:
                      TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: Color(0xff5c7189),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),

          const SizedBox(height: 14),

          detailRow(
            Icons.lunch_dining_outlined,
            "Cuisine : ${restaurant.cuisine}",
          ),

          const SizedBox(height: 10),

          detailRow(
            Icons.location_on_outlined,
            restaurant.address,
          ),

          const SizedBox(height: 10),

          detailRow(
            Icons.article_outlined,
            restaurant.notes,
          ),

          const Spacer(),
          if (restaurant.menuName.isNotEmpty) ...[
            const SizedBox(height: 12),

            detailRow(
              Icons.menu_book_outlined,
              "Menu : ${restaurant.menuName}",
            ),
          ],

          if (restaurant.menus.isNotEmpty) ...[
            const SizedBox(height: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: restaurant.menus.map((menu) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: InkWell(
                    onTap: () => launchSite(menu),
                    child: Text(
                      menu,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff0077b6),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          /// FOOTER
          Row(
            children: [

              const Text(
                "View Menu",
                style: TextStyle(
                  fontSize: 13,
                  color: Color(0xffff7a1a),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(width: 4),

              const Icon(
                Icons.arrow_outward,
                size: 15,
                color: Color(0xffff7a1a),
              ),

              const Spacer(),

              Text(
                restaurant.updatedDate,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  PopupMenuItem<String> popupItem(
      IconData icon,
      String title,
      ) {
    return PopupMenuItem<String>(
      value: title.toLowerCase(), // IMPORTANT
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 18,
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  Widget detailRow(
      IconData icon,
      String text,
      ) {
    return Row(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 15,
          color: const Color(0xff0077b6),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xff4f6480),
            ),
          ),
        ),
      ],
    );
  }

  Widget statusBadge(
      String text,
      Color bg,
      Color txt,
      ) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          color: txt,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}