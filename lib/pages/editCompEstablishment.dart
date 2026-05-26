import 'package:flutter/material.dart';

import '../components/Confirmation_Popup.dart';

class EditComparableEstablishment extends StatefulWidget {
  final Map<String, dynamic> establishmentData;
  final Function(Map<String, dynamic>) onSave;
  final Function() onDelete;

  const EditComparableEstablishment({
    super.key,
    required this.establishmentData,
    required this.onSave,
    required this.onDelete,
  });

  @override
  State<EditComparableEstablishment> createState() =>
      _EditComparableEstablishmentState();
}

class _EditComparableEstablishmentState
    extends State<EditComparableEstablishment> {
  late TextEditingController nameController;
  late TextEditingController websiteController;
  late TextEditingController notesController;

  String? selectedCuisine;
  String? selectedConceptType;
  String? selectedStatus;
  String? selectedAtmosphere;

  final primaryColor = const Color(0xFF0A3A78);

  final TextStyle smallFieldStyle = const TextStyle(
    fontSize: 13,
    color: Color(0xFF0A2C57),
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(
      text: widget.establishmentData["name"] ?? "",
    );

    websiteController = TextEditingController(
      text: widget.establishmentData["website"] ?? "",
    );

    notesController = TextEditingController(
      text: widget.establishmentData["notes"] ?? "",
    );

    selectedCuisine = widget.establishmentData["cuisine"];
    selectedConceptType = widget.establishmentData["conceptType"];
    selectedStatus = widget.establishmentData["status"];
    selectedAtmosphere = widget.establishmentData["atmosphere"];
  }

  @override
  void dispose() {
    nameController.dispose();
    websiteController.dispose();
    notesController.dispose();
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
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xffD7E1EC),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: primaryColor,
          width: 1.3,
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
                fontSize: 13,
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

  Widget buildDropdown({
    required String title,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return buildField(
      title: title,
      child: DropdownButtonFormField<String>(
        value: value,
        style: smallFieldStyle,
        decoration: inputDecoration("Select"),
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        items: items
            .map(
              (e) => DropdownMenuItem<String>(
            value: e,
            child: Text(
              e,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.55,
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
                  horizontal: 24,
                  vertical: 22,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xffE6EAF0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Edit Comparable Establishment Details",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff15355B),
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.close,
                        size: 24,
                        color: Color(0xff15355B),
                      ),
                    ),
                  ],
                ),
              ),

              /// BODY
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// NAME
                      buildField(
                        title: "Name",
                        required: true,
                        child: TextField(
                          controller: nameController,
                          style: smallFieldStyle,
                          decoration:
                          inputDecoration("The Burger Saloon"),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// CUISINE + CONCEPT TYPE
                      Row(
                        children: [
                          Expanded(
                            child: buildDropdown(
                              title: "Cuisine",
                              value: selectedCuisine,
                              items: const [
                                "American",
                                "Mexican",
                                "Italian",
                                "Indian",
                              ],
                              onChanged: (v) {
                                setState(() {
                                  selectedCuisine = v;
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 24),

                          Expanded(
                            child: buildDropdown(
                              title: "Concept Type",
                              value: selectedConceptType,
                              items: const [
                                "QSR",
                                "Quick Casual",
                                "Casual Dining",
                                "Fine Dining",
                              ],
                              onChanged: (v) {
                                setState(() {
                                  selectedConceptType = v;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// WEBSITE
                      buildField(
                        title: "Establishment Website URL",
                        child: TextField(
                          controller: websiteController,
                          style: smallFieldStyle,
                          decoration: inputDecoration(""),
                        ),
                      ),

                      const SizedBox(height: 24),

                      /// STATUS + ATMOSPHERE
                      Row(
                        children: [
                          Expanded(
                            child: buildDropdown(
                              title: "Status",
                              value: selectedStatus,
                              items: const [
                                "Active",
                                "Inactive",
                              ],
                              onChanged: (v) {
                                setState(() {
                                  selectedStatus = v;
                                });
                              },
                            ),
                          ),

                          const SizedBox(width: 24),

                          Expanded(
                            child: buildDropdown(
                              title: "Atmosphere",
                              value: selectedAtmosphere,
                              items: const [
                                "Casual",
                                "Family",
                                "Modern",
                                "Luxury",
                              ],
                              onChanged: (v) {
                                setState(() {
                                  selectedAtmosphere = v;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// NOTES
                      buildField(
                        title: "Notes",
                        child: TextField(
                          controller: notesController,
                          maxLines: 3,
                          style: smallFieldStyle,
                          decoration: inputDecoration(""),
                        ),
                      ),

                      const SizedBox(height: 28),

                      /// ADDITIONAL INFO
                      const Text(
                        "Additional Information",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff15355B),
                        ),
                      ),

                      const SizedBox(height: 24),

                      Row(
                        children: const [
                          Expanded(
                            child: Text(
                              "Google_Places_ID",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff15355B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Google_Overview",
                              style: TextStyle(
                                fontSize: 13,
                                color: Color(0xff15355B),
                                fontWeight: FontWeight.w500,
                              ),
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
                    top: BorderSide(
                      color: Color(0xffE6EAF0),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    /// DELETE
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
                              (
                              context,
                              animation,
                              secondaryAnimation,
                              ) {
                            return Center(
                              child: ConfirmationPopup(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 38,
                                ),
                                label: 'Delete this establishment',
                                subContent:
                                'This item will be removed permanently.',
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
                            final offsetAnimation =
                            Tween<Offset>(
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
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                        minimumSize: const Size(120, 48),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text("Delete"),
                    ),

                    /// RIGHT ACTIONS
                    Row(
                      children: [
                        /// CLEAR
                        OutlinedButton(
                          onPressed: () {
                            nameController.clear();
                            websiteController.clear();
                            notesController.clear();

                            setState(() {
                              selectedCuisine = null;
                              selectedConceptType = null;
                              selectedStatus = null;
                              selectedAtmosphere = null;
                            });
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor:
                            const Color(0xFFFF7A1A),
                            side: const BorderSide(
                              color: Color(0xFFFF7A1A),
                            ),
                            minimumSize:
                            const Size(120, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text("Clear"),
                        ),

                        const SizedBox(width: 16),

                        /// SAVE
                        ElevatedButton(
                          onPressed: () {
                            final updatedData = {
                              ...widget.establishmentData,
                              "name": nameController.text,
                              "website":
                              websiteController.text,
                              "notes": notesController.text,
                              "cuisine": selectedCuisine,
                              "conceptType":
                              selectedConceptType,
                              "status": selectedStatus,
                              "atmosphere":
                              selectedAtmosphere,
                            };

                            widget.onSave(updatedData);

                            if (mounted) {
                              Navigator.pop(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xffFF6B00),
                            minimumSize:
                            const Size(120, 48),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                            ),
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