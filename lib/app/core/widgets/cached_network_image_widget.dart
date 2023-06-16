import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String image;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final BoxFit? fit;
  final EdgeInsets? margin;

  const CachedNetworkImageWidget({
    Key? key,
    required this.image,
    this.width,
    this.height,
    this.borderRadius,
    this.border,
    this.fit,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        border: border,
        borderRadius: borderRadius ?? BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(12),
        child: SizedBox(
          width: width,
          height: height,
          child: CachedNetworkImage(
            imageUrl: image,
            fit: fit,
            placeholder: (context, url) => Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
            errorWidget: (context, url, error) {
              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: borderRadius ?? BorderRadius.circular(12),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
