import 'package:flutter/material.dart';
import 'package:gng_seller/services/auth_service.dart';
import 'package:gng_seller/views/home_screen.dart';

import 'package:gng_seller/widgets/custom_button.dart';
import 'package:gng_seller/widgets/custom_text.dart';
import 'package:gng_seller/widgets/loading_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  double spaceBetween = 30;

  login(email, password) async {

    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(message: "Checking Credentials");
      }
    );

    String? uid = await AuthService.signIn(email, password);

    Navigator.push(context, MaterialPageRoute(
      builder: (c) => HomeScreen(uid)
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // intro text
                Center(
                    child: CustomText(
                        text: 'Login', style: StyledText.bodyHeading.style)),
                SizedBox(height: spaceBetween),
                Center(
                    child: CustomText(
                        text: 'Sign in to your account.',
                        style: StyledText.bodySubheading.style)),
                SizedBox(height: spaceBetween),

                // email address
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                SizedBox(height: spaceBetween),

                // password
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                SizedBox(height: spaceBetween),

                // submit button
                CustomButton(
                  function: () async {
                    if (_formKey.currentState!.validate()) {
                      final email = _emailController.text.trim();
                      final password = _passwordController.text.trim();
                      login(email, password);
                    }
                  },
                  text: 'Login',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
