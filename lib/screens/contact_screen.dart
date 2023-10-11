import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ContactUsPage extends StatefulWidget {
  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> sendContactMessage(String name, String email, String message, String userId) async {
    try {
      final CollectionReference contactCollection = FirebaseFirestore.instance.collection('contactMessage');

      final docRef = await contactCollection.add({
        'name': name,
        'email': email,
        'message': message,
        'userId': userId,
      });

      // Get the generated document ID
      final String docId = docRef.id;

      // Update the document with the document ID
      await docRef.update({'docId': docId});

      // Data sent successfully
      print('Contact message sent successfully!');
    } catch (e) {
      // Error occurred while sending the data
      print('Error sending contact message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        backgroundColor: kActiveIconColor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Send us a message',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                maxLines: 4,
                controller: _messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    kActiveIconColor, // Set your desired background color here
                  ),
                ),
                onPressed: () {
                  // TODO: Implement the send message functionality
                  String name = _nameController.text;
                  String email = _emailController.text;
                  String message = _messageController.text;

                  User? user = FirebaseAuth.instance.currentUser;
                  if (user != null) {
                    String userId = user.uid;
                    sendContactMessage(name, email, message, userId);
                  }

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Message sent')),
                  );
                  Navigator.pop(context);
                },
                child: Text('Send'),
              ),
            ],
          ),
        ),
      )
    );
  }
}