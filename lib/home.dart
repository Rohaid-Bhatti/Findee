import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constants.dart';
import 'package:findee/controllers/auth_controller.dart';
import 'package:findee/login.dart';
import 'package:findee/providers/ads_provider.dart';
import 'package:findee/providers/category_provider.dart';
import 'package:findee/screens/ads_screen.dart';
import 'package:findee/screens/details_ads_screen.dart';
import 'package:findee/screens/search_screen.dart';
import 'package:findee/screens/search_screen_ads.dart';
import 'package:findee/widgets/category_widget.dart';
import 'package:findee/widgets/drawer_widget.dart';
import 'package:findee/widgets/top_ads_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _categoryStream =
      FirebaseFirestore.instance.collection('categories').snapshots();
  CategoryProvider? categoryProvider;

  @override
  void initState() {
    CategoryProvider provider = Provider.of(context, listen: false);
    provider.getCategoryData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    CategoryProvider userProvider = Provider.of(context);
    userProvider.getUserData();
    categoryProvider = Provider.of(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: kActiveIconColor,
        elevation: 0,
      ),
      drawer: DrawerWidget(
        userProvider: userProvider,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Center(
                  child: Image.asset('assets/FindeeLogoFinal.png'),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "Looking for your \nlost valuables?",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900, color: Colors.blueGrey),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SearchScreenAds()));
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(29.5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/search.svg"),
                        SizedBox(
                          width: 20,
                        ),
                        Text('Search'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 14),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: CategoryWidget(categoryProvider: categoryProvider!,),
              /*Container(
                height: 80,
                child: StreamBuilder(
                  stream: _categoryStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Connection Error');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading.....');
                    }
                    var docs = snapshot.data!.docs;
                    // return Text('${docs.length}');
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black),
                            ),
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AdsScreen(
                                                categoryName: docs[index]
                                                    ['categoryName'])));
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        docs[index]['categoryImage'],
                                        width: 40,
                                        height: 40,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        docs[index]['categoryName'],
                                        style: const TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                )));
                      },
                    );
                  },
                ),
              ),*/
            ),
            SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Top Ads',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            TopAds(),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
