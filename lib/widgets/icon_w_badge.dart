import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_utils/nb_utils.dart';

import '../theme/color.dart';

class CartIconWBadge extends StatefulWidget {
  const CartIconWBadge(this.icon,
      {Key? key,
      this.onTap,
      this.withBadge = false,
      this.svg = true,
      this.badgeValue,
      this.color = Colors.grey,
      this.bgColor,
      this.isActive = false})
      : super(key: key);
  final String icon;
  final Color color;
  final bool withBadge;
  final bool svg;
  final int? badgeValue;
  final Color? bgColor;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  State<CartIconWBadge> createState() => _CartIconWBadgeState();
}

class _CartIconWBadgeState extends State<CartIconWBadge> {
  @override
  Widget build(BuildContext context) {
    return AppButton(
      padding: EdgeInsets.zero,
      width: 0,
      height: 0,
      elevation: 0,
      color: primary,
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: widget.bgColor ?? primary,
          border: Border.all(color: greyLight, width: 1.5),
          // color: widget.isActive ? primary : bottomBarColor,
          boxShadow: [
            if (widget.isActive)
              BoxShadow(
                color: primary.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0), // changes position of shadow
              ),
          ],
        ),
        child: widget.withBadge
            ? (widget.badgeValue ?? 0) > 0
                ? Badge(
                    alignment: Alignment.topRight,
                    // padding: EdgeInsets.all(3),
                    position: BadgePosition.topEnd(),
                    // padding: const EdgeInsets.only(
                    //     right: 5, bottom: 1, top: 2, left: 2),
                    elevation: 0,
                    child: _icon(),
                    // badgeColor: widget.isActive ? primary : colorOnPColor,
                    badgeContent: Text(
                      (widget.badgeValue ?? 0).toString(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  )
                : _icon()
            : _icon(),
      ),
    );
  }

  Widget _icon() {
    return (widget.svg
            ? SvgPicture.asset(
                widget.icon,
                color: widget.isActive ? primary : widget.color,
                width: 24,
                height: 24,
              )
            : Image.asset(
                widget.icon,
                color: widget.isActive ? primary : widget.color,
                width: 24,
                height: 24,
              ))
        .paddingRight(4);
  }
}
