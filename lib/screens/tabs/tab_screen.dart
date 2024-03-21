import 'package:fire_base_example/screens/tabs/browse_screen/browse_screen.dart';
import 'package:fire_base_example/screens/tabs/home_screen/home_screen.dart';
import 'package:fire_base_example/screens/tabs/order_history/order_history.dart';
import 'package:fire_base_example/screens/tabs/product_screen/product_screen.dart';
import 'package:fire_base_example/screens/tabs/profile_screen/profile_screen.dart';
import 'package:fire_base_example/utils/colors/colors.dart';
import 'package:fire_base_example/utils/images/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../view_models/tab_view_model.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Widget> screens = [
    HOmeScreen(),
    BrowseScreen(),
    ProductScreen(),
    OrderHistory(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[context.watch<TabViewModel>().getIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: context.watch<TabViewModel>().getIndex,
        onTap: (newIndex) {
          context.read<TabViewModel>().changeIndex(newIndex);
        },
        items:  [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.home),
            label: "Home",
            activeIcon: SvgPicture.asset(AppImages.home,color: AppColors.main,),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.search),
            label: "Browse",
            activeIcon: SvgPicture.asset(AppImages.search,color: AppColors.main,),
          ), BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.store),
            label: "Store",
            activeIcon: SvgPicture.asset(AppImages.store,color: AppColors.main,),
          ),
          BottomNavigationBarItem(
            icon:SvgPicture.asset(AppImages.order),
            label: "Order history",
            activeIcon: SvgPicture.asset(AppImages.order,color: AppColors.main,),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(AppImages.profile),
            label: "Profile",
            activeIcon:SvgPicture.asset(AppImages.profile,color: AppColors.main,),
          )
        ],
      ),
    );
  }
}
