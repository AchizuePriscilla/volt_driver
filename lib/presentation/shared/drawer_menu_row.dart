import 'package:flutter/material.dart';
import 'package:volt_driver/presentation/shared/shared.dart';

class DrawerMenuRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const DrawerMenuRow({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 0.7, color: Theme.of(context).primaryColorLight))),
          child: Column(
            children: [
              const CustomSpacer(
                flex: 2,
              ),
              Row(children: [
                Icon(
                  icon,
                  color: Theme.of(context).primaryColorLight,
                  size: 18.h,
                ),
                const CustomSpacer(
                  flex: 6,
                  horizontal: true,
                ),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColorLight),
                )
              ]),
              const CustomSpacer(
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
