import 'package:devfest23/core/themes/theme_data.dart';
import 'package:devfest23/core/widgets/buttons.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DevFestTheme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: ShapeDecoration(
                      color: const Color(0xff81c995).withOpacity(0.2),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: '🤭',
                        style: DevFestTheme.of(context).textTheme?.body03,
                        children: const [
                          WidgetSpan(child: SizedBox(width: 4)),
                          TextSpan(text: 'Welcome Back!')
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'We are back and ready to awe',
                    style: DevFestTheme.of(context).textTheme?.headline02,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 50),
                    child: Text(
                      'We have great speakers and amazing sessions in place for this year’s DevFest! 🥳',
                      style: DevFestTheme.of(context).textTheme?.body02,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DevfestFilledButton(
                    title: const Text('Login to RSVP'),
                    onPressed: () {},
                  ),
                  const SizedBox(height: 13),
                  DevfestOutlinedButton(
                    title: const Text('Continue Without Login'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
          ],
        ),
      ),
    );
  }
}
