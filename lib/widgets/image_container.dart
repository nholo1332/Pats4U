import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';
import 'package:pats4u/providers/staff_image_cache_manager.dart';

class ImageContainer extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double borderWidth;
  final bool isShadow;
  final Color? borderColor;
  final Color? bgColor;
  final bool trBackground;
  final bool isNetwork;
  final double radius;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit fit;

  const ImageContainer({
    required this.image,
    this.width = 100,
    this.height = 100,
    this.bgColor,
    this.borderWidth = 0,
    this.borderColor,
    this.trBackground = false,
    this.fit = BoxFit.cover,
    this.isNetwork = true,
    this.radius = 50,
    this.borderRadius,
    this.isShadow = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        boxShadow: [
          if ( isShadow ) BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: isNetwork
      ? FutureBuilder(
        future: StaffImageCacheManager().getSingleFile(image),
        builder: (context, AsyncSnapshot<File> snapshot) {
          if ( snapshot.connectionState == ConnectionState.done && snapshot.data != null ) {
            //imageFilePath = snapshot.data!.path;
            return Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius ?? BorderRadius.circular(radius),
                image: DecorationImage(
                  image: FileImage(snapshot.data!),
                  fit: fit,
                ),
              ),
            );
          } else {
            return const SizedBox(
              height: 100,
              width: 100,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
      )
      : Image(
        image: AssetImage(image),
        fit: fit,
      ),
    );
  }

  Widget blankImage() {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: Center(
        child: SizedBox(
          child: Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            elevation: 0,
          ),
        ),
      ),
    );
  }
}