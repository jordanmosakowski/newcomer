// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newcomer/classes/user.dart';

class UpdateUserProfile extends StatefulWidget {
  const UpdateUserProfile({super.key});

  @override
  State<UpdateUserProfile> createState() => _UpdateUserProfileState();
}

class _UpdateUserProfileState extends State<UpdateUserProfile> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  UserProfile? profile;

  bool newProfile = false;
  bool loadingPic = false;

  Future<void> getProfile() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return;
    }
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    if (!mounted) {
      return;
    }
    setState(() {
      if (doc.exists) {
        profile = UserProfile.fromFirestore(doc);
        nameController.text = profile!.name;
      } else {
        debugPrint("NEW PROFILE");
        nameController.text = "";
        newProfile = true;
        profile = UserProfile(
            id: user.uid,
            name: "",
            hasProfilePic: false, 
            notificationTokens: [], 
            channels: [],
      );
      }
    });
  }
  String? initialCountry;
  String? initialPhone;

  // Future getImageFromGallery() async {
  //   User? user = FirebaseAuth.instance.currentUser;
  //   if (user == null) {
  //     return;
  //   }
  //   if (!mounted) {
  //     return;
  //   }
  //   var image_url = '';
  //   final picker = ImagePicker();
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   var imageFile = File(pickedFile!.path);
  //   //print("made it to picking the image");
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child(user.uid);
  //   UploadTask uploadTask = ref.putFile(imageFile);
  //   await uploadTask.whenComplete(() async {
  //     var url = await ref.getDownloadURL();
  //     image_url = url.toString();
  //     debugPrint(image_url);
  //   }).catchError((onError) {
  //     debugPrint(onError);
  //   });
  //   if (!mounted) {
  //     return;
  //   }
  //   setState(() {});
  // }
  Future<void> uploadImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(source: ImageSource.gallery);
    if (img == null) {
      return;
    }
    print("mounting");
    if (mounted) {
      setState(() {
        loadingPic = true;
      });
    }
    print("loading");
    Uint8List raw = await img.readAsBytes();
    Reference ref = FirebaseStorage.instance.ref('pictures/${user?.uid}');
    try {
      print("saving");
      await ref.putData(raw);
      print("saved");
      String url = await ref.getDownloadURL();
      print("getting url");
      image = url;
      print(url);
      profile?.hasProfilePic = true;
      if (mounted) setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Profile picture uploaded successfully!'),
        ),
      );
    } on FirebaseException catch (e) {
      debugPrint(e.toString());
    }
    print("Done?");
    if (mounted) {
      setState(() {
        loadingPic = false;
      });
    }
  }

  String? image;

//text field widgit
  @override
  Widget build(BuildContext context) {
    if (profile == null) {
      return Center(
          child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200, maxWidth: 200),
        child:
            const AspectRatio(aspectRatio: 1.0, child: CircularProgressIndicator()),
      ));
    }
    if (image == null && profile!.hasProfilePic) {
      FirebaseStorage.instance
          .ref('pictures/${profile!.id}')
          .getDownloadURL()
          .then((a) {
        if (mounted) setState(() => image = a);
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(newProfile ? "Create Profile" : "Update Profile"),
        ),
        //store all of that info into the db
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: ListView(children: [
                loadingPic
                      ? const AspectRatio(aspectRatio: 1, child: SizedBox(width: 50, height: 50, child: CircularProgressIndicator()))
                      : GestureDetector(
                        onTap: () => uploadImage(),
                        child: CircleAvatar(
                            radius: 50,
                            backgroundImage: (profile!.hasProfilePic && image != null)
                                ? NetworkImage(image!)
                                : null,
                            child: !(profile!.hasProfilePic && image != null)
                                ? const Icon(Icons.person, size: 50)
                                : null),
                      ),
                const SizedBox(height: 10),
                Center(child: Text("Tap the icon to select a photo", style: TextStyle(fontSize: 20),)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: nameController,
                    onChanged: (value) {
                      profile!.name = value;
                    },
                    decoration: InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          if(nameController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Please enter a name'),
                              ),
                            );
                            return;
                          }
                          User? user = FirebaseAuth.instance.currentUser;
                          if (user == null) {
                            return;
                          }
                          if (newProfile) {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .set(profile!.toJson());
                          } else {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .update(profile!.toJson());
                          }
                          print("SAVED PROFILE");
                          Navigator.pushReplacementNamed(context, "/questionnaire");
                        },
                        child: const Text("Save Profile"),
                    ),
                  ],
                )
                    
              ]),
            ),
          ),
        ));
  }
}
