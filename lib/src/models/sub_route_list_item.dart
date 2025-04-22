class SubRouteListItem {
  final String heading;
  final String description;
  final String routeId;

  SubRouteListItem({required this.heading, required this.description, required this.routeId});
}

final List<SubRouteListItem> labListItems = [
  SubRouteListItem(
    heading: 'Rough Notation Flutter',
    description: 'Animated, hand-drawn-style annotations for Flutter widgets.',
    routeId: 'rough-notation-flutter',
  ),
  SubRouteListItem(
    heading: 'UI Avatar',
    description:
        'Generate beautiful, text-based avatars with initials in Flutter.',
    routeId: 'ui-avatar',
  ),
  SubRouteListItem(
    heading: 'Live Darbar App',
    description: 'A powerful app for streaming live Kirtan from Darbar Sahib.',
    routeId: 'live-darbar-app',
  ),
];