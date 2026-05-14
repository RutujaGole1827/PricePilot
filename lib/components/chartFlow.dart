import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// =======================
/// REVENUE BAR CHART
/// =======================

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

    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          maxY: maxY,
          alignment: BarChartAlignment.spaceAround,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 5,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(.15),
                strokeWidth: 1,
                dashArray: [2, 2],
              );
            },
          ),
          borderData: FlBorderData(
            show: true,
            border: Border.all(
              color: Colors.grey.withOpacity(.15),
            ),
          ),
          titlesData: FlTitlesData(
            topTitles: const AxisTitles(),
            rightTitles: const AxisTitles(),

            /// LEFT TITLES
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 5,
                reservedSize: 28,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Color(0xFF4B5563),
                    ),
                  );
                },
              ),
            ),

            /// BOTTOM TITLES
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 28,
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
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          /// BAR DATA
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

/// =======================
/// ALLOWANCE DONUT CHART
/// =======================

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

/// =======================
/// COUNTRY SPLIT CHART
/// =======================

class CountrySplitChart extends StatelessWidget {
  final List<ChartData> data;

  const CountrySplitChart({
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
              sectionsSpace: 2,
              pieTouchData: PieTouchData(
                touchCallback: (event, response) {},
              ),
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

        const SizedBox(height: 14),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: data.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
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

/// =======================
/// COMMON MODEL
/// =======================

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