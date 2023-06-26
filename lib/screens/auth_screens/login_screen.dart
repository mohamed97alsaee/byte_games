import 'package:byte_games/main.dart';
import 'package:byte_games/providers/auth_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController deviceNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () async {
          final SharedPreferences prefs = await SharedPreferences.getInstance();

          await prefs.setString('token', "tokenguys").then((value) {
            Navigator.pushAndRemoveUntil(
                context,
                CupertinoPageRoute(builder: (context) => const ScreenRouter()),
                (route) => false);
          });
        }),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('LOGIN'),
                TextFormField(
                  controller: phoneController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (value.length != 9) {
                      return 'Please enter valid phone number with 9 deigits';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: passwordController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Please enter valid password number with 9 deigits';
                    }
                    return null;
                  },
                ),
                Provider.of<AuthProvider>(context, listen: true).isLoading
                    ? const CircularProgressIndicator()
                    : TextButton(
                        onPressed: () {
                          Provider.of<AuthProvider>(context, listen: false)
                              .login({
                            "phone": phoneController.text,
                            "password": passwordController.text,
                            "device_name": "iphone"
                          }).then((logedIn) {
                            if (logedIn) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) =>
                                          const ScreenRouter()),
                                  (route) => false);
                            }
                          });
                        },
                        child: const Text("Login"))
              ],
            ),
          ),
        ));
  }
}
