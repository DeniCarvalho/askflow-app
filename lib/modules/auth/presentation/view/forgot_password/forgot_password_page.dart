import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({
    Key? key,
  }) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  final FocusNode _emailFocus = FocusNode();
  late bool _loading = false;

  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
    initPage();
  }

  initPage() async {
    await Future.delayed(const Duration(milliseconds: 800));
    FocusScope.of(context).requestFocus(_emailFocus);
  }

  void _send() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool validate = _formKey.currentState?.validate() ?? false;
    if (validate) {
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
      Nav.pop();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: AppColors.secundary,
        title: Text(
          'recoveryPassword'.i18n(context),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 30.0.responsiveWidth,
            vertical: 30.0.responsiveHeight,
          ),
          child: Column(
            children: [
              Text(
                'recoveryPasswordMsg'.i18n(context),
                style: const TextStyle(
                  color: AppColors.light,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 15.responsiveHeight,
              ),
              TextFieldComponent(
                focusNode: _emailFocus,
                controller: _emailController,
                placeholder: 'email'.i18n(context),
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (val) {
                  // FocusScope.of(context).requestFocus(_passFocus);
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'required'.i18n(context);
                  }
                  if (!val.validateEmail()) return 'invalidEmail'.i18n(context);

                  return null;
                },
              ),
              SizedBox(
                height: 15.responsiveHeight,
              ),
              ButtonComponent(
                text: 'confirm'.i18n(context),
                onPressed: _send,
                loading: _loading,
                enabled: !_loading,
                bgColor: AppColors.secundary,
                // fgColor: AppColors.light,
                borderRadius: 8,
                // overlayColor: AppColors.light.withOpacity(0.3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
