import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

/// Ventana de dialogo para ver el detalle de una imagen

void imageDetailDialog(
  BuildContext context,
  XFile file,
  int index,
) =>
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        final size = MediaQuery.of(context).size;
        return AlertDialog(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          insetPadding: EdgeInsets.zero,
          scrollable: true,
          content: SizedBox(
            width: size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: size.height * 0.02),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image(
                    height: size.height * 0.4,
                    image: FileImage(File(file.path)),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: size.height * 0.025),
              ],
            ),
          ),
        );
      },
    );
