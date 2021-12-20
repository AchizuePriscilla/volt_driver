import 'package:flutter/material.dart';
import 'package:volt_driver/handlers/navigation_handler.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/utils/constants.dart';
import 'package:volt_driver/utils/locator.dart';

class SupportContainer extends StatelessWidget {
  const SupportContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        locator<NavigationHandler>().pushNamed(chatViewRoute);
      },
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColorLight,
            borderRadius: BorderRadius.circular(10.w)),
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CustomSpacer(
                flex: 2,
                horizontal: true,
              ),
              Container(
                height: 35.h,
                width: 35.h,
                decoration: BoxDecoration(
                    color: Palette.buttonColor.withOpacity(.2),
                    shape: BoxShape.circle),
                child: Icon(Icons.headset_mic_outlined,
                    color: const Color(0xff0B74E5), size: 20.h),
              ),
              const CustomSpacer(
                flex: 2,
                horizontal: true,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'How can we help you?',
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    Text(
                      'Chat with or call us',
                      style: TextStyle(
                          color: const Color(0xff808089), fontSize: 12.sp),
                    )
                  ]),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {
                  locator<NavigationHandler>().pushNamed(chatViewRoute);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color(0xff808089),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
