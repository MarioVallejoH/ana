import 'package:customer_app/utils/constant.dart';
import 'package:flutter/material.dart';

class CustomRoundTextForm extends StatelessWidget {
  const CustomRoundTextForm(
      {Key? key,
      this.hint = "",
      this.prefix,
      this.onChanged,
      this.initialValue,
      this.focus,
      this.suffix,
      this.controller,
      this.onFieldSubmitted,
      this.keyboardType,
      this.validator,
      this.onTap,
      this.obscureText = false,
      this.labelText,
      this.readOnly = false,
      this.maxLenght,
      this.maxLines,
      this.boxShadow,
      this.contentPadding})
      : super(key: key);
  final String hint;
  final String? initialValue;
  final bool obscureText;
  final Widget? prefix;
  final Widget? suffix;
  final TextInputType? keyboardType;
  final FocusNode? focus;
  final Function? onTap;
  final int? maxLines;
  final int? maxLenght;
  final String? labelText;
  final Function(String)? onFieldSubmitted;

  final Function(String)? onChanged;
  final String? Function(String?)? validator;

  final bool readOnly;
  final BoxShadow? boxShadow;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusValue2)),
      child: TextFormField(
        textAlignVertical: TextAlignVertical.center,
        onFieldSubmitted: onFieldSubmitted,
        focusNode: focus,
        keyboardType: keyboardType,
        maxLength: maxLenght,
        maxLines: maxLines,
        obscureText: obscureText,
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        autovalidateMode: AutovalidateMode.disabled,
        validator: validator,
        initialValue: initialValue,
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            contentPadding: contentPadding,
            prefixIcon: prefix,
            suffixIcon: suffix,
            labelText: labelText,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15)),
      ),
    );
  }
}
