import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/models/order_list_model.dart';
import 'package:volt_driver/presentation/shared/empty_container.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({Key? key}) : super(key: key);

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    context.read<UserVM>().checkTokenExpiry(() {
      return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: SizedBox(
            height: 30.h,
            child: Center(
              child: Text(
                'Session Expired, please login',
                style: TextStyle(fontSize: 14.sp),
              ),
            ),
          ),
        ),
      );
    });
    context.read<UserVM>().fetchUserDataFromCache();
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserVM>();
    return DefaultTabController(
      length: 2,
      child: ResponsiveWidget(
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
                  const CustomSpacer(flex: 2),
                  TabBar(
                    enableFeedback: false,
                    overlayColor: MaterialStateProperty.resolveWith(
                      (states) => Colors.transparent,
                    ),
                    indicatorPadding: EdgeInsets.symmetric(
                      horizontal: 5.w,
                      vertical: 6.h,
                    ),
                    unselectedLabelColor: Palette.blackColor,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      color: Palette.lightGreen,
                    ),
                    tabs: const [
                      Tab(
                        child: Text("Available orders"),
                      ),
                      Tab(
                        child: Text("Assigned"),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(.46),
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20),
                            ),
                          ),
                          child: FutureBuilder<List<Order>>(
                              future: context.watch<OrderVM>().getAllOrders(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var orders = snapshot.data;

                                  return RefreshIndicator(
                                    onRefresh: () async {
                                      await context
                                          .read<OrderVM>()
                                          .getAllOrders();
                                    },
                                    child: ListView.builder(
                                        itemCount:
                                            orders!.isEmpty ? 1 : orders.length,
                                        itemBuilder: (context, index) {
                                          return orders.isEmpty
                                              ? const EmptyContainer(
                                                  message: 'Available orders')
                                              : OrderCard(
                                                  order: orders[index],
                                                );
                                        }),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                        'Sorry, an error occured, try again'),
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              }),
                        ),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .disabledColor
                                .withOpacity(.46),
                            borderRadius: const BorderRadius.horizontal(
                              left: Radius.circular(20),
                              right: Radius.circular(20),
                            ),
                          ),
                          child: FutureBuilder<List<Order>>(
                              future:
                                  context.watch<OrderVM>().getAssignedOrders(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  var orders = snapshot.data;

                                  return RefreshIndicator(
                                    onRefresh: () async {
                                      await context
                                          .read<OrderVM>()
                                          .getAssignedOrders();
                                    },
                                    child: ListView.builder(
                                        itemCount:
                                            orders!.isEmpty ? 1 : orders.length,
                                        itemBuilder: (context, index) {
                                          return orders.isEmpty
                                              ? const EmptyContainer(
                                                  message: 'Assigned orders')
                                              : OrderCard(
                                                  order: orders[index],
                                                );
                                        }),
                                  );
                                }
                                if (snapshot.hasError) {
                                  return const Center(
                                    child: Text(
                                        'Sorry, an error occured, try again'),
                                  );
                                }
                                return const Center(
                                    child: CircularProgressIndicator());
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
