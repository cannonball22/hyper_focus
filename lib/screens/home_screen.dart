import 'package:flutter/material.dart';
import '../constants';
import '../screens/courses_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool moreOptions = false;
  int _selectedIndex = 0;
  PageController pageController = PageController();
  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        height: 56,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(14),
            topLeft: Radius.circular(14),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14.0),
            topRight: Radius.circular(14.0),
          ),
          child: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: ""),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/book.png"),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage("assets/icons/file-checked.png"),
                ),
                label: "",
              ),
            ],
            backgroundColor: const Color(0xff2C2C2E),
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xff1F89FD),
            unselectedItemColor: const Color(0xff8E8E93),
            onTap: onTapped,
          ),
        ),
      ),
      body: PageView(
        controller: pageController,
        children: [
          Container(),
          const CoursesScreen(),
          Container(),
        ],
      ),
    );
  }
}
