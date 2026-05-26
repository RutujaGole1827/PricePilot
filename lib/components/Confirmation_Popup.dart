import 'package:flutter/material.dart';

class ConfirmationPopup extends StatelessWidget {
  final VoidCallback onCloseWithoutSaving;
  final VoidCallback onContinueEditing;
  final Icon? icon;
  final String? label;
  final String? backbtnlabel;
  final String? continuebtnlabel;
  final String? subContent;

  const ConfirmationPopup({
    super.key,
    required this.onCloseWithoutSaving,
    required this.onContinueEditing,
    this.icon,this.label,this.backbtnlabel,this.continuebtnlabel,
    this.subContent,
  });

  /// CALL THIS METHOD TO OPEN POPUP
  static Future<void> show(
      BuildContext context, {
        required VoidCallback onCloseWithoutSaving,
        required VoidCallback onContinueEditing,
        Icon? icon,
        String? label,String? backbtnlabel,String? continuebtnlabel,
        String? subContent,
      }) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black54,
      builder: (_) => ConfirmationPopup(
        onCloseWithoutSaving: onCloseWithoutSaving,
        onContinueEditing: onContinueEditing,
        icon: icon,backbtnlabel: backbtnlabel,continuebtnlabel: continuebtnlabel,
        label: label,subContent: subContent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 36,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 30,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// WARNING ICON
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE5E5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: icon?? Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.red,
                    size: 38,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// TITLE
              Text(
                label??"Unsaved Changes",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF062B5B),
                ),
              ),

              const SizedBox(height: 14),

              /// DESCRIPTION
              Text(subContent??
                "Closing this without saving will\npermanently discard your changes.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: Color(0xFF2D3E5E),
                ),
              ),

              const SizedBox(height: 26),

              /// BUTTONS
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onCloseWithoutSaving();
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        side: const BorderSide(
                          color: Color(0xFF062B5B),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(backbtnlabel??
                        "Close Without Saving",
                        style: TextStyle(
                          color: Color(0xFF062B5B),
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        onContinueEditing();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF062B5B),
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(continuebtnlabel??
                        "Continue Editing",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}