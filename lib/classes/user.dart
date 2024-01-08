import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  List<String> notificationTokens;
  String name;
  bool hasProfilePic;

  UserData(
      {required this.id,
      required this.hasProfilePic,
      required this.name,
      required this.notificationTokens});

  static UserData fromFirestore(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return UserData(
        id: snap.id,
        hasProfilePic: data['hasProfilePic'] ?? false,
        name: data['name'] ?? "",
        notificationTokens: data['notificationTokens'].cast<String>());
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationTokens': notificationTokens,
      "name": name,
      "hasProfilePic": hasProfilePic
    };
  }
}
