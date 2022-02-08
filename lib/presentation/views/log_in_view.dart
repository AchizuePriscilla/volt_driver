import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/constants.dart';

class LogInView extends StatefulWidget {
  const LogInView({Key? key}) : super(key: key);

  @override
  _LogInViewState createState() => _LogInViewState();
}

class _LogInViewState extends State<LogInView> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool hidePassword = true;
  bool rememberMe = false;
  final _formKey = GlobalKey<FormState>();
  bool buttonActive = false;

  void onListen() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        buttonActive = false;
      });
    } else {
      setState(() {
        buttonActive = true;
      });
    }
  }

  void toggleVisibility() {
    setState(() {
      hidePassword = !hidePassword;
    });
  }

  void toggleRememberMe() {
    setState(() {
      rememberMe = !rememberMe;
    });
  }

  @override
  void initState() {
    super.initState();
    _emailController.addListener(onListen);
    _passwordController.addListener(onListen);
  }

  @override
  void dispose() {
    _emailController.removeListener(onListen);
    _passwordController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loginVM = context.read<LogInViewModel>();
    return ResponsiveWidget(
      resizeToAvoidBottomInset: false,
      builder: (_, size) {
        return Container(
          height: size.height,
          width: size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            image: const DecorationImage(
              image: AssetImage('assets/images/white_background.png'),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: _formKey,
              child: ListView(children: [
                Padding(
                  padding: EdgeInsets.only(top: 75.h, left: 75.h, right: 75.h),
                  child: SizedBox(
                    child:
                        Image.asset('assets/images/volt_logo/volt_mixed.png'),
                  ),
                ),
                const CustomSpacer(flex: 3),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Log in to your volt account',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const CustomSpacer(flex: 3),
                Text(
                  'Email',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const CustomSpacer(flex: 1),
                CustomTextField(
                  fillColor: Theme.of(context).primaryColorLight,
                  controller: _emailController,
                ),
                const CustomSpacer(flex: 3),
                Text(
                  'Password',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                const CustomSpacer(flex: 1),
                CustomTextField(
                  fillColor: Theme.of(context).disabledColor.withOpacity(.2),
                  obscure: hidePassword,
                  controller: _passwordController,
                  suffix: PasswordVisibilityIcon(
                    onPressed: toggleVisibility,
                    value: hidePassword,
                  ),
                ),
                const CustomSpacer(flex: 8),
                Button(
                    active: buttonActive,
                    loading: context.watch<LogInViewModel>().loading,
                    text: 'Log In',
                    onPressed: () {
                      loginVM.login(
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim());
                    }),
                const CustomSpacer(flex: 3),
              ]),
            ),
          ),
        );
      },
    );
  }
}
