import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constant/firebase_constant.dart';
import 'package:findee/providers/category_provider.dart';
import 'package:findee/screens/ads_screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final TextEditingController _searchController = TextEditingController();
  late Query _searchQuery;

  @override
  void initState() {
    super.initState();
    _searchQuery = firestore.collection('categories');
  }

  void _performSearch(String searchQuery) {
    setState(() {
      _searchQuery = firestore
          .collection('categories')
          .where('categoryName', isGreaterThanOrEqualTo: searchQuery)
          .where('categoryName', isLessThan: searchQuery + 'z')
          .orderBy('categoryName')
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
                          builder: (context) => AdsScreen(
                            categoryName: data['categoryName'],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
                      child: ListTile(
                        title: Text(data['categoryName']),
                        subtitle: Text(data['categoryDes']),
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
