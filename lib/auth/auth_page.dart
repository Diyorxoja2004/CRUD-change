// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:test1/auth/pages/auth_Login.dart';
import 'package:test1/auth/pages/auth_Register.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  void tooglesScreens(){
    setState(() {
      showLoginPage =!showLoginPage;
    });
  }

  bool showLoginPage = true;

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return Login_Page(showRegisterPage:tooglesScreens);
    }else{
      return auth_RegisterPage(showLoginPage:tooglesScreens);
    }
  }
}