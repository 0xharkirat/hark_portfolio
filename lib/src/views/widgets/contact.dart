import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:portfolio/src/utils/methods.dart';
import 'package:portfolio/src/views/widgets/heading.dart';
import 'package:portfolio/src/views/widgets/p.dart';
import 'package:portfolio/src/views/widgets/section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    final iconColor = ShadTheme.of(context).colorScheme.secondary;
    return Section(
      children: [
        Heading(text: "Contact"),
        const SizedBox(height: 20),
        P(
          text:
              "Say hi, or reach out if you're looking to hire or collaborate.",
        ),

        const SizedBox(height: 20),
        // create three buttons in a row, twitter dm, email me, copy email
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ShadTheme.of(context).colorScheme.border,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ShadButton.ghost(
                size: ShadButtonSize.sm,
                leading: Icon(
                  LucideIcons.twitter,
                  color: iconColor,
                ),
                child: const P(text: "Dm Me", isSelectable: false),
                // 1334824502497165312

                onPressed: () => linkOpen("https://twitter.com/messages/compose?recipient_id=1334824502497165312"),
              ),
              ShadButton.ghost(
                size: ShadButtonSize.sm,
                leading: Icon(
                  LucideIcons.mail,
                  color: iconColor,
                ),
                child: const P(text: "Email Me", isSelectable: false),
                onPressed:
                    () => linkOpen("mailto://info.sandhukirat23@gmail.com"),
              ),
              ShadButton.ghost(
                size: ShadButtonSize.sm,
                leading: Icon(
                  LucideIcons.copy,
                  color: iconColor,
                ),
                child: const P(text: "Copy Email", isSelectable: false),
                onPressed: () {
                  Clipboard.setData(
                    const ClipboardData(text: "info.sandhukirat23@gmail.com"),
                  );
                  ShadToaster.of(context).show(
                    const ShadToast(
                      duration: Duration(seconds: 5),
                      showCloseIconOnlyWhenHovered: false,
                      closeIconPosition: ShadPosition(
                        right: 0,
                        top: 0,
                        bottom: 0,
                      ),
                      alignment: Alignment.bottomCenter,
                      title: Heading(text: "info.sandhukirat23@gmail.com"),
                      description: P(text:'Email copied to clipboard'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
