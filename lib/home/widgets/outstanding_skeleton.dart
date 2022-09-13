import 'package:flutter/material.dart';
import 'package:customer_app/theme/color.dart';
import 'package:nb_utils/nb_utils.dart';

class OutstandingSkeleton extends StatelessWidget {
  const OutstandingSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(10, (index) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: SizedBox(
            height: 128,
            width: 300,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: SizedBox(
                      height: 105,
                      width: 105,
                      child: Container(
                        decoration: BoxDecoration(
                            color: greyLight,
                            borderRadius: BorderRadius.circular(10)),
                        width: 100,
                        height: 15,
                      ),
                    )).paddingSymmetric(horizontal: 10),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 20,
                      width: 130,
                      child: Container(
                        decoration: BoxDecoration(
                            color: greyLight,
                            borderRadius: BorderRadius.circular(10)),
                        width: 100,
                        height: 15,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: greyLight,
                          borderRadius: BorderRadius.circular(10)),
                      width: 100,
                      height: 15,
                    ),
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
