import 'package:findee/providers/category_provider.dart';
import 'package:findee/screens/ads_screen.dart';
import 'package:findee/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryComponent extends StatefulWidget {
  final CategoryProvider categoryProvider;

  const CategoryComponent({Key? key, required this.categoryProvider})
      : super(key: key);

  @override
  State<CategoryComponent> createState() => _CategoryComponentState();
}

class _CategoryComponentState extends State<CategoryComponent> {
  @override
  Widget build(BuildContext context) {
    return widget.categoryProvider.categoryList.isEmpty
            ? const SizedBox(
                height: 60,
                child: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.black),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(29.5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/search.svg"),
                              SizedBox(
                                width: 20,
                              ),
                              Text('Search'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: GridView.count(
                        scrollDirection: Axis.vertical,
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisSpacing: 5,
                        children: List.generate(
                          widget.categoryProvider.categoryList.length,
                          (index) => GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdsScreen(
                                          categoryName: widget
                                              .categoryProvider
                                              .categoryList[index]
                                              .categoryName)));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1.0,
                                  ),
                                  // color: Colors.grey.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: new BoxDecoration(
                                      image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: new NetworkImage(widget
                                            .categoryProvider
                                            .categoryList[index]
                                            .categoryImage),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    widget.categoryProvider.categoryList[index]
                                        .categoryName,
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
  }
}
