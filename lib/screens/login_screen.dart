import 'package:flutter/material.dart';
import 'package:krishi/widgets/auth_ui.dart';

class LoginScreen extends StatelessWidget {
  static const String id ='login-screen';

  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.blueAccent.shade400,
      body: Column(
        children: [
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,//device width
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(height: 100,),
                  Image.asset('assets/images/Farmer.png',width: 200, height: 200,
                  ),
                  const SizedBox(height: 10,),
                  const Text('Krishi Agri',style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily:'DancingScript',
                    color: Colors.blueAccent,
                  ),)
                ],
              ),
            ),),
          Expanded(
            child: Container(
              child: const AuthUi(),
            ),
          ),



        ],
      ),
    );
  }
}
