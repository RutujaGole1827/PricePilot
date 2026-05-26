import 'package:flutter/material.dart';

import '../components/Confirmation_Popup.dart';

class RevenueCenterPage extends StatefulWidget {
  final Map<String, dynamic> revenueData;
  final Function(Map<String, dynamic>) onSave;
  final Function() onDelete;

  const RevenueCenterPage({
    super.key,
    required this.revenueData,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<RevenueCenterPage> createState() => _RevenueCenterPageState();
}

class _RevenueCenterPageState extends State<RevenueCenterPage> {
  late TextEditingController nameController;
  late TextEditingController airportController;
  late TextEditingController locationController;
  late TextEditingController locationNotesController;
  late TextEditingController gateController;

  String? selectedCuisine;
  String? selectedConcept;

  bool isActive = true;
  bool isBrandControlled = false;
  bool approvedComps = false;
  bool convenienceComps = false;
  bool alcoholComps = false;

  final primaryColor = const Color(0xFF0A3A78);

  final TextStyle smallFieldStyle = const TextStyle(
    fontSize: 13,
    color: Color(0xFF0A2C57),
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    super.initState();

    selectedCuisine = widget.revenueData["cuisine"];
    selectedConcept = widget.revenueData["concept"];

    nameController =
        TextEditingController(text: widget.revenueData["title"]);

    airportController =
        TextEditingController(text: widget.revenueData["airport"] ?? "ATL");

    locationController =
        TextEditingController(text: widget.revenueData["location"]);

    locationNotesController =
        TextEditingController(text: widget.revenueData["terminal"] ?? "");

    gateController =
        TextEditingController(text: widget.revenueData["gate"] ?? "");

    isActive = widget.revenueData["isActive"] ?? true;
  }

  @override
  void dispose() {
    nameController.dispose();
    airportController.dispose();
    locationController.dispose();
    locationNotesController.dispose();
    gateController.dispose();

    super.dispose();
  }

  InputDecoration inputDecoration(String hint) {
    return InputDecoration(
      isDense: true,
      hintText: hint,
      hintStyle: const TextStyle(
        fontSize: 13,
        color: Colors.grey,
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          color: Color(0xffD7E1EC),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: primaryColor,
        ),
      ),
    );
  }

  Widget sectionTitle(String title, {bool required = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Color(0xFF0D2B52),
              ),
            ),
            if (required)
              const TextSpan(
                text: ' *',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget radioGroup({
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Row(
      children: [
        Row(
          children: [
            Radio<bool>(
              value: false,
              groupValue: value,
              activeColor: primaryColor,
              visualDensity: VisualDensity.compact,
              onChanged: (v) => onChanged(v!),
            ),
            const Text(
              "No",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
        const SizedBox(width: 12),
        Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: value,
              activeColor: primaryColor,
              visualDensity: VisualDensity.compact,
              onChanged: (v) => onChanged(v!),
            ),
            const Text(
              "Yes",
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildField({
    required String title,
    bool required = false,
    Widget? child,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle(title, required: required),
        child ??
            TextField(
              style: smallFieldStyle,
              decoration: inputDecoration(""),
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.52,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            children: [
              /// HEADER
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xffE6EAF0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Edit Revenue Center",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff15355B),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.close, size: 22),
                    ),
                  ],
                ),
              ),

              /// BODY
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionTitle("Status"),

                      Row(
                        children: [
                          Radio<bool>(
                            value: true,
                            groupValue: isActive,
                            activeColor: primaryColor,
                            onChanged: (v) {
                              setState(() => isActive = v!);
                            },
                          ),
                          const Text(
                            "Active",
                            style: TextStyle(fontSize: 13),
                          ),
                          const SizedBox(width: 20),
                          Radio<bool>(
                            value: false,
                            groupValue: isActive,
                            activeColor: primaryColor,
                            onChanged: (v) {
                              setState(() => isActive = v!);
                            },
                          ),
                          const Text(
                            "Inactive",
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      buildField(
                        title: "Name",
                        required: true,
                        child: TextField(
                          controller: nameController,
                          style: smallFieldStyle,
                          decoration: inputDecoration("Atlanta Bread"),
                        ),
                      ),

                      const SizedBox(height: 20),

                      buildField(
                        title: "Airport",
                        required: true,
                        child: TextField(
                          controller: airportController,
                          style: smallFieldStyle,
                          decoration: inputDecoration("ATL").copyWith(
                            suffixIcon: const Icon(Icons.search, size: 18),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: buildField(
                              title: "Cuisine",
                              child: DropdownButtonFormField<String>(
                                value: selectedCuisine,
                                style: smallFieldStyle,
                                decoration: inputDecoration("Select"),
                                items: const [
                                  DropdownMenuItem(
                                    value: "American",
                                    child: Text(
                                      "American",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Italian",
                                    child: Text(
                                      "Italian",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Indian",
                                    child: Text(
                                      "Indian",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                                onChanged: (v) {
                                  setState(() {
                                    selectedCuisine = v;
                                  });
                                },
                              ),
                            ),
                          ),

                          const SizedBox(width: 20),

                          Expanded(
                            child: buildField(
                              title: "Concept Type",
                              child: DropdownButtonFormField<String>(
                                value: selectedConcept,
                                style: smallFieldStyle,
                                decoration: inputDecoration("Select"),
                                items: const [
                                  DropdownMenuItem(
                                    value: "QSR",
                                    child: Text(
                                      "QSR",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Quick_Casual",
                                    child: Text(
                                      "Quick Casual",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: "Other",
                                    child: Text(
                                      "Other",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                                onChanged: (v) {
                                  setState(() {
                                    selectedConcept = v;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      buildField(
                        title: "Location Notes",
                        child: TextField(
                          controller: locationController,
                          style: smallFieldStyle,
                          decoration: inputDecoration("Location Notes"),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: buildField(
                              title: "Gate",
                              child: TextField(
                                controller: gateController,
                                style: smallFieldStyle,
                                decoration: inputDecoration("Gate"),
                              ),
                            ),
                          ),

                          const SizedBox(width: 20),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                sectionTitle("Is Brand Controlled"),
                                radioGroup(
                                  value: isBrandControlled,
                                  onChanged: (v) {
                                    setState(() {
                                      isBrandControlled = v;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              /// FOOTER
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 18,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Color(0xffE6EAF0)),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        showGeneralDialog(
                          context: context,
                          barrierDismissible: true,
                          barrierLabel: "Popup",
                          barrierColor: Colors.black54,
                          transitionDuration:
                          const Duration(milliseconds: 350),
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                            return Center(
                              child: ConfirmationPopup(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 38,
                                ),
                                label: 'Delete this item',
                                subContent:
                                'The item will no longer appear in your list.',
                                continuebtnlabel: 'Delete',
                                backbtnlabel: 'Cancel',
                                onCloseWithoutSaving: () {},
                                onContinueEditing: () {
                                  widget.onDelete();
                                },
                              ),
                            );
                          },
                          transitionBuilder:
                              (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                              ) {
                            final offsetAnimation = Tween<Offset>(
                              begin: const Offset(0, -1),
                              end: Offset.zero,
                            ).animate(
                              CurvedAnimation(
                                parent: animation,
                                curve: Curves.easeOut,
                              ),
                            );

                            return SlideTransition(
                              position: offsetAnimation,
                              child: child,
                            );
                          },
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                        side: const BorderSide(color: Colors.red),
                        minimumSize: const Size(110, 46),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Delete"),
                    ),

                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            nameController.clear();
                            airportController.clear();
                            locationController.clear();
                            locationNotesController.clear();
                            gateController.clear();

                            setState(() {
                              selectedCuisine = null;
                              selectedConcept = null;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFFFF7A1A),
                            side: const BorderSide(
                              color: Color(0xFFFF7A1A),
                            ),
                            minimumSize: const Size(110, 46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Clear"),
                        ),

                        const SizedBox(width: 14),

                        ElevatedButton(
                          onPressed: () {
                            final updatedData = {
                              ...widget.revenueData,
                              "title": nameController.text,
                              "airport": airportController.text,
                              "cuisine": selectedCuisine,
                              "concept": selectedConcept,
                              "location": locationController.text,
                              "terminal": locationNotesController.text,
                              "gate": gateController.text,
                              "isActive": isActive,
                            };

                            widget.onSave(updatedData);

                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffFF6B00),
                            minimumSize: const Size(110, 46),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
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