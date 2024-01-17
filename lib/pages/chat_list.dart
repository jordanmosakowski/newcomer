import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newcomer/classes/interest.dart';
import 'package:newcomer/classes/user.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    if(user == null) {
      return Container();
    }
    Map<String,Interest> interests = interestMap();
    return StreamProvider<UserData>.value(
      initialData: UserData(
          id: "", name: "", hasProfilePic: false, notificationTokens: [], channels: []),
      value: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots()
          .map((snap) => UserData.fromFirestore(snap)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chats'),
        ),
        body: Center(
          child: Builder(
            builder: (context) {
              UserData userData = Provider.of<UserData>(context);
              List<String> channels = userData.channels;
              channels.sort();
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: userData.channels.map((channel) {
                    int depth = channel.split(":").length-1;
                    if(channel.substring(0,4) == "town"){
                      depth--;
                    }
                    TextStyle? style = [Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, decoration: TextDecoration.underline),Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),Theme.of(context).textTheme.titleSmall,Theme.of(context).textTheme.titleSmall,Theme.of(context).textTheme.titleSmall][depth];
                    return ListTile(
                      title: Text(interests[channel]?.name ?? "", style: style),
                      subtitle: Text("2 members"),
                      onTap: () async {
                        DocumentSnapshot doc = await FirebaseFirestore.instance.collection("chats").doc(channel).get();
                        if(!doc.exists) {
                          await FirebaseFirestore.instance.collection("chats").doc(channel).set({
                            "title": interests[channel]?.name ?? ""
                          });
                        }
                        Navigator.pushNamed(context,"/chats/$channel");
                      },
                    );
                  }).toList(),
              );
            }
          ),
        ),
      ),
    );
  }
}