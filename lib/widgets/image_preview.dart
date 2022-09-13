import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:customer_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:customer_app/theme/color.dart';
import 'package:nb_utils/nb_utils.dart';
// ignore: implementation_imports

import 'package:photo_view/photo_view.dart';

// import 'package:pos_wappsi/components/image_file.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview(
      {Key? key,
      required this.imagePath,
      this.isAssetImage = false,
      this.isFileImage = false,
      this.withBottom = false,
      this.bottomSubtitle,
      this.bottomTitle,
      this.isNetworkImage = false})
      : super(key: key);
  final String imagePath;
  final bool isAssetImage;
  final bool withBottom;
  final String? bottomTitle;
  final String? bottomSubtitle;
  final bool isFileImage;
  final bool isNetworkImage;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  bool _showBottom = true;
  @override
  Widget build(BuildContext context) {
    dynamic imgProvider;
    if (widget.isFileImage) {
      imgProvider = FileImage(File(widget.imagePath));
    } else if (widget.isAssetImage) {
      imgProvider = AssetImage(widget.imagePath);
    } else if (widget.isNetworkImage) {
      imgProvider = CachedNetworkImageProvider(widget.imagePath);
    }
    return GestureDetector(
      onTap: () {
        setState(() {
          _showBottom = !_showBottom;
        });
      },
      child: Scaffold(
        floatingActionButton: _showBottom
            ? AppButton(
                height: 0,
                width: 0,
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(10),
                shapeBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                color: primary,
                child: Icon(
                  Icons.clear,
                  color: colorOnPColor,
                ),
                onTap: () {
                  finish(context);
                },
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PhotoView(
              backgroundDecoration: const BoxDecoration(color: Colors.white),
              imageProvider: imgProvider,
            ),
            widget.withBottom
                ? AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: _showBottom ? 78 : 0,
                    decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        )),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.bottomTitle ?? '',
                          textAlign: TextAlign.justify,
                          overflow: TextOverflow.ellipsis,
                          maxLines: widget.bottomSubtitle == null ? 2 : 1,
                          style: ThemeConf().titleTextStile(context,
                              fontWeightDelta: 3, color: Colors.white),
                        ).paddingBottom(4),
                        widget.bottomSubtitle != null
                            ? Text(
                                widget.bottomSubtitle ?? '',
                                style: ThemeConf().normalTextStyle(context,
                                    fontSizeFactor: 0.8, color: greyLight),
                              )
                            : Container(),
                      ],
                    ))
                : Container()
          ],
        ),
      ),
    );
  }
}
