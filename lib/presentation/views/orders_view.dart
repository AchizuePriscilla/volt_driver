import 'package:flutter/material.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        resizeToAvoidBottomInset: false,
        scaffoldKey: scaffoldKey,
        drawer: SizedBox(
            width: MediaQuery.of(context).size.width * .92,
            child: const DriverDrawer()),
        builder: (context, size) {
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
                          scaffoldKey.currentState!.openDrawer();
                        },
                        child: ImageIcon(
                          const AssetImage('assets/images/hamburger.png'),
                          color: Colors.black,
                          size: 20.h,
                        ),
                      ),
                      Text(
                        'Orders',
                        style: GoogleFonts.lato(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
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
                            image: Image.asset(
                              'assets/images/me.jpg',
                              fit: BoxFit.cover,
                            ).image,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomSpacer(flex: 2),
                Expanded(
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).disabledColor.withOpacity(.46),
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(20),
                        right: Radius.circular(20),
                      ),
                    ),
                    child: ListView.builder(
                        itemCount: 6,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.h, horizontal: 20.w),
                              child: const OrderCard());
                        }),
                  ),
                ),
              ],
            ),
          );
        });
  }
}


