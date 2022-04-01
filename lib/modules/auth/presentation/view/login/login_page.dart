import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/core.dart';
import 'login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late VideoPlayerController _controller;
  late bool isLoadVideo;
  late bool isLoadPage;
  late bool showForm;

  @override
  void initState() {
    isLoadVideo = false;
    isLoadPage = false;
    showForm = false;
    super.initState();
    loadPage();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  loadPage() async {
    _controller = VideoPlayerController.asset(
      AppVideos.background,
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.addListener(() {
      // if (!isLoadVideo &&
      //     (_controller.value.isInitialized && _controller.value.isPlaying)) {
      //   setState(() {
      //     isLoadVideo = true;
      //   });
      // }
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) async {
      setState(() {
        isLoadVideo = true;
      });

      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        isLoadPage = true;
      });
    });
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (showForm) {
          setState(() {
            showForm = false;
          });
          return Future<bool>.value(false);
        }
        return Future<bool>.value(true);
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: Size.zero,
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              child: isLoadVideo
                  ? BackgroundVideoComponent(
                      controller: _controller,
                      isBlur: !isLoadPage || showForm,
                      // isFilter: showForm,
                      blur: showForm ? 20.0 : 6.0,
                    )
                  : GradientContainer(
                      gradient: AppGradients.background,
                    ),
            ),
            AnimatedAlign(
              duration: const Duration(seconds: 2),
              curve: Curves.fastOutSlowIn,
              alignment: isLoadVideo && isLoadPage
                  ? const Alignment(0.0, -0.8)
                  : Alignment.center,
              child: LogoComponent(
                height: 65.responsiveHeight,
                path: AppImages.logoFullLightEffect,
                isHero: false,
              ),
            ),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _body(),
            ),
          ],
        ),
      ),
    );
  }

  Widget? _body() {
    if (!isLoadVideo || !isLoadPage) return null;

    if (!showForm) {
      return _optionSignIn;
    } else {
      return LoginForm(
        back: () {
          setState(() {
            showForm = false;
          });
        },
      );
    }
  }

  Widget get _optionSignIn => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 5.0.responsiveWidth,
            horizontal: 30.0.responsiveWidth,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ButtonComponent(
                text: 'signInEmail'.i18n(context),
                bgColor: const Color(0xFFf2c513),
                fgColor: AppColors.primary,
                borderRadius: 8,
                overlayColor: AppColors.light.withOpacity(0.3),
                onPressed: () {
                  setState(() {
                    showForm = true;
                  });
                },
              ),
              const SizedBox(
                height: 8,
              ),
              ButtonComponent(
                bgColor: AppColors.light,
                elevation: 0,
                borderRadius: 8,
                onPressed: () {},
                overlayColor: AppColors.secundary.withOpacity(0.1),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: 12.responsiveWidth,
                    vertical: 10.responsiveWidth,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.facebook,
                      height: 20.responsiveHeight,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 8.responsiveWidth,
                    ),
                    Text(
                      'signInFacebook'.i18n(context),
                      style: const TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              //  const SizedBox(
              //   height: 2,
              // ),
              ButtonComponent(
                bgColor: AppColors.light,
                elevation: 0,
                borderRadius: 8,
                onPressed: () {},
                overlayColor: AppColors.secundary.withOpacity(0.1),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(
                    horizontal: 12.responsiveWidth,
                    vertical: 10.responsiveWidth,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppImages.google,
                      height: 20.responsiveHeight,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(
                      width: 8.responsiveWidth,
                    ),
                    Text(
                      'signInGoogle'.i18n(context),
                      style: const TextStyle(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text('dontHaveAccount'.i18n(context)),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(AppColors.light),
                ),
              ),
            ],
          ),
        ),
      );
}
