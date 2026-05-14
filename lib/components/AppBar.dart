import 'package:flutter/material.dart';

class TopAppBar extends StatefulWidget {
  const TopAppBar({super.key});

  @override
  State<TopAppBar> createState() => _TopAppBarState();
}

class _TopAppBarState extends State<TopAppBar> {
  final LayerLink _layerLink = LayerLink();

  OverlayEntry? _overlayEntry;
  bool isMenuOpen = false;

  void _toggleMenu() {
    if (isMenuOpen) {
      _removeOverlay();
    } else {
      _showOverlay();
    }
  }

  void _showOverlay() {
    _overlayEntry = _createOverlay();
    Overlay.of(context).insert(_overlayEntry!);

    setState(() {
      isMenuOpen = true;
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;

    setState(() {
      isMenuOpen = false;
    });
  }

  OverlayEntry _createOverlay() {
    return OverlayEntry(
      builder: (context) => Positioned(
        top: 90,
        right: 20,
        child: CompositedTransformFollower(
          link: _layerLink,
          offset: const Offset(-10, 60),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: const Color(0xff001f4d),
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.15),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Column(
                children: [
                  PopupMenuTile(
                    icon: Icons.edit_outlined,
                    title: "Edit Profile",
                    onTap: () {
                      _removeOverlay();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Edit Profile Clicked"),
                        ),
                      );
                    },
                  ),

                  PopupMenuTile(
                    icon: Icons.person_outline,
                    title: "User Management",
                    onTap: () {
                      _removeOverlay();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("User Management Clicked"),
                        ),
                      );
                    },
                  ),

                  const Divider(
                    color: Colors.white12,
                    height: 1,
                  ),

                  PopupMenuTile(
                    icon: Icons.logout,
                    title: "Sign Out",
                    onTap: () {
                      _removeOverlay();

                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: const Text("Sign Out"),
                          content: const Text(
                            "Are you sure you want to sign out?",
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Signed Out"),
                                  ),
                                );
                              },
                              child: const Text("Sign Out"),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// LOGO
        /// LOGO SECTION
        Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        alignment: Alignment.centerLeft,
        color: Colors.white,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "SSP America",
              style: TextStyle(
                color: Color(0xff003c7a),
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "The Food Travels Experts",
              style: TextStyle(
                color: Color(0xff0070c0),
                fontSize: 14,
              ),
            ),
          ],
        ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// ACTIVITY LOG BUTTON
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: const Color(0xffff7a1a),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Activity Log Opened"),
                    ),
                  );
                },
                icon: const Icon(
                  Icons.history,
                  color: Colors.white,
                ),
                label: const Text(
                  "Activity Log",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),

              const SizedBox(width: 14),

              /// USER PROFILE SECTION
              CompositedTransformTarget(
                link: _layerLink,
                child: InkWell(
                  borderRadius: BorderRadius.circular(18),
                  onTap: _toggleMenu,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        /// AVATAR
                        Container(
                          height: 36,
                          width: 36,
                          decoration: const BoxDecoration(
                            color: Color(0xff003b8f),
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            "TS",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const SizedBox(width: 16),

                        /// USER DETAILS
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Tara Smith",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff0a2c5e),
                              ),
                            ),
                            Text(
                              "Senior Analyst",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(width: 12),

                        /// DROPDOWN ICON
                        AnimatedRotation(
                          duration: const Duration(milliseconds: 200),
                          turns: isMenuOpen ? 0.5 : 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xffe8eef7),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Icon(
                              Icons.keyboard_arrow_down,
                              size: 20,
                              color: Color(0xff5c708f),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PopupMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const PopupMenuTile({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 8,
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 16,
            ),

            const SizedBox(width: 16),

            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}