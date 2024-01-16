import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String id;
  List<String> notificationTokens;
  List<String> channels;
  String name;
  bool hasProfilePic;

  UserData(
      {required this.id,
      required this.hasProfilePic,
      required this.name,
      required this.notificationTokens,
      required this.channels,
  });

  static UserData fromFirestore(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return UserData(
        id: snap.id,
        hasProfilePic: data['hasProfilePic'] ?? false,
        name: data['name'] ?? "",
        channels: List<String>.from(data['channels'] ?? []),
        notificationTokens: List<String>.from(data['notificationTokens'] ?? []));
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationTokens': notificationTokens,
      "name": name,
      "channels": channels,
      "hasProfilePic": hasProfilePic
    };
  }
}
