
import 'package:flutter/material.dart';

class ReportTable extends StatelessWidget {
  final List<ReportModel> reports;

  const ReportTable({
    super.key,
    required this.reports,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width, // minimum width
          child: Column(
            children: [
              const TableHeader(),
              const Divider(),
              ...reports.map(
                    (report) => Column(
                  children: [
                    ReportRow(report: report),
                    const Divider(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TableHeader extends StatelessWidget {
  const TableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(flex: 1, child: HeaderText("Airport")),
        Expanded(flex: 1, child: HeaderText("Revenue Centers")),
        Expanded(flex: 1, child: HeaderText("# Menu Reviewed")),
        Expanded(flex: 1, child: HeaderText("Status")),
        Expanded(flex: 1, child: HeaderText("Created By")),
        Expanded(flex: 1, child: HeaderText("Created On")),
        Expanded(flex: 1, child: HeaderText("Last Updated")),
        Expanded(flex: 1, child: HeaderText("Actions")),
      ],
    );
  }
}

class HeaderText extends StatelessWidget {
  final String title;

  const HeaderText(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class ReportRow extends StatelessWidget {
  final ReportModel report;

  const ReportRow({
    super.key,
    required this.report,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted =
        report.status.toLowerCase() == "completed";

    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(report.airport)),
          Expanded(flex: 1, child: Text(report.revenueCenter)),
          Expanded(flex: 1, child: Text(report.reviewed)),

          Expanded(
            flex: 1,
            child: StatusBadge(
              text: report.status,
              color: isCompleted
                  ? Colors.green
                  : Colors.orange,
            ),
          ),

          Expanded(
            flex: 1,
            child: Text(report.createdBy),
          ),

          Expanded(
            flex: 1,
            child: Text(report.createdOn),
          ),

          Expanded(
            flex: 1,
            child: Text(report.updatedOn),
          ),

          const Expanded(
            flex: 1,
            child: Row(
              children: [
                ActionIcon(Icons.remove_red_eye),
                SizedBox(width: 8),
                ActionIcon(Icons.edit),
                SizedBox(width: 8),
                ActionIcon(Icons.download),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusBadge extends StatelessWidget {
  final String text;
  final Color color;

  const StatusBadge({
    super.key,
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }
}

class ActionIcon extends StatelessWidget {
  final IconData icon;

  const ActionIcon(this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xffe8f5ff),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(
        icon,
        size: 14,
        color: const Color(0xff005fa3),
      ),
    );
  }
}

class ReportModel {
  final String airport;
  final String revenueCenter;
  final String reviewed;
  final String status;
  final String analyst;
  final String createdBy;
  final String createdOn;
  final String updatedOn;

  ReportModel({
    required this.airport,
    required this.revenueCenter,
    required this.reviewed,
    required this.status,
    required this.analyst,
    required this.createdBy,
    required this.createdOn,
    required this.updatedOn,
  });
}