import 'package:flutter/material.dart';

class CreateActivity extends StatefulWidget {
  final String id;
  const CreateActivity(this.id, {super.key});

  @override
  State<CreateActivity> createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {

  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Activity'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Activity Name',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print(nameController.text);
                Navigator.pop(context, nameController.text);
              },
              child: Text('Create!'),
            ),
          ],
        ),
      )
    );
  }
}