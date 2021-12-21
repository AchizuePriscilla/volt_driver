import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volt_driver/presentation/shared/custom_spacer.dart';
import 'package:volt_driver/presentation/shared/responsive_widget.dart';
import 'package:volt_driver/presentation/shared/track_order_container.dart';

class TrackOrderView extends StatefulWidget {
  const TrackOrderView({Key? key}) : super(key: key);

  @override
  _TrackOrderPageState createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderView> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(builder: (_, size) {
      return Container(
        height: size.height,
        width: size.width,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          image: const DecorationImage(
            image: AssetImage('assets/images/white_background.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            TrackOrderContainer(),
            CustomSpacer(
              flex: 10,
            )
          ],
        ),
      );
    });
  }
}
