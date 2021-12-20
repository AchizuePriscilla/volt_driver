import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFields extends StatefulWidget {
  final StreamController<ErrorAnimationType> errorController;
  final TextEditingController controller;
  final Function(String) validator;
  final int length;
  final bool hasError;
  const PinCodeFields({
    Key? key,
    required this.controller,
    required this.validator,
    required this.errorController,
    this.hasError = false,
    this.length = 4,
  }) : super(key: key);

  @override
  _PinCodeFieldsState createState() => _PinCodeFieldsState();
}

class _PinCodeFieldsState extends State<PinCodeFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
      child: PinCodeTextField(
        autovalidateMode: AutovalidateMode.disabled,
        appContext: context,
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        pastedTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        length: widget.length,
        animationType: AnimationType.fade,
        validator: (v) {
          return widget.validator(v!);
        },
        pinTheme: PinTheme(
          selectedColor: Theme.of(context).primaryColor.withOpacity(.2),
          selectedFillColor: const Color(0xffBAE6FF).withOpacity(.3),
          inactiveColor: const Color(0xffBAE6FF).withOpacity(.5),
          inactiveFillColor: const Color(0xffBAE6FF).withOpacity(.4),
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(10.h),
          fieldHeight: 40.h,
          fieldWidth: 50.w,
          activeColor: widget.hasError
              ? Theme.of(context).errorColor
              : Theme.of(context).primaryColor.withOpacity(.8),
          activeFillColor: widget.hasError
              ? Theme.of(context).errorColor
              : Theme.of(context).primaryColor.withOpacity(.8),
        ),
        cursorColor: Theme.of(context).primaryColor,
        animationDuration: const Duration(milliseconds: 300),
        enableActiveFill: true,
        errorAnimationController: widget.errorController,
        controller: widget.controller,
        keyboardType: TextInputType.number,
        onChanged: (value) {},
        beforeTextPaste: (text) {
          return true;
        },
      ),
    );
  }
}
