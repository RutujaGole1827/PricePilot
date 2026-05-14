import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String label;
  final List<String> items;
  final String value;
  final ValueChanged<String> onChanged;
  final String hintText;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
    this.hintText = "Search",
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String searchText = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Label
        Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),

        const SizedBox(height: 8),

        /// Dropdown
        PopupMenuButton<String>(
          offset: const Offset(0, 60),
          color: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          onSelected: widget.onChanged,
          itemBuilder: (context) {
            return [
              PopupMenuItem<String>(
                enabled: false,
                padding: EdgeInsets.zero,
                child: StatefulBuilder(
                  builder: (context, setPopupState) {
                    final filteredItems = widget.items
                        .where(
                          (e) => e.toLowerCase().contains(
                        searchText.toLowerCase(),
                      ),
                    )
                        .toList();

                    return Container(
                      width: 300,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          /// Search Field
                          Container(
                            height: 48,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius:
                              BorderRadius.circular(10),
                            ),
                            child: TextField(
                              onChanged: (value) {
                                setPopupState(() {
                                  searchText = value;
                                });
                              },
                              decoration: InputDecoration(
                                hintText: widget.hintText,
                                border: InputBorder.none,
                                contentPadding:
                                const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                suffixIcon: const Icon(
                                  Icons.search,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          /// Items
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 250,
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: filteredItems.length,
                              itemBuilder: (context, index) {
                                final item =
                                filteredItems[index];

                                return InkWell(
                                  onTap: () {
                                    Navigator.pop(
                                      context,
                                      item,
                                    );
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    padding:
                                    const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors
                                              .grey.shade200,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      item,
                                      style:
                                      const TextStyle(
                                        fontSize: 18,
                                        color:
                                        Color(0xFF0B2C5F),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ];
          },

          /// Selected Value UI
          child: Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue.shade100,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.value,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}