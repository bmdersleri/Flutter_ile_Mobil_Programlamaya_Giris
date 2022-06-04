import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tald/pages/settings.dart';

import '../models/cryptocurrency.dart';
import '../providers/market_provider.dart';
import 'Acconut.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(110, 189, 189, 189),

        elevation: 1,

        title: Image(
          image: AssetImage("images/taldo__1_-removebg-preview.png"),
          height: 50,
        ),

        // leading: Container(
        //  child: Image.asset("assets/images/tubur2.png"),
        // ),
      ),
      backgroundColor: Color.fromARGB(110, 189, 189, 189),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
          child: Column(
            children: [
              Text(
                "Welcome",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Crypto Today",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 15,
                thickness: 2,
              ),
              //ser
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  height: 50,
                  child: TextField(
                    // onChanged: (value) => CryptoCurrency,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        hintText: "Search",
                        prefix: Icon(Icons.search),
                        fillColor: Colors.white38,
                        filled: true,
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 0, style: BorderStyle.none),
                            borderRadius:
                                BorderRadius.all(Radius.circular(16)))),
                  ),
                ),
              ),
              //ser
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Consumer<MarketProvider>(
                  builder: (context, marketProvider, child) {
                    if (marketProvider.isLoading == true) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (marketProvider.markets.length > 0) {
                        return ListView.builder(
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          itemCount: marketProvider.markets.length,
                          itemBuilder: (context, index) {
                            CryptoCurrency currentCrypto =
                                marketProvider.markets[index];

                            return ListTile(
                              contentPadding: EdgeInsets.all(0),
                              leading: CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage:
                                    NetworkImage(currentCrypto.image!),
                              ),
                              title: Text(currentCrypto.name!),
                              subtitle:
                                  Text(currentCrypto.symbol!.toUpperCase()),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "₺" +
                                        currentCrypto.currentPrice!
                                            .toStringAsFixed(4),
                                    style: TextStyle(
                                      color: Color(0xff0395eb),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      double priceChange =
                                          currentCrypto.priceChange24!;
                                      double priceChangePercentaga =
                                          currentCrypto
                                              .priceChangePercentage24!;

                                      if (priceChange < 0) {
                                        //negative
                                        return Text(
                                          "${priceChangePercentaga.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)}) ",
                                          style: TextStyle(color: Colors.red),
                                        );
                                      } else {
                                        return Text(
                                          "+${priceChangePercentaga.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)}) ",
                                          style: TextStyle(color: Colors.green),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Text("Data Not Found");
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    UserSetting(),
    UserAcconut(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          // BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'settings'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}
