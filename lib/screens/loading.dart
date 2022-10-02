import 'package:flutter/material.dart';
import 'package:flutter_with_laravel/components/app_navigator.dart';
import 'package:flutter_with_laravel/constants.dart';
import 'package:flutter_with_laravel/services/api_provider.dart';

import 'home.dart';
import 'login.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => LoadingScreenState();
}

class LoadingScreenState extends State<LoadingScreen> {
  final ApiProvider _apiProvider = ApiProvider();

  @override
  void initState() {
    super.initState();
    _apiProvider.checkAuth().then((authenticated) {
      if (authenticated) {
        AppNavigator.navigatePushAndReplace(context, const HomeScreen());
      }
      else {
        AppNavigator.navigatePushAndReplace(context, const LoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              APP_NAME,
              style: TextStyle(fontSize: 50, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}