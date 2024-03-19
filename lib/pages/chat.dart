// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../classes/chatMessagesModel.dart';
import '../../classes/user.dart';
import '../../classes/chatClass.dart';

class ChatPage extends StatefulWidget {
  const ChatPage(this.chatId, {Key? key}) : super(key: key);
  final String chatId;

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final fieldText = TextEditingController();
  final ScrollController _controller = ScrollController();
  var temporaryString = "";
  var myFocusNode = FocusNode();

  void makeUserMessage(String a, String uid, String name) {
    if (a != "") {
      FirebaseFirestore.instance.collection('messages').add(ChatMessage(
            messageContent: a,
            userId: uid,
            userName: name,
            timeStamp: DateTime.now(),
            chatId: widget.chatId,
          ).toJson());
      fieldText.clear();
      temporaryString = "";
    }
    myFocusNode.requestFocus();
  }

  updateMessage(value) {
    temporaryString = value;
  }

  @override
  void initState() {
    super.initState();
    stream = FirebaseFirestore.instance
        .collection("messages")
        .where("chatId", isEqualTo: widget.chatId)
        .orderBy("timeStamp")
        .snapshots()
        .map((snap) =>
            snap.docs.map((doc) => ChatMessage.fromFirestore(doc)).toList())
        .asBroadcastStream();
    stream.listen((a) {
      Future.delayed(Duration(milliseconds: 50), () {
        if (_controller.hasClients) {
          _controller.animateTo(
            _controller.position.maxScrollExtent,
            duration: Duration(milliseconds: 500),
            curve: Curves.fastOutSlowIn,
          );
        }
      });
    });
    //Load job
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .get()
        .then((doc) {
      if (doc.exists) {
        setState(() {
          chat = Chat.fromFirestore(doc);
        });
      }
    });
  }

  late Stream<List<ChatMessage>> stream;

  Chat? chat;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    if(user == null) {
      return Container();
    }
    return MultiProvider(
      providers: [
        StreamProvider<List<ChatMessage>>.value(initialData: const [], value: stream),
        StreamProvider<UserProfile>.value(
            initialData: UserProfile(
                id: "", name: "", hasProfilePic: false, notificationTokens: [], channels: []),
            value: FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .snapshots()
                .map((snap) => UserProfile.fromFirestore(snap)))
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Row(
            children: <Widget>[
              Text(chat?.title ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.calendar_month),
              onPressed: () {
                Navigator.pushNamed(context, '/activities/${widget.chatId}');
              },
            )
          ],
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Builder(
                builder: (context) {
                  List<ChatMessage> messages =
                      Provider.of<List<ChatMessage>>(context);
                  UserProfile userProfile = Provider.of<UserProfile>(context);
                  return ListView.builder(
                    controller: _controller,
                    itemCount: messages.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 10, bottom: 60),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(
                            left: 14, right: 14, top: 5, bottom: 5),
                        child: Align(
                          alignment: (messages[index].userId != userProfile.id
                              ? Alignment.topLeft
                              : Alignment.topRight),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (messages[index].userId != userProfile.id)
                                Text(
                                    '   ${messages[index].userName}     ${DateFormat.jm('en_US').format(messages[index].timeStamp)}',
                                    style: TextStyle(fontSize: 16)),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: (messages[index].userId != userProfile.id
                                      ? Colors.grey[700]
                                      : Color.fromARGB(255, 4, 14, 37)),
                                ),
                                padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                                constraints: BoxConstraints(maxWidth: 1000),
                                child: Text(
                                  messages[index].messageContent,
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              Builder(builder: (context) {
                return Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    height: 85,
                    width: double.infinity,
                    color: Colors.grey[900],
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 15, height: 30),
                        Expanded(
                          child: TextField(
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            expands: false,
                            autofocus: true,
                            controller: fieldText,
                            focusNode: myFocusNode,
                            onSubmitted: (value) {
                              Future.delayed(Duration(milliseconds: 10), () {
                                UserProfile userProfile = Provider.of<UserProfile>(
                                    context,
                                    listen: false);
                                makeUserMessage(
                                    value, userProfile.id, userProfile.name);
                              });
                            },
                            onChanged: (value) {
                              updateMessage(value);
                            },
                            decoration: InputDecoration(
                              hintText: "Write message...",
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            UserProfile userProfile =
                                Provider.of<UserProfile>(context, listen: false);
                            makeUserMessage(
                                temporaryString, userProfile.id, userProfile.name);
                          },
                          backgroundColor: Color.fromARGB(255, 4, 14, 37),
                          elevation: 0,
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
