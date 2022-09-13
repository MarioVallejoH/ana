import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import '../theme/color.dart';
import '../utils/formating/data_formating.dart';

class QttyControl extends StatelessWidget {
  const QttyControl(
      {Key? key,
      required this.add,
      this.buttonsSize,
      required this.remove,
      this.elevation = 2,
      this.enabled = true,
      required this.qtty})
      : super(key: key);
  final bool enabled;
  final Function add;
  final double? buttonsSize;
  final Function remove;
  final double qtty;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppButton(
          enabled: enabled,
          height: buttonsSize ?? 40,
          width: buttonsSize ?? 40,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onTap: () {
            remove();
          },
          child: Icon(
            Icons.remove,
            color: greyDarkerColor,
          ),
          elevation: elevation,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Text(
            getRoundedQtty(qtty),
            style:
                ThemeConf().buttonsTextStyle(context, color: greyDarkerColor),
          ),
        ),
        AppButton(
          height: buttonsSize ?? 40,
          width: buttonsSize ?? 40,
          enabled: enabled,
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          shapeBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onTap: () {
            add();
          },
          child: Icon(
            Icons.add,
            color: primary,
          ),
          elevation: elevation,
        )
      ],
    );
  }
}
