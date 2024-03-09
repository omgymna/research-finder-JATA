
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // Placeholder for search results. In a real app, this would be data fetched based on the search query.
  final List<Map<String, String>> _searchResults = [
    {"title": "Result 1", "description": "Description of Result 1"},
    {"title": "Result 2", "description": "Description of Result 2"},
    {"title": "Result 3", "description": "Description of Result 3"},
  ];

  bool _showResults = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
              onSubmitted: (String value) {
                setState(() {
                  _showResults = true;
                });
              },
            ),
          ),
          Expanded(
            child: _showResults
                ? ListView.builder(
                    itemCount: _searchResults.length,
                    itemBuilder: (context, index) {
                      var result = _searchResults[index];
                      return ListTile(
                        title: Text(result["title"] ?? ''),
                        subtitle: Text(result["description"] ?? ''),
                        onTap: () {
                        },
                      );
                    },
                  )
                : Container(
                    alignment: Alignment.center,
                    child: Text('No results to display. Start a search to see results.'),
                  ),
          ),
        ],
      ),
    );
  }
}
