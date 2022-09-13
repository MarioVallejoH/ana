import 'package:flutter/material.dart';
import 'package:customer_app/theme/color.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:skeleton_text/skeleton_text.dart';

class BestSellersSkeleton extends StatelessWidget {
  const BestSellersSkeleton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<BoxShadow> shadowList = [
      BoxShadow(
          color: Colors.grey[300]!, blurRadius: 30, offset: const Offset(0, 10))
    ];
    return Row(
      children: List.generate(10, (index) {
        return Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SkeletonAnimation(
                shimmerColor: skeletonShimerColor!,
                borderRadius: BorderRadius.circular(20),
                shimmerDuration: 0,
                child: Container(
                  height: 220,
                  width: 200,
                  margin: const EdgeInsets.only(right: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: shadowList,
                  ),
                )).paddingOnly(bottom: 5),
            Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: SizedBox(
                  height: 80,
                  width: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonAnimation(
                          shimmerColor: skeletonShimerColor!,
                          borderRadius: BorderRadius.circular(0),
                          shimmerDuration: 0,
                          child: const SizedBox(
                            width: 80,
                            height: 15,
                          )),
                      SkeletonAnimation(
                          shimmerColor: skeletonShimerColor!,
                          borderRadius: BorderRadius.circular(0),
                          shimmerDuration: 0,
                          child: const SizedBox(
                            width: 160,
                            height: 30,
                          ))
                    ],
                  ).paddingSymmetric(horizontal: 10),
                )).paddingOnly(right: 15, bottom: 10)
          ],
        );
      }),
    );
  }
}
