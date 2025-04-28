import 'package:flutter/material.dart';
import 'package:portfolio/src/views/widgets/common/heading.dart';
import 'package:portfolio/src/views/widgets/common/p.dart';
import 'package:portfolio/src/views/widgets/common/section.dart';



class Footer extends StatelessWidget {
  const Footer({super.key});


  

  @override
  Widget build(BuildContext context) {
 
   
    return Section(
      children: [
        Heading(text: "Socials & More"),
        const SizedBox(height: 20),
        P(
          text:"I share my work on [Twitter/X](https://x.com/intent/follow?screen_name=0xharkirat) and code on [GitHub](https://github.com/0xharkirat).",
                
        ),
        const SizedBox(height: 20),
        P(text: "I acknowledge and deeply appreciate the original design, creativity, and overall inspiration behind this site — all credited to [Emil Kowalski](https://emilkowal.ski/). This version is a Flutter-based version of his beautifully crafted portfolio, built for learning, admiration, and open source love.")
      ],
    );
  }
}
