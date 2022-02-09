import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class TrackOrderContainer extends StatefulWidget {
  const TrackOrderContainer({Key? key}) : super(key: key);

  @override
  State<TrackOrderContainer> createState() => _TrackOrderContainerState();
}

class _TrackOrderContainerState extends State<TrackOrderContainer> {
  bool phoneIconVisible = false;
  int index = 1;
  String getText(int num) {
    switch (num) {
      case 1:
        return 'Start Pickup';
      case 2:
        return 'Arrived at Pickup';
      case 3:
        return 'Pickup';

      default:
        return 'default';
    }
  }

  @override
  Widget build(BuildContext context) {
    var trackOrderVM = context.read<OrderVM>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            Material(
              elevation: 6,
              shadowColor: Colors.white,
              child: Container(
                padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 25.h),
                color: Colors.white,
                height: 180.h,
                width: MediaQuery.of(context).size.width * .65,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 15.w,
                        right: 15.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Name:  ',
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: 'Ade John',
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                          ),
                          const CustomSpacer(
                            flex: 3,
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Order No.  ',
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: 'QK78',
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                          ),
                          const CustomSpacer(
                            flex: 3,
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Address:  ',
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: 'Plot 18, Jeddiah Estate Enugu',
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ]),
                          ),
                          const CustomSpacer(
                            flex: 3,
                          ),
                          Text.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: 'Phone No.  ',
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: '081455189998',
                                style: GoogleFonts.lato(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Button(
                        text: getText(index),
                        onPressed: () {
                          setState(() {
                            index++;
                            if (index == 4) {
                              trackOrderVM.showPickedUpDialog();
                              index = 1;
                            }
                          });
                        },
                        size: Size(
                          350.w,
                          38.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: index == 2 ? true : false,
              child: Positioned(
                top: -15.h,
                left: MediaQuery.of(context).size.width * .325 - 13.h,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 36.h,
                    width: 36.h,
                    decoration: const BoxDecoration(
                      color: Palette.buttonColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.phone_in_talk_outlined,
                      color: Theme.of(context).primaryColorLight,
                      size: 22.h,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const CustomSpacer(
          flex: 2,
          horizontal: true,
        ),
        Column(
          children: [
            Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 6,
              shadowColor: Theme.of(context).primaryColorLight,
              child: Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.add,
                  size: 25.h,
                ),
              ),
            ),
            const CustomSpacer(
              flex: 5,
            ),
            Material(
              borderRadius: BorderRadius.circular(10),
              elevation: 6,
              shadowColor: Theme.of(context).primaryColorLight,
              child: Container(
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColorLight,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.remove,
                  size: 25.h,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
