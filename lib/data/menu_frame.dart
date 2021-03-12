import 'package:flutter/material.dart';
import './home_signin.dart';
import './create_login.dart';
import './signin.dart';

class MenuFrame extends StatelessWidget {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0, vertical: 20.0),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/login.png",
                      height: 150.0,
                      width: 150.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: pageController,
                children: [
                  HomeSignin(
                    goToSignIn: () {
                      pageController.animateToPage(1,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                    goToSignUp: () {
                      pageController.animateToPage(2,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeIn);
                    },
                  ),
                  SignIn(),
                  CreateLogin(cancelBackToHome: () {
                    pageController.animateToPage(0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
