import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id;
  String title;

  Chat({required this.id, required this.title});

  static Chat fromFirestore(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return Chat(
        id: snap.id,
        title: data['title'] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"title": title};
  }
}
