/*
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:price_pilot/pages/homescreen.dart';

import '../components/Confirmation_Popup.dart';
import '../components/SelectRevenueCenterMenu.dart';
import '../components/SlideLeftPopup.dart';


class PricingAnalytics extends StatefulWidget {
  const PricingAnalytics({super.key});

  @override
  State<PricingAnalytics> createState() =>
      _PricingAnalyticsState();
}

class _PricingAnalyticsState
    extends State<PricingAnalytics> {
  List<String> selectedMenuItems = [];

  final List<Map<String, dynamic>> recommendationItems = [
    {
      "menuItem": "Classic Cheeseburger",
      "price": "\$19.99",
      "similarity": "98%",
      "restaurant": "Sweet Maple",
    },
    {
      "menuItem": "Bacon Ranch Burger",
      "price": "\$20.50",
      "similarity": "95%",
      "restaurant": "Kitchen Story",
    },
    {
      "menuItem": "Smokehouse Burger",
      "price": "\$22.00",
      "similarity": "93%",
      "restaurant": "Papito Hayes",
    },
    {
      "menuItem": "Bleu Cheese Burger",
      "price": "\$21.75",
      "similarity": "91%",
      "restaurant": "Lapisara Eatery",
    },
  ];
  final List<String> airportList = [
    "ATL",
    "LAX",
    "ORD"
  ];

  final List<String> revenueCenterList = [
    "Atlanta Bread",
    "3 Daughter’s Brewing",
    "Alcohol",
    "Ancora Coffee Roaster – Gate 7",
  ];
  final Set<String> selectedCompNames = {};
  final Set<String> removedCompNames = {};
  String? selectedAirport;
  String? selectedRevenueCenter;
  int currentStep = 0;
  bool isApplyEnabled = false;
  bool get hasSelectedMenu => selectedMenuItems.isNotEmpty;
  bool showAnalyticsScreen = false;
  bool isLoading = false;

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
      "status": "RELEVANT"
    },
    {
      "name": "Kitchen Story",
      "cuisine": "American",
      "type": "Quick_Casual",
      "price": "\$\$\$\$",
      "rating": "2.50",
      "status": "RELEVANT"
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
  /// ================= FILTER VARIABLES =================

  final GlobalKey statusFilterKey = GlobalKey();

  String selectedStatus = "ALL";

  final List<String> statusOptions = [
    "ALL",
    "RELEVANT",
    "NOT RELEVANT",
    "PREVIOUSLY USED",
  ];

  /// FILTERED TABLE DATA
  List<Map<String, dynamic>> get filteredCompList {
    List<Map<String, dynamic>> filtered =
    compList.where((item) {
      final isRemoved =
      removedCompNames.contains(item["name"]);

      if (isRemoved) return false;

      if (selectedStatus == "ALL") {
        return true;
      }

      return item["status"]
          .toString()
          .toUpperCase() ==
          selectedStatus.toUpperCase();
    }).toList();

    return filtered;
  }
  void enableButton() {
    setState(() {
      isApplyEnabled =
          selectedAirport != null &&
              selectedRevenueCenter != null;
    });
  }

  Future<void> applyFilter() async {
    if (!isApplyEnabled) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    setState(() {
      isLoading = false;
      showAnalyticsScreen = true;
    });
  }

  void resetFilter() {
    setState(() {
      selectedAirport = null;
      selectedRevenueCenter = null;
      isApplyEnabled = false;
      showAnalyticsScreen = false;
      selectedMenuItems.clear(); // IMPORTANT
      currentStep=0;
    });
  }
  void toggleSelection(String name) {
    setState(() {
      if (selectedCompNames.contains(name)) {
        selectedCompNames.remove(name);
      } else {
        selectedCompNames.add(name);
      }
    });
  }
  void deleteComp(String name) {
    setState(() {
      removedCompNames.add(name);

      /// REMOVE FROM SELECTED ALSO
      selectedCompNames.remove(name);
    });
  }
  /// ================= STATUS FILTER POPUP =================

  void showStatusPopup() async {
    final RenderBox renderBox =
    statusFilterKey.currentContext!
        .findRenderObject() as RenderBox;

    final position = renderBox.localToGlobal(Offset.zero);

    final selected = await showMenu<String>(
      context: context,
      color: Colors.white,
      elevation: 8,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height + 6,
        position.dx + renderBox.size.width,
        0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      items: statusOptions.map((status) {
        Color dotColor;

        switch (status) {
          case "RELEVANT":
            dotColor = Colors.green;
            break;

          case "NOT RELEVANT":
            dotColor = Colors.orange;
            break;

          case "PREVIOUSLY USED":
            dotColor = Colors.purple;
            break;

          default:
            dotColor = Colors.blueGrey;
        }

        return PopupMenuItem<String>(
          value: status,
          child: Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),

              const SizedBox(width: 10),

              Text(
                status,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
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
    final bool isMobile =
        MediaQuery.of(context).size.width < 900;
    return  Scaffold(
        backgroundColor: const Color(0xffddeefa),//const Color(0xffe1e2e3),
        body: SafeArea(
            child:  Column(
              children: [
                buildHeader(isMobile),
                buildTopFilterBar(isMobile),
                Expanded(
                  child: AnimatedSwitcher(
                    duration:
                    const Duration(milliseconds: 400),
                    child: showAnalyticsScreen
                        ? buildAnalyticsScreen(isMobile)
                        : Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 6,
                      ),
                          child: buildEmptyState(),
                        ),
                  ),
                ),
                Text(
                  "Copyright © 2026 . All rights reserved.",
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.5,
                    color: Color(0xff516174),
                  ),
                ),
              ],
            )
        )
    );
  }
//=======EmptyState==========
  Widget buildEmptyState() {
    final bool isMobile =
        MediaQuery.of(context).size.width < 900;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffDCE6F0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.restaurant_menu,
            size: 48,
            color: Color(0xffFF6B00),
          ),
          const SizedBox(height: 12),
          Text(
            "No Pricing Analytics Yet",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:
              isMobile ? 18 : 22,
              fontWeight:
              FontWeight.w600,
              color:
              const Color(0xff163A69),
            ),
          ),
          SizedBox(
            height:
            isMobile ? 10 : 12,
          ),
          // DESCRIPTION
          Text(
            "Select Airport and Revenue Center filters above, then click Apply Filters to generate pricing analytics results.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:
              isMobile ? 12 : 13,
              height: 1.6,
              color:
              const Color(0xff6B7A90),
            ),
          ),
        ],
      ),
    );
  }
  // ================= TOP FILTER BAR =================

  Widget buildTopFilterBar(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 8: 12),
      color: const Color(0xffdfe6ec),
      child: isMobile
          ? Column(
        children: [
          buildDropdown(
            hint: "Select Airport",
            value: selectedAirport,
            items: airportList,
            onChanged: (value) {
              selectedAirport = value;
              enableButton();
            },
          ),

          const SizedBox(height: 10),

          buildDropdown(
            hint: "Select Revenue Center",
            value: selectedRevenueCenter,
            items: revenueCenterList,
            onChanged: (value) {
              selectedRevenueCenter = value;
              enableButton();
            },
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: buildApplyButton(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildResetButton(),
              ),
            ],
          )
        ],
      )
          : Row(
        children: [
          buildDropdown(
            hint: "Select Airport",
            value: selectedAirport,
            items: airportList,
            onChanged: (value) {
              selectedAirport = value;
              enableButton();
            },
          ),
          const SizedBox(width: 12),
          buildDropdown(
            hint: "Select Revenue Center",
            value: selectedRevenueCenter,
            items: revenueCenterList,
            onChanged: (value) {
              selectedRevenueCenter = value;
              enableButton();
            },
          ),
          Spacer(),
          buildApplyButton(),
          const SizedBox(width: 12),
          buildResetButton(),
        ],
      ),
    );
  }

  // ================= DROPDOWN =================

  Widget buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 42,width: 200,
      padding:
      const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffD7E2EC),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(10),
          hint: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
          ),
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            onChanged(value);
            setState(() {});
          },
        ),
      ),
    );
  }

  // ================= APPLY BUTTON =================

  Widget buildApplyButton() {
    return SizedBox(
      height: 42,
      width: 130,
      child: ElevatedButton(
        onPressed:
        isApplyEnabled ? applyFilter : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isApplyEnabled
              ? const Color(0xffFF6B00)
              : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Text(
          "Apply Filters",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ================= RESET BUTTON =================

  Widget buildResetButton() {
    return SizedBox(
      height: 42,
      width: 90,
      child: OutlinedButton(
        onPressed: resetFilter,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.grey.shade400,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Reset",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  // ================= MAIN ANALYTICS =================

  Widget buildAnalyticsScreen(bool isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 6,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [
            const SizedBox(height: 4),
            buildStepper(isMobile),

            Expanded(
              child: AnimatedSwitcher(
                duration:
                const Duration(milliseconds: 400),
                child: showAnalyticsScreen
                    ?buildStepContent(isMobile)
                    : buildEmptyState(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStepContent(bool isMobile) {

    switch (currentStep) {

      case 0:
        return isMobile
            ? buildMobileContent()
            : buildDesktopContent();

      case 1:
        return  buildMenuPricingContent() ;

      case 2:
        return buildSummaryContent();

      case 3:
        return buildPricingAnalysisContent();

      case 4:
        return buildFinalReviewContent();

      default:
        return buildDesktopContent();
    }
  }
  // ================= HEADER =================

  Widget buildHeader(bool isMobile) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: isMobile
          ? Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            "Pricing Analytics",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff163A69),
            ),
          ),
          const SizedBox(height: 12),
          buildInfoCard(),

        ],
      )
          : Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Pricing Analytics",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Color(0xFF123D6A),
            ),
          ),
          Row(
            children: [
              buildInfoCard(),
              SizedBox(width: 4,),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PricingApp(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xff0077B6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description_outlined, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Reports",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoCard() {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 260,
        maxWidth: 430,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xffE3EBF3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // AIRPORT
          Expanded(
            child: buildInfoColumn(
              "Airport",
              selectedAirport ?? "-",
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
          ),

          // REVENUE CENTER + EDIT
          Expanded(
            //flex: 2,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  "Revenue Center",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xff6B7A90),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedRevenueCenter ??
                            "-",
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight:
                          FontWeight.w600,
                          color: Color(0xff163A69),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    InkWell(
                      borderRadius:
                      BorderRadius.circular(
                          6),
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "Popup",
                          barrierColor: Colors.black54,
                          transitionDuration:
                          const Duration(milliseconds: 350),
                          pageBuilder:
                              (
                              context,
                              animation,
                              secondaryAnimation,
                              ) {
                            return Center(
                                child:  ConfirmationPopup(
                                  onCloseWithoutSaving: () {
                                    resetFilter;
                                    print("Closed without saving");
                                  },label: "Change Filter?",
                                  subContent: "Applying a new filter will clear the current report data and reload results based on your new selection.",
                                  backbtnlabel: "Change Filter",continuebtnlabel: "Keep Current Filter",
                                  onContinueEditing: () {
                                    print("Continue editing");
                                  },
                                ));
                          },
                          transitionBuilder:
                              (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                              ) {
                            final offsetAnimation =
                            Tween<Offset>(
                              begin: const Offset(0, -1),
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
                      child: Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration:
                        BoxDecoration(
                          color:
                          const Color(
                              0xffFFF1E7),
                          borderRadius:
                          BorderRadius
                              .circular(
                              6),
                        ),
                        child: const Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            Icon(
                              Icons
                                  .edit_outlined,
                              size: 12,
                              color: Color(
                                  0xffFF6B00),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoColumn(
      String title,
      String value,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xff6B7A90),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xff163A69),
          ),
        ),
      ],
    );
  }

  // ================= STEPPER =================

  Widget buildStepper(bool isMobile) {
    final steps = [
      "Comp Establishments",
      "Menu Pricing",
      "Summary",
      "Pricing Analysis",
      "Final Review",
    ];

    return SizedBox(
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: steps.length,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemBuilder: (context, index) {

          final bool active = index == currentStep;

          return Container(
            width: isMobile ? 160 : 220,
            margin: const EdgeInsets.only(right: 8),

            decoration: BoxDecoration(
              color: active
                  ? const Color(0xffFF6B00)
                  : const Color(0xff727C96),

              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.white,

                  child: Text(
                    "0${index + 1}",
                    style: TextStyle(
                      fontSize: 10,
                      color: active
                          ? const Color(0xffFF6B00)
                          : const Color(0xff727C96),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Flexible(
                  child: Text(
                    steps[index],
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // ================= DESKTOP CONTENT =================

  Widget buildDesktopContent() {
    return Row(
      children: [
        buildLeftPanel(),

        Expanded(
          child: buildTableSection(),
        ),
      ],
    );
  }

  // ================= MOBILE CONTENT =================

  Widget buildMobileContent() {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildLeftPanel(),
          buildTableSection(),
        ],
      ),
    );
  }

  // ================= LEFT PANEL =================

  Widget buildLeftPanel() {
    return Container(
      width: 220,
      margin: const EdgeInsets.fromLTRB(8, 8, 4, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffEEF5FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: const Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              "ATL",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "Atlanta Bread",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 18),

            SideText("Cuisine", "American"),

            SizedBox(height: 14),

            SideText(
              "Concept Type",
              "Quick_Casual",
            ),

            SizedBox(height: 14),

            SideText(
              "Location",
              "International Terminal G\n(Gate 99/101)",
            ),
          ],
        ),
      ),
    );
  }

  // ================= TABLE =================

  Widget buildTableSection() {
    final bool isMobile =
        MediaQuery.of(context).size.width < 900;

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 8, 8, 8),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          /// HEADER + FILTER
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            children: [

              /// TITLE
              Expanded(
                child: Row(
                  children: const [
                    Icon(
                      Icons.auto_awesome,
                      color: Color(0xffFF6B00),
                      size: 18,
                    ),

                    SizedBox(width: 8),

                    Text(
                      "Recommended Comp Establishments",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xffFF6B00),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              /// FILTER BUTTON
              buildFilterButton(),
            ],
          ),

          const SizedBox(height: 14),

          /// TABLE
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
                border: Border.all(
                  color: const Color(0xffE4EDF5),
                ),
                color: Colors.white,
              ),

              child: Column(
                children: [

                  /// HEADER
                  buildTableHeader(),

                  /// BODY
                  Expanded(
                    child: filteredCompList.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: const [

                          Icon(
                            Icons.search_off,
                            size: 42,
                            color:
                            Colors.grey,
                          ),

                          SizedBox(height: 12),

                          Text(
                            "No matching establishments found",
                            style: TextStyle(
                              color:
                              Colors.grey,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      itemCount:
                      filteredCompList
                          .length,
                      itemBuilder:
                          (context, index) {

                        final item =
                        filteredCompList[
                        index];

                        return buildTableRow(
                            item);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          if (!isMobile)
            const SizedBox(height: 12),

    Row(
    children: [
    Align(
    alignment: Alignment.bottomLeft,
    child: OutlinedButton(
    onPressed: () => currentStep = currentStep-1,
    child: const Text("Back"),
    ),
    ),

    Spacer(),
          /// NEXT BUTTON
          if (!isMobile)
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  /// SELECTED COUNT
                  Text(
                    "${selectedCompNames.length.toString().padLeft(2, '0')}Selected",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff163A69),
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// NEXT BUTTON
                  InkWell(
                    onTap: () {

                      if (selectedCompNames.isEmpty) {

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
                      });
                    },
                    child: Container(
                      height: 48,
                      width: 160,
                      decoration: BoxDecoration(
                        color: selectedCompNames.isNotEmpty
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
    ])
        ],
      ),
    );
  }
  Widget buildSummaryContent() {
    return const Center(
      child: Text(
        "Summary Screen",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildPricingAnalysisContent() {
    return const Center(
      child: Text(
        "Pricing Analysis Screen",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget buildFinalReviewContent() {
    return const Center(
      child: Text(
        "Final Review Screen",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
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
    selectedCompNames.contains(item["name"]);

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

  // ================= CHIP =================

  Widget buildStatusChip(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.green,
          fontWeight: FontWeight.w600,
        ),
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

  Widget buildFilterButton() {
    return GestureDetector(
      key: statusFilterKey,
      onTap: () {
        showStatusPopup();
      },
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xffD7E2EC),
          ),
        ),

        child: Row(
          children: [

            /// TEXT
            Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Text(
                selectedStatus == "ALL"
                    ? "Filter By Status"
                    : selectedStatus,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight:
                  FontWeight.w500,
                  color: Color(0xff1682C4),
                ),
              ),
            ),

            /// DIVIDER
            Container(
              width: 1,
              height: double.infinity,
              color: const Color(0xffD7E2EC),
            ),

            /// ICON
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
              ),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Color(0xff1682C4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// ================= RECOMMENDATION UI =================

  Widget buildMenuPricingContent() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          /// SEARCH DROPDOWN
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: InkWell(
              onTap: () async {
                final result = await SlideLeftPopup.show(
                  context,
                  content: const SelectRevenueCenterMenu(),
                );

                if (result != null &&
                    result is List<String> &&
                    result.isNotEmpty) {
                  setState(() {
                    selectedMenuItems = result;
                  });
                }
              },
              child: Container(
                height: 42,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xffD7E2EC),
                  ),
                ),
                child: const Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Search Menu",
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Icon(Icons.keyboard_arrow_down),
                  ],
                ),
              ),
            ),
          ),

          //const SizedBox(height: 14),

          if (!hasSelectedMenu)
            Expanded(child: buildEmptyState())
          else ...[
            buildSelectedMenuCard(),
            const SizedBox(height: 14),
            buildRecommendationHeader(),
            const SizedBox(height: 12),
            Expanded(child: buildRecommendationTable()),
            const SizedBox(height: 12),
            buildRecommendationFooter(),
          ],
        ],
      ),
    );
  }
  Widget buildSelectedMenuCard() {
    return Container(
      padding: const EdgeInsets.all(12),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Bacon Bleu - \$21.50",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff163A69),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "All beef patty, Point Rese bleu cheese, A-1, smoked bacon, lettuce, red onion. Toasted brioche bun.",
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Color(0xffEAF5FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.remove,
              size: 18,
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
          size: 18,
        ),
        const SizedBox(width: 6),
        const Expanded(
          child: Text(
            'Recommended Menu Items For "Bacon Bleu"',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xffFF6B00),
            ),
          ),
        ),
        SizedBox(
          width: 250,
          height: 38,
          child: TextField(
            style: const TextStyle(fontSize: 11),
            decoration: InputDecoration(
              hintText: "Search By Item",
              hintStyle: const TextStyle(fontSize: 11),
              prefixIcon: const Icon(Icons.search, size: 18),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
  Widget buildRecommendationTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
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
            flex: 4,
            child: Text(
              "Menu Item",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Price",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              "Similarity",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              "Restaurant",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildRecommendationTable() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffDCE6F0),
        ),
      ),
      child: Column(
        children: [
          buildRecommendationTableHeader(),

          Expanded(
            child: ListView.builder(
              itemCount: recommendationItems.length,
              itemBuilder: (_, index) {
                return buildRecommendationRow(
                  recommendationItems[index],
                );
              },
            ),
          ),

          buildPagination(),
        ],
      ),
    );
  }
  Widget buildRecommendationFooter() {
    return Row(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back"),
            ),
          ),
          Spacer(),
          Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "${selectedCompNames.length.toString().padLeft(2, '0')} Selected",
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 12),
        SizedBox(
          width: 140,
          height: 38,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              backgroundColor: const Color(0xffFF6B00),
            ),
            onPressed: () {
              setState(() {
                currentStep = 2;
              });
            },
            child: const Text(
              "Next",
              style: TextStyle(
                fontSize: 11,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    )]);
  }
  Widget buildRecommendationRow(
      Map<String, dynamic> item,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
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
            flex: 4,
            child: Text(
              item["menuItem"],
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              item["price"],
              style: const TextStyle(fontSize: 11),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 3,
              ),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                item["similarity"],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.green,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              item["restaurant"],
              style: const TextStyle(
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildPagination() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            iconSize: 18,
            onPressed: () {},
            icon: const Icon(Icons.chevron_left),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: const Color(0xffFF6B00),
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Text(
              "1",
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            iconSize: 18,
            onPressed: () {},
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

// ================= SIDE TEXT =================

class SideText extends StatelessWidget {
  final String title;
  final String value;

  const SideText(
      this.title,
      this.value, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          "$title :",
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff1682C4),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}*/
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:price_pilot/pages/pricingTab.dart';
import 'package:price_pilot/pages/summaryTab.dart';
import '../components/Confirmation_Popup.dart';
import 'compTab.dart';
import 'finalreviewTab.dart';
import 'homescreen.dart';
import 'menu_pricing_screen.dart';

class PricingAnalytics extends StatefulWidget {
  const PricingAnalytics({super.key});

  @override
  State<PricingAnalytics> createState() =>
      _PricingAnalyticsState();
}
class _PricingAnalyticsState
    extends State<PricingAnalytics> {

  int currentStep = 0;

  bool showAnalyticsScreen = false;
  bool isLoading = false;

  String? selectedAirport;
  String? selectedRevenueCenter;

  bool isApplyEnabled = false;

  List<String> selectedMenuItems = [];

  final Set<String> selectedCompNames = {};

  final List<String> airportList = [
    "ATL",
    "LAX",
    "ORD"
  ];

  final List<String> revenueCenterList = [
    "Atlanta Bread",
    "3 Daughter’s Brewing",
    "Alcohol",
    "Ancora Coffee Roaster – Gate 7",
  ];
  final List<Map<String, dynamic>> recommendationItems = [
    {
      "menuItem": "Classic Cheeseburger",
      "price": "\$19.99",
      "similarity": "98%",
      "restaurant": "Sweet Maple",
    },
    {
      "menuItem": "Bacon Ranch Burger",
      "price": "\$20.50",
      "similarity": "95%",
      "restaurant": "Kitchen Story",
    },
    {
      "menuItem": "Smokehouse Burger",
      "price": "\$22.00",
      "similarity": "93%",
      "restaurant": "Papito Hayes",
    },
    {
      "menuItem": "Bleu Cheese Burger",
      "price": "\$21.75",
      "similarity": "91%",
      "restaurant": "Lapisara Eatery",
    },
  ];

  Future<void> applyFilter() async {
    if (!isApplyEnabled) return;

    setState(() {
      isLoading = true;
    });

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    setState(() {
      isLoading = false;
      showAnalyticsScreen = true;
    });
  }

  void resetFilter() {
    setState(() {
      selectedAirport = null;
      selectedRevenueCenter = null;

      isApplyEnabled = false;

      showAnalyticsScreen = false;

      currentStep = 0;

      selectedCompNames.clear();
      selectedMenuItems.clear();
    });
  }

  void enableButton() {
    setState(() {
      isApplyEnabled =
          selectedAirport != null &&
              selectedRevenueCenter != null;
    });
  }

  Widget buildRightPanel() {
    switch (currentStep) {
      case 0:
        return CompEstablishmentsScreen(

          selectedCompNames: selectedCompNames,

          onNext: () {
            setState(() {
              currentStep = 1;
            });
          },
        );

      case 1:
        return MenuPricingScreen(

          selectedMenuItems: selectedMenuItems,

          recommendationItems: recommendationItems,

          selectedCompCount:
          selectedCompNames.length,

          onBack: () {
            setState(() {
              currentStep = 0;
            });
          },

          onNext: () {
            setState(() {
              currentStep = 2;
            });
          },
        );

      case 2:
        return SummaryScreen(

          onBack: () {
            setState(() {
              currentStep = 1;
            });
          },

          onNext: () {
            setState(() {
              currentStep = 3;
            });
          },
        );

      case 3:
        return PricingAnalysisScreen(

          onBack: () {
            setState(() {
              currentStep = 2;
            });
          },

          onNext: () {
            setState(() {
              currentStep = 4;
            });
          },
        );

      case 4:
        return FinalReviewScreen(

          onBack: () {
            setState(() {
              currentStep = 3;
            });
          },
        );

      default:
        return const SizedBox();
    }
  }
  // ================= HEADER =================

  Widget buildHeader(bool isMobile) {
    return Padding(
      padding: const EdgeInsets.all(18),
      child: isMobile
          ? Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          const Text(
            "Pricing Analytics",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xff163A69),
            ),
          ),
          const SizedBox(height: 12),
          buildInfoCard(),

        ],
      )
          : Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Pricing Analytics",
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w500,
              color: Color(0xFF123D6A),
            ),
          ),
          Row(
            children: [
              buildInfoCard(),
              SizedBox(width: 4,),
              InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PricingApp(),
                    ),
                  );
                },
                child: Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xff0077B6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.description_outlined, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Reports",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget buildInfoCard() {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 260,
        maxWidth: 430,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xffE3EBF3),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // AIRPORT
          Expanded(
            child: buildInfoColumn(
              "Airport",
              selectedAirport ?? "-",
            ),
          ),

          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            width: 1,
            height: 40,
            color: Colors.grey.shade300,
          ),

          // REVENUE CENTER + EDIT
          Expanded(
            //flex: 2,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const Text(
                  "Revenue Center",
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xff6B7A90),
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedRevenueCenter ??
                            "-",
                        maxLines: 1,
                        overflow:
                        TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight:
                          FontWeight.w600,
                          color: Color(0xff163A69),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    InkWell(
                      borderRadius:
                      BorderRadius.circular(
                          6),
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "Popup",
                          barrierColor: Colors.black54,
                          transitionDuration:
                          const Duration(milliseconds: 350),
                          pageBuilder:
                              (
                              context,
                              animation,
                              secondaryAnimation,
                              ) {
                            return Center(
                                child:  ConfirmationPopup(
                                  onCloseWithoutSaving: () {
                                    resetFilter;
                                    print("Closed without saving");
                                  },label: "Change Filter?",
                                  subContent: "Applying a new filter will clear the current report data and reload results based on your new selection.",
                                  backbtnlabel: "Change Filter",continuebtnlabel: "Keep Current Filter",
                                  onContinueEditing: () {
                                    print("Continue editing");
                                  },
                                ));
                          },
                          transitionBuilder:
                              (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                              ) {
                            final offsetAnimation =
                            Tween<Offset>(
                              begin: const Offset(0, -1),
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
                      child: Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        decoration:
                        BoxDecoration(
                          color:
                          const Color(
                              0xffFFF1E7),
                          borderRadius:
                          BorderRadius
                              .circular(
                              6),
                        ),
                        child: const Row(
                          mainAxisSize:
                          MainAxisSize.min,
                          children: [
                            Icon(
                              Icons
                                  .edit_outlined,
                              size: 12,
                              color: Color(
                                  0xffFF6B00),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoColumn(
      String title,
      String value,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            color: Color(0xff6B7A90),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Color(0xff163A69),
          ),
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        MediaQuery
            .of(context)
            .size
            .width < 900;

    return Scaffold(

      backgroundColor:
      const Color(0xffddeefa),

      body: SafeArea(

        child: Column(

          children: [

            buildHeader(isMobile),

            buildTopFilterBar(isMobile),

            Expanded(

              child: showAnalyticsScreen

                  ? Padding(
                padding:
                const EdgeInsets.all(8),

                child: Container(

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(16),
                  ),

                  child: Column(

                    children: [
SizedBox(height: 8,),
                      buildStepper(isMobile),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [

                            // LEFT PANEL (fixed height safe)
                            buildLeftPanel(),

                            const SizedBox(width: 8),

                            // RIGHT PANEL (FIXED SCROLL WRAPPER)
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: SingleChildScrollView(
                                    child: SizedBox(
                                      height: MediaQuery.of(context).size.height,
                                      child: buildRightPanel(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )

                  : Padding(
                padding:
                const EdgeInsets.all(16),

                child: buildEmptyState(),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // ================= TOP FILTER BAR =================

  Widget buildTopFilterBar(bool isMobile) {
    return Container(
      padding: EdgeInsets.all(isMobile ? 8: 12),
      color: const Color(0xffdfe6ec),
      child: isMobile
          ? Column(
        children: [
          buildDropdown(
            hint: "Select Airport",
            value: selectedAirport,
            items: airportList,
            onChanged: (value) {
              selectedAirport = value;
              enableButton();
            },
          ),

          const SizedBox(height: 10),

          buildDropdown(
            hint: "Select Revenue Center",
            value: selectedRevenueCenter,
            items: revenueCenterList,
            onChanged: (value) {
              selectedRevenueCenter = value;
              enableButton();
            },
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: buildApplyButton(),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: buildResetButton(),
              ),
            ],
          )
        ],
      )
          : Row(
        children: [
          buildDropdown(
            hint: "Select Airport",
            value: selectedAirport,
            items: airportList,
            onChanged: (value) {
              selectedAirport = value;
              enableButton();
            },
          ),
          const SizedBox(width: 12),
          buildDropdown(
            hint: "Select Revenue Center",
            value: selectedRevenueCenter,
            items: revenueCenterList,
            onChanged: (value) {
              selectedRevenueCenter = value;
              enableButton();
            },
          ),
          Spacer(),
          buildApplyButton(),
          const SizedBox(width: 12),
          buildResetButton(),
        ],
      ),
    );
  }

  // ================= DROPDOWN =================

  Widget buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      height: 42,width: 200,
      padding:
      const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xffD7E2EC),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(10),
          hint: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 18,
          ),
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) {
            onChanged(value);
            setState(() {});
          },
        ),
      ),
    );
  }

  // ================= APPLY BUTTON =================

  Widget buildApplyButton() {
    return SizedBox(
      height: 42,
      width: 130,
      child: ElevatedButton(
        onPressed:
        isApplyEnabled ? applyFilter : null,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: isApplyEnabled
              ? const Color(0xffFF6B00)
              : Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: isLoading
            ? const SizedBox(
          height: 18,
          width: 18,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Text(
          "Apply Filters",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ================= RESET BUTTON =================

  Widget buildResetButton() {
    return SizedBox(
      height: 42,
      width: 90,
      child: OutlinedButton(
        onPressed: resetFilter,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: Colors.grey.shade400,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Reset",
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  // ================= STEPPER =================

  Widget buildStepper(bool isMobile) {
    final steps = [
      "Comp Establishments",
      "Menu Pricing",
      "Summary",
      "Pricing Analysis",
      "Final Review",
    ];

    return SizedBox(
      height: 56,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: steps.length,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        itemBuilder: (context, index) {

          final bool active = index == currentStep;

          return Container(
            width: isMobile ? 160 : 220,
            margin: const EdgeInsets.only(right: 8),

            decoration: BoxDecoration(
              color: active
                  ? const Color(0xffFF6B00)
                  : const Color(0xff727C96),

              borderRadius: BorderRadius.circular(10),
            ),

            child: Row(
              mainAxisAlignment:
              MainAxisAlignment.center,

              children: [

                CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.white,

                  child: Text(
                    "0${index + 1}",
                    style: TextStyle(
                      fontSize: 10,
                      color: active
                          ? const Color(0xffFF6B00)
                          : const Color(0xff727C96),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Flexible(
                  child: Text(
                    steps[index],
                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  // ================= LEFT PANEL =================

  Widget buildLeftPanel() {
    return Container(
      width: 220,
      margin: const EdgeInsets.fromLTRB(8, 8, 4, 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xffEEF5FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: const Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            Text(
              "ATL",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "Atlanta Bread",
              style: TextStyle(fontSize: 14),
            ),

            SizedBox(height: 18),

            SideText("Cuisine", "American"),

            SizedBox(height: 14),

            SideText(
              "Concept Type",
              "Quick_Casual",
            ),

            SizedBox(height: 14),

            SideText(
              "Location",
              "International Terminal G\n(Gate 99/101)",
            ),
          ],
        ),
      ),
    );
  }
  //=======EmptyState==========
  Widget buildEmptyState() {
    final bool isMobile =
        MediaQuery.of(context).size.width < 900;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffDCE6F0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.restaurant_menu,
            size: 48,
            color: Color(0xffFF6B00),
          ),
          const SizedBox(height: 12),
          Text(
            "No Pricing Analytics Yet",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:
              isMobile ? 18 : 22,
              fontWeight:
              FontWeight.w600,
              color:
              const Color(0xff163A69),
            ),
          ),
          SizedBox(
            height:
            isMobile ? 10 : 12,
          ),
          // DESCRIPTION
          Text(
            "Select Airport and Revenue Center filters above, then click Apply Filters to generate pricing analytics results.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize:
              isMobile ? 12 : 13,
              height: 1.6,
              color:
              const Color(0xff6B7A90),
            ),
          ),
        ],
      ),
    );
  }
}
// ================= SIDE TEXT =================

class SideText extends StatelessWidget {
  final String title;
  final String value;

  const SideText(
      this.title,
      this.value, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          "$title :",
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xff1682C4),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 2),

        Text(
          value,
          style: const TextStyle(
            fontSize: 12,
            height: 1.4,
          ),
        ),
      ],
    );
  }
}