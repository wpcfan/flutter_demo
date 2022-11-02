import 'package:flutter/material.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final appService = Provider.of<AppService>(context);
    return Scaffold(
      appBar: AppBar(
          // title: Text(APP_PAGE.onBoarding.toTitle),
          ),
      body: Center(
        child: TextButton(
          onPressed: () {
            // appService.onboarding = true;
          },
          child: const Text("Done"),
        ),
      ),
    );
  }
}
