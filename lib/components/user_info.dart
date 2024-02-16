import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieid/components/contact_info.dart';
import 'package:ieid/components/profile_buttons.dart';
import 'package:ieid/components/profile_info.dart';

class MyUserInfo extends StatefulWidget {
  const MyUserInfo({Key? key}) : super(key: key);

  @override
  State<MyUserInfo> createState() => _MyUserInfoState();
}

class _MyUserInfoState extends State<MyUserInfo> {
  String user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Row(
            verticalDirection: VerticalDirection.down,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: const AssetImage('lib/images/user.png'),
                backgroundColor: Colors.grey[300],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileInfo(),
                  ],
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              children: [
                ContactInfo(),
              ],
            ),
          ),
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: ProfileButtons(),
              ),
            ],
          )

        ],
      ),
    );
  }
}
