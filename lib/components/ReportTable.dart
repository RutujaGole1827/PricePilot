import 'package:flutter/material.dart';
class ReportTable extends StatelessWidget {
  const ReportTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const TableHeader(),

          const Divider(),

          ReportRow(
            airport: "BOS",
            center: "Taco Bell",
            reviewed: "3 / 3",
            status: "COMPLETED",
            statusColor: Colors.green,
          ),

          const Divider(),

          ReportRow(
            airport: "ATL",
            center: "Atlanta Bread",
            reviewed: "2 / 4",
            status: "IN PROGRESS",
            statusColor: Colors.orange,
          ),
        ],
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
        Expanded(child: HeaderText("Airport")),
        Expanded(flex: 1, child: HeaderText("Revenue Centers")),
        Expanded(child: HeaderText("Reviewed")),
        Expanded(child: HeaderText("Status")),
        Expanded(child: HeaderText("Actions")),
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
  final String airport;
  final String center;
  final String reviewed;
  final String status;
  final Color statusColor;

  const ReportRow({
    super.key,
    required this.airport,
    required this.center,
    required this.reviewed,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(airport)),
        Expanded(flex: 1, child: Text(center)),
        Expanded(child: Text(reviewed)),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color:
                statusColor.withOpacity(.15),
                borderRadius:
                BorderRadius.circular(10),
              ),
              child: Text(
                status,
                style: TextStyle(
                  color: statusColor,fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        const Expanded(
          child: Row(
            children: [
              ActionIcon(
                icon: Icons.remove_red_eye,
              ),
              SizedBox(width: 10),
              ActionIcon(
                icon: Icons.edit,
              ),
              SizedBox(width: 10),
              ActionIcon(
                icon: Icons.download,
              ),
            ],
          ),
        ),
      ],
    );
  }
}


class ActionIcon extends StatelessWidget {
  final IconData icon;

  const ActionIcon({
    super.key,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xffe8f5ff),
        borderRadius:
        BorderRadius.circular(12),
      ),
      child: Icon(
        icon,
        color: const Color(0xff005fa3),
      ),
    );
  }
}