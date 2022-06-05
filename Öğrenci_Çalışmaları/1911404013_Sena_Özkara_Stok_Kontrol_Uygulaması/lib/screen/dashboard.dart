import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:lisanstezistoktakipsistemi/screen/add_stock.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lisanstezistoktakipsistemi/screen/get_started.dart';



class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool _loading = true;
  bool _searchActive=false;
  String? query;
 final FirebaseAuth _auth=FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  User? loggedInUser;

  get stockQuantity => null;


  @override
  void initState() {
    FirebaseAuth.instance
        .userChanges()
        .listen((value) {

          {
            loggedInUser = value;
            _loading = false;
          } }) ;
    super.initState();
  }
   Future<void> editStockQuantity(String stock,String barcode) async {
      int? stockQty,enteredStockQty;
      String? units;
     stockQty=int.parse(stock.split(" ")[0]);
     units=stock.split(" ")[1];
    return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Stok Miktarını Düzenle'),
        content: TextFormField(
          onChanged: (value){
            enteredStockQty=int.parse(value);
          },
          decoration: const InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF35858B)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF35858B)),
            ),
          ),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly
          ],
          keyboardType: TextInputType.number,
          cursorColor:const Color(0xFF35858B),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Stok Ekle',style: TextStyle(
                          color: Color(0xFF35858B))),
            onPressed: () {
              FirebaseFirestore.instance
                    .collection("Inventory").doc(loggedInUser!.uid).collection('Items').doc(barcode).update({'stockQuantity':'${enteredStockQty!+stockQty!} $units'}).then((value) => Navigator.of(context).pop());
            },
          ),
        ],
      );});
  }
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      floatingActionButton: SizedBox(
        height: 185,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'Stok Ekle',
              backgroundColor:const Color(0xFF35858B),
              elevation: 1,
              onPressed: () {
                try {
                  FlutterBarcodeScanner.scanBarcode(
                      "#ff6666", "Geri", true, ScanMode.BARCODE)

                      .then((value) {
                    String barcode = value;
                    FirebaseFirestore.instance
                        .collection("Inventory")
                        .doc(loggedInUser!.uid)
                        .collection('Items')
                        .doc(value)
                        .get()
                        .then((value) {
                      // ignore: unnecessary_null_comparison
                      if (value.data == null) {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) =>
                            AddStock(
                               user: loggedInUser!, /*barcode: barcode*/)));
                      } else {
                        editStockQuantity(
                            value.data()!['stockQuantity'], barcode);
                      }
                    }
                    );
                  });
                } catch (e) {
                  if (kDebugMode) {
                    print("Got error: $e");
                  }
                }
                finally {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) => AddStock(user: loggedInUser!)));
                }

                child : const FaIcon(
                  FontAwesomeIcons.plus,
                  size: 28,
                );
              }),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF35858B),
        actions: <Widget>[
          Center(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  _auth.signOut().then((value) =>  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const GetStartedScreen()), (route) => false));
                },
                child: const Text(
                  'Çıkış Yap',
                  style: TextStyle(fontSize: 18),
                )),
          )),
        ],
        title: const Text(
          'Stok Kontrol',
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.bold, fontFamily: 'Logo'),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              color: const Color(0xFF35858B),
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                  controller: _searchController,
                  onFieldSubmitted: (value) {
                    _searchActive=true;
                    setState(() {
                    query=value;
                    _searchController.clear();
                    });
                  },
                  textInputAction: TextInputAction.search,
                  cursorColor: const Color(0xFF35858B),
                  decoration: InputDecoration(
                    suffixIcon: IconButton(icon: const Icon(Icons.clear,color: Colors.grey,), onPressed:(){setState(() {
                      _searchActive=false;
                      FocusScope.of(context).unfocus();
                      FocusScope.of(context).unfocus();
                    });}),
                      hintText: "Envanterde Ara...",
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Color(0xFF35858B),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF35858B))),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF35858B))),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Color(0xFF35858B)))),
                ),
              ),
            ),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color(0xFF35858B)),
                    ))
                  : StreamBuilder<QuerySnapshot>(

                   stream: _searchActive?firestore.collection('Inventory').doc(loggedInUser!.uid).collection('Items').where('searchIndex',arrayContains:query!.toLowerCase()).snapshots(): firestore
                          .collection('Inventory')
                          .doc(loggedInUser!.uid)
                          .collection('Items')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return const Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Color(0xFF35858B)),
                          ));
                        }
                        final products = snapshot.data!.docChanges;
                        List<ProductStockCard> productStockCards = [];
                        for (var product in products) {
                          productStockCards.add(
                            ProductStockCard(
                              productName: product.doc['productName'],
                              productLocation: product.doc['productLocation'],
                              rate: product.doc['rate'],
                              availableStock: product.doc['stockQuantity'],
                            ),
                          );
                        }
                        return ListView(children: productStockCards);
                      }),
            )
          ]),
        ),
      ),
    );
  }
}

class ProductStockCard extends StatelessWidget {
 // ignore: use_key_in_widget_constructors
 const ProductStockCard(
      {required this.productName, required this.productLocation, required this.availableStock, required this.rate});
  final String productName, productLocation, availableStock, rate;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ignore: unnecessary_string_interpolations
            Text("$productName",
                style: const TextStyle(fontSize: 20, color: Color(0xFF35858B))),
            const SizedBox(height: 5),
            Text("Konum: $productLocation", style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Text('Mevcut Stok: $availableStock',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 5),
            Text("Ürün Fiyatı: ₺ $rate", style: const TextStyle(fontSize: 16))
          ],
        ),
      ),
    );
  }
}
