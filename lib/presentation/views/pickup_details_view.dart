import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class PickupDetails extends StatefulWidget {
  final OrderModel order;
  const PickupDetails({Key? key, required this.order}) : super(key: key);

  @override
  State<PickupDetails> createState() => _PickupDetailsState();
}

class _PickupDetailsState extends State<PickupDetails> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserVM>();
    return ResponsiveWidget(
        scaffoldKey: _scaffoldKey,
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * .92,
            child: const DriverDrawer()),
        builder: (_, size) {
          return Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorLight,
              image: const DecorationImage(
                image: AssetImage('assets/images/white_background.png'),
              ),
            ),
            child: Column(
              children: [
                const CustomSpacer(flex: 7),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _scaffoldKey.currentState!.openDrawer();
                        },
                        child: ImageIcon(
                          const AssetImage('assets/images/hamburger.png'),
                          color: Colors.black,
                          size: 20.h,
                        ),
                      ),
                      Container(
                        height: 38.w,
                        width: 38.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.buttonColor.withOpacity(.7),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: user.profilePic.isEmpty ||
                                    user.profilePic == 'undefined'
                                ? Image.asset(
                                    'assets/images/empty_profile_picture.png',
                                    fit: BoxFit.cover,
                                  ).image
                                : Image.network(user.profilePic).image,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomSpacer(
                  flex: 3,
                ),
                PickupDetailsCard(order: widget.order),
              ],
            ),
          );
        });
  }
}
