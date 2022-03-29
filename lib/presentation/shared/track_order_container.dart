import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class TrackOrderContainer extends StatefulWidget {
  final OrderModel order;
  const TrackOrderContainer({Key? key, required this.order}) : super(key: key);

  @override
  State<TrackOrderContainer> createState() => _TrackOrderContainerState();
}

class _TrackOrderContainerState extends State<TrackOrderContainer> {
  bool phoneIconVisible = false;
  String getText(String status) {
    switch (status) {
      case 'ASSIGNED':
        return 'Start Pickup';
      case 'DELIVERING':
        return 'Arrived at Pickup';
      case 'ARRIVED':
        return 'Pickup';

      default:
        return 'Pick up';
    }
  }

  String getStatus(String status) {
    switch (status) {
      case 'ASSIGNED':
        return 'DELIVERING';
      case 'DELIVERING':
        return 'ARRIVED';
      case 'ARRIVED':
        return 'DELIVERED';

      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    var trackOrderVM = context.read<OrderVM>();
    var rxtrackOrderVM = context.watch<OrderVM>();
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
                height: 200.h,
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
                                text: trackOrderVM.user.name,
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
                                text: widget.order.orderNo,
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
                                text: widget.order.origin.address,
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
                                text: trackOrderVM.user.phoneNumber,
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
                        text: getText(rxtrackOrderVM.order.status),
                        loading: rxtrackOrderVM.loading,
                        onPressed: () {
                          trackOrderVM.updateOrderStatus(
                              orderId: widget.order.id,
                              status: getStatus(rxtrackOrderVM.order.status));
                        },
                        size: Size(
                          350.w,
                          35.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible:
                  rxtrackOrderVM.order.status == 'DELIVERING' ? true : false,
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
