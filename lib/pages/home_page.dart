import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieid/components/home_tab.dart';
import 'package:ieid/components/qr_section.dart';
import 'package:ieid/components/user_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  void function() {
    print('Hello');
  }

  @override
  Widget build(BuildContext context) {
    void signUserOut() {
      FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.transparent,
        title: const Text(
          'My QR',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 225, 0, 1),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const MyUserInfo(),
          const QrSection(),
          const SizedBox(height: 10),
          HomeTab()

        ],
      )
    );
  }
}

