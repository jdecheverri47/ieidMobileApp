import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieid/components/my_button.dart';
import 'package:share_plus/share_plus.dart';

class ProfileButtons extends StatelessWidget {

  const ProfileButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MyButton(
            text: "Edit Profile",
            width: 160.0,
            height: 30.0,
            color: const Color.fromRGBO(255, 232, 55, 1),
            onPressed: () {
              final String url = 'https://thehun-infections-pursue-ordering.trycloudflare.com/forms?user=${FirebaseAuth.instance.currentUser!.uid}';
              Share.share(url);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: MyButton(
              text: "Share QR",
              width: 165.0,
              height: 30.0,
              color: const Color.fromRGBO(255, 232, 55, 1),
              onPressed: () {
                final String url = 'https://thehun-infections-pursue-ordering.trycloudflare.com/forms?user=${FirebaseAuth.instance.currentUser!.uid}';
                Share.share(url);
              },
            ),
          ),
      ],
    );
  }
}