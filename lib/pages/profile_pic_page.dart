import 'package:flutter/material.dart';
import 'package:ieid/components/user_image.dart';

class ProfilePicPage extends StatefulWidget {
  final String? photoUrl;

  const ProfilePicPage({Key? key, this.photoUrl}) : super(key: key);

  @override
  State<ProfilePicPage> createState() => _ProfilePicPage();
}

class _ProfilePicPage extends State<ProfilePicPage> {

  late String imageUrl;

  void initState() {
    super.initState();
    imageUrl = widget.photoUrl ?? 'https://firebasestorage.googleapis.com/v0/b/ieid-8d946.appspot.com/o/images%2FJZnE3wGOPubalGKNWV9aMHlBt4J2?alt=media&token=5134b636-1006-49b2-905d-aa22b630eee4';
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          shadowColor: Colors.transparent,
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: const Color.fromRGBO(255, 225, 0, 1),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          )
        ),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 180),
              UserImage(onFileChanged: (imageUrl) {
                setState(() {
                  this.imageUrl = imageUrl;
                });
              }, imageUrl: imageUrl,)
            ],
          ),
        ));
  }
}
