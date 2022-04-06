import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/core.dart';

class ResetPassword extends StatefulWidget {
  final String token;
  const ResetPassword({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _newPassController;
  late TextEditingController _confirmPassController;
  final FocusNode _newPassFocus = FocusNode();
  final FocusNode _confirmPassFocus = FocusNode();
  late bool _loading = false;

  @override
  void initState() {
    _newPassController = TextEditingController();
    _confirmPassController = TextEditingController();
    super.initState();
    initPage();
  }

  initPage() async {
    await Future.delayed(const Duration(seconds: 2));
    FocusScope.of(context).requestFocus(_newPassFocus);
  }

  void _confirm() async {
    FocusScope.of(context).requestFocus(FocusNode());
    bool validate = _formKey.currentState?.validate() ?? false;
    if (validate) {
      setState(() => _loading = true);
      await Future.delayed(const Duration(seconds: 2));
        Nav.navigate('/');
    }
  }



  @override
  void dispose() {
    _newPassController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: AppColors.secundary,
        title: kIsWeb
            ? LogoComponent(
                height: 30.responsiveHeight,
                path: AppImages.logoLight,
                isHero: false,
              )
            : const Text(
                'Alteração de senha',
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
              if (kIsWeb) ...[
                const Text(
                  'Alteração de senha',
                  style: TextStyle(
                    color: AppColors.light,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 18.responsiveHeight,
                ),
              ],
              TextFieldComponent(
                controller: _newPassController,
                placeholder: 'Nova senha',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                focusNode: _newPassFocus,
                onFieldSubmitted: (val) {
                  FocusScope.of(context).requestFocus(_confirmPassFocus);
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'required'.i18n(context);
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20.responsiveHeight,
              ),
              TextFieldComponent(
                controller: _confirmPassController,
                placeholder: 'Confirme a nova senha',
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                focusNode: _confirmPassFocus,
                onFieldSubmitted: (val) {
                  _confirm();
                },
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'required'.i18n(context);
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 15.responsiveHeight,
              ),
              ButtonComponent(
                text: 'confirm'.i18n(context),
                onPressed: _confirm,
                loading: _loading,
                enabled: !_loading,
                bgColor: AppColors.secundary,
                // fgColor: AppColors.light,
                borderRadius: 8,
                padding: kIsWeb
                    ? MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: 20.responsiveWidth,
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
