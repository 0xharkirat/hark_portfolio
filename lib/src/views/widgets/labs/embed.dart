import 'dart:html' as html;
import 'dart:ui_web'; // for platformViewRegistry
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WebEmbed extends StatelessWidget {
  const WebEmbed({
    super.key,
    required this.url,
    this.height = 600,
    this.borderRadius = 8.0,
    this.allowFullscreen = true,
    this.allowClipboardAccess = false,
  });

  final String url;
  final double height;
  final double borderRadius;
  final bool allowFullscreen;
  final bool allowClipboardAccess;

  static final Set<String> _registeredViewTypes = {}; // track registered types

  @override
  Widget build(BuildContext context) {
    const prefix = 'web-embed-';
    final viewType = '$prefix${url.hashCode}';

    if (kIsWeb && !_registeredViewTypes.contains(viewType)) {
      _registeredViewTypes.add(viewType); // mark as registered

      platformViewRegistry.registerViewFactory(viewType, (int viewId) {
        final iframe = html.IFrameElement()
          ..src = url
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '100%'
          ..allowFullscreen = allowFullscreen
          ..allow = allowClipboardAccess ? 'clipboard-read; clipboard-write' : '';
        return iframe;
      });
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: HtmlElementView(viewType: viewType),
      ),
    );
  }
}
