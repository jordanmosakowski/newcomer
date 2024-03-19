import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:newcomer/classes/interest.dart';
import 'package:newcomer/classes/user.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

String? image;

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    if(user == null) {
      return Container();
    }
    Map<String,Interest> interests = interestMap();
    return StreamProvider<UserProfile>.value(
      initialData: UserProfile(
          id: "", name: "", hasProfilePic: false, notificationTokens: [], channels: []),
      value: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snap) => UserProfile.fromFirestore(snap)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Center(
              child: Builder(
                builder: (context) {
                  UserProfile userProfile = Provider.of<UserProfile>(context);
                  List<String> channels = userProfile.channels;
                  if (image == null && userProfile.hasProfilePic) {
                    FirebaseStorage.instance
                        .ref('pictures/${userProfile.id}')
                        .getDownloadURL()
                        .then((a) {
                      if (mounted) setState(() => image = a);
                    });
                  }
                  channels.sort();
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            backgroundImage: (userProfile.hasProfilePic && image != null)
                                ? NetworkImage(image!)
                                : null,
                            child: !(userProfile.hasProfilePic && image != null)
                                ? const Icon(Icons.person)
                                : null),
                        title: Text(
                          userProfile.name,
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: userProfile.channels.map((channel) {
                              int depth = channel.split(":").length-1;
                              if(channel.substring(0,4) == "town"){
                                depth--;
                              }
                              // if(depth > 2) {
                              //   depth = 2;
                              // }
                              // TextStyle? style = [
                              //   Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                              //   Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                              //   Theme.of(context).textTheme.titleSmall,Theme.of(context).textTheme.titleSmall,Theme.of(context).textTheme.titleSmall
                              // ][depth];
                              return Padding(
                                padding: EdgeInsets.only(left: depth * 20.0),
                                child: ListTile(
                                  leading: Text("#", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold)),
                                  title: Text(interests[channel]?.name ?? ""),
                                  minLeadingWidth: 10,
                                  // subtitle: Text("2 members"),
                                  onTap: () async {
                                    DocumentSnapshot doc = await FirebaseFirestore.instance.collection("chats").doc(channel).get();
                                    if(!doc.exists) {
                                      await FirebaseFirestore.instance.collection("chats").doc(channel).set({
                                        "title": interests[channel]?.name ?? ""
                                      });
                                    }
                                    Navigator.pushNamed(context,"/chats/$channel");
                                  },
                                ),
                              );
                            }).toList(),
                        ),
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ),
    );
  }
}