import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/models/top.dart';
import 'package:diaryapp/screens/login.dart';
import 'package:diaryapp/widgets/custom_app_bar.dart';
import 'package:diaryapp/widgets/home_shop.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  // late User user;

  // const HomePage({required this.user});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var selected = 0;
  final pageController = PageController();

  final diary = Diary.generateDiary();

  void selectOrderSummary(BuildContext context) {
    Navigator.of(context).pushNamed('/order_summary');
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, User>;
    var user = routeArgs['user'];
    return Scaffold(
      backgroundColor: kBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(
            Icons.arrow_back_ios_outlined,
            Icons.search_outlined,
          ),
          // HomeShop(),
          ProdList(selected, (int index) {
            setState(() {
              selected = index;
            });
            pageController.jumpToPage(index);
          }, diary),
          Expanded(
              child: ProdListView(
            selected,
            (int index) {
              setState(() {
                selected = index;
              });
            },
            pageController,
            diary,
          )),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            height: 60,
            child: SmoothPageIndicator(
              controller: pageController,
              count: diary.menu.length,
              effect: CustomizableEffect(
                  dotDecoration: DotDecoration(
                      width: 8,
                      height: 8,
                      color: Colors.grey.withOpacity((0.5)),
                      borderRadius: BorderRadius.circular(8)),
                  activeDotDecoration: DotDecoration(
                      width: 10,
                      height: 10,
                      color: kBackground,
                      borderRadius: BorderRadius.circular(10),
                      dotBorder: const DotBorder(
                          color: kPrimaryColor, padding: 2, width: 2))),
              onDotClicked: (index) => pageController.jumpToPage(index),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: const Text('Sign out'))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => selectOrderSummary(context),
        backgroundColor: kPrimaryColor,
        elevation: 2,
        child: const Icon(
          Icons.shopping_bag_outlined,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }
}
