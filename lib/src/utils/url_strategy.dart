// lib/src/utils/url_strategy.dart
export 'stub_url_strategy.dart'
    if (dart.library.html) 'web_url_strategy.dart';
