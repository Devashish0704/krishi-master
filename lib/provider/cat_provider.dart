import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:krishi/services/firebase_service.dart';

class CategoryProvider with ChangeNotifier {
  final FirebaseService _service = FirebaseService();

  DocumentSnapshot? doc;
  DocumentSnapshot? userDetails;
  String? SelectedCategory;
  String? SelectedSubCat;

  List<String> urlList = [];
  Map<String, dynamic> dataToFirestore = {};


  getCategory(selectedCat) {
    SelectedCategory = selectedCat;
    notifyListeners();
  }

  getSubCategory(selectedsubCat) {
    SelectedSubCat = selectedsubCat;
    notifyListeners();
  }
  getCatSnapshot(snapshot) {
    doc = snapshot;
    notifyListeners();
  }

  getImages(url) {
    urlList.add(url);
    notifyListeners();
  }

  getData(data) {
    dataToFirestore = data;
    notifyListeners();
  }

  getUserDetails() {
    _service.getUserData().then((value) {
      userDetails = value;

      notifyListeners();
    });
  }
  clearData(){
    urlList = [];
    dataToFirestore = {};
    notifyListeners();

  }
}
