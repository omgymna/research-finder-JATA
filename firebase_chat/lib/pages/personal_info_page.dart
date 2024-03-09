import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          CircleAvatar(
            radius: 50,
          ),
          const SizedBox(height: 16),
          Text(
            'John Do',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Text(
            'University of North Texas',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(
            'Bachelors, Computer Science',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            'Graduates May 2024',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Divider(),
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Journey',
                  style: Theme.of(context).textTheme.headline5,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Implement navigation to the edit page or display an inline text field for editing
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'filler text',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          const Divider(),
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Experience',
                  style: Theme.of(context).textTheme.headline5,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Implement navigation to the edit page or display an inline text field for editing
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'filler text',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
          const Divider(),
           Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Education',
                  style: Theme.of(context).textTheme.headline5,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    // TODO: Implement navigation to the edit page or display an inline text field for editing
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'filler text',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
