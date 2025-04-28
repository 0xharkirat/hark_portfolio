import 'package:flutter/material.dart';
import 'package:portfolio/src/utils/methods.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Section(
      children: [
        Heading(text: "Contact"),
        const SizedBox(height: 20),
        P(
          text:
              "Say hi, or reach out if you're looking to hire or collaborate.",
        ),

        const SizedBox(height: 16),
        // create three buttons in a row, twitter dm, email me, copy email
        Wrap(
          children: [
            Button(
              text: "Dm me",
              onTap:
                  () => linkOpen(
                    "https://twitter.com/messages/compose?recipient_id=1334824502497165312",
                  ),
              icon: LucideIcons.twitter,
            ),
            Button(
              icon: LucideIcons.mail,

              text: "Email Me",
              onTap: () => linkOpen("mailto://info.sandhukirat23@gmail.com"),
            ),

            Button(
              text: "Copy Email",
              onTap: () {
                copyText('info.sandhukirat23@gmail.com');
                ShadToaster.of(context).show(
                  showToast(
                    title: Heading(text: "info.sandhukirat23@gmail.com"),
                    description: P(
                      text: 'Email copied to clipboard',
                      isSelectable: false,
                    ),
                  ),
                );
              },
              icon: LucideIcons.copy,
            ),
          ],
        ),
      ],
    );
  }
}

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    required this.onTap,
    required this.icon,
  });
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ShadButton(leading: Icon(icon), onPressed: onTap, child: Text(text));
  }
}
