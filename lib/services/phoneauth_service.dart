import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:krishi/screens/authentication/otp_screen.dart';
import 'package:krishi/screens/location_screen.dart';

class PhoneAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  Future<void> addUser(context,uid) async {


    final QuerySnapshot result =await users.where('uid',isEqualTo: uid).get();
    List <DocumentSnapshot>document = result.docs;


    if(document.isNotEmpty){
      Navigator.pushReplacementNamed(context, LocationScreen.id);

    }else{

      return users.doc(user?.uid)
          .set({
        'uid': user?.uid,
        'mobile':user?.phoneNumber,
        'email': user?.email,
        'name':null,
        'address':null,
      }).then((value){
        Navigator.pushReplacementNamed(context, LocationScreen.id);

      })
          .catchError((error)=> print('Failed to add user:$error'));
    }

  }





  Future<void> verifyPhoneNumber(BuildContext context,number) async {
    verificationCompleted(PhoneAuthCredential credential) async {

      await auth.signInWithCredential(credential);
    }
    verificationFailed(
        FirebaseAuthException e) {
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print('The error is ${e.code}');
    }
    codeSent(String verId, int? resendToken) async {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OTPScreen(number: number,verId:verId)));
    }
    try {
      auth.verifyPhoneNumber(phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 120),
          codeAutoRetrievalTimeout: (String verificationId) {
            print(verificationId);
          });
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}