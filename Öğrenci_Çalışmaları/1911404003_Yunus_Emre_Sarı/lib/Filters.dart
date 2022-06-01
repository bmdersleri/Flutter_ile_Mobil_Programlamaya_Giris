import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flash/flash.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FilterValues.dart';
import 'FlashMessage.dart';
import 'main.dart';
final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

class Filters extends StatefulWidget {
  Filters({Key? key}) : super(key: key);

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {

  late List<String> listSelectedGenres = FilterValues.listSelectedGenres;
  late List<String> listSelectedTypes = FilterValues.listSelectedTypes;
  late String? imdbSelectedValue = FilterValues.GetImdbSelectedValue();
  late TextEditingController minYearController = FilterValues.minYearController;
  late TextEditingController maxYearController = FilterValues.maxYearController;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    SetFilterValuesFromPrefs();

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // PrefsRemove();

    GetFilterValues();

  }

  double changeChildSize = 0.8;

  Widget SampleTextField({required String hintTxt, TextEditingController? textEditingController}) {
    return TextField(
      textAlign: TextAlign.center,
      controller: textEditingController,
      cursorColor: Colors.black,
      onChanged: (val) => SaveFilterValues(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        border: OutlineInputBorder(),
        hintText: hintTxt,
        filled: true,
        fillColor: appColors.clrLightDark.withOpacity(0.075),
        hintStyle: TextStyle(
          color: Colors.black.withOpacity(0.3),
          fontWeight: FontWeight.normal,
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.transparent, width: 0)),
        counterText: "",
      ),
      keyboardType: TextInputType.number,
      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      maxLength: 4,
    );
  }

  Widget SampleText(String txt){
    return  Text(
      txt,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: 18,
        color: appColors.clrRed,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  var genres =["Action", "Adventure", "Animation", "Biography", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "Film-Noir", "Game-Show", "History", "Horror", "Music", "Musical", "Mystery", "News", "Reality-TV", "Romance", "Sci-Fi", "Short", "Sport", "Talk-Show", "Thriller", "War", "Western",];

  var imdbTitles = ["Ignore This Filter", "Rated Over 7", "Rated Over 7.5", "Rated Over 8", "Rated Over 8.5", "Rated Over 9",];

  var types=["Movie", "Series",];

  DraggableScrollableController _draggableScrollableController=DraggableScrollableController();



  Future<void> SaveFilterValues() async{

    final SharedPreferences prefs = await _prefs;
    print("Filters Save Started");

    if (this.mounted) {
      setState(() {
        prefs.setString('minYear', minYearController.text);
        prefs.setString('maxYear', maxYearController.text);
        prefs.setString('imdbSelectedValue', imdbSelectedValue!);
        prefs.setStringList('listSelectedGenres', listSelectedGenres);
        prefs.setStringList('listSelectedTypes', listSelectedTypes);
      });
    }
    print("Filters Save Finished");

  }


  Future<void> GetFilterValues() async{
    final SharedPreferences prefs = await _prefs;

      setState(() {

        if(prefs.getString("minYear") == null){
          print("Filter Values null çekti!");
        }
        else{
          minYearController.text =  prefs.getString("minYear")!;
          maxYearController.text =  prefs.getString("maxYear")!;
          imdbSelectedValue =  prefs.getString("imdbSelectedValue")!;
          listSelectedTypes =  prefs.getStringList("listSelectedTypes")!;
          listSelectedGenres =  prefs.getStringList("listSelectedGenres")!;

          SetFilterValuesFromPrefs();

          print("GetFilterValues Yerleştirildi");

        }

      });

  }



  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: changeChildSize,

      minChildSize: 0,
      maxChildSize: changeChildSize,
      controller: _draggableScrollableController,
      builder: (BuildContext context, controller) {
        return Container(
          child: Stack(clipBehavior: Clip.none, children: [

            //Kaydet butonu stack dışına çıktığı için tıklanmıyor. Burda gizli bir container ekleyip tıklaanbilir yapıyoruz.
            Container(
                width: double.infinity,
                height: 50,
                color: Colors.blue.withOpacity(0)),

            Container(
              padding: EdgeInsets.fromLTRB(30,50,30,50),
              transform: Matrix4.translationValues(0.0, 40.0, 0.0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: appColors.clrGrey,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              height: phoneHeight,
              child: Column(
                children: [
                  //Start Year - End Year
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SampleText("Start Year"),

                            Container(
                              height: 35,
                              width: 150,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: SampleTextField(hintTxt: "def:2015",textEditingController: minYearController),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SampleText("End Year"),

                            Container(
                              height: 35,
                              width: 150,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: SampleTextField(hintTxt: "def:2022",textEditingController: maxYearController),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  //Genres
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SampleText("Categories"),
                            Container(
                              height: 40,
                              width: phoneWidth*0.85,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Align(
                                    child: Text(
                                      'Selected All',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme
                                            .of(context)
                                            .hintColor,
                                      ),
                                    ),
                                  ),
                                  iconSize: 25,
                                  buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                                  icon: Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: appColors.clrLightDark.withOpacity(0.25)
                                  ),
                                  isExpanded: true,
                                  buttonDecoration: BoxDecoration(
                                    color: appColors.clrLightDark.withOpacity(0.075),
                                    borderRadius: BorderRadius.circular(25)
                                  ),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: appColors.clrGrey,
                                  ),
                                  dropdownMaxHeight: 200,
                                  items: genres.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      //disable default onTap to avoid closing menu when selecting an item
                                      enabled: false,
                                      child: StatefulBuilder(
                                        builder: (context, menuSetState) {
                                          final _isSelected = listSelectedGenres.contains(item);
                                          return InkWell(
                                            onTap: () {
                                              _isSelected
                                                  ? listSelectedGenres.remove(item)
                                                  : listSelectedGenres.add(item);
                                              SaveFilterValues();
                                              //This rebuilds the StatefulWidget to update the button's text
                                              setState(() {});
                                              //This rebuilds the dropdownMenu Widget to update the check mark
                                              menuSetState(() {});
                                            },
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  _isSelected
                                                      ? Icon(Icons.check_box_outlined,color: appColors.clrPurple,)
                                                      : Icon(Icons.check_box_outline_blank),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                  //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                  value: listSelectedGenres.isEmpty ? null : listSelectedGenres.last,
                                  onChanged: (value) {},
                                  buttonHeight: 40,
                                  itemHeight: 40,
                                  itemPadding: EdgeInsets.zero,
                                  selectedItemBuilder: (context) {
                                    return genres.map(
                                          (item) {
                                        return Container(
                                          alignment: AlignmentDirectional.center,
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Text(
                                            listSelectedGenres.join(', '),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        );
                                      },
                                    ).toList();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                  //IMDB
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            SampleText("IMDB"),

                            Container(
                              height: 40,
                              width: phoneWidth*0.85,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                    isExpanded: true,
                                    items: imdbTitles
                                        .map((item) =>
                                        DropdownMenuItem<String>(
                                          value: item,
                                          alignment: Alignment.center,
                                          child: Text(
                                            item,
                                            style: TextStyle(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ))
                                        .toList(),
                                  value: imdbSelectedValue!.isEmpty ? imdbSelectedValue=imdbTitles[0] : imdbSelectedValue,
                                    onChanged: (value) {
                                      setState(() {

                                        SaveFilterValues();
                                        //Burası filtre kısmında değiştiğini görmek için
                                        imdbSelectedValue = value as String;

                                        //Burası arkaplanda veriyi saklayabilmek için.
                                        //Filtre sayfası kapanıp açılınca veriler default a dönüyor.
                                        //Bu yüzden static olarak saklıyoruz bu değerleri
                                        FilterValues.imdbSelectedValue = FilterValues.GetMinImdbValue(value.toString());

                                      });
                                    },
                                    icon: Icon(
                                        Icons.arrow_drop_down_circle_outlined,
                                        color: appColors.clrLightDark.withOpacity(0.25)
                                    ),
                                    iconSize: 25,
                                    iconDisabledColor: Colors.grey,
                                    buttonPadding: EdgeInsets.symmetric(horizontal: 10),

                                    buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      color: appColors.clrLightDark.withOpacity(0.075),
                                    ),
                                    itemHeight: 40,
                                    dropdownMaxHeight: 200,
                                    dropdownPadding: null,
                                    dropdownDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: appColors.clrGrey,
                                    ),
                                    dropdownElevation: 8,
                                    scrollbarRadius: const Radius.circular(40),
                                    scrollbarThickness: 6,
                                    scrollbarAlwaysShow: true,
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                  //Type
                  Padding(
                    padding: EdgeInsets.fromLTRB(0,0,0,30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SampleText("Type"),
                            Container(
                              height: 40,
                              width: phoneWidth*0.85,
                              margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  hint: Align(
                                    child: Text(
                                      'Selected All',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme
                                            .of(context)
                                            .hintColor,
                                      ),
                                    ),
                                  ),
                                  iconSize: 25,
                                  buttonPadding: EdgeInsets.symmetric(horizontal: 10),
                                  icon: Icon(
                                      Icons.arrow_drop_down_circle_outlined,
                                      color: appColors.clrLightDark.withOpacity(0.25)
                                  ),
                                  isExpanded: true,
                                  buttonDecoration: BoxDecoration(
                                      color: appColors.clrLightDark.withOpacity(0.075),
                                      borderRadius: BorderRadius.circular(25)
                                  ),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: appColors.clrGrey,
                                  ),
                                  dropdownMaxHeight: 200,
                                  items: types.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      //disable default onTap to avoid closing menu when selecting an item
                                      enabled: false,
                                      child: StatefulBuilder(
                                        builder: (context, menuSetState) {
                                          final _isSelected = listSelectedTypes.contains(item);
                                          return InkWell(
                                            onTap: () {
                                              _isSelected
                                                  ? listSelectedTypes.remove(item)
                                                  : listSelectedTypes.add(item);

                                              SaveFilterValues();
                                              //This rebuilds the StatefulWidget to update the button's text
                                              setState(() {});
                                              //This rebuilds the dropdownMenu Widget to update the check mark
                                              menuSetState(() {});
                                            },
                                            child: Container(
                                              height: double.infinity,
                                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                              child: Row(
                                                children: [
                                                  _isSelected
                                                      ? Icon(Icons.check_box_outlined,color: appColors.clrPurple,)
                                                      : Icon(Icons.check_box_outline_blank),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    item,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                  //Use last selected item as the current value so if we've limited menu height, it scroll to last item.
                                  value: listSelectedTypes.isEmpty ? null : listSelectedTypes.last,
                                  onChanged: (value) {},
                                  buttonHeight: 40,
                                  itemHeight: 40,
                                  itemPadding: EdgeInsets.zero,
                                  selectedItemBuilder: (context) {
                                    return types.map(
                                          (item) {
                                        return Container(
                                          alignment: AlignmentDirectional.center,
                                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                          child: Text(
                                            listSelectedTypes.join(', '),
                                            style: const TextStyle(
                                              fontSize: 16,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                        );
                                      },
                                    ).toList();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),

                      ],
                    ),
                  ),

                ],
              ),
            ),

            //Close Button
            Center(
              heightFactor: 1.25,
              child: Container(
                transformAlignment: Alignment.center,
                child: FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  backgroundColor: appColors.clrPurple,
                  child: Icon(
                    Icons.done,
                    size: 30,
                  ),
                ),
              ),
            ),


          ]),
        );
      },
    );
  }
}


//Eğer ki filters kısmı hiç açılmadan suggest me ye tıklanırsa diye burayı mainden çağırıyoruz
Future<void> SetFilterValuesFromPrefs() async{
  final SharedPreferences prefs = await _prefs;

  if(prefs.getString("minYear") == null){
    print("SetFilterValuesFromPrefs null çekti!");
  }
  else{
    FilterValues.maxYearController.text =  prefs.getString("maxYear")!;
    FilterValues.minYearController.text =  prefs.getString("minYear")!;
    FilterValues.imdbSelectedValue =  FilterValues.GetMinImdbValue(prefs.getString("imdbSelectedValue")!);
    FilterValues.listSelectedTypes =  prefs.getStringList("listSelectedTypes")!;
    FilterValues.listSelectedGenres =  prefs.getStringList("listSelectedGenres")!;

    print("SetFilterValuesFromPrefs Yerleştirildi");
  }

}
