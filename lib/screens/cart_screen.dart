import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:krishi/services/firebase_service.dart';
import 'package:like_button/like_button.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseService _service = FirebaseService();
    final _format = NumberFormat('##,##,##0');
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const Text(
            'My Products',
            style: TextStyle(color: Colors.black),
          ),
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
            labelStyle: const TextStyle(fontWeight: FontWeight.bold),
            indicatorWeight: 6,
            tabs: [
              Tab(
                child: Text(
                  'Your Products',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
              Tab(
                child: Text(
                  'Favourites',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                child: FutureBuilder<QuerySnapshot>(
                  future: _service.products.where('sellerUid',isEqualTo:_service.user!.uid ).orderBy('postedAt').get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 140, right: 140),
                        child: Center(
                          child: LinearProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor),
                            backgroundColor: Colors.grey.shade100,
                          ),
                        ),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            height: 56,
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Your Products',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            )),
                        Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 2 / 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: snapshot.data!.size,
                            itemBuilder: (BuildContext context, int i) {
                              var data = snapshot.data!.docs[i];

                              var _price = int.parse(data['price']);
                              String _formattedPrice =
                                  '₹ ${_format.format(_price)}';
                              return Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 100,
                                            child: Center(
                                              child: Image.network(
                                                  data['images'][0]),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            _formattedPrice,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data['name'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: 0.0,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          child: LikeButton(
                                            circleColor: const CircleColor(
                                                start: Color(0xff00ddff),
                                                end: Color(0xff0099cc)),
                                            bubblesColor: const BubblesColor(
                                              dotPrimaryColor:
                                                  Color(0xff33b5e5),
                                              dotSecondaryColor:
                                                  Color(0xff0099cc),
                                            ),
                                            likeBuilder: (bool isLiked) {
                                              return Icon(
                                                Icons.favorite,
                                                color: isLiked
                                                    ? Colors.redAccent
                                                    : Colors.grey,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(context)
                                          .primaryColor
                                          .withOpacity(.8),
                                    ),
                                    borderRadius: BorderRadius.circular(4)),
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const Center(
              child: Text('My Favourites'),
            ),
          ],
        ),
      ),
    );
  }
}
