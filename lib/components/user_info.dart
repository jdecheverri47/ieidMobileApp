import 'package:cloud_firestore/cloud_firestore.dart';
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
  late Stream<DocumentSnapshot> _userStream;
  String user = FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
    _userStream =
        FirebaseFirestore.instance.collection('users').doc(user).snapshots();
    print(_userStream);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: _userStream,
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(
              color: Color.fromRGBO(255, 225, 0, 1),
            ));
          } else {
            String? photoUrl = snapshot.data?.get('imageUrl');
            String? name = snapshot.data?.get('name');
            String? department = snapshot.data?.get('department');
            String? email = snapshot.data?.get('email');
            String? phone = snapshot.data?.get('phone');

            print(photoUrl);

            return Container(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      verticalDirection: VerticalDirection.down,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (photoUrl != "")
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('$photoUrl'),
                            backgroundColor: Colors.grey[300],
                          ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ProfileInfo(name: '$name', department: department),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: Row(
                      children: [
                        ContactInfo(email: '$email', phone: '$phone',),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        child: ProfileButtons(imageUrl: photoUrl,),
                      ),
                    ],
                  )
                ],
              ),
            );
          }
        });
  }
}
