import 'package:flutter/material.dart';

class SlideLeftPopup {
  static Future<dynamic> show(
      BuildContext context, {
        required Widget content,
        double widthFactor = 0.44,
      }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Slide Left Popup",
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 350),

      pageBuilder: (context, animation, secondaryAnimation) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            color: Colors.white,
            child: Container(
              width: MediaQuery.of(context).size.width * widthFactor,
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
              child: content,
            ),
          ),
        );
      },

      transitionBuilder:
          (context, animation, secondaryAnimation, child) {
        final offsetAnimation = Tween<Offset>(
          begin: const Offset(1, 0),
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
  }
}

