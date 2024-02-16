import 'package:flutter/material.dart';
import 'package:ieid/utils/my_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vcard_maintained/vcard_maintained.dart';

class QrOffline extends StatefulWidget {
  const QrOffline({super.key});

  @override
  State<QrOffline> createState() => _QrOfflineState();
}

class _QrOfflineState extends State<QrOffline> {
  final storage = MyService.instance.storage;
  Map<String, String?>? socialUrls = {
    'facebook': 'https://www.facebook.com/iegrupo',
    'instagram': 'https://www.instagram.com/iegrupo/',
    'linkedin': 'https://www.linkedin.com/company/iegrupo',
    'twitter': 'https://twitter.com/iegrupo',
    'youtube': 'https://www.youtube.com/channel/UC4QX0Z0Z5u2Z5X0Q4Z2Z2jw',
  };

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.data == true) {
          final user = storage.getItem('user');
          final vCard = VCard();
          vCard.firstName = user['name'];
          vCard.workEmail = user['email'];
          vCard.workPhone = user['phone'];
          vCard.organization = 'Internacional de Electricos';
          vCard.socialUrls = socialUrls;

          return SizedBox(
            height: 250,
            width: 250,
            child: QrImageView(
              data: vCard.getFormattedString(),
              version: QrVersions.auto,
              size: 400,
              gapless: false,
            ),
          );
        }
        return const Center(
          child: Text(
            'No data found',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      }
    );
  }
}
