import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrOnline extends StatelessWidget {
  QrOnline({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 250,
      child: QrImageView(
        data:
            'https://horizontal-edwards-history-alcohol.trycloudflare.com/forms?user=${user.uid}',
        size: 300,
      ),
    );
  }
}
