// import 'package:customer_app/theme/color.dart';
import 'package:customer_app/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class EditableTextFieldWButton extends StatelessWidget {
  const EditableTextFieldWButton(
      {Key? key,
      required this.controller,
      required this.editable,
      // required this.onTap,
      required this.password,
      required this.labelText})
      : super(key: key);

  final TextEditingController controller;
  final bool editable;
  final String labelText;
  final bool password;
  // final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextField(
            controller: controller,
            readOnly: !editable,
            obscureText: password,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              // prefixIcon: prefix,
              fillColor: editable ? Colors.white : Colors.transparent,
              filled: true,
              labelText: labelText,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radiusValue2),
                  borderSide: BorderSide.none),
            )).expand(),
        // const SizedBox(
        //   width: 10,
        // ),
        // AppButton(
        //   color: Colors.white,
        //   width: 10,
        //   onTap: onTap,
        //   padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        //   shapeBorder: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(radiusValue2)),
        //   child: Icon(
        //     Icons.edit,
        //     color: editable ? primary : greyDarkerColor,
        //   ),
        // )
      ],
    );
  }
}
