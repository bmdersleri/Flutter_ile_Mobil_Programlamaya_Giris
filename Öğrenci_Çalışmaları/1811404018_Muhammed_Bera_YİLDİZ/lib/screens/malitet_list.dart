import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sut_cepte_mobile_app/model/maliyet_tip.dart';
import 'package:sut_cepte_mobile_app/providers/maliyet_listeleme.dart';

class MalitetList extends StatefulWidget {
  Function onDismissed;
  MalitetList({required this.onDismissed, Key? key}) : super(key: key);

  @override
  State<MalitetList> createState() => _MalitetListState();
}

class _MalitetListState extends State<MalitetList> {
  late MalitetListelePoriver _malitetProvider;

  @override
  Widget build(BuildContext context) {
    _malitetProvider = Provider.of<MalitetListelePoriver>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          height: 200,
          child: _malitetProvider.getList().isNotEmpty
              ? ListView.builder(
                  padding: EdgeInsets.all(10),
                  shrinkWrap: true,
                  itemCount: _malitetProvider.getList().length,
                  itemBuilder: (context, index) {
                    MaliyetModel maliyetModel =
                        _malitetProvider.getList()[index];
                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.startToEnd,
                      onDismissed: (a) {
                        widget.onDismissed(index);
                      },
                      child: Card(
                        child: ListTile(
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                maliyetModel.maliyerDeger.toString() + " TL",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                maliyetModel.kg == null
                                    ? ""
                                    : maliyetModel.kg.toString() + " kg",
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                          title: Text(maliyetModel.maliyetName.toString()),
                          leading: CircleAvatar(
                            backgroundColor:
                                Colors.indigo.shade100, // renk bu ha
                            child: Text((index + 1).toString()),
                          ),
                          subtitle: Text(maliyetModel.maliyetTipi.toString()),
                        ),
                      ),
                    );
                  })
              : Center(
                  child: Text(
                  "İşlemleri ekleyiniz",
                  style: GoogleFonts.poppins(),
                )),
        ),
      ),
    );
  }
}
