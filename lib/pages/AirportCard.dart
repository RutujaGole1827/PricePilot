import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
/*

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AirportDashboard(),
    );
  }
}
*/

class AirportModel {
  final String code;
  final String country;
  final String airport;
  final String analyst;
  final int allowance;
  final String notes;
  final String status;

  AirportModel({
    required this.code,
    required this.country,
    required this.airport,
    required this.analyst,
    required this.allowance,
    required this.notes,
    required this.status,
  });
}

class AirportDashboard extends StatefulWidget {
  const AirportDashboard({super.key});

  @override
  State<AirportDashboard> createState() =>
      _AirportDashboardState();
}

class _AirportDashboardState
    extends State<AirportDashboard> {
  final TextEditingController searchController =
  TextEditingController();

  String selectedCountry = 'All';
  String selectedAnalyst = 'All';
  String selectedStatus = 'All';

  final List<AirportModel> airports = [
    AirportModel(
      code: 'ATL',
      country: 'US',
      airport:
      'Hartsfield Jackson Atlanta International Airport',
      analyst: 'Open',
      allowance: 15,
      notes:
      'Comp locations cannot be changed without approval.',
      status: 'ACTIVE',
    ),
    AirportModel(
      code: 'ATW',
      country: 'US',
      airport: 'Appleton International Airport',
      analyst: 'Jennifer Jackson',
      allowance: 10,
      notes: 'Airport approval required.',
      status: 'ACTIVE',
    ),
    AirportModel(
      code: 'BDA',
      country: 'US',
      airport: 'L.F. Wade International Airport',
      analyst: 'Jennifer Jackson',
      allowance: 10,
      notes: 'Alcohol pricing specific to each unit.',
      status: 'ACTIVE',
    ),
    AirportModel(
      code: 'BOS',
      country: 'US',
      airport: 'General Edward Lawrence Logan',
      analyst: 'Jennifer Jackson',
      allowance: 12,
      notes: 'Convenience items line-priced.',
      status: 'ACTIVE',
    ),
  ];

  List<AirportModel> get filteredAirports {
    return airports.where((e) {
      final search =
      searchController.text.toLowerCase();

      final searchMatch =
          e.airport.toLowerCase().contains(search) ||
              e.code.toLowerCase().contains(search);

      final countryMatch =
          selectedCountry == 'All' ||
              e.country == selectedCountry;

      final analystMatch =
          selectedAnalyst == 'All' ||
              e.analyst == selectedAnalyst;

      final statusMatch =
          selectedStatus == 'All' ||
              e.status == selectedStatus;

      return searchMatch &&
          countryMatch &&
          analystMatch &&
          statusMatch;
    }).toList();
  }

  void clearFilters() {
    setState(() {
      selectedCountry = 'All';
      selectedAnalyst = 'All';
      selectedStatus = 'All';
      searchController.clear();
    });
  }

  int getCrossAxisCount(double width) {
    if (width > 1400) return 4;
    if (width > 1000) return 3;
    if (width > 700) return 2;
    return 1;
  }
  double getChildAspectRatio(double width) {
    if (width > 1600) return 3.2; // ultra wide screens
    if (width > 1200) return 2.8; // large desktop
    if (width > 900) return 2.4;  // normal desktop
    if (width > 600) return 2.1;  // tablet
    return 1.9;                  // mobile
  }
  @override
  Widget build(BuildContext context) {
    final width =
        MediaQuery.of(context).size.width;

    return Container(

      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(mainAxisSize: MainAxisSize.min,
          children: [
            topBar(),
            const SizedBox(height: 8),
            MasonryGridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: getCrossAxisCount(width),
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              itemCount: filteredAirports.length,
              itemBuilder: (context, index) {
                return AirportCardWidget(
                  data: filteredAirports[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget topBar() {
    return Row(
      children: [
        compactDropdown(
          title: 'Country',
          value: selectedCountry,
          items: ['All', 'US'],
          onChanged: (v) {
            setState(() {
              selectedCountry = v!;
            });
          },
        ),
        const SizedBox(width: 5),
        compactDropdown(
          title: 'Analyst',
          value: selectedAnalyst,
          items: [
            'All',
            'Open',
            'Jennifer Jackson'
          ],
          onChanged: (v) {
            setState(() {
              selectedAnalyst = v!;
            });
          },
        ),
        const SizedBox(width: 5),
        compactDropdown(
          title: 'Status',
          value: selectedStatus,
          items: ['All', 'ACTIVE'],
          onChanged: (v) {
            setState(() {
              selectedStatus = v!;
            });
          },
        ),
        const SizedBox(width: 5),
        InkWell(
          onTap: clearFilters,
          child: Container(
            height: 30,
            padding:
            const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color:
              const Color(0xff0b6bcb),
              borderRadius:
              BorderRadius.circular(6),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.close,
                  size: 11,
                  color: Colors.white,
                ),
                SizedBox(width: 4),
                Text(
                  'Clear',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 180,
          height: 30,
          child: TextField(
            controller: searchController,
            onChanged: (_) {
              setState(() {});
            },
            style:
            const TextStyle(fontSize: 12),
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle:
              const TextStyle(
                fontSize: 12,
              ),
              prefixIcon: const Icon(
                Icons.search,
                size: 14,
              ),
              contentPadding:
              const EdgeInsets.symmetric(
                horizontal: 6,
                vertical: 0,
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(6),
                borderSide: BorderSide(
                  color:
                  Colors.blue.shade100,
                ),
              ),
              enabledBorder:
              OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                    6),
                borderSide: BorderSide(
                  color:
                  Colors.blue.shade100,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Container(
          height: 30,
          padding:
          const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius:
            BorderRadius.circular(6),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.filter_alt_outlined,
                size: 12,
                color: Colors.white,
              ),
              SizedBox(width: 4),
              Text(
                'Filter',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight:
                  FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget compactDropdown({
    required String title,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      height: 30,
      padding:
      const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(6),
        border: Border.all(
          color: Colors.blue.shade100,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            size: 14,
          ),
          onChanged: onChanged,
          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text('$title : $e'),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class AirportCardWidget extends StatelessWidget {
  final AirportModel data;

  const AirportCardWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(12),
        border: Border.all(
          color:
          const Color(0xffd9ebff),
        ),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration:
                const BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                  Color(0xffeaf5ff),
                ),
                child: const Icon(
                  Icons.luggage,
                  size: 13,
                  color:
                  Color(0xff0b6bcb),
                ),
              ),

              const SizedBox(width: 6),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style:
                        const TextStyle(
                          fontSize: 12,
                          color: Color(
                              0xff0b6bcb),
                        ),
                        children: [
                          TextSpan(
                            text:
                            '${data.country} / ',
                          ),
                          TextSpan(
                            text: data.code,
                            style:
                            const TextStyle(
                              fontWeight:
                              FontWeight
                                  .w700,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                        height: 4),

                    Text(
                      data.airport,
                      maxLines: 2,
                      overflow:
                      TextOverflow
                          .ellipsis,
                      style:
                      const TextStyle(
                        fontSize: 12,
                        height: 1.1,
                        fontWeight:
                        FontWeight
                            .w700,
                        color: Color(
                            0xff11284b),
                      ),
                    ),

                    const SizedBox(
                        height: 5),

                    Row(
                      children: [
                        const Icon(
                          Icons
                              .person_outline,
                          size: 11,
                          color: Color(
                              0xff0b6bcb),
                        ),

                        const SizedBox(
                            width: 3),

                        Expanded(
                          child: Text(
                            data.analyst,
                            overflow:
                            TextOverflow
                                .ellipsis,
                            style:
                            const TextStyle(
                              fontSize: 12,
                              color: Color(
                                  0xff0b6bcb),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 5),

              Column(
                crossAxisAlignment:
                CrossAxisAlignment.end,
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 2,
                    ),
                    decoration:
                    BoxDecoration(
                      color: const Color(
                          0xffe8fff2),
                      borderRadius:
                      BorderRadius
                          .circular(
                          4),
                    ),
                    child: Text(
                      data.status,
                      style:
                      const TextStyle(
                        fontSize: 12,
                        fontWeight:
                        FontWeight
                            .w700,
                        color: Color(
                            0xff1d9b5f),
                      ),
                    ),
                  ),

                  const SizedBox(
                      height: 6),

                  Text(
                    '${data.allowance}%',
                    style:
                    const TextStyle(
                      fontSize: 16,
                      height: 1,
                      fontWeight:
                      FontWeight.w700,
                      color: Color(
                          0xff0b6bcb),
                    ),
                  ),

                  const SizedBox(
                      height: 2),

                  const Text(
                    'Allowance',
                    style: TextStyle(
                      fontSize: 12,
                      color:
                      Color(0xff56718f),
                    ),
                  ),

                  const SizedBox(
                      height: 2),

                  PopupMenuButton<String>(
                    padding:
                    EdgeInsets.zero,
                    constraints:
                    const BoxConstraints(),
                    icon: Container(
                      padding:
                      const EdgeInsets
                          .all(3),
                      decoration:
                      BoxDecoration(
                        borderRadius:
                        BorderRadius
                            .circular(
                            5),
                        color: const Color(
                            0xffeef6ff),
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        size: 12,
                        color: Color(
                            0xff0b6bcb),
                      ),
                    ),
                    itemBuilder:
                        (context) => [
                      popupItem(
                          'Edit Airport'),
                      popupItem(
                          'Revenue Centers'),
                      popupItem(
                          'Comp Establishments'),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 6),
          Divider(
            height: 1,
            color: Colors.blue.shade50,
          ),
          const SizedBox(height: 6),
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.notes_outlined,
                size: 11,
                color:
                Color(0xff0b6bcb),
              ),

              const SizedBox(width: 4),

              Expanded(
                child: Text(
                  data.notes,
                  maxLines: 2,
                  overflow:
                  TextOverflow.ellipsis,
                  style:
                  const TextStyle(
                    fontSize: 12,
                    height: 1.15,
                    color:
                    Color(0xff1f3552),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PopupMenuItem<String> popupItem(
      String title) {
    return PopupMenuItem<String>(
      height: 24,
      value: title,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
  }
}