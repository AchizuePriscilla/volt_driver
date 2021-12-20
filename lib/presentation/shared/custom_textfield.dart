import 'package:flutter/material.dart';
import 'package:volt_driver/presentation/shared/shared.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? label;
  final String? hint;
  final Widget? prefix;
  final Widget? suffix;
  final Function(String)? validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Color? borderColor;
  final Color? hintColor;
  final TextCapitalization textCapitalization;
  final VoidCallback? onTap;
  final Color? fillColor;
  final bool obscure;

  const CustomTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.label,
    this.hint,
    this.prefix,
    this.suffix,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.borderColor,
    this.hintColor,
    this.onTap,
    this.fillColor,
    this.obscure = false,
    this.textCapitalization = TextCapitalization.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      textCapitalization: textCapitalization,
      cursorColor: borderColor,
      style: TextStyle(
        fontSize: 17.sp,
      ),
      obscureText: obscure,
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.disabled,
      textAlign: TextAlign.start,
      keyboardType: keyboardType,
      controller: controller,
      focusNode: focusNode,
      validator: (value) {
        if (validator != null) {
          return validator!(value ?? "");
        }
      },
      decoration: InputDecoration(
        alignLabelWithHint: true,
        labelText: label,
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: suffix,
        filled: true,
        fillColor: fillColor ?? Theme.of(context).primaryColorLight,
        labelStyle: TextStyle(
          fontSize: 16.sp,
          color:
              hintColor ?? Theme.of(context).primaryColorLight.withOpacity(.4),
        ),
        hintStyle: GoogleFonts.poppins(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: hintColor ?? Theme.of(context).disabledColor.withOpacity(.6),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffC7C7C7),
          ),
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffC7C7C7),
          ),
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffC7C7C7),
          ),
          borderRadius: BorderRadius.all(Radius.circular(0)),
        ),
      ),
    );
  }
}
