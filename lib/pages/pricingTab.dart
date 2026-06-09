import 'dart:async';
import 'package:flutter/material.dart';

class PricingAnalysisScreen extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const PricingAnalysisScreen({
    super.key,
    required this.onBack,
    required this.onNext,
  });

  @override
  State<PricingAnalysisScreen> createState() =>
      _PricingAnalysisScreenState();
}

class _PricingAnalysisScreenState
    extends State<PricingAnalysisScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const _PricingLoadingView()
        : _PricingAnalysisContent(
      onBack: widget.onBack,
      onNext: widget.onNext,
    );
  }
}

/// ---------------------------------------------------------
/// LOADING VIEW
/// ---------------------------------------------------------

class _PricingLoadingView extends StatelessWidget {
  const _PricingLoadingView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF8FAFC),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Colors.orange,
                size: 45,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Generating Price...",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Please do not refresh the page.\nThis may take a few moments.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const SizedBox(
              width: 250,
              child: LinearProgressIndicator(),
            )
          ],
        ),
      ),
    );
  }
}

/// ---------------------------------------------------------
/// CONTENT SCREEN
/// ---------------------------------------------------------

class _PricingAnalysisContent extends StatefulWidget {
  final VoidCallback onBack;
  final VoidCallback onNext;

  const _PricingAnalysisContent({
    required this.onBack,
    required this.onNext,
  });

  @override
  State<_PricingAnalysisContent> createState() =>
      _PricingAnalysisContentState();
}

class _PricingAnalysisContentState
    extends State<_PricingAnalysisContent> {
  late List<PricingAnalysisItem> items;

  @override
  void initState() {
    super.initState();

    items = [
      PricingAnalysisItem(
        name: "Donut French Toast",
        description:
        "Baby arugula, pickled red onions, lemon vinaigrette, extra virgin olive oil & chili flakes on multi-grain toast",
        currentPrice: 21.50,
        maxAllowedPrice: 25.00,
        proposedPrice: 22.00,
        competitors: [
          CompetitorItem(
            item: "French Toast Stack",
            description:
            "Warm nutella, maple syrup, fresh berries, sweet cream",
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
        ],
      ),
      PricingAnalysisItem(
        name: "Bacon Bleu",
        description:
        "All beef patty, Point Rese bleu cheese, A-1, smoked bacon, lettuce, red onion. Toasted brioche bun.",
        currentPrice: 21.50,
        maxAllowedPrice: 25.00,
        proposedPrice: 22.00,
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
          CompetitorItem(
            item: "The E&O Cheeseburger",
            description:
            "8 Oz Beef Patty, Smoked Bacon, Sharp Cheddar, Caramelized Onions, Toasted Brioche",
            restaurant: "E&O Kitchen And Bar",
            price: 13.00,
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: items.length,
            itemBuilder: (_, index) {
              return PricingAnalysisCard(
                item: items[index],
              );
            },
          ),
        ),

        Container(
          padding: const EdgeInsets.all(16),
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
              OutlinedButton(
                onPressed: widget.onBack,
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFFFFF),
                  foregroundColor: const Color(0xFFFF7A00), // text color
                  side: const BorderSide(
                    color: Color(0xFFFF7A00), // orange border
                    width: 1.5,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  minimumSize: const Size(140, 44),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                child: const Text("Previous"),
              ),
              const Spacer(),
              InkWell(
                onTap:  widget.onNext,
                child: Container(
                  height: 32,
                  width: 180,
                  decoration: BoxDecoration(
                    color: const Color(0xffFF6B00),
                    borderRadius:
                    BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      "Final Review Report",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

/// ---------------------------------------------------------
/// CARD
/// ---------------------------------------------------------

class PricingAnalysisCard extends StatefulWidget {
  final PricingAnalysisItem item;

  const PricingAnalysisCard({
    super.key,
    required this.item,
  });

  @override
  State<PricingAnalysisCard> createState() =>
      _PricingAnalysisCardState();
}

class _PricingAnalysisCardState
    extends State<PricingAnalysisCard> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();

    controller = TextEditingController(
      text: widget.item.proposedPrice.toStringAsFixed(2),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xffD9E6F2),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${item.name} - \$${item.currentPrice.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(item.description),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          item.isExpanded =
                          !item.isExpanded;
                        });
                      },
                      icon: Icon(
                        item.isExpanded
                            ? Icons.remove
                            : Icons.add,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                Row(
                  children: [
                    _priceTile(
                      "Current Price",
                      item.currentPrice,
                    ),
                    const SizedBox(width: 40),
                    _priceTile(
                      "Max. Allowed Price",
                      item.maxAllowedPrice,
                    ),
                    const SizedBox(width: 40),

                    Expanded(
                      child: item.isEditing
                          ? TextField(
                        controller: controller,
                        keyboardType:
                        const TextInputType
                            .numberWithOptions(
                          decimal: true,
                        ),
                        decoration:
                        const InputDecoration(
                          labelText:
                          "Proposed Price",
                          border:
                          OutlineInputBorder(),
                        ),
                      )
                          : _priceTile(
                        "Proposed Price",
                        item.proposedPrice,
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: Text(
                        item.proposedPrice <=
                            item.maxAllowedPrice
                            ? "Price updated as per SSP's compliant rules."
                            : "Price exceeds allowed limit.",
                        style: TextStyle(
                          color:
                          item.proposedPrice <=
                              item.maxAllowedPrice
                              ? Colors.green
                              : Colors.red,
                          fontWeight:
                          FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(width: 20),

                    if (!item.isEditing)
                      SizedBox(
                        height: 32,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              item.isEditing = true;
                            });
                          },
                          child: const Text("Edit"),
                        ),
                      ),

                    if (item.isEditing) ...[
                      SizedBox(
                        height: 32,
                        child: ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(
                            backgroundColor:
                            Color(0xFF5261BF),
                          ),
                          onPressed: () {
                            final value =
                                double.tryParse(
                                  controller.text,
                                ) ??
                                    0;

                            if (value >
                                item.maxAllowedPrice) {
                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Price cannot exceed \$${item.maxAllowedPrice}",
                                  ),
                                ),
                              );
                              return;
                            }

                            setState(() {
                              item.proposedPrice =
                                  value;
                              item.isEditing =
                              false;
                            });
                          },
                          child: const Text("Save",style: TextStyle(color: Colors.white),),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        height: 32,
                        child: OutlinedButton(
                          onPressed: () {
                            controller.text = item
                                .proposedPrice
                                .toStringAsFixed(2);

                            setState(() {
                              item.isEditing =
                              false;
                            });
                          },
                          child:
                          const Text("Cancel"),
                        ),
                      )
                    ]
                  ],
                ),
              ],
            ),
          ),

          if (item.isExpanded)
            CompetitorTable(
              competitors: item.competitors,
            ),
        ],
      ),
    );
  }

  Widget _priceTile(
      String title,
      double value,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 5),
        Text(
          "\$${value.toStringAsFixed(2)}",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------
/// TABLE
/// ---------------------------------------------------------

class CompetitorTable extends StatelessWidget {
  final List<CompetitorItem> competitors;

  const CompetitorTable({
    super.key,
    required this.competitors,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding:
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
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
                        FontWeight.bold,
                      ),
                    )),
                Expanded(
                    flex: 3,
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Text(
                      "Comp Restaurant",
                      style: TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    )),
                SizedBox(
                  width: 80,
                  child: Text(
                    "Price",
                    style: TextStyle(
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          ...competitors.map(
                (e) => Padding(
              padding:
              const EdgeInsets.symmetric(
                vertical: 18,
              ),
              child: Row(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(e.item),
                  ),
                  Expanded(
                    flex: 3,
                    child: Text(
                      e.description,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      e.restaurant,
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Text(
                      "\$${e.price.toStringAsFixed(2)}",
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------
/// MODELS
/// ---------------------------------------------------------

class PricingAnalysisItem {
  String name;
  String description;

  double currentPrice;
  double maxAllowedPrice;
  double proposedPrice;

  bool isExpanded;
  bool isEditing;

  List<CompetitorItem> competitors;

  PricingAnalysisItem({
    required this.name,
    required this.description,
    required this.currentPrice,
    required this.maxAllowedPrice,
    required this.proposedPrice,
    this.isExpanded = true,
    this.isEditing = false,
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