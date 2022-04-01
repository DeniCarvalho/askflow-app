import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../presentation.dart';

///
/// Custom splash page
///
class SplashPage extends StatefulWidget {
  /// Creates a [SplashPage]
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with PostFrameMixin {
  late bool endAnimation = false;

  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(
    //   SystemUiMode.manual,
    //   overlays: [SystemUiOverlay.top],
    // );
    postFrame(_navigateAfterStart);
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateAfterStart() async {
    await Future.delayed(const Duration(seconds: 2));
    Nav.navigate(SplashRoutes.login);
    // SystemChrome.restoreSystemUIOverlays();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          GradientContainer(
            gradient: AppGradients.background,
          ),
          Align(
            alignment: Alignment.center,
            child: LogoComponent(
              height: 65.responsiveHeight,
              path: AppImages.logoFullLightEffect,
            ),
          ),
        ],
      ),
    );
  }
}
