import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  @override
  Widget build(BuildContext context) {
    var signUpVM = context.read<SignUpViewModel>();
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
                    'Create your volt account',
                    style: GoogleFonts.poppins(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const CustomSpacer(flex: 3),
                CustomTextField(
                  fillColor: Theme.of(context).primaryColorLight,
                  prefix: Icon(
                    Icons.person_outlined,
                    color: Theme.of(context).disabledColor.withOpacity(.6),
                  ),
                  hint: 'Full Name',
                ),
                const CustomSpacer(flex: 3),
                CustomTextField(
                  fillColor: Theme.of(context).primaryColorLight,
                  prefix: Icon(
                    Icons.mail_outline,
                    color: Theme.of(context).disabledColor.withOpacity(.6),
                  ),
                  hint: 'Email',
                ),
                const CustomSpacer(flex: 3),
                CustomTextField(
                  fillColor: Theme.of(context).primaryColorLight,
                  prefix: Icon(
                    Icons.lock_outline,
                    color: Theme.of(context).disabledColor.withOpacity(.6),
                  ),
                  hint: 'Password',
                ),
                const CustomSpacer(flex: 3),
                Button(
                    text: 'Sign Up',
                    onPressed: () {
                      signUpVM.navigateToLogInView();
                    }),
                const CustomSpacer(flex: 3),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const CustomSpacer(
                      horizontal: true,
                      flex: 0.3,
                    ),
                    GestureDetector(
                      onTap: () {
                        signUpVM.navigateToLogInView();
                      },
                      child: Text(
                        'Sign in Here',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Palette.orangeColor,
                        ),
                      ),
                    ),
                    const CustomSpacer(flex: 20),
                  ],
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}
