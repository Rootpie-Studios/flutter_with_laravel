import 'package:flutter/material.dart';
import 'package:flutter_with_laravel/components/app_navigator.dart';
import 'package:flutter_with_laravel/screens/home.dart';
import 'package:flutter_with_laravel/services/api_provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final ApiProvider _apiProvider = ApiProvider();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String failText = "";

  _login() {
    Map<String, dynamic> userData = {
      'name' : nameController.text,
      'email' : emailController.text,
      'password' : passwordController.text,
      'device' : 'test',
    };

    _apiProvider.register(userData).then((success) {
      if (success) {
        AppNavigator.navigatePushAndReplace(context, const HomeScreen());
      }
      else {
        setState(() {
          failText = "Something went wrong";
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
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
          "Register",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(40),
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: TextField(
                controller: nameController,
                obscureText: false,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Name",
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
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