import 'package:flutter/material.dart';

class AddAirport extends StatefulWidget {
  const AddAirport({super.key});

  @override
  State<AddAirport> createState() => _AddAirportState();
}

class _AddAirportState extends State<AddAirport> {
  int currentTab = 0;

  /// TAB 1
  final iataController = TextEditingController();
  final nameController = TextEditingController();
  final latitudeController = TextEditingController();
  final longitudeController = TextEditingController();

  /// TAB 2
  final submissionsController = TextEditingController();
  final searchRadiusController = TextEditingController();
  final maxComparableController = TextEditingController();

  /// TAB 3
  final directorController = TextEditingController();
  final regionalController = TextEditingController();
  final businessController = TextEditingController();
  final marketingController = TextEditingController();

  String? country;
  String? compSheet;

  bool get isBasicValid =>
      iataController.text.isNotEmpty &&
          nameController.text.isNotEmpty &&
          latitudeController.text.isNotEmpty &&
          longitudeController.text.isNotEmpty &&
          country != null;

  bool get isAnalysisValid =>
      submissionsController.text.isNotEmpty &&
          searchRadiusController.text.isNotEmpty &&
          maxComparableController.text.isNotEmpty &&
          compSheet != null;

  bool get isContactsValid =>
      directorController.text.isNotEmpty &&
          regionalController.text.isNotEmpty &&
          businessController.text.isNotEmpty &&
          marketingController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();

    final controllers = [
      iataController,
      nameController,
      latitudeController,
      longitudeController,
      submissionsController,
      searchRadiusController,
      maxComparableController,
      directorController,
      regionalController,
      businessController,
      marketingController,
    ];

    for (var controller in controllers) {
      controller.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void dispose() {
    iataController.dispose();
    nameController.dispose();
    latitudeController.dispose();
    longitudeController.dispose();
    submissionsController.dispose();
    searchRadiusController.dispose();
    maxComparableController.dispose();
    directorController.dispose();
    regionalController.dispose();
    businessController.dispose();
    marketingController.dispose();
    super.dispose();
  }

  void nextTab() {
    if (currentTab < 2) {
      setState(() {
        currentTab++;
      });
    }
  }

  void previousTab() {
    if (currentTab > 0) {
      setState(() {
        currentTab--;
      });
    }
  }

  void clearAll() {
    final controllers = [
      iataController,
      nameController,
      latitudeController,
      longitudeController,
      submissionsController,
      searchRadiusController,
      maxComparableController,
      directorController,
      regionalController,
      businessController,
      marketingController,
    ];

    for (var c in controllers) {
      c.clear();
    }

    setState(() {
      currentTab = 0;
      country = null;
      compSheet = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool nextEnabled =
    currentTab == 0 ? isBasicValid : isAnalysisValid;

    final bool submitEnabled = isContactsValid;

    return Material(
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
                    "Add Airport",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff15355B),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.close, size: 22),
                  )
                ],
              ),
            ),

            /// BODY
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 20,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: _tab(
                            "Basic Information",
                            0,
                          ),
                        ),
                        Expanded(
                          child: _tab(
                            "Analysis Settings",
                            1,
                          ),
                        ),
                        Expanded(
                          child: _tab(
                            "Point Of Contacts",
                            2,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: _buildCurrentTab(),
                    ),
                  ),
                ],
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (currentTab > 0)
                    OutlinedButton(
                      onPressed: previousTab,
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(100, 46),
                      ),
                      child: const Text("Back"),
                    ),

                  if (currentTab > 0) const SizedBox(width: 12),

                  OutlinedButton(
                    onPressed: clearAll,
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(100, 46),
                    ),
                    child: const Text("Clear"),
                  ),

                  const SizedBox(width: 14),

                  currentTab != 2
                      ? ElevatedButton(
                    onPressed: nextEnabled ? nextTab : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF6B00),
                      disabledBackgroundColor:
                      const Color(0xffAAB3C5),
                      minimumSize: const Size(110, 46),
                    ),
                    child: const Text(
                      "Next",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                      : ElevatedButton(
                    onPressed: submitEnabled
                        ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                          Text("Airport Added Successfully"),
                        ),
                      );
                    }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF6B00),
                      disabledBackgroundColor:
                      const Color(0xffAAB3C5),
                      minimumSize: const Size(110, 46),
                    ),
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentTab() {
    switch (currentTab) {
      case 0:
        return _basicInformationTab();

      case 1:
        return _analysisTab();

      case 2:
        return _contactsTab();

      default:
        return const SizedBox();
    }
  }

  /// TAB 1
  Widget _basicInformationTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Is Active",
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 6),

        Row(
          children: [
            Radio(
              value: 0,
              groupValue: 0,
              onChanged: (_) {},
              visualDensity: VisualDensity.compact,
            ),
            const Text("No"),
            const SizedBox(width: 20),
            Radio(
              value: 1,
              groupValue: 0,
              onChanged: (_) {},
              visualDensity: VisualDensity.compact,
            ),
            const Text("Yes"),
          ],
        ),

        const SizedBox(height: 18),

        Row(
          children: [
            Expanded(
              child: _textField(
                "IATA Code *",
                controller: iataController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _dropdownField(
                "Country *",
                value: country,
                items: const ["USA", "India", "Canada"],
                onChanged: (v) {
                  setState(() {
                    country = v;
                  });
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        _textField(
          "Name *",
          controller: nameController,
        ),

        const SizedBox(height: 16),

        _textField(
          "Assignee",
          suffixIcon: Icons.search,
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _textField(
                "Latitude *",
                controller: latitudeController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _textField(
                "Longitude *",
                controller: longitudeController,
              ),
            ),
          ],
        ),

        const SizedBox(height: 16),

        _textField(
          "Comments",
          maxLines: 4,
        ),
      ],
    );
  }

  /// TAB 2
  Widget _analysisTab() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _textField("Last Audit Date"),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _textField("Next Audit Date"),
            ),
          ],
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: _textField(
                "Submissions Per Year",
                controller: submissionsController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _textField("Surcharges"),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: const [
            Text("Previously Approved Comps Required?"),
            SizedBox(width: 16),
            Text("No"),
            SizedBox(width: 16),
            Text("Yes"),
          ],
        ),

        const SizedBox(height: 20),

        _textField(
          "Search Radius (Miles) *",
          controller: searchRadiusController,
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: _dropdownField(
                "Comp Sheet Format",
                value: compSheet,
                items: const [
                  "PDF",
                  "Excel",
                  "CSV",
                ],
                onChanged: (v) {
                  setState(() {
                    compSheet = v;
                  });
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _textField(
                "Maximum Comparable Establishments *",
                controller: maxComparableController,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// TAB 3
  Widget _contactsTab() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _textField(
                "Director Of Operations",
                controller: directorController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _textField(
                "Regional Vice President",
                controller: regionalController,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: _textField(
                "Business Developer",
                controller: businessController,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _textField(
                "Marketing Manager",
                controller: marketingController,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        _textField("Airport Authority Contact Number"),
      ],
    );
  }

  Widget _tab(String title, int index) {
    final bool active = currentTab == index;

    return InkWell(
      onTap: () {
        /// Allow navigation only to completed tabs
        if (index == 0 ||
            (index == 1 && isBasicValid) ||
            (index == 2 && isBasicValid && isAnalysisValid)) {
          setState(() {
            currentTab = index;
          });
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: active
                  ? const Color(0xffFF6B00)
                  : const Color(0xff15355B),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 2,
            width: double.infinity,
            color: active
                ? const Color(0xffFF6B00)
                : Colors.transparent,
          ),
        ],
      ),
    );
  }

  Widget _textField(
      String label, {
        int maxLines = 1,
        IconData? suffixIcon,
        TextEditingController? controller,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          style: const TextStyle(fontSize: 11),
          decoration: InputDecoration(
            suffixIcon:
            suffixIcon != null ? Icon(suffixIcon, size: 18) : null,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
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
          ),
        ),
      ],
    );
  }

  Widget _dropdownField(
      String label, {
        required List<String> items,
        required String? value,
        required Function(String?) onChanged,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
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
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(fontSize: 11),
              ),
            ),
          )
              .toList(),
          onChanged: onChanged,
        ),
      ],
    );
  }
}