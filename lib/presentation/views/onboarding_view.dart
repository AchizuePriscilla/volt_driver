import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:volt_driver/presentation/shared/shared.dart';
import 'package:volt_driver/presentation/viewmodels/viewmodels.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  _OnboardingViewState createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  TabController? tabController;
  // int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<OnboardingVM>().initState(_pageController);
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var onboardingVM = context.read<OnboardingVM>();

    return ResponsiveWidget(builder: (context, size) {
      return Container(
        color: Theme.of(context).primaryColor,
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                PageView.builder(
                  physics: const ClampingScrollPhysics(),
                  controller: onboardingVM.pageController,
                  // reverse: true,
                  onPageChanged: (index) {
                    onboardingVM.changePage(index);
                    setState(() {
                      onboardingVM.currentIndex = index;
                      tabController!.index = onboardingVM.currentIndex;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return _pages[index % _pages.length];
                  },
                  itemCount: _pages.length,
                ),
                Positioned(
                  bottom: 60.h,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              var index = onboardingVM.currentIndex + 1;
                              onboardingVM.changePage(
                                  index, index == 3 ? true : false);
                            });
                          },
                          child: SizedBox(
                            height: 55,
                            width: 55,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CircularProgressIndicator(
                                  strokeWidth: 3,
                                  value: onboardingVM.currentIndex == 0
                                      ? 0.3
                                      : onboardingVM.currentIndex / 2,
                                  backgroundColor: Theme.of(context)
                                      .primaryColorLight
                                      .withOpacity(.4),
                                  color: Theme.of(context).primaryColorLight,
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Theme.of(context)
                                              .primaryColorLight),
                                      child: Center(
                                        child: Icon(Icons.arrow_forward_ios,
                                            size: 15.h),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const CustomSpacer(flex: 2),
                      Align(
                        alignment: Alignment.center,
                        child: TabPageSelector(
                          controller: tabController,
                          color: Theme.of(context)
                              .primaryColorLight
                              .withOpacity(.4),
                          selectedColor: Theme.of(context).primaryColorLight,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
      );
    });
  }
}

class _Pages extends StatelessWidget {
  final String header;
  final String subText1;
  final String subText2;
  final String imagePath;
  const _Pages({
    Key? key,
    required this.header,
    required this.subText1,
    required this.subText2,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const CustomSpacer(flex: 20),
          Container(
            height: 230.h,
            child: Image.asset('assets/images/$imagePath.png'),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
          ),
          const CustomSpacer(flex: 10),
          Text(header,
              style: GoogleFonts.lato(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).primaryColorLight,
              )),
          const CustomSpacer(flex: 3),
          Text(
            subText1,
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          Text(
            subText2,
            style: GoogleFonts.lato(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ],
      ),
    );
  }
}

final List<Widget> _pages = <Widget>[
  const _Pages(
    header: 'Welcome to Volt laundry',
    subText1: 'App that will help you make orders',
    subText2: 'and get them delivered',
    imagePath: 'volt_laundry',
  ),
  const _Pages(
    header: 'Track your orders',
    subText1: 'App that will help you make orders',
    subText2: 'and get them delivered',
    imagePath: 'track_orders',
  ),
  const _Pages(
    header: 'Instant delivery',
    subText1: 'App that will help you make orders',
    subText2: 'and get them delivered',
    imagePath: 'instant_orders',
  ),
];
