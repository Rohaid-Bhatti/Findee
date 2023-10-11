import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants.dart';


class CategoryCard extends StatelessWidget {
  final  svgSrc;
  final String title;
  final VoidCallback press;
  const CategoryCard({
    super.key,
    required this.svgSrc,
    required this.title,
    required this.press,
  });


@override
Widget build(BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(13),
    child: Container(
      height: 200,
      width: 200,
      //padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
          boxShadow: const [
            BoxShadow(
              offset: Offset(0,17),
              blurRadius: 17,
              spreadRadius: -23,
              color: kShadowColor,
            ),
          ]
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:  press,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                const Spacer(),
                Image.network(svgSrc,errorBuilder: (context , object ,error){
                  return SvgPicture.asset('assets/images/image-not-found-icon.svg');
                },),
                const Spacer(),
                Text(title,
                  style: Theme.of(context)
                      .textTheme.
                  titleMedium
                      ?.copyWith(fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
}