import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';




class AddStock extends StatefulWidget {
 const AddStock({Key? key, required this.user}) : super(key: key);
  final User  user;
  //final String barcode;
  @override
   // ignore: library_private_types_in_public_api
   _AddStockState createState() => _AddStockState();
}

class FirebaseUser {
}

class _AddStockState extends State<AddStock> {
  final addProductFormKey = GlobalKey<FormState>();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String?
      enteredbarcode,
      enteredProductName,
      enteredRate,
      enteredIndividualQuantity,
      enteredProductLoc,
      totalStock,
      totalStockUnits = 'Adet';
  List<String> productSearch=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF35858B),
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.clear,
              size: 30,
            )),
        title: const Text('Stok Ekle', style: TextStyle(fontSize: 28)),
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: addProductFormKey,
          child: Center(
            child: SingleChildScrollView(
                        child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Ürün Stok detayları:',
                          style: TextStyle(
                              color:  Color(0xFF35858B),
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left)),

                const SizedBox(height: 40),
            TextFormField(
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              keyboardType: TextInputType.number,
              onFieldSubmitted: (value) {
                FocusScope.of(context).nextFocus();
              },
              textInputAction: TextInputAction.next,
              cursorColor: const Color(0xFF35858B),
              decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF35858B)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF35858B)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF185A9D)),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  labelText: 'Ürün barkodu',
                  labelStyle: const TextStyle(
                      fontSize: 20, color: Color(0xFF35858B))),
              // ignore: missing_return
              validator: (rate) {
                if (rate!.isEmpty) return "Bu alan boş olamaz";
                return null;
              },
              onChanged: (barcode) {
                enteredbarcode = barcode;
              },
            ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor:  const Color(0xFF35858B),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color:   Color(0xFF35858B)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color:   Color(0xFF35858B)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF185A9D)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        labelText: 'Ürün adı',
                        labelStyle: const TextStyle(
                            fontSize: 20, color: Color(0xFF35858B))),
                    validator: (productName) {
                      if (productName!.isEmpty) return "Bu alan boş olamaz";
                      return null;
                    },
                    onChanged: (value) {
                      enteredProductName = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    keyboardType: TextInputType.number,
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: const Color(0xFF35858B),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF35858B)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF35858B)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF185A9D)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        labelText: 'Ürün Fiyatı',
                        labelStyle: const TextStyle(
                            fontSize: 20, color: Color(0xFF35858B))),
                    // ignore: missing_return
                    validator: (rate) {
                      if (rate!.isEmpty) return "Bu alan boş olamaz";
                      return null;
                    },
                    onChanged: (rate) {
                      enteredRate = rate;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    onFieldSubmitted: (value) {
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next,
                    cursorColor: const Color(0xFF35858B),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF35858B)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF35858B)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF185A9D)),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.grey[800]),
                        labelText: 'Depolanan stok yeri',
                        labelStyle: const TextStyle(
                            fontSize: 20, color:Color(0xFF35858B))),
                    // ignore: missing_return
                    validator: (productLoc) {
                      if (productLoc!.isEmpty) return "Bu alan boş olamaz";
                      return null;
                    },
                    onChanged: (value) {
                      enteredProductLoc = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: TextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          keyboardType: TextInputType.number,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).nextFocus();
                          },
                          textInputAction: TextInputAction.next,
                          cursorColor:const Color(0xFF35858B),
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                     BorderSide(color:Color(0xFF35858B)),
                                borderRadius:  BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF35858B)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF185A9D)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              hintStyle: TextStyle(color: Colors.grey[800]),
                              labelText: 'Toplam stok miktarı',
                              labelStyle: const TextStyle(
                                  fontSize: 20, color: Color(0xFF35858B))),
                          // ignore: missing_return
                          validator: (totalStock) {
                            if (totalStock!.isEmpty) {
                              return "Bu alan boş olamaz";
                            }
                            return null;
                          },
                          onChanged: (qty) {
                            totalStock = qty;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: DropdownButton<String>(
                          value: totalStockUnits,
                          iconSize: 24,
                          style: const TextStyle(
                            color: Color(0xFF35858B),
                            fontSize: 20,
                          ),
                          underline: Container(
                            height: 1,
                            color: Colors.white,
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              totalStockUnits = newValue;
                            });
                          },
                          items: <String>['Adet', 'Kutu']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value,
                                  style: const TextStyle(
                                    fontSize: 20,
                                  )),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 50),
                  OutlinedButton(
                    onPressed: () {
                      String temp='';
                      if (addProductFormKey.currentState!.validate())
                        {
                          for(var character in enteredProductName!.toLowerCase().split(""))
                            {
                            temp+=character;
                            productSearch.add(temp);
                            }
                          firestore
                            .collection('Inventory')
                            .doc(widget.user.uid)
                            .collection('Items')
                            .doc(enteredbarcode)
                            .set({
                          'productName': enteredProductName,
                          'productLocation': enteredProductLoc,
                          'rate': enteredRate,
                         'stockQuantity': "${totalStock!} ' '${totalStockUnits!}",
                          'searchIndex':productSearch,
                        }).then((value) => Navigator.pop(context));}
                      OutlinedButtonThemeData(style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF35858B)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      backgroundColor : Colors.white,
                      ));

                    },




                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 18),
                      child: Text(
                        'Stok Ekle',
                        style:
                            TextStyle(color: Color(0xFF35858B), fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
