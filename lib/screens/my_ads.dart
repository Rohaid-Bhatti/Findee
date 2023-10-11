import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/components/edit_ads_component.dart';
import 'package:findee/constants.dart';
import 'package:findee/providers/ads_provider.dart';
import 'package:findee/screens/details_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyAds extends StatefulWidget {
  final String userId;

  const MyAds({Key? key, required this.userId}) : super(key: key);

  @override
  State<MyAds> createState() => _MyAdsState();
}

class _MyAdsState extends State<MyAds> {
  AdsProvider? adsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdsProvider provider = Provider.of(context, listen: false);
    provider.getAdsData(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    adsProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Ads'),
        centerTitle: true,
        backgroundColor: kActiveIconColor,
        elevation: 0,
      ),
      body: adsProvider!.adsUserList.isEmpty
          ? const Center(
              child: Text('No Ads Uploaded'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      /*physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,*/
                      padding: EdgeInsets.only(
                          left: 8, top: 8, right: 8, bottom: 16),
                      itemCount: adsProvider!.adsUserList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdsDetailsScreen(
                                          id: adsProvider!
                                              .adsUserList[index].id,
                                          name: adsProvider!
                                              .adsUserList[index].name,
                                          image: adsProvider!
                                              .adsUserList[index].image,
                                          reward: adsProvider!
                                              .adsUserList[index].reward,
                                          number: adsProvider!
                                              .adsUserList[index].number,
                                          desc: adsProvider!
                                              .adsUserList[index].desc,
                                          longitude: adsProvider!
                                              .adsUserList[index].longitude,
                                          latitude: adsProvider!
                                              .adsUserList[index].latitude,
                                          userId: adsProvider!
                                              .adsUserList[index].userId,
                                          category: adsProvider!
                                              .adsUserList[index].category,
                                          email: adsProvider!
                                              .adsUserList[index].email,
                                          username: adsProvider!
                                              .adsUserList[index].username,
                                        )));
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: 150,
                                        width: 150,
                                        child: Image.network(
                                          adsProvider!.adsUserList[index].image,
                                            errorBuilder:
                                                (context, object, error) {
                                              return SvgPicture.asset(
                                                  'assets/images/image-not-found-icon.svg');
                                            }
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120,
                                              child: Text(
                                                adsProvider!
                                                    .adsUserList[index].name,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 22),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Divider(
                                                color: Colors.black,
                                                thickness: 8),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Text(
                                                'Reward = ' +
                                                    adsProvider!
                                                        .adsUserList[index]
                                                        .reward,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                maxLines: 1,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: 120,
                                              child: Text(
                                                adsProvider!
                                                    .adsUserList[index].desc,
                                                softWrap: false,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          IconButton(
                                            icon: Icon(Icons.edit),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditAdsPage(adId: adsProvider!.adsUserList[index].id,)));
                                            }, // Call the _editAd method
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.delete),
                                            onPressed: () {

                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return AlertDialog(
                                                    title: Text('Confirm Delete'),
                                                    content: Text('Are you sure you want to delete this document?'),
                                                    actions: [
                                                      TextButton(
                                                        child: Text('Cancel'),
                                                        onPressed: () {
                                                          Navigator.of(context).pop();
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text('Delete'),
                                                        onPressed: () async {
                                                          try {
                                                            FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                            DocumentReference documentReference =
                                                            firestore.collection('ads').doc(adsProvider!.adsUserList[index].id);

                                                            await documentReference.delete();
                                                            print('Document deleted successfully.');
                                                          } catch (error) {
                                                            print('Failed to delete document: $error');
                                                          }
                                                          Navigator.of(context).pop();
                                                          Navigator.pop(context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            }, // Call the _editAd method
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
    );
  }
}
