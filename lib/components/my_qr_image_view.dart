import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrImageView extends QrImageView {
  MyQrImageView({
    Key? key,
    required String data,
    required double size,
    this.onScan,
  }) : super(
          key: key,
          data: data,
          size: size,
        );

  final void Function(String str)? onScan;

}
