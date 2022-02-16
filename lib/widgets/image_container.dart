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
  final Future<File>? imageCacheProvider;

  const ImageContainer({
    required this.image,
    this.imageCacheProvider,
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
    // Create image container design
    // Allow passing a custom cache provider (for different image types)
    Future<File>? imageProvider;
    if ( isNetwork ) {
      if ( imageCacheProvider == null ) {
        imageProvider = StaffImageCacheManager().getSingleFile(image);
      } else {
        imageProvider = imageCacheProvider!;
      }
    }
    // If image is network, load in FutureBuilder, and it not, load locally
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: borderRadius ?? BorderRadius.circular(radius),
        boxShadow: [
          if (isShadow)
            BoxShadow(
              color: Theme.of(context).colorScheme.shadow.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1),
            ),
        ],
      ),
      child: isNetwork && imageProvider != null
          ? FutureBuilder(
              future: imageProvider,
              builder: (context, AsyncSnapshot<File> snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          borderRadius ?? BorderRadius.circular(radius),
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

  // If not image found, display a blank container
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
