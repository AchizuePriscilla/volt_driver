import 'package:flutter/material.dart';
import 'package:volt_driver/handlers/handlers.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/utils/utils.dart';

class PickupDetailsCard extends StatelessWidget {
  const PickupDetailsCard({
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
        height: 240.h,
        width: MediaQuery.of(context).size.width * .8,
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
              'QK78',
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            const CustomSpacer(flex: 4),
            Text(
              'Plot 18, Jedidah Street, Enugu',
              softWrap: true,
              style: GoogleFonts.lato(
                  fontWeight: FontWeight.w700, fontSize: 14.sp),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Ade John  ',
                  style: GoogleFonts.lato(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Container(
                  height: 3.h,
                  width: 3.h,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).disabledColor),
                ),
                Text(
                  '  08145518998',
                  style: GoogleFonts.lato(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
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
                  onPressed: () {},
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            const CustomSpacer(flex: 1),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Button(
                  text: 'Decline',
                  onPressed: () {},
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
