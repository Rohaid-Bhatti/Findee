import 'package:findee/constants.dart';
import 'package:findee/screens/get_loction_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

class AdsDetailsScreen extends StatefulWidget {
  final String id;
  final String name;
  final String image;
  final String reward;
  final String number;
  final String desc;
  final String longitude;
  final String latitude;
  final String category;
  final String userId;
  final String email;
  final String username;

  AdsDetailsScreen(
      {Key? key,
      required this.id,
      required this.name,
      required this.image,
      required this.reward,
      required this.number,
      required this.desc,
      required this.longitude,
      required this.latitude,
      required this.userId,
      required this.category,
      required this.email,
      required this.username})
      : super(key: key);

  @override
  State<AdsDetailsScreen> createState() => _AdsDetailsScreenState();
}

class _AdsDetailsScreenState extends State<AdsDetailsScreen> {
  //phone launcher code
  // String? phoneNumber;

  @override
  void initState() {
    super.initState();
    // phoneNumber = widget.number;
  }

  /*void addToPhoneBook() async {
    final url = *//*'https://twitter.com'*//*'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ads Details'),
        centerTitle: true,
        backgroundColor: kActiveIconColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(widget.image,
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover, errorBuilder: (context, object, error) {
                  return SvgPicture.asset(
                      'assets/images/image-not-found-icon.svg');
                }),
              ),
              SizedBox(height: 16),
              Text(
                'Ad Title',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.name,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Ad Description',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.desc,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Reward',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.reward,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Text(
                'Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.category,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              /*Text(
                'Location',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'New York, USA',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),*/
              Text(
                'Contact',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                widget.username,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                widget.email,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                widget.number,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          kActiveIconColor, // Set your desired background color here
                        ),
                      ),
                      onPressed: () async {
                        // Add your logic here for getting the phone number
                        // addToPhoneBook();
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: widget.number,
                        );
                        if(await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          print('Cannot launch the app');
                        }
                      },
                      child: Text('Call'),
                    ),
                    const SizedBox(width: 8,),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          kActiveIconColor, // Set your desired background color here
                        ),
                      ),
                      onPressed: () {
                        // Add your logic here for getting the location
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetLocationScreen(
                                    latitude: widget.latitude,
                                    longitude: widget.longitude)));
                      },
                      child: Text('Get Location'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
