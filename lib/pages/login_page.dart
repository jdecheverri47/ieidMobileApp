import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieid/components/my_textfields.dart';
import 'package:ieid/components/my_button.dart';
import 'package:ieid/pages/register_page.dart';
import 'package:ieid/utils/my_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  void setLocalStorage() async {
    final storage = MyService.instance.storage;
    final user = await FirebaseAuth.instance.currentUser!;
    final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

    await storage.ready;
    storage.setItem('user', {
      'name': doc['name'],
      'email': doc['email'],
      'phone': doc['phone'],
    });
  }

  void signUserIn() async {

    showDialog(
      context: context,
      builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });

    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text
      );
      setLocalStorage();
      Navigator.pop(context);

    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == "INVALID_LOGIN_CREDENTIALS") {
        invalidCredentials();
      } else if (e.code == 'wrong-password') {
        noPasswordMessage();
      } else {
        print(e);
      }
    }
  }

  void invalidCredentials() {
    showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: const Text('Wrong Credentials'),
        content: const Text('The email or password you entered is incorrect'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      );
    });
  }

  void noPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
      return AlertDialog(
        title: const Text('Wrong Password'),
        content: const Text('Please type your password.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
              Row(
                children: [
                  Image.asset(
                    'lib/images/logo-ie-header.png',
                    height: 100,
                    width: 100,
                  ),
                  Image.asset(
                    'lib/images/mi-tarjeta-digital.png',
                    height: 100,
                    width: 200,
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Inicia Sesión',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Ingresa tus datos para continuar',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),



              const SizedBox(height: 30,),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text("Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  MyTextField(
                    hintText: 'Ingresa tu correo',
                    controller: emailController,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ],
              ),

              const SizedBox(height: 15),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: Text("Contraseña",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),

                    MyTextField(
                      hintText: 'Ingresa tu contraseña',
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('¿Olvidaste tu contraseña?',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              MyButton(
                text: "Iniciar Sesión",
                color: const Color.fromRGBO(255, 225, 0, 1),
                onPressed: signUserIn,
              ),

                  ],),
            ),
          )
        )
      ),
    );
  }
}