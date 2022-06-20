import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sut_cepte_mobile_app/screens/drawer.dart';
import 'package:sut_cepte_mobile_app/screens/stockcard.dart';

class Stock extends StatefulWidget {
  const Stock({Key? key}) : super(key: key);

  @override
  State<Stock> createState() => _StockState();
}

class _StockState extends State<Stock> {
  List<String> imgUrl = [
    "https://images.freeimages.com/images/large-previews/7d6/hay-pattern-1183771.jpg",
    "https://www.ciftcitv.com/wp-content/uploads/2022/03/sigir-besi-yemi-1-jpg.jpg",
    "https://www.atilimsilaj.com/upload/resimler/urun_7.jpg",
    "http://www.tarimsalpazarlama.com/upload/vck/kuru-yonca.jpg",
    "https://cdn.cimri.io/image/240x240/15-kg-tavuk-yumurta-yemi-pelet-yem-yuksek-verimli-yumurta-yemi_512916816.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_Lc3lDVLys63qE10s5aSp52HYVkDGNfJyOg&usqp=CAU",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerMe(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.indigo),
        backgroundColor: Colors.white,
        title: Text(
          "Yemler",
          style: GoogleFonts.poppins(
              textStyle:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Stok Yönetimi",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w700),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
                children: [
                  stockCard(imgUrl[0], "Saman", "50"),
                  stockCard(imgUrl[1], "Süt Yemi", "125"),
                  stockCard(imgUrl[2], "Mısır Silajı", "67"),
                  stockCard(imgUrl[3], "Yonca Kuru Otu", "350"),
                  stockCard(imgUrl[4], "Düve Yemi", "0"),
                  stockCard(imgUrl[5], "Sığır Besi Yemi", "0"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
