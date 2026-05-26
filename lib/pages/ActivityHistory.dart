import 'package:flutter/material.dart';
class HistoryLogContent extends StatelessWidget {
  const HistoryLogContent({super.key});

  @override
  Widget build(BuildContext context) {
    final logs = [
      {
        "title": "Created – Pricing Analytics Report",
        "subtitle": "Rebecca Gottfried on 18 Feb 2026, 10:12 AM",
      },
      {
        "title":
        "Added – Pricing Updated On BOS – Temazcal – Post Terminal B",
        "subtitle": "Jennifer Jackson on 22 Feb 2026, 10:25 AM",
      },
      {
        "title": "Created – Pricing Analytics Report",
        "subtitle": "Rebecca Gottfried on 21 Feb 2026, 10:12 AM",
      },
      {
        "title":
        "Added – Pricing Updated On BOS – Temazcal – Post Terminal B",
        "subtitle": "Jennifer Jackson on 21 Feb 2026, 10:25 AM",
      },
      {
        "title":
        "Updated – Price Validated On BOS – Temazcal – Post Terminal B",
        "subtitle": "Tara smith on 20 Feb 2026, 11:05 AM",
      },
      {
        "title":
        "Updated – Price Validated On BOS – Temazcal – Post Terminal B",
        "subtitle": "Tara smith on 19 Feb 2026, 11:05 AM",
      },
    ];

    return Column(
      children: [
        /// HEADER
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 22,
          ),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xffE4EBF3),
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "History Log",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff0E2F56),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pop(context),
                child: const Icon(
                  Icons.close,
                  size: 28,
                  color: Color(0xff0E2F56),
                ),
              ),
            ],
          ),
        ),

        /// BODY
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 26,
              vertical: 28,
            ),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final item = logs[index];

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// TIMELINE
                    Column(
                      children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color(0xffFF7A1A),
                            shape: BoxShape.circle,
                          ),
                        ),

                        if (index != logs.length - 1)
                          Expanded(
                            child: Container(
                              width: 2,
                              color: const Color(0xffD7E1EC),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(width: 20),

                    /// CONTENT
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16,top:0),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              item["title"]!,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0E2F56),
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              item["subtitle"]!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xff0E2F56),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}