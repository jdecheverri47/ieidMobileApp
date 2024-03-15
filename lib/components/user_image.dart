import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:ieid/components/my_button.dart';
import 'package:path/path.dart' as p;
import 'package:ieid/components/round_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UserImage extends StatefulWidget {
  final Function(String imageUrl) onFileChanged;
  final String? imageUrl;

  UserImage({
    required this.onFileChanged,
    this.imageUrl,
  });

  @override
  State<UserImage> createState() => _UserImageState();
}

class _UserImageState extends State<UserImage> {
  final ImagePicker _picker = ImagePicker();

  late String? imageUrl;

  void initState() {
    super.initState();
    imageUrl = widget.imageUrl;
  }
  String user = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imageUrl == null)
          Icon(
            Icons.image,
            size: 60,
            color: Color.fromRGBO(255, 225, 0, 1),
          ),
        if (imageUrl != null)
          InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () => _selectPhoto(),
            child: AppRoundImage.url(
              imageUrl!,
              height: 180,
              width: 180,
            ),
          ),
        SizedBox(height: 20),
        MyButton(
          text: "Cambiar Imagen",
          color: Color.fromRGBO(255, 232, 55, 1),
          onPressed: () {
            _selectPhoto();
          },
        ),
      ],
    );
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                        leading: Icon(Icons.photo_camera),
                        title: Text('Camera'),
                        onTap: () {
                          Navigator.of(context).pop();
                          _pickImage(ImageSource.camera);
                        }),
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Pick a file'),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      },
                    )
                  ],
                )));
  }

  Future _pickImage(ImageSource source) async {
    final pickedFile =
        await _picker.pickImage(source: source, imageQuality: 50);

    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }

    var selectedImage = await compressImage(file.path, 35);

    await _uploadFile(selectedImage.path);
  }

  Future<XFile> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);

    return result!;
  }

  Future _uploadFile(String path) async {
    final ref = FirebaseStorage.instance.ref().child('images').child('${user}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user)
        .update({'imageUrl': fileUrl});

    setState(() {
      imageUrl = fileUrl;
    });

    widget.onFileChanged(fileUrl);
  }
}
