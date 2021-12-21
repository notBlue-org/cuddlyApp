import 'package:diaryapp/constants/colors.dart';
import 'package:diaryapp/models/top.dart';
import 'package:diaryapp/widgets/diary_item.dart';
import 'package:flutter/material.dart';

class HomeShop extends StatelessWidget {
  final diary = Diary.generateDiary();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(diary.name,
                        style: TextStyle(
                            fontSize: 55.0, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            )
          ],
        ));
  }
}

class ProdList extends StatelessWidget {
  final int selected;
  final Function callback;
  final Diary diary;
  ProdList(this.selected, this.callback, this.diary);
  @override
  Widget build(BuildContext context) {
    final category = diary.menu.keys.toList();
    return Container(
        height: 100,
        padding: EdgeInsets.symmetric(vertical: 30),
        child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 25),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
                  onTap: () => callback(index),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color:
                              selected == index ? kPrimaryColor : Colors.white),
                      child: Text(category[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                ),
            separatorBuilder: (_, index) => SizedBox(width: 20),
            itemCount: category.length));
  }
}

class ProdListView extends StatelessWidget {
  final int selected;
  final Function callback;
  final PageController pageController;
  final Diary diary;

  ProdListView(this.selected, this.callback, this.pageController, this.diary);
  @override
  Widget build(BuildContext context) {
    final category = diary.menu.keys.toList();
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: PageView(
          controller: pageController,
          onPageChanged: (index) => callback(index),
          children: category
              .map((e) => ListView.separated(
                  itemBuilder: (context, index) =>
                      diaryItem(diary.menu[category[selected]]![index]),
                  separatorBuilder: (_, index) => SizedBox(height: 15),
                  itemCount: diary.menu[category[selected]]!.length))
              .toList(),
        ));
  }
}
