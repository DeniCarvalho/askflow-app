import 'package:flutter/material.dart';
import '../../../../../core/core.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback? back;
  const LoginForm({
    Key? key,
    this.back,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passController;
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passFocus = FocusNode();
  late bool _loading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passController = TextEditingController();
    super.initState();
    initPage();
  }

  initPage() async {
    await Future.delayed(const Duration(milliseconds: 800));
    FocusScope.of(context).requestFocus(_emailFocus);
  }

  void signin() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool validate = _formKey.currentState?.validate() ?? false;
    if (validate) {
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
      // Nav.navigate(AuthRoutes.homeModule);
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0.responsiveWidth,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFieldComponent(
              focusNode: _emailFocus,
              controller: _emailController,
              placeholder: 'email'.i18n(context),
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (val) {
                FocusScope.of(context).requestFocus(_passFocus);
              },
              validator: (val) {
                if (val == null || val.isEmpty) return 'Campo obrigatório';

                bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(val);
                if (!emailValid) return 'invalidEmail'.i18n(context);

                return null;
              },
            ),
            SizedBox(
              height: 25.responsiveHeight,
            ),
            TextFieldComponent(
              controller: _passController,
              placeholder: 'password'.i18n(context),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              focusNode: _passFocus,
              onFieldSubmitted: (val) {},
              validator: (val) {
                if (val == null || val.isEmpty) {
                  return 'required'.i18n(context);
                }

                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'forgotYourPassword'.i18n(context),
                  ),
                  style: ButtonStyle(
                    // backgroundColor:
                    //     MaterialStateProperty.all(AppColors.transparent),
                    foregroundColor:  MaterialStateProperty.all(AppColors.tertiary),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15.responsiveHeight,
            ),
            ButtonComponent(
              text: 'signIn'.i18n(context),
              onPressed: () {},
              loading: _loading,
              enabled: !_loading,
              bgColor: const Color(0xFFf2c513),
              fgColor: AppColors.primary,
              borderRadius: 8,
              overlayColor: AppColors.light.withOpacity(0.3),
            ),
            SizedBox(
              height: 5.responsiveHeight,
            ),
            TextButton(
              onPressed: widget.back,
              child: const Text('Já tenho uma conta'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(AppColors.light),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
