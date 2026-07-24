import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';
import 'package:food_delivery/core/router/contents_router.dart';

import '../../../core/widget/show_snack_bar.dart';

class ForgotPasswordBottomSheet extends StatefulWidget {
  @override
  State<ForgotPasswordBottomSheet> createState() =>
      _ForgotPasswordBottomSheetState();
  final String titleEmail;
  final String? titlePhone;

  const ForgotPasswordBottomSheet({
    super.key,
    required this.titleEmail,
    this.titlePhone,
  });
}

class _ForgotPasswordBottomSheetState extends State<ForgotPasswordBottomSheet> {
  String selectedOption = "whatsapp"; // default selected option

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Forgot password?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            "Select which contact details should we use to reset your password",
          ),
          const SizedBox(height: 20),

          // WhatsApp Option
          GestureDetector(
            onTap: () {
              setState(() {
                selectedOption = "whatsapp";
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      selectedOption == "whatsapp"
                          ? ColorManager.primary
                          : ColorManager.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.messenger, color: ColorManager.green),
                  const SizedBox(width: 10),
                  Expanded(child: Text(widget.titlePhone ?? "No there phone")),
                  if (selectedOption == "whatsapp")
                    const Icon(Icons.check_circle, color: ColorManager.primary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Email Option
          GestureDetector(
            onTap: () {
              setState(() {
                selectedOption = "email";
              });
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      selectedOption == "email"
                          ? ColorManager.primary
                          : ColorManager.grey,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.email, color: ColorManager.blue),
                  const SizedBox(width: 10),
                  Expanded(child: Text(widget.titleEmail)),
                  if (selectedOption == "email")
                    const Icon(Icons.check_circle, color: ColorManager.primary),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Continue Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorManager.primary,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              if ((selectedOption == "whatsapp" && widget.titlePhone == null)) {
               AppSnackBar.error(context, message: "there is no phone number");
                return;
              }
              Navigator.pop(context);
              Navigator.pushNamed(
                context,
                ContentsRouter.otpView,
                arguments:
                    selectedOption == "whatsapp"
                        ? widget.titlePhone
                        : widget.titleEmail,
              );
            },
            child: const Text(
              "Continue",
              style: TextStyle(color: ColorManager.white),
            ),
          ),
        ],
      ),
    );
  }
}
