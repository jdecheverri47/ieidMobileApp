import 'package:flutter/material.dart';

class ContactInfo extends StatelessWidget {

  final String? email;
  final String? phone;

  const ContactInfo({Key? key, this.email, this.phone}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
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
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }

}

 