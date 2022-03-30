import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundComponent extends StatelessWidget {
  final ImageProvider image;
  final bool isFilter;
  const BackgroundComponent({
    Key? key,
    required this.image,
    this.isFilter = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.fill,
          colorFilter: isFilter
              ? ColorFilter.mode(
                  Colors.black.withOpacity(1.0),
                  BlendMode.dstATop,
                )
              : null,
        ),
      ),
      child: isFilter
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            )
          : Container(),
    );
  }
}
