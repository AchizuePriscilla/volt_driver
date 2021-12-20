import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';
import 'package:volt_driver/utils/constants.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginVM = context.read<LogInViewModel>();
    return ResponsiveWidget(
        appBar: CustomAppBar(),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  'Password Reset',
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.w600, fontSize: 24.sp),
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                const CustomTextField(
                  hint: 'Enter Email',
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                Button(
                    text: 'Reset',
                    onPressed: () {
                      loginVM.navigateToRoute(resetPasswordViewRoute);
                    })
              ],
            ),
          );
        });
  }
}
