import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String id;
  String title;
  String description;

  Chat({required this.id, required this.title, required this.description});

  static Chat fromFirestore(DocumentSnapshot snap) {
    Map<String, dynamic> data = snap.data() as Map<String, dynamic>;
    return Chat(
        id: snap.id,
        title: data['title'] ?? "",
        description: data["description"] ?? "");
  }

  Map<String, dynamic> toJson() {
    return {"description": description, "title": title};
  }
}
