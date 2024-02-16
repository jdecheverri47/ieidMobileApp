import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieid/components/my_button.dart';
import 'package:ieid/components/my_textfields.dart';
import 'package:ieid/pages/login_page.dart';
import 'package:ieid/utils/my_service.dart';
import '../utils/user_json.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();

  // late AnimationController _animationController;
  // late Widget _tick;

  Future<void> signUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(
                color: Color.fromRGBO(255, 225, 0, 1)),
          );
        });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);

      String user = FirebaseAuth.instance.currentUser!.uid;

      if (user.isNotEmpty) {
        await FirebaseFirestore.instance.collection('users').doc(user).set({
          'firstname': firstnameController.text,
          'lastname': lastnameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
          'userId': user,
        });

        UserModel userData = UserModel(
          firstname: firstnameController.text,
          lastname: lastnameController.text,
          email: emailController.text,
          phone: phoneController.text,
          userId: user,
        );

        final json = userData.toJson();

        await MyService.instance.storage.setItem('user', json);
      }

      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        ModalRoute.withName('/LoginPage'), // Asegúrate de que '/LoginPage' sea una ruta registrada en tu aplicación
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      if (e.code == 'weak-password') {
        weakPasswordMessage();
      } else if (e.code == 'email-already-in-use') {
        emailAlreadyInUseMessage();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // _animationController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(seconds: 1),

    // );

    // _tick = AnimatedBuilder(
    //   animation: _animationController,
    //   builder: (context, child) {
    //     return Icon(
    //       Icons.check,
    //       color: Colors.green,
    //       size: 50 * _animationController.value,
    //     );
    //   }
    //   );
  }

  void weakPasswordMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Weak Password'),
            content: const Text('The password you entered is too weak'),
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

  void emailAlreadyInUseMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Email Already in Use'),
            content: const Text('The email you entered is already in use'),
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
      appBar: AppBar(
        toolbarHeight: 80,
        shadowColor: Colors.transparent,
        title: RichText(
          text: const TextSpan(
            text: 'Completa los datos para ',
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.normal,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'crear tu cuenta',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromRGBO(255, 225, 0, 1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nombre",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    MyTextField(
                      hintText: 'Ingresa tu nombre',
                      controller: firstnameController,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Apellido",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    MyTextField(
                      hintText: 'Ingresa tu apellido',
                      controller: lastnameController,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Celular",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    MyTextField(
                      hintText: 'Ingresa tu numero de celular',
                      controller: phoneController,
                      obscureText: false,
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Email",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    MyTextField(
                      hintText: 'Ingresa tu correo electronico',
                      controller: emailController,
                      obscureText: false,
                      keyboardType: TextInputType.name,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Contraseña",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    MyTextField(
                      hintText: 'Ingresa tu contraseña',
                      controller: passwordController,
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),
                const Text(
                  'By creating an account, you agree to our Terms of Service and Privacy Policy.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                MyButton(
                  text: "Registrarse",
                  color: const Color.fromRGBO(255, 225, 0, 1),
                  onPressed: signUp,
                ),
                // _tick
              ],
            ),
          ),
        ),
      ),
    );
  }
}
