import 'package:flutter/material.dart';
import 'package:volt_driver/presentation/shared/shared.dart';

class EmptyContainer extends StatelessWidget {
  const EmptyContainer({
    Key? key,
    required this.message,
  }) : super(key: key);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
     
      Center(
        child: SizedBox(
          child: Image.asset('assets/images/oops.png'),
        ),
      ),
      Text(
        'Oops!',
        style:
            GoogleFonts.lato(fontSize: 24.sp, fontWeight: FontWeight.w900),
      ),
      const CustomSpacer(
        flex: 1,
      ),
      Text(
        'No $message found at this time',
        style:
            GoogleFonts.lato(fontSize: 17.sp, fontWeight: FontWeight.w500),
      )
    ]);
  }
}
