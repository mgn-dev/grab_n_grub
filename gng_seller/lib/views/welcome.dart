import 'package:flutter/material.dart';
import 'package:gng_seller/views/login_screen.dart';
import 'package:gng_seller/views/register_screen.dart';
import 'package:gng_seller/widgets/custom_button.dart';
import 'package:gng_seller/widgets/custom_text.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/gng_seller_logo_t.png',
                    width: 300,
                    height: 300,
                  ),
                  CustomButton(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const LoginScreen()));
                      },
                      text: 'login'),
                  TextButton(
                      style: ButtonStyle(
                        padding: WidgetStateProperty.all(
                          EdgeInsets.zero,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (c) => const RegisterScreen()));
                      },
                      child: CustomText(
                        text: 'Or sign up',
                        style: StyledText.labelHeavyDark.style,
                      )
                  ),
                  const SizedBox(height: 180),
                ],
              )),
        ),
      ),
    );
  }
}
