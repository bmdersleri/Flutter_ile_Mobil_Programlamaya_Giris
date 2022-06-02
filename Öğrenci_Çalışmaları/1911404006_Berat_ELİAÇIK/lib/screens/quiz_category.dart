import 'package:flutter/material.dart';
import 'package:projemmmm/models/category.dart';
import 'package:projemmmm/screens/quiz_category_details.dart';

import '../common/theme_helper.dart';
import '../stores/quiz_store.dart';

class QuizCategoryScreen extends StatefulWidget {
  static const routeName = '/quizCategory';
  const QuizCategoryScreen({Key? key}) : super(key: key);

  @override
  _QuizCategoryScreenState createState() => _QuizCategoryScreenState();
}

class _QuizCategoryScreenState extends State<QuizCategoryScreen> {
  late List<Category> categoryList = [];
  @override
  void initState() {
    var quizStore = QuizStore();
    quizStore.loadCategoriesAsync().then((value) {
      setState(() {
        categoryList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          alignment: Alignment.center,
          decoration: ThemeHelper.fullScreenBgBoxDecoration(),
          child: Column(
            children: [
              screenHeader(),
              Expanded(
                child: categoryListView(categoryList),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget screenHeader() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          GestureDetector(
            child: Image(
              image: AssetImage("assets/icons/back.png"),
              width: 40,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          Text(
            "Sınav Konuları",
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }

  Widget categoryListView(List<Category> categoryList) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 20,
        runSpacing: 30,
        direction: Axis.horizontal,
        children: categoryList
            .map((x) => GestureDetector(
          child: categoryListViewItem(x),
          onTap: () {
            Navigator.of(context).pushNamed(
                QuizCategoryDetailsScreen.routeName,
                arguments: x);
          },
        ))
            .toList(),
      ),
    );
  }

  Widget categoryListViewItem(Category category) {
    return Container(
      width: 160,
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(category.imagePath),
            width: 130,
          ),
          Text(category.name),
        ],
      ),
    );
  }
}