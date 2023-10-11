import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/screens/details_ads_screen.dart';
import 'package:flutter/material.dart';

class SearchScreenAds extends StatefulWidget {
  const SearchScreenAds({Key? key}) : super(key: key);

  @override
  State<SearchScreenAds> createState() => _SearchScreenAdsState();
}

class _SearchScreenAdsState extends State<SearchScreenAds> {
  final TextEditingController _searchController = TextEditingController();
  late Query _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = firestore.collection('ads');
  }

  void _performSearch(String searchQuery) {
    setState(() {
      _searchQuery = firestore
          .collection('ads')
          .where('name', isGreaterThanOrEqualTo: searchQuery)
          .where('name', isLessThan: searchQuery + 'z')
          .orderBy('name')
          .limit(10);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextFormField(
          controller: _searchController,
          onChanged: _performSearch,
          keyboardType: TextInputType.name,
          style: TextStyle(fontSize: 17),
          decoration: InputDecoration(
            hintText: "Search",
            suffixIcon: IconButton(
              icon: Icon(Icons.search, size: 18),
              onPressed: () {
                _searchController.clear();
                _performSearch('');
              },
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _searchQuery.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AdsDetailsScreen(
                                id: data['id'],
                                name: data['name'],
                                image: data['image'],
                                reward: data['reward'],
                                number: data['number'],
                                desc: data['desc'],
                                longitude: data['longitude'],
                                latitude: data['latitude'],
                                userId: data['userId'],
                                category: data['category'],
                                email: data['email'],
                                username: data['username'])),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: ListTile(
                        title: Text(data['name']),
                        subtitle: Text(data['desc']),
                      ),
                    ),
                  ),
                );
              },
            );
            /*ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot document = snapshot.data!.docs[index];
                Map<String, dynamic> data =
                document.data() as Map<String, dynamic>;
                return ListView.separated(
                  itemCount: snapshot.data!.docs.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data!.docs[index];
                    Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SupplierScreen(
                              categoryName: data['categoryName'],
                            ),
                          ),
                        );
                      },
                      title: Text(data['categoryName']),
                      subtitle: Text(data['categoryDes']),
                    );
                  },
                );
              },
            );*/
          }
        },
      ),
    );
  }
}
