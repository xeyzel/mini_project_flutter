import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    Key? key,
    this.height = 125,
    this.borderRadius = 20,
    required this.width,
    required this.imageUrl,
    this.padding,
    required this.child,
    this.margin,
  }) : super(key: key);

  final double width;
  final double height;
  final double borderRadius;
  final String imageUrl;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              height: height,
              width: width,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Image.asset(
                'assets/images/image_01.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: child,
          ),
        ],
      ),
    );
    // return Container(
    //   height: height,
    //   padding: padding,
    //   width: width,
    //   margin: margin,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(20),
    //     image: DecorationImage(
    //       image: NetworkImage(imageUrl),
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   child: child,
    // );
  }
}
