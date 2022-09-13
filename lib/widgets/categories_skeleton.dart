import 'package:flutter/material.dart';
import 'package:customer_app/theme/color.dart';

class CategoriesSkeleton extends StatelessWidget {
  const CategoriesSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(10, (index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            width: 125,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                    decoration: BoxDecoration(
                        color: greyLight,
                        borderRadius: BorderRadius.circular(10)),
                    width: 28,
                    height: 28,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: greyLight,
                      borderRadius: BorderRadius.circular(10)),
                  width: 40,
                  height: 28,
                ),
              ],
            ),
            // margin: const EdgeInsets.only(right: 15),
          ),
        );
      }),
    );
  }
}
