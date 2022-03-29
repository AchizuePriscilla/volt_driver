import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/handlers/handlers.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/order_view_model.dart';
import 'package:volt_driver/utils/utils.dart';

class PickupDetailsCard extends StatelessWidget {
  final OrderModel order;
  const PickupDetailsCard({
    required this.order,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var orderVM = context.read<OrderVM>();
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
                      icon: Icon(
                        Icons.close,
                        color: Colors.red,
                        size: 24.h,
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
            const CustomSpacer(flex: 2),
            Text(
              order.origin.address,
              softWrap: true,
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            const CustomSpacer(flex: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  orderVM.user.name!,
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
                    orderVM.user.phoneNumber!,
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
                  loading: context.watch<OrderVM>().loading,
                  onPressed: () async {
                    await context.read<OrderVM>().assignOrder(order);
                    await context.read<OrderVM>().getOrderById(order.id);
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
