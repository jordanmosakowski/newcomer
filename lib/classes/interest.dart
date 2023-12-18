class Interest {
  String id;
  String name;
  List<Interest> subInterests;

  Interest({required this.id, required this.name, this.subInterests = const []});

}