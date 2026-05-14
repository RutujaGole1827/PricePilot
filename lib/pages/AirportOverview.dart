import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../components/chartFlow.dart';

class AirportsOverviewScreen extends StatelessWidget {
  const AirportsOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
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
                      SizedBox(height: 8),
                      Text(
                        "Airports Overview",
                        style: TextStyle(
                          fontSize: 42,
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
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 22,
                          ),
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.flight,
                          color: Color(0xFFFF7A1A),
                        ),
                        label: const Text(
                          "Airports Audit Info",
                          style: TextStyle(
                            color: Color(0xFFFF7A1A),
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF7A1A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 22,
                          ),
                          elevation: 0,
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_outline),
                        label: const Text(
                          "Add New",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// Stats Cards
              Container(
                padding: const EdgeInsets.symmetric(vertical: 28),
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

              /// Bottom Charts
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// BAR CHART
                  Expanded(
                    flex: 1,
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

                  /// ALLOWANCE
                  Expanded(
                    child: DashboardCard(
                      title: "Allowance Distribution",
                      child: AllowancePieChart(
                        data: [
                          ChartData(
                            title: "0–5%",
                            value: 33,
                            color: Color(0xFFF7C90A),
                          ),
                          ChartData(
                            title: "6–10%",
                            value: 28,
                            color: Color(0xFF6677E8),
                          ),
                          ChartData(
                            title: "11–15%",
                            value: 12,
                            color: Color(0xFFFF8B4D),
                          ),
                          ChartData(
                            title: "16–20%",
                            value: 45,
                            color: Color(0xFF73C8EC),
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
                            color: Color(0xFF6677E8),
                          ),
                          ChartData(
                            title: "Canada",
                            value: 28,
                            color: Color(0xFF73C8EC),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String active;
  final String total;
  final String inactive;
  final Color iconBg;

  const StatCard({
    super.key,
    required this.icon,
    required this.title,
    required this.active,
    required this.total,
    required this.inactive,
    required this.iconBg,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: iconBg,
                child: Icon(
                  icon,
                  size: 24,
                  color: const Color(0xFF1277B3),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0070B8),
                    ),
                  ),
                  Text(
                    active,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF22B573),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                "Total ",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                total,
                style: const TextStyle(
                  color: Color(0xFF123D6A),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 24),
              const CircleAvatar(
                radius: 4,
                backgroundColor: Colors.red,
              ),
              const SizedBox(width: 10),
              const Text(
                "Inactive ",
                style: TextStyle(fontSize: 14),
              ),
              Text(
                inactive,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CountryCard extends StatelessWidget {
  final String emoji;
  final String country;
  final String active;
  final String total;
  final String inactive;

  const CountryCard({
    super.key,
    required this.emoji,
    required this.country,
    required this.active,
    required this.total,
    required this.inactive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFFDFF2FA),
                child: Text(
                  emoji,
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    country,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xFF0070B8),
                    ),
                  ),
                  Text(
                    active,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Color(0xFF22B573),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              const Text("Total ", style: TextStyle(fontSize: 14)),
              Text(
                total,
                style: const TextStyle(
                  color: Color(0xFF123D6A),
                  fontSize: 14,
                ),
              ),
              const SizedBox(width: 24),
              const CircleAvatar(
                radius: 4,
                backgroundColor: Colors.red,
              ),
              const SizedBox(width: 10),
              const Text("Inactive ", style: TextStyle(fontSize: 14)),
              Text(
                inactive,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final Widget child;

  const DashboardCard({
    super.key,
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF0070B8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(child: child),
        ],
      ),
    );
  }
}

/// ===============================
/// BAR CHART
/// ===============================

class RevenueChart extends StatelessWidget {
  final List<RevenueData> data;

  const RevenueChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final maxY = data
        .map((e) => e.value)
        .reduce((a, b) => a > b ? a : b)
        .toDouble() +
        5;

    return Padding(
      padding: const EdgeInsets.only(
       /* right: 12,
        left: 4,
        bottom: 8,*/
      ),
      child: BarChart(
        BarChartData(
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,

          /// GRID
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(.10),
                strokeWidth: 1,
                dashArray: [4, 4],
              );
            },
          ),

          /// BORDER
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.grey.withOpacity(.15),
            ),
          ),

          /// TITLES
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),

            /// LEFT TITLES
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 35,
                interval: 5,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),

            /// BOTTOM TITLES
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();

                  if (index >= data.length) {
                    return const SizedBox();
                  }

                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      data[index].name,
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// BARS
          barGroups: List.generate(
            data.length,
                (index) {
              final item = data[index];

              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: item.value.toDouble(),
                    width: 40,
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFF48D1A0),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class RevenueData {
  final String name;
  final int value;

  RevenueData({
    required this.name,
    required this.value,
  });
}

/// ===============================
/// ALLOWANCE PIE CHART
/// ===============================

class AllowancePieChart extends StatelessWidget {
  final List<ChartData> data;

  const AllowancePieChart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 45,
              sectionsSpace: 3,
              sections: List.generate(
                data.length,
                    (index) {
                  final item = data[index];

                  return PieChartSectionData(
                    value: item.value.toDouble(),
                    color: item.color,
                    radius: 42,
                    title: "",
                  );
                },
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: data.map((item) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 3,
                  backgroundColor: item.color,
                ),
                const SizedBox(width: 6),
                Text(
                  "${item.title}   ${item.value}",
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// ===============================
/// COUNTRY SPLIT CHART
/// ===============================

class CountrySplitChart extends StatefulWidget {
  final List<ChartData> data;

  const CountrySplitChart({
    super.key,
    required this.data,
  });

  @override
  State<CountrySplitChart> createState() =>
      _CountrySplitChartState();
}

class _CountrySplitChartState
    extends State<CountrySplitChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              centerSpaceRadius: 45,
              sectionsSpace: 2,

              pieTouchData: PieTouchData(
                enabled: true,

                touchCallback: (event, response) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        response == null ||
                        response.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }

                    touchedIndex = response
                        .touchedSection!
                        .touchedSectionIndex;
                  });
                },
              ),

              sections: List.generate(
                widget.data.length,
                    (index) {
                  final item = widget.data[index];

                  final isTouched =
                      index == touchedIndex;

                  return PieChartSectionData(
                    value: item.value.toDouble(),
                    color: item.color,

                    radius: isTouched ? 50 : 42,

                    title: isTouched
                        ? "${item.title}\n${item.value}"
                        : "",

                    titleStyle: const TextStyle(
                      fontSize: 11,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                },
              ),
            ),
          ),
        ),

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: widget.data.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 3,
                    backgroundColor: item.color,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    "${item.title}  ${item.value}",
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

/// ===============================
/// COMMON MODEL
/// ===============================

class ChartData {
  final String title;
  final int value;
  final Color color;

  ChartData({
    required this.title,
    required this.value,
    required this.color,
  });
}
