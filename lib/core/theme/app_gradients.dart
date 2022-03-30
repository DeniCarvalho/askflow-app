import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppGradients {
  static LinearGradient get background => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment(0.0, 1.0),
        stops: [
          0.2,
          0.8,
        ],
        colors: [
          AppColors.secundary,
          AppColors.primary,
        ],
      );
}
