import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/handlers/handlers.dart';
import 'package:volt_driver/models/navigation/pickup_details_args.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/string_utils.dart';
import 'package:volt_driver/utils/utils.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({
    required this.order,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // height: 140.h,
      width: size.width * .7,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 30.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColorLight),
      child: Column(
        children: [
          const CustomSpacer(flex: 3),
          Text(
            'Order Number',
            style:
                GoogleFonts.lato(fontWeight: FontWeight.w300, fontSize: 14.sp),
          ),
          const CustomSpacer(flex: 1),
          Text(
            order.orderNo,
            style:
                GoogleFonts.lato(fontWeight: FontWeight.w700, fontSize: 36.sp),
          ),
          const CustomSpacer(flex: 1),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.watch_later, size: 18),
            const CustomSpacer(
              flex: 1,
              horizontal: true,
            ),
            Text(
              StringUtils.getTimeAgo(order.createdAt),
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w300, fontSize: 12.sp),
            )
          ]),
          const CustomSpacer(flex: 2),
          Container(
            height: 35.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Button(
              text: 'View Order',
              active: !context.watch<OrderVM>().loading,
              onPressed: () async {
                await context.read<OrderVM>().getUserById(order.createdBy);
                
                var success =
                    await context.read<OrderVM>().getOrderById(order.id);
                if (success) {
                  order.assignedTo == ''
                      ? locator<NavigationHandler>().pushNamed(
                          pickupDetailsViewRoute,
                          arg: PickupDetailsArgs(order: order))
                      : locator<NavigationHandler>().pushNamed(
                          trackOrderViewRoute,
                          arg: PickupDetailsArgs(order: order));
                }
              },
              color: Palette.lightGreen,
            ),
          ),
          const CustomSpacer(
            flex: 4,
          )
        ],
      ),
    );
  }
}
