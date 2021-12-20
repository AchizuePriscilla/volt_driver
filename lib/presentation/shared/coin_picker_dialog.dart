import 'package:flutter/material.dart';
import 'package:volt_driver/models/dialog/dialog_request.dart';
import 'package:volt_driver/presentation/shared/shared.dart';

class CoinPickerDialog extends StatelessWidget {
  final DialogRequest request;
  final Function(bool) dismissDialog;
  const CoinPickerDialog({
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
                constraints: BoxConstraints(
                    minWidth: MediaQuery.of(context).size.width * .3,
                    minHeight: MediaQuery.of(context).size.height * .3),
                margin: EdgeInsets.symmetric(horizontal: dialogMargin),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(30.w),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 33.h,
                            width: 33.h,
                            child: Image.asset(
                                'assets/images/volt_coin_yellow.png'),
                          ),
                          const CustomSpacer(
                            flex: 1,
                            horizontal: true,
                          ),
                          Text(
                            'Volt Coin',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Radio(
                              value: 1,
                              toggleable: true,
                              groupValue: 1,
                              onChanged: (value) => dismissDialog(false),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 33.h,
                            width: 33.h,
                            child: Image.asset(
                                'assets/images/volt_coin_yellow.png'),
                          ),
                          const CustomSpacer(
                            flex: 1,
                            horizontal: true,
                          ),
                          Text(
                            'Volt Naira Coin',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Radio(
                              value: 1,
                              toggleable: true,
                              groupValue: 1,
                              onChanged: (value) => dismissDialog(false),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 33.h,
                            width: 33.h,
                            child: Image.asset(
                                'assets/images/volt_coin_yellow.png'),
                          ),
                          const CustomSpacer(
                            flex: 1,
                            horizontal: true,
                          ),
                          Text(
                            'Naira',
                            style: GoogleFonts.lato(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Radio(
                              value: 1,
                              toggleable: true,
                              groupValue: 1,
                              onChanged: (value) => dismissDialog(false),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap),
                        ],
                      ),
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
