import 'package:findee/providers/ads_provider.dart';
import 'package:findee/screens/details_ads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TopComponents extends StatefulWidget {
  final AdsProvider adsProvider;

  const TopComponents({Key? key, required this.adsProvider}) : super(key: key);

  @override
  State<TopComponents> createState() => _TopComponentsState();
}

class _TopComponentsState extends State<TopComponents> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.adsProvider.adsList.length >= 5
            ? 5
            : widget.adsProvider.adsList
                .length /*widget.adsProvider.adsList.length*/,
        // Replace with actual data list length
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdsDetailsScreen(
                            id: widget.adsProvider.adsList[index].id,
                            name: widget.adsProvider.adsList[index].name,
                            image: widget.adsProvider.adsList[index].image,
                            reward: widget.adsProvider.adsList[index].reward,
                            number: widget.adsProvider.adsList[index].number,
                            desc: widget.adsProvider.adsList[index].desc,
                            longitude:
                                widget.adsProvider.adsList[index].longitude,
                            latitude:
                                widget.adsProvider.adsList[index].latitude,
                            userId: widget.adsProvider.adsList[index].userId,
                            category:
                                widget.adsProvider.adsList[index].category,
                            email: widget.adsProvider.adsList[index].email,
                            username:
                                widget.adsProvider.adsList[index].username,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 150,
                              width: 150,
                              child: Image.network(
                                  widget.adsProvider.adsList[index].image
                                      .toString(),
                                  errorBuilder: (context, object, error) {
                                return SvgPicture.asset(
                                    'assets/images/image-not-found-icon.svg');
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        widget.adsProvider.adsList[index].name,
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
                                    Divider(color: Colors.black, thickness: 8),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: Text(
                                        'Reward = ' +
                                            widget.adsProvider.adsList[index]
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
                                        widget.adsProvider.adsList[index].desc,
                                        overflow: TextOverflow.ellipsis,
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
  }
}
