import 'package:flutter/material.dart';
import 'package:food_delivery/core/Colors/color_manager.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String hint;
  final String? Function(String?)? validator;
  final bool isPassword;
  final Function(String)? onFieldSubmitted;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.hint,
    this.validator,
    this.isPassword = false,
    this.onFieldSubmitted,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isObscure = true;
  OutlineInputBorder _outLineInPutBorder({bool error = false}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      gapPadding: 8,
      borderSide: BorderSide(
        color: error ? ColorManager.error : ColorManager.black,
        width: 1.25,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: widget.isPassword ? _isObscure : false,
      onFieldSubmitted: widget.onFieldSubmitted,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: widget.hint,
        hintStyle: const TextStyle(color: ColorManager.grey, fontSize: 14),
        border: _outLineInPutBorder(),
        focusedBorder: _outLineInPutBorder(),
        errorBorder: _outLineInPutBorder(error: true),
        suffixIcon:
            widget.isPassword
                ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscure = !_isObscure;
                    });
                  },
                  child: Icon(
                    _isObscure ? Icons.visibility_off : Icons.visibility,
                  ),
                )
                : null,
      ),
    );
  }
}
