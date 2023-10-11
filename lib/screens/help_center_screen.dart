import 'package:findee/constants.dart';
import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
        centerTitle: true,
        backgroundColor: kActiveIconColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Frequently Asked Questions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            FaqItem(
              question: 'How do I create an account?',
              answer: 'To create an account, click on the "Sign Up" button and fill out the required information.',
            ),
            FaqItem(
              question: 'Is posting ads free?',
              answer: 'Yes these are free for every user. Anyone who are signed up can post ads.',
            ),
            FaqItem(
              question: 'How do I contact customer support?',
              answer: 'You can contact our customer support team by sending an email to ashraf5hamza@gmail.com.',
            ),
          ],
        ),
      ),
    );
  }
}

class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({required this.question, required this.answer});

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              widget.answer,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ),
        ],
      ),
    );
  }
}