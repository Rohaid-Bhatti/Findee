import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findee/components/top_ads_component.dart';
import 'package:findee/providers/ads_provider.dart';
import 'package:findee/screens/details_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class TopAds extends StatefulWidget {
  const TopAds({Key? key}) : super(key: key);

  @override
  State<TopAds> createState() => _TopAdsState();
}

class _TopAdsState extends State<TopAds> {
  // final _userStream = FirebaseFirestore.instance.collection('ads').snapshots();
  AdsProvider? adsProvider;

  @override
  void initState() {
    AdsProvider provider = Provider.of(context, listen: false);
    provider.getAds();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    adsProvider = Provider.of(context);

    return TopComponents(adsProvider: adsProvider!);
    /*StreamBuilder(
      stream: _userStream,
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
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: *//*docs.length*//*docs.length >= 3 ? 3 : docs.length,
            // Replace with actual data list length
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdsDetailsScreen(
                            id: docs[index]['id'],
                            name: docs[index]['name'],
                            image: docs[index]['image'],
                            reward: docs[index]['reward'],
                            number: docs[index]['number'],
                            desc: docs[index]['desc'],
                            longitude: docs[index]['longitude'],
                            latitude: docs[index]['latitude'],
                            userId: docs[index]['userId'],
                            category: docs[index]['category'],
                            email: docs[index]['email'],
                            username: docs[index]['username'],
                          )));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Flexible(
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
                              CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 150,
                                  width: 150,
                                  child: Image.network(
                                      docs[index]['image'].toString(),
                                      errorBuilder:
                                          (context, object, error) {
                                        return SvgPicture.asset(
                                            'assets/images/image-not-found-icon.svg');
                                      }),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(top: 15.0),
                                  child: Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 120,
                                          child: Text(
                                            docs[index]['name'],
                                            overflow:
                                            TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
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
                                                docs[index]['reward'],
                                            overflow:
                                            TextOverflow.ellipsis,
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
                                            docs[index]['desc'],
                                            overflow:
                                            TextOverflow.ellipsis,
                                            softWrap: false,
                                            maxLines: 1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );*/
  }
}
