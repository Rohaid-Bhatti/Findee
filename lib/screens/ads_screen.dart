import 'package:findee/constants.dart';
import 'package:findee/providers/ads_provider.dart';
import 'package:findee/screens/details_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class AdsScreen extends StatefulWidget {
  final String categoryName;

  const AdsScreen({Key? key, required this.categoryName}) : super(key: key);

  @override
  State<AdsScreen> createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  AdsProvider? adsProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    AdsProvider provider = Provider.of(context, listen: false);
    provider.getAdsByCategory(widget.categoryName);
  }

  @override
  Widget build(BuildContext context) {
    adsProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Ads Screen'),
        centerTitle: true,
        backgroundColor: kActiveIconColor,
        elevation: 0,
      ),
      body: adsProvider!.adsByCategoryList.isEmpty
          ? const Center(
              child: Text('No Ads Uploaded'),
            )
          : ListView.builder(
              /*physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,*/
              padding: EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 16),
              itemCount: adsProvider!.adsByCategoryList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AdsDetailsScreen(
                          id: adsProvider!.adsByCategoryList[index].id,
                          name: adsProvider!.adsByCategoryList[index].name,
                          image: adsProvider!.adsByCategoryList[index].image,
                          reward: adsProvider!.adsByCategoryList[index].reward,
                          number: adsProvider!.adsByCategoryList[index].number,
                          desc: adsProvider!.adsByCategoryList[index].desc,
                          longitude: adsProvider!.adsByCategoryList[index].longitude,
                          latitude: adsProvider!.adsByCategoryList[index].latitude,
                          userId: adsProvider!.adsByCategoryList[index].userId,
                          category: adsProvider!.adsByCategoryList[index].category,
                          email: adsProvider!.adsByCategoryList[index].email,
                          username: adsProvider!.adsByCategoryList[index].username,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.network(
                                  adsProvider!.adsByCategoryList[index].image,
                                    errorBuilder:
                                        (context, object, error) {
                                      return SvgPicture.asset(
                                          'assets/images/image-not-found-icon.svg');
                                    }
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15.0),
                                child: Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          adsProvider!
                                              .adsByCategoryList[index].name,
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
                                          color: Colors.black, thickness: 8),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        width: 120,
                                        child: Text(
                                          'Reward = ' +
                                              adsProvider!
                                                  .adsByCategoryList[index]
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
                                              .adsByCategoryList[index].desc,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              /*const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Icon(
                                                          Icons.favorite_outline),*/
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
