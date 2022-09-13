import 'package:customer_app/products/products.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:nb_utils/nb_utils.dart';

import '../theme/color.dart';
import '../utils/formating/data_formating.dart';

class PreferenceCard extends StatelessWidget {
  const PreferenceCard(
      {Key? key,
      required this.onTap,
      required this.prodPref,
      required this.isSelected})
      : super(key: key);

  final Function onTap;
  final ProductPreference? prodPref;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            height: 70,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  capitalizeText(prodPref?.name ?? ''),
                  style: ThemeConf().normalTextStyle(
                    context,
                  ),
                ).expand(),
                Container(
                  height: 25,
                  width: 25,
                  margin: const EdgeInsets.only(left: 16),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: greyDLight, width: 0.7)),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: isSelected ? primary : Colors.white),
                  ),
                ),
                // Checkbox(
                //   checkColor: Colors.white,
                //   fillColor: MaterialStateProperty.all(primary),
                //   // fillColor: MaterialStateProperty.resolveWith(primary),
                //   value: isSelected,

                //   shape: const CircleBorder(),
                //   onChanged: (bool? v) {
                //     onTap();
                //   },
                // )
              ],
            )
            // margin: const EdgeInsets.only(right: 15),
            ),
      ),
    );
  }
}
