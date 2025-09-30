import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/activity_tab/activity_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/calender_tab/calender_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab/home_tab.dart';

import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/home_tab_controller.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/tabs/profile_tab/profile_tab.dart';
import 'package:kod_ghaseel_provider_app/features/home_screen/widgets/wave_shape.dart';

import '../../Utilites/app_assets/assets.dart';
import '../../Utilites/app_style/style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final GlobalKey _bottomNavigationBarKey = GlobalKey();
  Size _bottomNavigationBarSize = Size(0, 0);

  @override
  void initState() {
    super.initState();

    HomeTabController.value.addListener(_onTabChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _getBottomNavigationBarSize());
  }
  void _onTabChanged() {
    if (_selectedIndex != HomeTabController.value.value) {
      setState(() => _selectedIndex = HomeTabController.value.value);
    }
  }

  void _getBottomNavigationBarSize() {
    final RenderBox? bottomNavigationBarRenderBox =
        _bottomNavigationBarKey.currentContext?.findRenderObject()
            as RenderBox?;
    if (bottomNavigationBarRenderBox != null) {
      final bottomNavigationBarSize = bottomNavigationBarRenderBox.size;
      setState(() {
        _bottomNavigationBarSize = bottomNavigationBarSize;
      });
    }
  }

  List<Widget> pages = [
    const HomeTab(),
    const CalenderTab(),
    ActivityTab(),
    const ProfileTab(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadiusGeometry.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black.withAlpha(128), blurRadius: 10),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                topLeft: Radius.circular(24.r),
                topRight: Radius.circular(24.r),
              ),
              child: SizedBox(
                height: 70.h,
                child: BottomNavigationBar(
                  backgroundColor: AppStyle.white,
                  enableFeedback: false,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  type: BottomNavigationBarType.fixed,
                  key: _bottomNavigationBarKey,
                  items: [
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Assets.homeIconSVG,
                        color: _selectedIndex == 0 ? AppStyle.primaryColor : null,
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Assets.calendarIconSVG,
                        color: _selectedIndex == 1 ? AppStyle.primaryColor : null,
                      ),
                      label: 'discount',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        "assets/icons/activity_icon.svg",
                        color: _selectedIndex == 2 ? AppStyle.primaryColor : null,
                      ),
                      label: 'activity',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        Assets.profileIconSVG,
                        color: _selectedIndex == 3 ? AppStyle.primaryColor : null,
                      ),
                      label: 'calendar',
                    ),

                  ],
                  currentIndex: _selectedIndex,
                  onTap: (index) {
                    setState(() {
                      HomeTabController.value.value = index;
                    });
                  },
                ),
              ),
            ),
            AnimatedPositioned(
              duration:  Duration(milliseconds: 350),
              curve: Curves.easeOutCubic,
              bottom: 0,
              right:
                  ((_bottomNavigationBarSize.width / 4) * _selectedIndex) -
                  25.w,
              child:  WaveShape(),
            ),
          ],
        ),
      ),
      body: pages[_selectedIndex],
    );
  }
}
