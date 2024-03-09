//flutter page with research 

import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sample data for demonstration
    final List<Map<String, String>> researchPosts = [
      {"title": "Research Title 1", "description": "Description of Research 1"},
      {"title": "Research Title 2", "description": "Description of Research 2"},
      {"title": "Research Title 3", "description": "Description of Research 3"},
      // Add more research titles and descriptions here
    ];

    return ListView.builder(
      itemCount: researchPosts.length,
      itemBuilder: (context, index) {
        var post = researchPosts[index];
        return Card( // Wrap with a Card widget
          margin: const EdgeInsets.all(8.0), // Add some margin around each card
          child: ListTile(
            title: Text(post["title"] ?? ''), // Display the title
            subtitle: Text(post["description"] ?? ''), // Display the description below the title
            onTap: () {
              // Handle the tap event if needed, e.g., navigate to a detailed view
            },
          ),
        );
      },
    );
  }
}
