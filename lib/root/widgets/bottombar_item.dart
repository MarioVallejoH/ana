import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../cart/models/cart_item_model.dart';
import '../../theme/color.dart';

class BottomBarItem extends StatefulWidget {
  const BottomBarItem(this.icon,
      {Key? key,
      this.onTap,
      this.withBadge = false,
      this.badgeValue,
      this.color = Colors.grey,
      this.activeColor,
      this.isActive = false})
      : super(key: key);
  final String icon;
  final Color color;
  final bool withBadge;
  final Stream<List<CartItem>?>? badgeValue;
  final Color? activeColor;
  final bool isActive;
  final GestureTapCallback? onTap;

  @override
  State<BottomBarItem> createState() => _BottomBarItemState();
}

class _BottomBarItemState extends State<BottomBarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: widget.isActive?primary:Colors.white,
          // color: widget.isActive ? primary : bottomBarColor,
          boxShadow: [
            if (widget.isActive)
              BoxShadow(
                color: colorOnPColor,
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 0), // changes position of shadow
              ),
          ],
        ),
        child: widget.withBadge
            ? StreamBuilder<List<CartItem>?>(
                stream: widget.badgeValue,
                builder: (BuildContext context,
                    AsyncSnapshot<List<CartItem>?> snapshot) {
                  if (snapshot.hasData &&
                      (snapshot.data?.isNotEmpty ?? false)) {
                    return Badge(
                      alignment: Alignment.topRight,
                      // padding: EdgeInsets.all(3),
                      position: BadgePosition.topEnd(),
                      // padding: const EdgeInsets.only(
                      //     right: 5, bottom: 1, top: 2, left: 2),
                      elevation: 0,
                      child: _icon(),
                      // badgeColor: widget.isActive ? primary : colorOnPColor,
                      badgeContent: Text(
                        snapshot.data?.length.toString() ?? '',
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return _icon();
                },
              )
            : _icon(),
      ),
    );
  }

  SvgPicture _icon() {
    return SvgPicture.asset(
      widget.icon,
      color: !widget.isActive ? Colors.grey : widget.color,
      width: 25,
      height: 25,
    );
  }
}
