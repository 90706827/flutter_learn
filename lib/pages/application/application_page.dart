import 'package:flutter/material.dart';
import 'package:flutter_learn/common/widgets/AppBar.dart';
import 'package:flutter_learn/config/IconParam.dart';
import 'package:flutter_learn/config/app_colors.dart';
import 'package:flutter_learn/pages/account/account_page.dart';
import 'package:flutter_learn/pages/bookmarks/bookmarks_page.dart';
import 'package:flutter_learn/pages/category/category_page.dart';
import 'package:flutter_learn/pages/main/main_page.dart';
import 'package:flutter_learn/utils/screen.dart';

class ApplicationPage extends StatefulWidget {
  ApplicationPage({Key key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage>
    with SingleTickerProviderStateMixin {
  //当前 tab
  int tab = 0;

  // tab 标题
  final List<String> tabTitles = [
    "欢迎",
    "栏目",
    "书包",
    "我的",
  ];

  //页控制器
  PageController pageController;

  final List<BottomNavigationBarItem> bottomTabs = <BottomNavigationBarItem>[
    new BottomNavigationBarItem(
        icon: Icon(IconParam.home, color: AppColors.tabBarElement),
        activeIcon: Icon(IconParam.home, color: AppColors.secondaryElementText),
        label: "主页",
        backgroundColor: AppColors.primaryBackground),
    new BottomNavigationBarItem(
      icon: Icon(IconParam.grid, color: AppColors.tabBarElement),
      activeIcon: Icon(IconParam.grid, color: AppColors.secondaryElementText),
      label: "栏目",
      backgroundColor: AppColors.primaryBackground,
    ),
    new BottomNavigationBarItem(
      icon: Icon(
        IconParam.tag,
        color: AppColors.tabBarElement,
      ),
      activeIcon: Icon(
        IconParam.tag,
        color: AppColors.secondaryElementText,
      ),
      label: "书籍",
      backgroundColor: AppColors.primaryBackground,
    ),
    new BottomNavigationBarItem(
      icon: Icon(IconParam.me, color: AppColors.tabBarElement),
      activeIcon: Icon(IconParam.me, color: AppColors.secondaryElementText),
      label: "我的",
      backgroundColor: AppColors.primaryBackground,
    ),
  ];

  @override
  void initState() {
    super.initState();
    pageController = new PageController(initialPage: this.tab);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildPage(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  //内容页
  Widget buildPage() {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        MainPage(),
        CategoryPage(),
        BookmarksPage(),
        AccountPage(),
      ],
      controller: pageController,
      onPageChanged: handlePageChanged,
    );
  }

  //tab栏页码切换
  void handlePageChanged(int tab) {
    setState(() {
      this.tab = tab;
    });
  }

  //底部导航
  Widget buildBottomNavigationBar() {
    return BottomNavigationBar(
      items: bottomTabs,
      currentIndex: tab,
      type: BottomNavigationBarType.fixed,
      onTap: handleNavBarTap,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }

  // tab栏动画
  void handleNavBarTap(int index) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  //顶部导航
  Widget buildAppBar() {
    return transparentAppBar(
      context: context,
      title: Text(
        tabTitles[tab],
        style: TextStyle(
          color: AppColors.primaryText,
          fontFamily: 'Montserrat',
          fontSize: setFontSize(18.0),
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.search,
            color: AppColors.primaryText,
          ),
          onPressed: () {
            print('search');
          },
        ),
      ],
    );
  }
}
