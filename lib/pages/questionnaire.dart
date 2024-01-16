import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newcomer/classes/interest.dart';
import 'package:provider/provider.dart';

class Questionnaire extends StatefulWidget {
  const Questionnaire({super.key});

  @override
  State<Questionnaire> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends State<Questionnaire> {
  Interest? currentLocation;
  Interest? hometown;

  List<Interest> selectedInterests = [];

  List<Interest> flattenedInterests = [];

  @override
  void initState() {
    super.initState();
    Queue q = Queue();
    q.addAll(interestOptions);
    while(q.isNotEmpty) {
      Interest i = q.removeFirst();
      flattenedInterests.add(i);
      q.addAll(i.subInterests);
    }
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<User?>(context);
    if(user == null) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome Questionnaire"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            children: [
              Text("Current Location", style: Theme.of(context).textTheme.displaySmall),
              Autocomplete<Interest>(
                displayStringForOption: (option) => option.name,
                optionsBuilder: (TextEditingValue value) {
                  if(value.text == '') {
                    return const Iterable<Interest>.empty();
                  }
                  return townOptions.where((t){
                    return t.name.toLowerCase().contains(value.text.toLowerCase());
                  });
                },
                onSelected: (selected) {
                  currentLocation = selected;
                },
              ),
              Container(height: 25),
              Text("Hometown", style: Theme.of(context).textTheme.displaySmall),
              Autocomplete<Interest>(
                displayStringForOption: (option) => option.name,
                optionsBuilder: (TextEditingValue value) {
                  if(value.text == '') {
                    return const Iterable<Interest>.empty();
                  }
                  return townOptions.where((t){
                    return t.name.toLowerCase().contains(value.text.toLowerCase());
                  });
                },
                onSelected: (selected) {
                  hometown = selected;
                },
              ),
              Container(height: 25),
              Text("Interests", style: Theme.of(context).textTheme.displaySmall),
              Wrap(
                children: interestOptions.map((interest) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: FilterChip(
                      label: Text(interest.name),
                      selected: selectedInterests.contains(interest),
                      onSelected: (selected) {
                        setState(() {
                          if(selected) {
                            selectedInterests.add(interest);
                          } else {
                            selectedInterests.remove(interest);
                          }
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              ...flattenedInterests.map((interest){
                return AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  firstChild: Container(),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(interest.name),
                      Wrap(
                        children: interest.subInterests.map((subInterest) {
                          return Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: FilterChip(
                              label: Text(subInterest.name),
                              selected: selectedInterests.contains(subInterest),
                              onSelected: (selected) {
                                setState(() {
                                  if(selected) {
                                    selectedInterests.add(subInterest);
                                  } else {
                                    selectedInterests.remove(subInterest);
                                  }
                                });
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  crossFadeState: (selectedInterests.contains(interest) && interest.subInterests.isNotEmpty) ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                );
                // if(interest.subInterests.isNotEmpty) {
                //   return 
                // }
                // return Container();
              }),
              TextButton(
                onPressed: () async {
                  // made a firestore document in the "questionnaire" collection with the user ID as a document ID, storing all of the form information
                  await FirebaseFirestore.instance.collection("questionnaire").doc(user.uid).set({
                    "currentLocation": currentLocation!.id,
                    "hometown": hometown!.id,
                    "interests": selectedInterests.map((interest) => interest.id).toList(),
                  });
                  await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
                    "name": user.displayName,
                    "channels": {currentLocation!.id,hometown!.id,...selectedInterests.map((interest) => interest.id).toList()}.toList(),
                  });
                  Navigator.pushNamed(context, '/chats');
                },
                child: Text("Submit")
              )
            ]
          ),
        ),
      )
    );
  }
}

