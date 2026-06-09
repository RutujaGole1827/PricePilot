import 'package:flutter/material.dart';

class SummaryScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const SummaryScreen({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  final List<MenuComparisonModel> items = [
    MenuComparisonModel(
      title: "Donut French Toast",
      price: 21.50,
      description:
      "Baby arugula, pickled red onions, lemon vinaigrette, extra virgin olive oil & chili flakes on multi-grain toast",
      status: ItemStatus.draft,
      isSelected: true,
      competitors: [
        CompetitorItem(
          item: "French Toast Stack",
          description:
          "warm nutella, maple syrup, fresh berries, sweet cream",
          restaurant: "Keke's Breakfast Cafe",
          price: 14.95,
        ),
        CompetitorItem(
          item: "French Toast Topped With Fresh Fruit",
          description:
          "Fresh strawberries, banana, blueberries, and powdered sugar.",
          restaurant: "Buoys Waterfront Bar And Grill",
          price: 14.00,
        ),
        CompetitorItem(
          item: "Banana, And Caramel French Toast",
          description:
          "Topped with banana, pecans, caramel, and powdered sugar.",
          restaurant: "First Watch",
          price: 13.00,
        ),
      ],
    ),
    MenuComparisonModel(
      title: "Bacon Bleu",
      price: 21.50,
      description:
      "All beef patty, Point Rese bleu cheese, A-1, smoked bacon, lettuce, red onion. Toasted brioche bun.",
      status: ItemStatus.reviewed,
      competitors: [
        CompetitorItem(
          item: "Piggy Burger",
          description:
          "Bacon, tomato, caramelized onion, romaine, mild cheddar, sriracha aioli",
          restaurant: "Lapisara Eatery",
          price: 14.95,
        ),
        CompetitorItem(
          item: "Aloha Barbecue Burger",
          description:
          "Bacon, Chipotle Aioli, BBQ Sauce, Onions, Provolone, Pineapple Relish, Potato Chips",
          restaurant: "Bartlett Hall",
          price: 14.00,
        ),
      ],
    ),
  ];

  int get selectedCount =>
      items.where((element) => element.isSelected).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                return MenuComparisonCard(
                  model: items[index],
                  onSelectionChanged: () {
                    setState(() {
                      items[index].isSelected =
                      !items[index].isSelected;
                    });
                  },
                  onDeleteCompetitor: (competitorIndex) {
                    setState(() {
                      items[index]
                          .competitors
                          .removeAt(competitorIndex);
                    });
                  },
                );
              },
            ),
          ),

          /// Bottom Bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black12,
                )
              ],
            ),
            child: Row(
              children: [
                Text(
                  "$selectedCount selected",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const Spacer(),

                ElevatedButton.icon(
                  onPressed: selectedCount > 0
                      ? widget.onNext
                      : null,
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text("Generate Pricing"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(12),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MenuComparisonCard extends StatefulWidget {
  final MenuComparisonModel model;
  final VoidCallback onSelectionChanged;
  final Function(int) onDeleteCompetitor;

  const MenuComparisonCard({
    super.key,
    required this.model,
    required this.onSelectionChanged,
    required this.onDeleteCompetitor,
  });

  @override
  State<MenuComparisonCard> createState() =>
      _MenuComparisonCardState();
}

class _MenuComparisonCardState
    extends State<MenuComparisonCard> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    final model = widget.model;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: const Color(0xffD7E3F1),
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: widget.onSelectionChanged,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: model.isSelected
                          ? Color(0xFF304DAC)
                          : Color(0xFFD1D8EF),
                      borderRadius:
                      BorderRadius.circular(6),
                    ),
                    child:  Icon(
                      Icons.check,size: 12,
                      color: model.isSelected
                          ? Colors.white:Color(0xFF648FE1),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${model.title} - \$${model.price.toStringAsFixed(2)}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        model.description,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),

                _StatusBadge(status: model.status),

                const SizedBox(width: 12),

                IconButton(
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  },
                  icon: Icon(
                    expanded
                        ? Icons.remove
                        : Icons.add,
                  ),
                )
              ],
            ),
          ),

          if (expanded) ...[
            const Divider(height: 1),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding:
                    const EdgeInsets.symmetric(
                      vertical: 14,
                      horizontal: 12,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffEEF5FA),
                      borderRadius:
                      BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Item",
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold),
                            )),
                        Expanded(
                            flex: 3,
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold),
                            )),
                        Expanded(
                            flex: 2,
                            child: Text(
                              "Comp Restaurant",
                              style: TextStyle(
                                  fontWeight:
                                  FontWeight.bold),
                            )),
                        SizedBox(
                          width: 80,
                          child: Text(
                            "Price",
                            style: TextStyle(
                                fontWeight:
                                FontWeight.bold),
                          ),
                        ),
                        SizedBox(width: 50),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...List.generate(
                    model.competitors.length,
                        (index) {
                      final competitor =
                      model.competitors[index];

                      return Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                competitor.item,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                competitor.description,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                competitor.restaurant,
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text(
                                "\$${competitor.price.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 50,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  widget
                                      .onDeleteCompetitor(
                                      index);
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final ItemStatus status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final isDraft = status == ItemStatus.draft;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: isDraft
            ? const Color(0xffFFF1E8)
            : const Color(0xffE9FBF1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            isDraft ? Icons.edit : Icons.check,
            size: 18,
            color:
            isDraft ? Colors.orange : Colors.green,
          ),
          const SizedBox(width: 6),
          Text(
            isDraft ? "In Draft" : "Reviewed",
            style: TextStyle(
              color: isDraft
                  ? Colors.orange
                  : Colors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

enum ItemStatus {
  draft,
  reviewed,
}

class MenuComparisonModel {
  String title;
  double price;
  String description;
  bool isSelected;
  ItemStatus status;
  List<CompetitorItem> competitors;

  MenuComparisonModel({
    required this.title,
    required this.price,
    required this.description,
    required this.status,
    this.isSelected = false,
    required this.competitors,
  });
}

class CompetitorItem {
  final String item;
  final String description;
  final String restaurant;
  final double price;

  CompetitorItem({
    required this.item,
    required this.description,
    required this.restaurant,
    required this.price,
  });
}