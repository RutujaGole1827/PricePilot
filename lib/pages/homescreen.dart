import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:price_pilot/components/AppBar.dart';
import '../components/ActionButton.dart';
import '../components/Confirmation_Popup.dart';
import '../components/SlideLeftPopup.dart';
import 'AddAirport.dart';
import 'AirportCard.dart';
import '../components/ReportTable.dart';
import '../components/dropdown_searchable.dart';
import 'AirportOverview.dart';
import 'CompEstablishments.dart';
import 'RevenueCenter.dart';

void main() {
  runApp(const PricingApp());
}

class PricingApp extends StatelessWidget {
  const PricingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pricing Dashboard',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xffeef5fb),
        fontFamily: 'Arial',
      ),
      home: const PricingDashboardScreen(),
    );
  }
}

class PricingDashboardScreen extends StatefulWidget {
  const PricingDashboardScreen({super.key});

  @override
  State<PricingDashboardScreen> createState() =>
      _PricingDashboardScreenState();
}

class _PricingDashboardScreenState extends State<PricingDashboardScreen> {
  int selectedMenu = 1;
  final List<MenuModel> menus = [
    MenuModel(Icons.flight, "Airports Overview"),
    MenuModel(Icons.attach_money, "Revenue Centers"),
    MenuModel(Icons.storefront, "Comp Establishments"),
    MenuModel(Icons.analytics_outlined, "Pricing Analytics"),
    MenuModel(Icons.description_outlined, "Reports"),
  ];

  final List<String> pageTitles = [
    "Airport Overview",
    "Revenue Centers",
    "Competition Establishments",
    "Pricing Analytics",
    "Pricing Reports",
  ];

  @override
  Widget build(BuildContext context) {
    var width= MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          TopAppBar(),
          Expanded(
            child: Row(
              children: [

                /// SIDEBAR
                SideMenu(
                  menus: menus,
                  selectedIndex: selectedMenu,
                  onMenuSelected: (index) {
                    setState(() {
                      selectedMenu = index;
                    });
                  },
                ),

                /// CONTENT
                pageTitles[selectedMenu]=="Airport Overview"?
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Top Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Airports Overview",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF1D4E89),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Airports Overview",
                                      style: TextStyle(
                                        fontSize: 32,
                                        fontWeight: FontWeight.w500,
                                        color: Color(0xFF123D6A),
                                      ),
                                    ),
                                  ],
                                ),

                                Row(
                                  children: [
                                    OutlinedButton.icon(
                                      style: OutlinedButton.styleFrom(
                                        side: const BorderSide(
                                          color: Color(0xFFFF7A1A),
                                          width: 1.5,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 16,
                                        ),
                                      ),
                                      onPressed: () {
                                        showGeneralDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          barrierLabel: "Popup",
                                          barrierColor: Colors.black54,
                                          transitionDuration: const Duration(milliseconds: 350),

                                          pageBuilder: (context, animation, secondaryAnimation) {
                                            return Center(
                                              child: ConfirmationPopup(
                                                onCloseWithoutSaving: () {
                                                  print("Closed without saving");
                                                },
                                                onContinueEditing: () {
                                                  print("Continue editing");
                                                },
                                              ),
                                            );
                                          },

                                          transitionBuilder:
                                              (context, animation, secondaryAnimation, child) {
                                            final offsetAnimation = Tween<Offset>(
                                              begin: const Offset(0, -1), // top
                                              end: Offset.zero, // center
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
                                        Icons.flight,
                                        color: Color(0xFFFF7A1A),
                                      ),
                                      label: const Text(
                                        "Airports Audit Info",
                                        style: TextStyle(
                                          color: Color(0xFFFF7A1A),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
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
                                        SlideLeftPopup.show(
                                          context,
                                          content: AddAirport(),
                                        );
                                        /* showGeneralDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          barrierLabel: "Popup",
                                          barrierColor: Colors.black54,
                                          transitionDuration: const Duration(milliseconds: 350),
                                          pageBuilder: (_, __, ___) {
                                            return const Align(
                                              alignment: Alignment.centerRight,
                                              child: AddAirport(),
                                            );
                                          },
                                          transitionBuilder: (context, animation, secondaryAnimation, child) {
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
                                        );*/
                                      },
                                      icon: const Icon(Icons.add_circle_outline,color: Colors.white,),
                                      label: const Text(
                                        "Add New",
                                        style: TextStyle(fontSize: 14,color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(height: 24),
                            /// Stats Cards
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(28),
                              ),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: StatCard(
                                      icon: Icons.luggage,
                                      title: "# Airports",
                                      active: "92",
                                      total: "145",
                                      inactive: "53",
                                      iconBg: Color(0xFFDFF2FA),
                                    ),
                                  ),
                                  VerticalDivider(width: 1),
                                  Expanded(
                                    child: StatCard(
                                      icon: Icons.person_outline,
                                      title: "# Analyst",
                                      active: "04",
                                      total: "05",
                                      inactive: "01",
                                      iconBg: Color(0xFFDFF2FA),
                                    ),
                                  ),
                                  VerticalDivider(width: 1),
                                  Expanded(
                                    child: CountryCard(
                                      emoji: "🇺🇸",
                                      country: "USA",
                                      active: "64",
                                      total: "100",
                                      inactive: "36",
                                    ),
                                  ),
                                  VerticalDivider(width: 1),
                                  Expanded(
                                    child: CountryCard(
                                      emoji: "🇨🇦",
                                      country: "Canada",
                                      active: "28",
                                      total: "45",
                                      inactive: "17",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),
                            /// Center Charts
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// BAR CHART
                                Expanded(
                                  flex: 2,
                                  child: DashboardCard(
                                    title: "Revenue Centers Distribution",
                                    child: RevenueChart(
                                      data: [
                                        RevenueData(name: "Rebecca", value: 7),
                                        RevenueData(name: "Jennifer", value: 14),
                                        RevenueData(name: "Tara", value: 25),
                                        RevenueData(name: "Mindy", value: 11),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 20),

                                /// ALLOWANCE DONUT
                                Expanded(
                                  child: DashboardCard(
                                    title: "Allowance Distribution",
                                    child: AllowancePieChart(
                                      data: [
                                        ChartData(
                                          title: "0–5%",
                                          value: 33,
                                          color: const Color(0xFFF7C90A),
                                        ),
                                        ChartData(
                                          title: "6–10%",
                                          value: 28,
                                          color: const Color(0xFF6677E8),
                                        ),
                                        ChartData(
                                          title: "11–15%",
                                          value: 12,
                                          color: const Color(0xFFFF8B4D),
                                        ),
                                        ChartData(
                                          title: "16–20%",
                                          value: 45,
                                          color: const Color(0xFF73C8EC),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 20),

                                /// COUNTRY SPLIT
                                Expanded(
                                  child: DashboardCard(
                                    title: "Country Split",
                                    child: CountrySplitChart(
                                      data: [
                                        ChartData(
                                          title: "USA",
                                          value: 64,
                                          color: const Color(0xFF6677E8),
                                        ),
                                        ChartData(
                                          title: "Canada",
                                          value: 28,
                                          color: const Color(0xFF73C8EC),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            ///cards
                            AirportDashboard()

                          ],
                        )
                    ),
                  ),
                )
                    : pageTitles[selectedMenu]=="Revenue Centers"?
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// Top Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text(
                                      "Revenue Centers",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Color(0xFF1D4E89),
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      "Revenue Centers",
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
                                      transitionDuration: const Duration(milliseconds: 350),
                                      pageBuilder: (_, __, ___) {
                                        return const Align(
                                          alignment: Alignment.centerRight,
                                          child: AddAirport(),
                                        );
                                      },
                                      transitionBuilder: (context, animation, secondaryAnimation, child) {
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
                                  icon: const Icon(Icons.add_circle_outline,color: Colors.white,),
                                  label: const Text(
                                    "Add New",
                                    style: TextStyle(fontSize: 14,color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            /// Stats Cards
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: const [
                                  Expanded(
                                    child: StatItem(
                                      icon: Icons.storefront_outlined,
                                      title: 'Revenue Centers',
                                      value: '644',
                                    ),
                                  ),
                                  VerticalDivider(width: 1,),
                                  Expanded(
                                    child: StatItem(
                                      icon: Icons.room_service_outlined,
                                      title: 'Cuisines',
                                      value: '24',
                                    ),
                                  ),
                                  VerticalDivider(width: 1,),
                                  Expanded(
                                    child: StatItem(
                                      icon: Icons.restaurant_menu,
                                      title: 'Concept Type',
                                      value: '19',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 28),
                            ///cards
                            RevenueCenterCards()

                          ],
                        )
                    ),
                  ),
                )
                    : pageTitles[selectedMenu]=="Competition Establishments"?
                Compestablishments()
                    :  Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          PageHeading(
                            title: pageTitles[selectedMenu],
                          ),
                          const SizedBox(height: 24),
                          const HeaderCard(),
                          const SizedBox(height: 24),
                          const FilterSection(),
                          const SizedBox(height: 24),
                          const ReportTable(),
                        ],
                      ),
                    ),
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

/// =======================================================
/// MODELS
/// =======================================================

class MenuModel {
  final IconData icon;
  final String title;

  MenuModel(this.icon, this.title);
}

/// =======================================================
/// SIDEBAR
/// =======================================================

class SideMenu extends StatelessWidget {
  final List<MenuModel> menus;
  final int selectedIndex;
  final Function(int) onMenuSelected;

  const SideMenu({
    super.key,
    required this.menus,
    required this.selectedIndex,
    required this.onMenuSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff0067b1),
            Color(0xff004c86),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          SizedBox(height: 8,),

          /// MENUS
          Expanded(
            child: ListView.builder(
              padding:
              const EdgeInsets.symmetric(horizontal: 16),
              itemCount: menus.length,
              itemBuilder: (context, index) {
                final menu = menus[index];

                return MenuTile(
                  icon: menu.icon,
                  title: menu.title,
                  isSelected: selectedIndex == index,
                  onTap: () => onMenuSelected(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const MenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 18,
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xffff7a1a)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
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


class PopupMenuRow extends StatelessWidget {
  final IconData icon;
  final String title;

  const PopupMenuRow({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const SizedBox(width: 14),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

/// =======================================================
/// PAGE HEADING
/// =======================================================

class PageHeading extends StatelessWidget {
  final String title;

  const PageHeading({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color(0xff0b2d5c),
      ),
    );
  }
}

/// =======================================================
/// HEADER CARD
/// =======================================================

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [
            Color(0xff0067b1),
            Color(0xff004c86),
          ],
        ),
      ),
      child: Row(
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  "Generate Pricing Comparison Report",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  "Select airport and restaurant to review competitor pricing.",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffff7a1a),
              padding: const EdgeInsets.symmetric(
                horizontal: 28,
                vertical: 22,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
            ),
            onPressed: () {},
            icon: const Icon(Icons.auto_graph),
            label: const Text(
              "Generate Report",
              style: TextStyle(fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}

/// =======================================================
/// FILTERS
/// =======================================================

class FilterSection extends StatefulWidget {
  const FilterSection({super.key});

  @override
  State<FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<FilterSection> {
  String selectedAirport = "All";
  final List<String> airports = [
    "All",
    "ATL",
    "BOS",
    "BDA",
    "BDL",
    "SFO",
  ];

  @override
  Widget build(BuildContext context) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: CustomDropdown(
            label: "Airport",
            items: airports,
            value: selectedAirport,
            onChanged: (value) {
              setState(() {
                selectedAirport = value;
              });
            },
          ),
        ),
        const SizedBox(width: 18),

        Expanded(
          child: CustomDropdown(
            label: "Status",
            items: airports,
            value: selectedAirport,
            onChanged: (value) {
              setState(() {
                selectedAirport = value;
              });
            },
          ),
        ),
        const SizedBox(width: 18),

        Expanded(
          child: CustomDropdown(
            label: "Analyst",
            items: airports,
            value: selectedAirport,
            onChanged: (value) {
              setState(() {
                selectedAirport = value;
              });
            },
          ),
        ),

        const SizedBox(width: 18),

        ActionButton(
          title: "Apply",
          backgroundColor:
          const Color(0xffff7a1a),
          textColor: Colors.white,
          onTap: () {},
        ),
        const SizedBox(width: 12),
        ActionButton(
          title: "Clear All",
          backgroundColor: Colors.white,
          textColor: const Color(0xffff7a1a),
          borderColor:
          const Color(0xffff7a1a),
          onTap: () {},
        ),
      ],
    );
  }
}