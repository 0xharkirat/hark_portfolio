class ListItem {
  final String heading;
  final String description;
  final String? url;

  ListItem({
    required this.heading,
    required this.description,
    this.url,
  });
}


final List<ListItem> projectListItems = [
  ListItem(
    heading: 'Flutter',
    description: 'A UI toolkit for building natively compiled applications.',
    url: 'https://flutter.dev',
  ),
  ListItem(
    heading: 'Dart',
    description: 'A client-optimized language for fast apps on any platform.',
    url: 'https://dart.dev',
  ),
  ListItem(
    heading: 'Firebase',
    description: 'A platform developed by Google for creating mobile and web applications.',
    url: 'https://firebase.google.com',
  ),
];

final List<ListItem> contributionListItems = [
 // some pr numbers with descriptions pointing to my github
  ListItem(
    heading: 'PR #1',
    description: 'Fixed a bug in the authentication module.',
    url: ''),

    ListItem(
    heading: 'PR #2',
    description: 'Fixed a bug in the authentication module.',
    url: ''),

    ListItem(
    heading: 'PR #3',
    description: 'Fixed a bug in the authentication module.',
    url: ''),

    ListItem(
    heading: 'PR #4',
    description: 'Fixed a bug in the authentication module.',
    url: ''),
  
];
