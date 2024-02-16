
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  String user = FirebaseAuth.instance.currentUser!.uid;

  Future<Map<String, String>> _getUser() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance.collection('users').doc(user).get();
    return {
      'name': doc['name'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done) {
          Map<String, String> data = snapshot.data as Map<String, String>;
          String? name = data['name'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "$name",
                  style: const TextStyle(
                  color: Color(0xFF1A1A1A),
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  height: 0.04,
                  )
                ),

                const SizedBox(height: 15),
                const Text(
                    'Director Administrativo\ny Comercial',
                    style: TextStyle(
                        color: Color(0xFF63666B),
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                    ),
                ),

              ],
            ),
          );

        } else {
          return const Center(child: CircularProgressIndicator(color: Color.fromRGBO(255, 225, 0, 1),));
        }
      },
    );
  }
}