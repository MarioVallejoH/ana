import 'package:flutter/material.dart';

import '../theme/color.dart';

class CustomRoundTextBox extends StatelessWidget {
  const CustomRoundTextBox(
      {Key? key,
      this.hint = "",
      this.prefix,
      this.onChanged,
      this.focus,
      this.suffix,
      this.controller,
      this.onTap,
      this.readOnly = false,
      this.boxShadow,
      this.contentPadding})
      : super(key: key);
  final String hint;
  final Widget? prefix;
  final Widget? suffix;
  final FocusNode? focus;
  final Function? onTap;
  final Function(String)? onChanged;
  final bool readOnly;
  final BoxShadow? boxShadow;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    BoxShadow _boxShadow = boxShadow ??
        BoxShadow(
          color: shadowColor.withOpacity(0.05),
          spreadRadius: 1,
          blurRadius: 1,
          offset: const Offset(0, 1), // changes position of shadow
        );
    return Container(
      alignment: Alignment.center,
      // padding: const EdgeInsets.only(top: 3),
      height: 40,
      decoration: BoxDecoration(
        color: textBoxColor,
        border: Border.all(color: textBoxColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [_boxShadow],
      ),
      child: TextField(
        focusNode: focus,
        onTap: () {
          if (onTap != null) {
            onTap!();
          }
        },
        readOnly: readOnly,
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
            contentPadding: contentPadding,
            prefixIcon: prefix,
            suffixIcon: suffix,
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.grey, fontSize: 15)),
      ),
    );
  }
}
