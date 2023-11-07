import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:researchfinder_1/utilities/constants.dart';






class SelectUniScreen extends StatefulWidget {
  const SelectUniScreen({Key? key}) : super(key: key);

  @override
  State<SelectUniScreen> createState() => _SelectUniversity();
}

class _SelectUniversity extends State<SelectUniScreen>{

    final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "University of North Texas", "city": "Denton, TX"},
    {"id": 2, "name": "Dallas College", "city": "Dallas, TX"},
    {"id": 3, "name": "Baylor University", "city": "Waco, TX"},
    {"id": 4, "name": "University of Texas - Arlington", "city": "Arlington, TX"},
    {"id": 5, "name": "Texas Tech", "city": "Lubbock, TX"},
    {"id": 6, "name": "Texas A&M", "city": "College Station, TX"},
    {"id": 7, "name": "University of Texas", "city": "Austin, TX"},
    {"id": 8, "name": "Southern Methodist University", "city": "Dallas, TX"},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {

    _foundUsers = _allUsers;
    super.initState();
  }

   void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your University'),
        backgroundColor: Color(0xFF56674A),
      ),
      body: Padding(

        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                itemCount: _foundUsers.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(_foundUsers[index]["id"]),
                  color: Color(0xFFc2beb4),
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    leading: SelectableText(
                      _foundUsers[index]["id"].toString(),
                      style: const TextStyle(fontSize: 24, color:Colors.brown),
                    ),
                    title: SelectableText(
                      _foundUsers[index]['name'], style:TextStyle(
                      color:Colors.black
                    )),
                    subtitle: SelectableText(
                        '${_foundUsers[index]["city"]}',style:TextStyle(
                        color:Colors.black
                    )),
                  ),
                ),
              )
                  : const Text(
                'No results found',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}