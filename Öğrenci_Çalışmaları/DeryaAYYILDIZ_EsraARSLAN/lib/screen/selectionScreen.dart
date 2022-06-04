import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vetlogin/screen/analysisView.dart';
import 'package:vetlogin/screen/analysis_input.dart';
import 'package:vetlogin/widget/selectButton.dart';

class SelectionScreen extends StatefulWidget {
  late final List<String> items;

  SelectionScreen(this.items) {}

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false, //görüntülenen bir ekran klavyesi varsa, klavyenin üst üste gelmesini önlemek için gövde yeniden boyutlandırılabilir. 
                                       //Burada klavye özelliği olmadığı için false değerini almakta
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          child: Stack(
            children: <Widget>[
              Center( // ortalamak için center widgetını kullanıyoruz.
                child: Container(
                  width: 600, //genişlik belirtiyoruz
                  height: 1000,//yükseklik belirtiyoruz.
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/bg.png"),// arka plan resmini ekliyoruz.
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(), //kaydırılacak içerik olmadığında kaydırmayı devre dışı bırakan varsayılan davranışı geçersiz kılmaktadır.
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 120),
                    child: Column( //Alt öğelerini dikey bir dizide görüntüleyen bir pencere öğesidir.


                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 30),
                        SelectButton(
                          text: "Tahlil Görüntüle",
                          function: openAnalysisView,// tahlil görüntüle butonuna basıldığında analiz görüntüle sayfasına ulaşması için fonksiyonumuz çalışıcaktır.
                        ),
                        SelectButton(
                            text: "Tahlil Gir", function: openAnalisisInput)//tahlil gir butonuna basıldığında tahlil gir sayfasına ulaşması için fonksiyonumuz çalışıcaktır.
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void openAnalysisView() {// fonksiyonumuz yönlendirme yapmaktadır
    Navigator.push(
      this.context,
      MaterialPageRoute(
        builder: (context) => SimpleDropDown(),
      ),
    );
  }

  void openAnalisisInput() {
    Navigator.push(
      this.context,
      MaterialPageRoute(
        builder: (context) => AnaliysisInput(),
      ),
    );
  }
}