import 'package:findee/providers/category_provider.dart';
import 'package:findee/screens/ads_screen.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  final CategoryProvider categoryProvider;

  const CategoryWidget({Key? key, required this.categoryProvider}) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.categoryProvider.categoryList.length,
        itemBuilder: (context, index) {
          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.symmetric(
                  vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black),
              ),
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdsScreen(
                                  categoryName: widget.categoryProvider.categoryList[index].categoryName)));
                    },
                    child: Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
                      children: [
                        Image.network(
                          widget.categoryProvider.categoryList[index].categoryImage,
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          widget.categoryProvider.categoryList[index].categoryName,
                          style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  )));
        },
      ),
    );
  }
}
