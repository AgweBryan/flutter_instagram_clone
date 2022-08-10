import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/constants.dart';
import 'package:flutter_instagram_clone/views/screens/auth/login_screen.dart';
import 'package:flutter_instagram_clone/views/widgets/text_input_field.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernameController = TextEditingController();

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => authController.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                backgroundColor: purpleColor,
              ),
            )
          : Container(
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
                      'Register',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    authController.selectedImage.isNotEmpty
                        ? GestureDetector(
                            onTap: () => authController.pickImage(),
                            child: CircleAvatar(
                              radius: 64,
                              backgroundImage: MemoryImage(
                                authController.selectedImage,
                              ),
                            ),
                          )
                        : GestureDetector(
                            onTap: () => authController.pickImage(),
                            child: CircleAvatar(
                              radius: 64,
                              backgroundColor: Get.isDarkMode
                                  ? Colors.grey.shade800
                                  : Colors.grey.shade300,
                              child: const Center(
                                child: Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextInputField(
                        controller: _usernameController,
                        icon: Icons.person,
                        labelText: 'Username',
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
                      leading: obscureText
                          ? IconButton(
                              onPressed: () => setState(() {
                                obscureText = !obscureText;
                              }),
                              icon: const Icon(Icons.check_box_outline_blank),
                              color: purpleColor,
                            )
                          : IconButton(
                              onPressed: () => setState(() {
                                obscureText = !obscureText;
                              }),
                              icon: const Icon(Icons.check_box),
                              color: purpleColor,
                            ),
                      title: const Text('Show password?'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () => authController.registerUser(
                        _usernameController.text.trim().toLowerCase(),
                        _emailController.text,
                        _passwordController.text,
                        authController.selectedImage,
                      ),
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
                          'Register',
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
                          onTap: () => Get.to(() => const LoginScreen()),
                          child: const Text(
                            'Login',
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
    ));
  }
}
