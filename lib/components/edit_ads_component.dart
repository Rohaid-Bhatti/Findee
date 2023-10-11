import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constants.dart';
import 'package:flutter/material.dart';

class FirestoreService {
  final CollectionReference adsCollection =
  FirebaseFirestore.instance.collection('ads');

  Future<DocumentSnapshot> getAdById(String adId) =>
      adsCollection.doc(adId).get();

  Future<void> updateAd(String adId, Map<String, dynamic> data) =>
      adsCollection.doc(adId).update(data);
}

class EditAdsPage extends StatefulWidget {
  final String adId;
  const EditAdsPage({Key? key, required this.adId}) : super(key: key);

  @override
  _EditAdsPageState createState() => _EditAdsPageState();
}

class _EditAdsPageState extends State<EditAdsPage> {
  final FirestoreService _firestoreService = FirestoreService();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _rewardController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchAdDetails();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _rewardController.dispose();
    super.dispose();
  }

  Future<void> fetchAdDetails() async {
    try {
      DocumentSnapshot adSnapshot =
      await _firestoreService.getAdById(widget.adId);
      Map<String, dynamic> adData = adSnapshot.data() as Map<String, dynamic>;
      _nameController.text = adData['name'] ?? '';
      _descriptionController.text = adData['desc'] ?? '';
      _rewardController.text = adData['reward'] ?? '';
    } catch (e) {
      // Handle any errors that occur while fetching ad details
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Ads'),
        centerTitle: true,
        backgroundColor: kActiveIconColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _rewardController,
                decoration: InputDecoration(
                  labelText: 'Reward',
                ),
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    kActiveIconColor, // Set your desired background color here
                  ),
                ),
                onPressed: () {
                  updateAdDetails();
                },
                child: Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateAdDetails() async {
    try {
      String name = _nameController.text;
      String description = _descriptionController.text;
      String reward = _rewardController.text;

      await _firestoreService.updateAd(widget.adId, {
        'name': name,
        'desc': description,
        'reward': reward,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ad updated successfully')),
      );
    } catch (e) {
      // Handle any errors that occur while updating ad details
    }
  }
}