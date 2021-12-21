import 'package:flutter/material.dart';
import 'package:volt_driver/models/dialog/dialog_request.dart';
import 'package:volt_driver/presentation/shared/shared.dart';

class PickedUpDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(bool) dismissDialog;
  const PickedUpDialog({
    Key? key,
    required this.request,
    required this.dismissDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTapDown: (details) {
        //do nothing if dialog is not dismissable
        if (!request.dismissable) return;

        var screenOffset = details.localPosition;
        var dialogCardHeight = dialogContainerKey.currentContext!.size!.height;

        //dismiss dialog if user taps on any screen area outside the dimensions of the dialog

        if (screenOffset.dy < (height - dialogCardHeight) / 2 ||
            screenOffset.dy > (height + dialogCardHeight) / 2) {
          dismissDialog(false);
        }
        if (screenOffset.dx < dialogMargin ||
            screenOffset.dx > (width - dialogMargin)) {
          dismissDialog(false);
        }
      },
      child: Material(
        color: Theme.of(context).primaryColorLight.withOpacity(.75),
        elevation: 10,
        child: SizedBox(
          height: height,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                key: dialogContainerKey,
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * .6,
                    minHeight: MediaQuery.of(context).size.height * .3),
                margin: EdgeInsets.symmetric(horizontal: dialogMargin),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).dialogTheme.backgroundColor,
                  borderRadius: BorderRadius.circular(30.w),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CustomSpacer(
                      flex: 5,
                    ),
                    Text(
                      request.message,
                      style: GoogleFonts.lato(
                          fontSize: 48.sp,
                          fontWeight: FontWeight.w600,
                          color: Palette.buttonColor),
                    ),
                    const CustomSpacer(
                      flex: 10,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Button(
                        onPressed: () => dismissDialog(false),
                        text: 'Close',
                        color: Palette.lightGreen,
                        isRounded: true,
                      ),
                    ),
                    const CustomSpacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
