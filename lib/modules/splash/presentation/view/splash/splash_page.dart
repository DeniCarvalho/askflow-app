import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';
import 'package:video_player/video_player.dart';

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
  late VideoPlayerController _controller;
  late bool endAnimation = false;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.asset(AppVideos.background);
    // _controller.addListener(() {
    //   setState(() {});
    // });
    // _controller.setLooping(true);
    // _controller.initialize().then((_) => setState(() {}));
    // _controller.play();
    postFrame(_navigateAfterStart);
  }

  @override
  void dispose() {
    // _controller.dispose();
    super.dispose();
  }

  Future<void> _navigateAfterStart() async {
    await Future.delayed(const Duration(seconds: 2));
    Nav.navigate(SplashRoutes.home);
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
      body: GradientContainer(
        gradient: AppGradients.background,
        body: _body(),
      ),
    );
    // :
    // _backgroundVideo();
  }

  Widget _backgroundVideo() {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          VideoPlayer(
            _controller,
          ),
          _body()
        ],
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        LogoComponent(
          height: 65.responsiveHeight,
          path: AppImages.logoFullLightEffect,
        ),
      ],
    );
  }
}
