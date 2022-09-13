import 'package:flutter/material.dart';
import 'package:customer_app/theme/color.dart';
import 'package:nb_utils/nb_utils.dart';

class ProdDetSelectionSkeleton extends StatelessWidget {
  const ProdDetSelectionSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(5, (index) {
        return Card(
          elevation: 0,
          margin: const EdgeInsets.all(1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          child: SizedBox(
            height: 80,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                            decoration: BoxDecoration(
                                color: greyLight,
                                borderRadius: BorderRadius.circular(10)),
                            height: 20,
                            width: 130)
                        .paddingSymmetric(horizontal: 16),
                    Container(
                      decoration: BoxDecoration(
                          color: greyLight,
                          borderRadius: BorderRadius.circular(10)),
                      width: 100,
                      height: 15,
                    ),
                  ],
                )
              ],
            ),
            // margin: const EdgeInsets.only(right: 15),
          ),
        );
      }),
    );
  }
}
