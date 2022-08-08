import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:flutter_instagram_clone/views/screens/auth/signup_screen.dart';
import 'package:flutter_instagram_clone/views/widgets/text_input_field.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Instagram',
                style: TextStyle(
                    fontSize: 35,
                    color: purpleColor,
                    fontWeight: FontWeight.w900),
              ),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _emailController,
                  icon: Icons.email,
                  labelText: 'Email',
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: TextInputField(
                  controller: _passwordController,
                  isObscure: obscureText,
                  icon: Icons.lock,
                  labelText: 'Password',
                ),
              ),
              ListTile(
                onTap: () {
                  setState(() {
                    obscureText = !obscureText;
                  });
                },
                leading: obscureText
                    ? const Icon(
                        Icons.check_box_outline_blank,
                        color: purpleColor,
                      )
                    : const Icon(
                        Icons.check_box,
                        color: purpleColor,
                      ),
                title: const Text('Show password?'),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () => authController.loginUser(
                    _emailController.text, _passwordController.text),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: purpleColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      )),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Don\'t have an account? ',
                    style: TextStyle(fontSize: 20),
                  ),
                  InkWell(
                    onTap: () => Get.off(() => const SignUpScreen()),
                    child: const Text(
                      'Register',
                      style: TextStyle(
                        color: purpleColor,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
