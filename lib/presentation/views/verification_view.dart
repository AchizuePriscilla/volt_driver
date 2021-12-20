import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/constants.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({Key? key}) : super(key: key);

  @override
  _VerificationViewState createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final TextEditingController _controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  // ignore: close_sinks
  StreamController<ErrorAnimationType>? _errorController;
  final bool _hasError = false;
  bool buttonActive = false;

  void onListen() {
    if (_controller.text.length < 4) {
      setState(() {
        buttonActive = false;
      });
    } else {
      setState(() {
        buttonActive = true;
      });
    }
  }

  @override
  void initState() {
    _errorController = StreamController<ErrorAnimationType>();
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback(
      (timeStamp) {
        context.read<VerificationViewModel>().startTimer();
      },
    );

    _controller.addListener(onListen);
  }

  @override
  void dispose() {
    _errorController!.close();
    _controller.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var verificationVM = context.read<VerificationViewModel>();
    return ResponsiveWidget(
      builder: (_, size) {
        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Container(
              height: size.height,
              width: size.width,
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  const CustomSpacer(flex: 25),
                  Text(
                    context.watch<VerificationViewModel>().getTime,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Palette.buttonColor,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const CustomSpacer(flex: 3),
                  Text(
                    "Enter the verification code \nwe've sent you",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w400,
                        color: Theme.of(context).disabledColor),
                  ),
                  const CustomSpacer(flex: 3),
                  PinCodeFields(
                      hasError: _hasError,
                      errorController: _errorController!,
                      controller: _controller,
                      validator: (val) {
                        if (val.length < 4) {
                          return 'Enter code';
                        }
                        return null;
                      }),
                  const CustomSpacer(flex: 3),
                  Text(
                    "Resend Code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: verificationVM.active
                          ? Theme.of(context).disabledColor.withOpacity(.7)
                          : Theme.of(context).primaryColor,
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const CustomSpacer(flex: 3),
                  Button(
                    text: 'Next',
                    onPressed: () {
                      verificationVM.navigateToRoute(signUpViewRoute);
                    },
                    isSmall: true,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
