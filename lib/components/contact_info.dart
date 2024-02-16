import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:ieid/components/profile_buttons.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  String user = FirebaseAuth.instance.currentUser!.uid;

  Future<Map<String, String>> _getUser() async {
    DocumentSnapshot doc =
        await FirebaseFirestore.instance.collection('users').doc(user).get();

    return {
      'name': doc['name'],
      'email': doc['email'],
      'phone': doc['phone'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _getUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, String> data = snapshot.data as Map<String, String>;
          String? email = data['email'];
          String? phone = data['phone'];

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.email,
                        color: Color.fromRGBO(255, 225, 0, 1), size: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text("$email",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                          )),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Icon(Icons.phone_android,
                        color: Color.fromRGBO(255, 225, 0, 1), size: 24),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        "$phone",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  children: [
                    Icon(Icons.phone,
                        color: Color.fromRGBO(255, 225, 0, 1), size: 24),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "(601) 744 81 30",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                const Row(
                  children: [
                    Icon(Icons.location_on,
                        color: Color.fromRGBO(255, 225, 0, 1), size: 24),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text(
                        "Bogotá  Calle 22B N° 30-32  Puerta 2",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(
            color: Color.fromRGBO(255, 225, 0, 1),
          ));
        }
      },
    );
  }
}
