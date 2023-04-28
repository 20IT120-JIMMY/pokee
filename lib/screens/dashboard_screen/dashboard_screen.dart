import 'package:flutter/material.dart';
import 'package:pokee/constants.dart';
import 'package:pokee/helper_network_info.dart';
import 'package:pokee/screens/dashboard_screen/favourite_screen.dart';
import 'package:pokee/screens/dashboard_screen/home_screen.dart';
import 'package:pokee/screens/dashboard_screen/make_users_screen.dart';
import 'package:pokee/screens/dashboard_screen/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  String Uid;
  DashBoardScreen(this.Uid);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  String userToken = "";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  PageController _pageController = PageController();
  int _pageIndex = 0;

  List<Widget>? _screens;

  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  bool singleVendor = false;
  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      MakeUserScreen(),
      FavouriteScreen(),
      ProfileScreen(widget.Uid)
    ];
    NetworkInfo.checkConnectivity(context);
    loaddata();
  }

  void loaddata() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).textTheme.bodyText1?.color,
          showUnselectedLabels: true,
          currentIndex: _pageIndex,
          type: BottomNavigationBarType.fixed,
          items: _getBottomWidget(singleVendor),
          onTap: (int index) {
            _setPage(index);
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens?.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens?[index];
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _barItem(IconData icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: icon != Icons.favorite
          ? Icon(
              icon,
              color: index == _pageIndex
                  ? PrimaryColor
                  : Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.color
                      ?.withOpacity(0.3),
              size: 30,
            )
          : Stack(
              children: [
                Icon(
                  icon,
                  color: index == _pageIndex
                      ? PrimaryColor
                      : Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.color
                          ?.withOpacity(0.3),
                  size: 30,
                ),
                Positioned(
                    top: -3,
                    right: -2,
                    child: Text(
                      "12",
                      style: TextStyle(
                          color: PrimaryColor, fontWeight: FontWeight.w800),
                    ))
              ],
            ),
      label: label,
    );
  }

  void _setPage(int pageIndex) {
    setState(() {
      _pageController.jumpToPage(pageIndex);
      _pageIndex = pageIndex;
    });
  }

  List<BottomNavigationBarItem> _getBottomWidget(bool isSingleVendor) {
    List<BottomNavigationBarItem> _list = [];
    _list.add(_barItem(Icons.home, '', 0));
    _list.add(_barItem(Icons.supervised_user_circle_rounded, '', 1));
    _list.add(_barItem(Icons.favorite, '', 2));
    _list.add(_barItem(Icons.person, '', 3));
    return _list;
  }
}
