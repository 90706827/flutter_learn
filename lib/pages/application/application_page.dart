import 'package:flutter/material.dart';

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
  final List<String> tabTitles =[
    "欢迎",
    "栏目",
    "书包",
    "我的",
  ];
  //页控制器
  PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ,
      body: ,
      bottomNavigationBar: ,
    );
  }
  Widget buildAppBar(){
    return
  }

}
