import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final String? name;
  final String? department;

  const ProfileInfo({Key? key, required this.name, this.department})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("$name",
              style: const TextStyle(
                color: Color(0xFF1A1A1A),
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 0.04,
              )),
          const SizedBox(height: 10),
          Text(
            "$department",
            style: const TextStyle(
              color: Color(0xFF63666B),
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
