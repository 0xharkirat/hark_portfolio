class ListItem {
  final String heading;
  final String description;
  final String? url;

  ListItem({required this.heading, required this.description, this.url});
}

final List<ListItem> projectListItems = [
  ListItem(
    heading: 'Rough Notation Flutter',
    description: 'Animated, hand-drawn-style annotations for Flutter widgets.',
    url: 'https://roughnotation-flutter.web.app',
  ),
  ListItem(
    heading: 'UI Avatar',
    description:
        'Generate beautiful, text-based avatars with initials in Flutter.',
    url: 'https://pub.dev/packages/ui_avatar',
  ),
  ListItem(
    heading: 'Live Darbar App',
    description: 'A powerful app for streaming live Kirtan from Darbar Sahib.',
    url: 'https://github.com/0xharkirat/live_darbar',
  ),
  ListItem(
    heading: 'Polar Dart SDK',
    description: 'Polar Dart SDK for interacting with the Polar API.',
    url: 'https://github.com/0xharkirat/polar-dart',
  ),
  ListItem(
    heading: 'Avaad Python Module',
    description:
        'A transliteration toolkit for Gurmukhi ASCII ↔ Unicode and Romanized scripts.',
    url: 'https://github.com/0xharkirat/anvaad-py',
  ),
  ListItem(
    heading: 'Calmendar',
    description: 'A calm and minimal calendar app made with Flutter.',
    url: 'https://github.com/0xharkirat/calmendar',
  ),
  ListItem(
    heading: 'Its Urgent',
    description:
        'GSoC\'24 project to explore intentional urgent communication systems.',
    url: 'https://github.com/0xharkirat/its_urgent',
  ),
];

final List<ListItem> contributionListItems = [
  ListItem(
    heading: 'PR #136 – Supabase Auth UI',
    description:
        'Added SupaAvatar widget for editing and displaying user avatars.',
    url: 'https://github.com/supabase-community/flutter-auth-ui/pull/136',
  ),
  ListItem(
    heading: 'PR #163443 – Flutter',
    description:
        'Proposal to set `debugShowCheckedModeBanner` default to `false`.',
    url: 'https://github.com/flutter/flutter/issues/163443',
  ),
  ListItem(
    heading: 'PR #252 – flutter-shadcn-ui',
    description:
        'Added theme color selector for dynamic component previews in the docs.',
    url: 'https://github.com/nank1ro/flutter-shadcn-ui/pull/252',
  ),
  ListItem(
    heading: 'PR #2913 – Codemagic Docs',
    description:
        'Added troubleshooting guide for Flutter build error with localizations.',
    url: 'https://github.com/codemagic-ci-cd/codemagic-docs/pull/2913',
  ),
  ListItem(
    heading: 'PR #6 – monterail/intelligence',
    description:
        'Added iOS setup and minimum version documentation for the Intelligence SDK.',
    url: 'https://github.com/monterail/intelligence/pull/6',
  ),
  ListItem(
    heading: 'PR #45 – installed_apps',
    description: 'Added `getInstalledAppsNamed` for better API clarity.',
    url: 'https://github.com/sharmadhiraj/installed_apps/pull/45',
  ),
];

final List<ListItem> youtubeListItems = [
  ListItem(
    heading: 'Flutter Playlist',
    description: 'My videos on Flutter development.',
    url: 'https://www.youtube.com/playlist?list=PLLx2TfaNTPhxjIc4Ydm2CYhTxz9cPH-hy',
  ),
  ListItem(
    heading: 'Tabla Playlist',
    description: 'Videos of me playing Tabla.',
    url: 'https://www.youtube.com/playlist?list=PLLx2TfaNTPhyQPAIfEnib4MfXppYtYVyB',
  ),
];
