import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_driver/presentation/theme/palette.dart';

class Button extends StatelessWidget {
  final String text;
  final bool? loading;
  final Function onPressed;
  final bool outlined;
  final bool isSmall;
  final bool active;
  final Size? size;
  final Color? color;
  final bool? isRounded;

  const Button({
    Key? key,
    required this.text,
    this.loading = false,
    required this.onPressed,
    this.outlined = false,
    this.isSmall = false,
    this.active = true,
    this.isRounded = false,
    this.size,
    this.color,
  }) : super(key: key);

  MaterialStateProperty<Size> get minSize => MaterialStateProperty.resolveWith(
        (states) =>
            size ??
            Size(
              300.w,
              38.h,
            ),
      );
  MaterialStateProperty<Size> get smallButtonMinSize =>
      MaterialStateProperty.resolveWith(
        (states) => Size(
          137.w,
          35.h,
        ),
      );

  @override
  Widget build(BuildContext context) {
    Widget child = loading!
        ? CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation(Theme.of(context).primaryColorLight),
          )
        : Text(
            text,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          );
    return outlined
        ? OutlinedButton(
            style: ButtonStyle(
              minimumSize: isSmall ? smallButtonMinSize : minSize,
            ),
            onPressed: () => active ? onPressed() : () {},
            child: child,
          )
        : TextButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.resolveWith((states) => size),
              minimumSize: isSmall ? smallButtonMinSize : minSize,
              foregroundColor: MaterialStateProperty.resolveWith(
                (states) => active
                    ? Theme.of(context).primaryColorLight
                    : Theme.of(context).primaryColorLight.withOpacity(.65),
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (states) =>
                    color ??
                    (active
                        ? Palette.buttonColor
                        : Palette.buttonColor.withOpacity(.6)),
              ),
              shape: isRounded!
                  ? MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ))
                  : null,
            ),
            child: child,
            onPressed: () => active ? onPressed() : () {},
          );
  }
}
