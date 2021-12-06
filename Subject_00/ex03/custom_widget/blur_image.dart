import 'package:flutter/material.dart';

getLinearGradient(AlignmentGeometry begin, AlignmentGeometry end) {
  return (LinearGradient(
    begin: begin,
    end: end,
    colors: [Colors.black.withOpacity(0.0), Colors.black],
  ));
}

class BlurImage extends StatelessWidget {
  final String imagePath;

  const BlurImage({required Key key, required this.imagePath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          Image.network(imagePath),
          Container(
            decoration: BoxDecoration(
              gradient:
                  getLinearGradient(Alignment.center, Alignment.topCenter),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient:
                  getLinearGradient(Alignment.center, Alignment.bottomCenter),
            ),
          ),
        ],
      ),
    );
  }
}
