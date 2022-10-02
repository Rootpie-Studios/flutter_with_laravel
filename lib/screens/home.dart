import 'package:flutter/material.dart';
import 'package:flutter_with_laravel/components/app_navigator.dart';
import 'package:flutter_with_laravel/constants.dart';
import 'package:flutter_with_laravel/services/api_provider.dart';

import 'login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    _apiProvider.checkAuth().then((authenticated) {
      if (!authenticated) {
        AppNavigator.navigatePushAndReplace(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          APP_NAME,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome",
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _apiProvider.logout().then((success) {
                  if (success) {
                    AppNavigator.navigatePushAndReplace(context, const LoginScreen());
                  }
                });
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}