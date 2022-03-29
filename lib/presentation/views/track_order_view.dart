import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/shared/custom_back_button.dart';
import 'package:volt_driver/presentation/shared/custom_spacer.dart';
import 'package:volt_driver/presentation/shared/responsive_widget.dart';
import 'package:volt_driver/presentation/shared/track_order_container.dart';

class TrackOrderView extends StatefulWidget {
  final OrderModel order;
  const TrackOrderView({required this.order, Key? key}) : super(key: key);

  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderView> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        resizeToAvoidBottomInset: false,
        builder: (_, size) {
          return Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              image: const DecorationImage(
                  image: AssetImage('assets/images/white_background.png'),
                  fit: BoxFit.cover),
            ),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const CustomSpacer(
                  flex: 10,
                ),
                const Align(
                    alignment: Alignment.topLeft, child: CustomBackButton()),
                const Expanded(child: SizedBox()),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: TrackOrderContainer(
                      order: widget.order,
                    )),
                const CustomSpacer(
                  flex: 10,
                )
              ],
            ),
          );
        });
  }
}
