import 'package:flutter/material.dart';
import 'package:gng_seller/model/seller.dart';
import 'package:gng_seller/services/auth_service.dart';
import 'package:gng_seller/services/global_seller.dart';
import 'package:gng_seller/views/home_screen.dart';
import 'package:gng_seller/widgets/custom_button.dart';
import 'package:gng_seller/widgets/custom_text.dart';
import 'package:gng_seller/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  double spaceBetween = 30;

  void signup(
    email,
    password,
    name,
    phone,
  ) async {
    
    showDialog(
      context: context,
      builder: (c) {
        return const LoadingDialog(message: "Checking Credentials");
      }
    );

    String? uid = await AuthService.signUp(email, password);

    if (uid != null) {
      createAndStoreNewSeller(uid, email, name, phone);
      Navigator.push(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (c) => HomeScreen(uid)));
    }
  }

  createAndStoreNewSeller(uid, email, name, phone){
    Provider.of<GlobalSeller>(context, listen: false)
      .set(Seller(
        uid: uid ?? '',
        name: name,
        email: email ?? '',
        phone: phone,
      ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
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
                      text: 'Register', 
                      style: StyledText.bodyHeading.style
                    )
                  ),
                  SizedBox(height: spaceBetween),
                  Center(
                    child: CustomText(
                      text: 'Sign in to your account.', 
                      style: StyledText.bodySubheading.style
                    )
                  ),
                  SizedBox(height: spaceBetween),

                  // name
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
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

                  // email address
                  TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(labelText: 'Phone'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
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

                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'confirm'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value != _passwordController.text) {
                        return 'Passwords do not match';
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
                        final name = _nameController.text.trim();
                        final phone = _phoneController.text.trim();

                        signup(email, password, name, phone);
                      }
                    },
                    text: 'Login',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
