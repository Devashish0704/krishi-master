import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:krishi/screens/home_screen.dart';
import 'package:krishi/screens/location_screen.dart';
import 'package:krishi/services/firebase_service.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    return FutureBuilder<DocumentSnapshot>(
      future: _service.users.doc(_service.user!.uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text("Address not selected");
        }

        if (snapshot.connectionState==ConnectionState.done) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<
              String,
              dynamic>;
          if (data['address'] == null) {
            GeoPoint latLong = data['location'];
            _service.getAddress(latLong.latitude, latLong.longitude).then((
                adress) {
              return appBar(adress, context);
            });
          } else {
            return appBar(data['address'], context);
          }
        }
        return appBar('Fetch Location', context);
      },
    );
  }

  Widget appBar(address, context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      automaticallyImplyLeading: false,
      title: InkWell(
        onTap: () {
         Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>const LocationScreen(popScreen: HomeScreen.id,),),);
        },
        child: SizedBox(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 8),
            child: Row(
              children: [
                const Icon(
                  CupertinoIcons.location_solid,
                  color: Colors.black,
                  size: 18,
                ),
                Flexible(
                  child: Text(
                    address,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.black,
                  size: 12,
                )
              ],
            ),
          ),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12,0,12,8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.search,
                          ),
                          labelText: 'Find Pesticides,Fertilizers and many more',
                          labelStyle: const TextStyle(fontSize: 12),
                          contentPadding: const EdgeInsets.only(left: 10, right: 10),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                        )),
                  ),
                ),
                const SizedBox(width:10,),
                const Icon(Icons.notifications_none),
                const SizedBox(width:10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
