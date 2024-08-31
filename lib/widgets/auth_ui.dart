import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:krishi/screens/authentication/email_auth_screen.dart';
import 'package:krishi/screens/authentication/google_auth_screen.dart';
import 'package:krishi/screens/authentication/phoneauth_screen.dart';
import 'package:krishi/services/phoneauth_service.dart';

class AuthUi extends StatelessWidget {
  const AuthUi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 220,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.0)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, PhoneAuthScreen.id);
              },
              child: const Row(
                children: [
                  Icon(
                    Icons.phone_android_outlined,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Continue with Phone',
                    style: TextStyle(color: Colors.black),
                  )
                ],
              ),
            ),
          ),
          SignInButton(Buttons.Google, text: ("Continue With Google"),
              onPressed: () async {
            User? user =
                await GoogleAuthentication.signInWithGoogle(context: context);
            if (user != null) {
              PhoneAuthService _authentication = PhoneAuthService();
              _authentication.addUser(context, user.uid);
            }
          }),
          SignInButton(Buttons.Facebook,
              text: ("Continue With Facebook"), onPressed: () {}),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'OR',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, EmailAuthScreen.id);

            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: const Text(
                  'Login with Email',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
               decoration: const BoxDecoration(border:Border(bottom:BorderSide(color: Colors.white)) ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
