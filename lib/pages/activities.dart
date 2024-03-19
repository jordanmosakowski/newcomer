import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  final String id;
  const Activities(this.id, {super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  bool showUpcoming = true;

  final List<Widget> upcomingActivities = [
    const ListTile(
      leading: Icon(Icons.run_circle_outlined),
      title: Text("Meet up @ Central Park"),
      subtitle: Text("Sat, Mar 30, 2024, 3:00 PM (EDT)\nCentral Park"),
    ),
    const ListTile(
      leading: Icon(Icons.local_activity),
      title: Text("Taylor Swift Concert"),
      subtitle: Text("Mon, Apr 1, 2024, 7:00 PM (EDT)\nMetLife Stadium"),
    ),
  ];

  final List<Widget> pastActivities = [
    const ListTile(
      leading: Icon(Icons.sports_football),
      title: Text("Pick up Flag Football"),
      subtitle: Text("Fri, Mar 15, 2024, 6:00 PM (PDT)\nBellarmine Prep"),
    ),
    const ListTile(
      leading: Icon(Icons.code_rounded),
      title: Text("Personal Projects Time"),
      subtitle: Text("Mon, Mar 12, 2024, 5:30 PM (EDT)\nSanta Clara University"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Activities"),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      style: showUpcoming ? ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 4, 14, 80)),
                      ) : null,
                      onPressed: () {
                        if (showUpcoming) {
                          return;
                        }
                        showUpcoming = true;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: const Text("Upcoming"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.swap_horiz),
                    ),
                    ElevatedButton(
                      style: !showUpcoming ? ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 4, 14, 80)),
                      ) : null,
                      onPressed: () {
                        if (!showUpcoming) {
                          return;
                        }
                        showUpcoming = false;
                        if (mounted) {
                          setState(() {});
                        }
                      },
                      child: const Text("Past"),
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    children: showUpcoming ? upcomingActivities : pastActivities,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}