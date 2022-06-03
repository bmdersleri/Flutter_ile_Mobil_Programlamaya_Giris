import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/routes/routes.dart';
import 'package:news_app/viewmodel/viewmodel.dart';
import 'package:news_app/widgets/search_delegate.dart';
import 'package:news_app/widgets/turkey_news.dart';
import 'package:news_app/widgets/us_news.dart';
import 'package:provider/provider.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late NewsViewModel _newsViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    _newsViewModel = Provider.of<NewsViewModel>(context, listen: false);
    Future.delayed(Duration.zero, () {
      //Bir sonraki olay döngüsü yinelemesine
      //  kadar yürütmeyi geciktirmek için Dart'ın olay kuyruğunun davranışını kullanıyor
      _data();
    });
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [
            Container(
              child: IconButton(
                  onPressed: () {
                    showSearch(
                        context: context,
                        delegate: CustomSearchDelegate(
                            searchTr: _newsViewModel.trArticles));
                  },
                  icon: Icon(Icons.search)),
            ),
            IconButton(
                onPressed: () async {
                  await _auth.signOut();
                  Navigator.of(context).pushReplacementNamed(login);
                },
                icon: Icon(Icons.logout))
          ],
          title: Center(
            child: Text("Haberler"),
          ),
          bottom: TabBar(controller: _tabController, tabs: [
            Tab(
              child: Text("TR"),
            ),
            Tab(
              child: Text("US"),
            )
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            TurkeyNews(
              context: context,
            ),
            UsNews(
              context: context,
            )
          ],
        ),
      ),
    );
  }

  _data() async {
    await _newsViewModel.getTurkeyyNews();
    await _newsViewModel.getUsNews();
  }
}
