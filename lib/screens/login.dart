import 'package:flutter/material.dart';
import 'package:flutter_with_laravel/components/app_navigator.dart';
import 'package:flutter_with_laravel/screens/home.dart';
import 'package:flutter_with_laravel/screens/register.dart';
import 'package:flutter_with_laravel/services/api_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final ApiProvider _apiProvider = ApiProvider();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String failText = "";

  _login() {
    Map<String, dynamic> credentials = {
      'email' : emailController.text,
      'password' : passwordController.text,
      'device' : 'test',
    };

    _apiProvider.login(credentials).then((success) {
      if (success) {
        AppNavigator.navigatePushAndReplace(context, const HomeScreen());
      }
      else {
        setState(() {
          failText = "Wrong email or password!";
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _apiProvider.checkAuth().then((authenticated) {
      if (authenticated) {
        AppNavigator.navigatePushAndReplace(context, const HomeScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                obscureText: false,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Email",
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Password",
                  border: OutlineInputBorder(),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              alignment: Alignment.center,
              child: Text(failText,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.redAccent,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    AppNavigator.navigate(context, const RegisterScreen());
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    _login();
                  },
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                    size: 30,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

}