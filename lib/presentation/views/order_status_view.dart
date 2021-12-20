import 'package:flutter/material.dart';
import 'package:volt_driver/presentation/shared/shared.dart';

class OrderStatusView extends StatefulWidget {
  const OrderStatusView({Key? key}) : super(key: key);

  @override
  _OrderStatusViewState createState() => _OrderStatusViewState();
}

class _OrderStatusViewState extends State<OrderStatusView> {
  bool isDropdownVisible = true;
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
        appBar: CustomAppBar(
          text: 'Order Status',
        ),
        builder: (_, size) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Progress Status',
                    style: GoogleFonts.lato(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Palette.blackColor),
                  ),
                ),
                const CustomSpacer(
                  flex: 2,
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                        },
                        child: OrderStatusDropdown(
                          isDropdownVisible:
                              selectedIndex == index ? true : false,
                          orderNo: 'Qi08208',
                        ),
                      );
                    },
                    itemCount: 4,
                  ),
                ),
              ],
            ),
          );
        });
  }
}

class OrderStatusDropdown extends StatelessWidget {
  const OrderStatusDropdown(
      {Key? key, required this.isDropdownVisible, required this.orderNo})
      : super(key: key);

  final bool isDropdownVisible;
  final String orderNo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.w),
            color: Palette.lightBlue,
          ),
          margin: EdgeInsets.symmetric(vertical: 5.h),
          padding: EdgeInsets.all(5.h),
          child: Row(
            children: [
              const CustomSpacer(
                flex: 5,
                horizontal: true,
              ),
              Text(
                'Order No',
                style: GoogleFonts.lato(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const CustomSpacer(flex: 2, horizontal: true),
              Text(
                orderNo,
                style: GoogleFonts.lato(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const Expanded(child: SizedBox()),
              IconButton(
                onPressed: () {},
                icon: Icon(
                    isDropdownVisible
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 22.h),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isDropdownVisible,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OrderStageContainer(
                imagePath: 'bike',
                orderStage: 'Order Picked',
              ),
              Row(
                children: [
                  const CustomSpacer(flex: 6, horizontal: true),
                  Container(
                    height: 35.h,
                    width: 1,
                    color: Theme.of(context).disabledColor,
                  ),
                ],
              ),
              const OrderStageContainer(
                imagePath: 'wash',
                orderStage: 'Cleaning',
              ),
              Row(
                children: [
                  const CustomSpacer(flex: 6, horizontal: true),
                  Container(
                    height: 35.h,
                    width: 1,
                    color: Theme.of(context).disabledColor,
                  ),
                ],
              ),
              const OrderStageContainer(
                imagePath: 'bike',
                orderStage: 'Courier is on the way',
                hasArrivalTime: true,
              ),
              const CustomSpacer(
                flex: 2,
              ),
              Row(children: [
                CircleAvatar(
                  radius: 27.w,
                  backgroundImage: const AssetImage('assets/images/me.jpg'),
                ),
                const CustomSpacer(flex: 2, horizontal: true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Paul David',
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Courier',
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),
                const Expanded(child: SizedBox()),
                Text(
                  'Close',
                  style: GoogleFonts.lato(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: Theme.of(context).primaryColor),
                ),
              ]),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '08145518998',
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const CustomSpacer(flex: 2),
                    Text(
                      'Black in complexion',
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const CustomSpacer(flex: 2),
                    Text(
                      'Tall',
                      style: GoogleFonts.lato(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class OrderStageContainer extends StatelessWidget {
  final String imagePath;
  final String orderStage;
  final bool? hasArrivalTime;
  const OrderStageContainer(
      {Key? key,
      required this.imagePath,
      required this.orderStage,
      this.hasArrivalTime = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(15.w),
          margin: EdgeInsets.symmetric(vertical: 2.h),
          height: 50.h,
          width: 50.h,
          decoration: BoxDecoration(
            color: Palette.buttonColor,
            borderRadius: BorderRadius.circular(10.w),
          ),
          child: Image.asset('assets/images/volt_$imagePath.png'),
        ),
        const CustomSpacer(flex: 3, horizontal: true),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              orderStage,
              style: GoogleFonts.lato(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: Palette.blackColor),
            ),
            if (hasArrivalTime!)
              Text(
                'Arrival is in 5 minutes',
                style: GoogleFonts.lato(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                    color: Palette.blackColor),
              ),
          ],
        ),
      ],
    );
  }
}
