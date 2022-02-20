import 'package:flutter/material.dart';
import 'package:volt_driver/handlers/handlers.dart';
import 'package:volt_driver/models/navigation/pickup_details_args.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/utils/utils.dart';

class PickupDetailsCard extends StatelessWidget {
  final Order order;
  const PickupDetailsCard({
    required this.order,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Theme.of(context).primaryColorLight,
      elevation: 3,
      color: Theme.of(context).primaryColorLight,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        // height: 240.h,
        width: MediaQuery.of(context).size.width * .8,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Theme.of(context).primaryColorLight),
        child: Column(
          children: [
            const CustomSpacer(flex: 3),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 18.w,
                    child: Icon(Icons.place_rounded,
                        color: Theme.of(context).primaryColorLight),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                      onPressed: () {
                        locator<NavigationHandler>().goBack();
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.red,
                      )),
                )
              ],
            ),
            const CustomSpacer(flex: 1),
            Text(
              'Pickup',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600, fontSize: 24.sp),
            ),
            Text(
              order.orderNo,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            const CustomSpacer(flex: 4),
            Text(
              order.currentLocation.address,
              softWrap: true,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  order.createdBy,
                  style: GoogleFonts.lato(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  height: 3.h,
                  width: 3.h,
                  margin: EdgeInsets.symmetric(horizontal: 7.w),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).disabledColor),
                ),
                Flexible(
                  child: Text(
                    '  08145518998khdfihjzdfhif',
                    style: GoogleFonts.lato(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const CustomSpacer(flex: 2),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Button(
                  text: 'Accept',
                  onPressed: () {
                    locator<NavigationHandler>().pushNamed(trackOrderViewRoute,
                        arg: PickupDetailsArgs(order));
                  },
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const CustomSpacer(
              flex: 6,
            )
            // const CustomSpacer(flex: 1),
            // Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.w),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(15),
            //     child: Button(
            //       text: 'Decline',
            //       onPressed: () {},
            //       color: Colors.red,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
