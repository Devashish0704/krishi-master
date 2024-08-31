

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  User? user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  CollectionReference products = FirebaseFirestore.instance.collection('products');


  Future<void> updateUser(Map<String, dynamic>data, context,screen) {
    return users
        .doc(user!.uid)
        .update(data)
        .then((value) {
      Navigator.pushNamed(context,screen);
    },).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to Update Location'),
        ),);
      print(error);
    });
  }
  Future<String> getAddress(double lat, double long) async {
    try {
      final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=YOUR_API_KEY';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['results'].isNotEmpty) {
          final address = data['results'][0]['formatted_address'];
          print("Address: $address");
          return address;
        }
      }
      return "Address not found";
    } catch (e) {
      print("Error getting address: $e");
      return "Error getting address";
    }
  }

  Future<DocumentSnapshot>getUserData() async {
    DocumentSnapshot doc = await users.doc(user!.uid).get();
    return doc;

  }
  Future<DocumentSnapshot>getSellerData(id) async {
    DocumentSnapshot doc = await users.doc(id).get();
    return doc;

  }
}