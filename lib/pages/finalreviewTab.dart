import 'package:flutter/material.dart';

class FinalReviewScreen extends StatelessWidget {
  final VoidCallback onBack;

  const FinalReviewScreen({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  _buildRestaurantInfoCard(),
                  const SizedBox(height: 12),
                  _buildMenuItemCard(),
                ],
              ),
            ),
          ),

          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildRestaurantInfoCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffEAF4FB),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "BOS",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Atlanta Bread",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Column(
                  children: [
                    Text(
                      "2 / 4",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text("Menu Items Reviewed"),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.save_outlined),
                label: const Text("Save As Draft"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0075B8),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 46),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              )
            ],
          ),

          const Divider(height: 12),

          const Row(
            children: [
              Expanded(
                child: InfoItem(
                  title: "Cuisine",
                  value: "American",
                ),
              ),
              Expanded(
                child: InfoItem(
                  title: "Concept Type",
                  value: "Quick_Casual",
                ),
              ),
              Expanded(
                child: InfoItem(
                  title: "Min. Comparable Menu Items",
                  value: "03",
                ),
              ),
              Expanded(
                child: InfoItem(
                  title: "Percentage Above Street",
                  value: "15%",
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          Row(
            children: const [
              Expanded(
                child: InfoItem(
                  title: "Airport Name",
                  value: "Hartsfield–Jackson Atlanta International Airport",
                ),
              ),
              Expanded(
                child: InfoItem(
                  title: "Location",
                  value: "International Terminal G (Gate 99/101)",
                ),
              ),
              Expanded(
                flex: 2,
                child: InfoItem(
                  title: "Analysis Notes",
                  value:
                  "Comp locations cannot be changed without airport approval. All items need to be included on comp sheet.",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItemCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Donut French Toast - \$21.50",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffE8F8EC),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "Compliant",
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 10),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Baby arugula, pickled red onions, lemon vinaigrette, extra virgin olive oil & chili flakes on multi-grain toast",
                  ),
                ),

                const SizedBox(height: 12),

                Row(
                  children: const [
                    PriceInfo(
                      title: "Current Price",
                      value: "\$21.50",
                    ),
                    SizedBox(width: 40),
                    PriceInfo(
                      title: "Max. Allowed Price",
                      value: "\$25.00",
                    ),
                    SizedBox(width: 40),
                    PriceInfo(
                      title: "Proposed Price",
                      value: "\$22.00",
                    ),
                  ],
                ),
              ],
            ),
          ),

          Container(
            height: 60,
            color: const Color(0xffF3F7FA),
            child: const Row(
              children: [
                Expanded(child: Center(child: Text("Item"))),
                Expanded(child: Center(child: Text("Description"))),
                Expanded(child: Center(child: Text("Comp Restaurant"))),
                Expanded(child: Center(child: Text("Price"))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Color(0xffE0E0E0)),
        ),
      ),
      child: Row(
        children: [
          OutlinedButton(
            onPressed: onBack,
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(170, 50),
              foregroundColor: const Color(0xffFF7A00),
              side: const BorderSide(
                color: Color(0xffFF7A00),
              ),shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            ),
            child: const Text("Previous"),
          ),

          const Spacer(),

          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Created by Tara Smith",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                "Created on 02/24/2026 at 04:35 PM",
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
SizedBox(width: 8,),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download),
            label: const Text("Export Report"),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFF7A00),
              foregroundColor: Colors.white,
              minimumSize: const Size(190, 52),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InfoItem extends StatelessWidget {
  final String title;
  final String value;

  const InfoItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title :",
          style: const TextStyle(
            color: Color(0xff0075B8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}

class PriceInfo extends StatelessWidget {
  final String title;
  final String value;

  const PriceInfo({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}