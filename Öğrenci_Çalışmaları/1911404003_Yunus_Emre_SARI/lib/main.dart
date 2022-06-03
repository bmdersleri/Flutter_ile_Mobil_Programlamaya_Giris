import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:SuggestME/FilterValues.dart';
import 'package:SuggestME/Filters.dart';
import 'package:SuggestME/MovieBottom.dart';
import 'package:SuggestME/MovieTop.dart';
import 'package:SuggestME/SuggestParameters.dart';
import 'APIData.dart';
import 'AboutMe.dart';
import 'AppColors.dart';
import 'FlashMessage.dart';
import 'GetDataFromAPI.dart';
import 'GradientBackground.dart';
import 'MovieTitle.dart';
import 'package:stack/stack.dart' as Stack1;
import "package:shared_preferences/shared_preferences.dart";
import 'dart:async';

final AppColors appColors = AppColors();

Future<String>? movieTrailer;

late Future<String> imageFromId;
late Future<MovieTitle> movieInfos;

late Future<String> suggestMe;

late double phoneWidth;
late double phoneHeight;

String lastTitleId = "";
// String titleIdNow = "tt12060242";
String titleIdNow = "";
String? lastSearchingGenre;

late Stack1.Stack<String> stckLastTitles;

bool isSearchingTitle = false;
bool canGoPrevTitle = false;

late List<Widget> baseWidgets;

double btnWidthFactor = 1; //Tam ekran olunca alttaki butonlar gitsin diye

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

void main() {
  runApp(const MainPage());
}

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: appColors.clrDark,
      title: 'API Call Demo',
      initialRoute: '/',
      routes: {
        "/": (context) {
          //Phone height ve width ataması yapalım ki aşağıda initstate de kullanabilelim
          phoneWidth = MediaQuery.of(context).size.width;
          phoneHeight = MediaQuery.of(context).size.height;
          return HomePage();
        },
        "/AboutMe": (context) => AboutMe(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  Future<void> SetPrefsLastTitleId() async {
    print("SetPrefsLastTitleId Çalıştı");
    final SharedPreferences prefs = await _prefs;

    setState(() {
      prefs.setString('lastTitleId', lastTitleId);
      prefs.setString('lastSearchingGenre', lastSearchingGenre!);
      //Son aranan genreyi kaydediyruz ki uygulama ilk açıldığında Genre kısmında
      // ilk olarak hangi genre arandığı yazsın sonra filmin diğer türleri yazsın
    });
  }


  @override
  void initState() {
    // PrefsRemove();

    StartShowTitle();

    SetFilterValuesFromPrefs();

    print("Title: $lastTitleId");
    stckLastTitles = Stack1.Stack();

    //Maksimum kaçıncı sayfadan aramaya başlıcaz
    SuggestParameters.pageSearchNow =
        Random().nextInt(SuggestParameters.maxPageStartSearch) + 1;

    //Başlangıçta loading gif oynatılıyor
    baseWidgets = [
      LoadingIndicator(),
    ];

    ;

  }

  //Başlangıçta eğer prefs varsa önceki title göster, yoksa suggest me yap
  void StartShowTitle() {

    setState(() {

      GetDataFromAPI().GetLastTitle().then((result) {
      print(result);

      if(result == "no-title"){
        RunSuggestMe();
      }
      else if(result == "no-internet"){
          baseWidgets = [InternetConnectionError()];
      }else{
        titleIdNow = result;
        print("GetPrefsLastTitleId Çalıştı: " + titleIdNow);
        //Başlangıçta yüklenen son filmi yine başlangıç olarak atıyoruz
        //Böylece SuggestMe butonuna tıklanmadan uygulama yine kapatılırsa yine bu filmi gösterelim
        lastTitleId = titleIdNow;
        SetPrefsLastTitleId();

        ShowMovieWithTitle();
      }
    });
    });

  }


  void ShowFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true, // set this to true
      builder: (context) => Filters(),
    );
  }


  void RunSuggestMe() {
    //Title type çek random şekilde
    String? titleType;
    int rndTitleType = Random().nextInt(FilterValues.listSelectedTypes.length);
    titleType = FilterValues.listSelectedTypes[rndTitleType];
    (titleType == "Movie") ? titleType = "movie" : titleType = "tvSeries";

    String? genre;
    int rndGenre = Random().nextInt(FilterValues.listSelectedGenres.length);
    genre = FilterValues.listSelectedGenres[rndGenre];
    lastSearchingGenre = genre;

    int minYear;
    int maxYear;
    if (FilterValues.minYearController.text.toString().isEmpty)
      minYear = 2010;
    else if (int.parse(FilterValues.minYearController.text.toString()) < 1950)
      minYear = 1950;
    else
      minYear = int.parse(FilterValues.minYearController.text.toString());

    if (FilterValues.maxYearController.text.toString().isEmpty)
      maxYear = 2022;
    else if (int.parse(FilterValues.maxYearController.text.toString()) < 1950)
      maxYear = 1950;
    else
      maxYear = int.parse(FilterValues.maxYearController.text.toString());

    if (maxYear < minYear) minYear = maxYear - 1;

    int limit = 50;

    SuggestParameters.params = {
      'info': 'base_info',
      'page': SuggestParameters.pageSearchNow.toString(),
      'limit': limit.toString(),
      'titleType': titleType,
      'startYear': minYear.toString(),
      'endYear': maxYear.toString(),
      'genre': genre,
    };

    suggestMe = GetDataFromAPI(
            authority: SuggestParameters.authority,
            path: SuggestParameters.path,
            params: SuggestParameters.params,
            headers: SuggestParameters.headers1)
        .SuggestMe();

    print(
        "---------------------------------------------------------------------------------");
    print("Önerilecek Film Aranıyor");
    print("Page: " +
        SuggestParameters.pageSearchNow.toString() +
        " Genre: $genre " +
        " Type: $titleType");

    setState(() {
      baseWidgets = [

        FutureBuilder<String>(
            future: suggestMe,
            builder: (context, snapshot) {
              bool isDataLoaded = true;

              List<Widget> widgetTurn = [];

              if (snapshot.connectionState != ConnectionState.done ||
                  !snapshot.hasData) {
                isDataLoaded = false;
                widgetTurn = [
                  LoadingIndicator()
                ];
              } else if (snapshot.hasError) {
                isDataLoaded = false;
                widgetTurn = [MovieTop(), MovieBottom()];
                FlashMessage.ShowFlashMessage(
                    context: context,
                    text: snapshot.error.toString(),
                    miliseconds: 7000);
                print("ERROR: " + snapshot.error.toString());
              }

              if (isDataLoaded) {
                //Gönderdiğimiz page de istediğimiz title yokmuş,
                //Tekrar göndermesi için zamanlıyoruz burda hemen tekrar çalışyıor
                if (snapshot.data!.toString() == "no-result" && SuggestParameters.pageChangeCount <
                        SuggestParameters.maxPageChangeCount) {
                  print("No-Result Continue To Search");
                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    setState(() {
                      SuggestParameters.pageChangeCount++;
                      RunSuggestMe();
                    });
                  });
                }
                else if (snapshot.data!.toString() == "no-result") {

                  //Yeterince arama yapılmış ve sonuç bulunamamış
                  print("Maksimum sayfa değiştirme sayısına ulaşıldı");

                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    FlashMessage.ShowFlashMessage(
                        context: context,
                        text:
                            "Sorry! \n We couldn't find anything matching your filters",
                        miliseconds: 4000);
                  });

                  //Arama sonucunda bir şey bulamadık. Eskisini Gösteriyoruz
                  widgetTurn = [MovieTop(), MovieBottom()];

                  SuggestParameters.pageChangeCount = 0;
                  SuggestParameters.lookedPages.clear();

                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    setState(() {
                      isSearchingTitle = false;
                    });
                  });
                }
                else if (snapshot.data!.toString().contains("API call returned")) {
                  //API CALL hatası çıkmış burda eskisini gösterip hata flash mesajı yazalım

                  print("HATA => API CALL RETURNED: " +
                      snapshot.data!.toString());
                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    FlashMessage.ShowFlashMessage(
                        context: context,
                        text:
                        "Sorry! \n Something went wrong. Please try again.",
                        miliseconds: 4000);

                    isSearchingTitle = false;
                  });

                  //Arama sonucunda bir şey bulamadık. Eskisini Gösteriyoruz
                  widgetTurn = [MovieTop(), MovieBottom()];

                  SuggestParameters.pageChangeCount = 0;
                  SuggestParameters.lookedPages.clear();

                }
                else if(snapshot.data!.toString() == "no-internet"){

                  widgetTurn = [
                    InternetConnectionError(),
                  ];

                }
                else{
                  //Başarıyla yeni film&dizi gösterildi bunları sıfırlayabiliriz.
                  titleIdNow = snapshot.data!.toString();
                  lastTitleId = titleIdNow;
                  SetPrefsLastTitleId();

                  imageFromId = GetDataFromAPI(
                      authority: "moviesdatabase.p.rapidapi.com",
                      path: "/titles/" + titleIdNow,
                      params: {
                        "info": 'mini_info'
                      },
                      headers: {
                        "x-rapidapi-key":
                            "fffe7d0acbmshff9c36b2802f723p166e95jsnc241f6da8ec4",
                        "x-rapidapi-host": "moviesdatabase.p.rapidapi.com",
                      }).GetImage();

                  movieInfos = GetDataFromAPI(
                      authority: "moviesdatabase.p.rapidapi.com",
                      path: "/titles/" + titleIdNow,
                      params: {
                        "info": 'base_info'
                      },
                      headers: {
                        "x-rapidapi-key":
                            "fffe7d0acbmshff9c36b2802f723p166e95jsnc241f6da8ec4",
                        "x-rapidapi-host": "moviesdatabase.p.rapidapi.com",
                      }).GetMovieInfoFromTitleId(titleId: titleIdNow,searchingGenre: lastSearchingGenre);

                  widgetTurn = [MovieTop(), MovieBottom()];

                  SuggestParameters.pageChangeCount = 0;
                  SuggestParameters.lookedPages.clear();

                  SchedulerBinding.instance?.addPostFrameCallback((_) {
                    setState(() {
                      isSearchingTitle = false;
                    });
                  });
                }
              }

              // baseWidgets = [];

              return Column(children: widgetTurn);
            }),
      ];
    });
  }


  void ShowPrevTitle() {

    setState(() {
      isSearchingTitle = true;
      baseWidgets = [LoadingIndicator()];
    });

    GetDataFromAPI().InternetControl().then((value) {

      if(value == "success"){
        print("Stack Uzunluk: " + stckLastTitles.length.toString());
        titleIdNow = stckLastTitles.pop();
        print("Çağrılması Gereken: " + titleIdNow.toString());
        lastTitleId = titleIdNow;
        SetPrefsLastTitleId();

        ShowMovieWithTitle();
      }
      else
      {
        setState(() {
          baseWidgets = [InternetConnectionError()];
          isSearchingTitle = false;
        });
      }

    });

  }


  //Lastprev den geliyor veya uygulama ilk açıldığında son title id geliyor
  void ShowMovieWithTitle(){

    List<Widget> widgetTurn = [];

    if (stckLastTitles.length == 0) canGoPrevTitle = false;

    imageFromId = GetDataFromAPI(
        authority: "moviesdatabase.p.rapidapi.com",
        path: "/titles/" + titleIdNow,
        params: {
          "info": 'mini_info'
        },
        headers: {
          "x-rapidapi-key":
          "fffe7d0acbmshff9c36b2802f723p166e95jsnc241f6da8ec4",
          "x-rapidapi-host": "moviesdatabase.p.rapidapi.com",
        }).GetImage();

    movieInfos = GetDataFromAPI(
        authority: "moviesdatabase.p.rapidapi.com",
        path: "/titles/" + titleIdNow,
        params: {
          "info": 'base_info'
        },
        headers: {
          "x-rapidapi-key":
          "fffe7d0acbmshff9c36b2802f723p166e95jsnc241f6da8ec4",
          "x-rapidapi-host": "moviesdatabase.p.rapidapi.com",
        }).GetMovieInfoFromTitleId(titleId: titleIdNow,searchingGenre: lastSearchingGenre);

    widgetTurn = [MovieTop(), MovieBottom()];

    SuggestParameters.pageChangeCount = 0;
    SuggestParameters.lookedPages.clear();

    setState(() {
      baseWidgets = [Column(children: widgetTurn)];
      isSearchingTitle = false;
    });

  }

  Widget InternetConnectionError(){
    return Container(
      height: phoneHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please Check Your Internet Connection",
            style: TextStyle(fontSize: 18,color: Colors.white),
          ),

          ElevatedButton(onPressed: () => RunSuggestMe(), child: Text("Try Again"))

        ],
      ),
    );
  }

  Widget LoadingIndicator(){
    return Container(
      color: appColors.clrDark,
      height: phoneHeight - 100,
      child: Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColors.clrDark,
      body: Stack(
          children: [
        Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GradientBackground(
                  color1: appColors.clrDark.value,
                  color2: appColors.clrDark.value,
                  color3: appColors.clrDark.value,
                  children: baseWidgets,
                ),
              ),
            ),
          ],
        ),

        //Filters and NextMovie Button
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            width: phoneWidth * btnWidthFactor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //Filters Button
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: phoneWidth * 0.15, height: 50),
                  child: FloatingActionButton(
                    onPressed: () =>
                        Future.delayed(const Duration(milliseconds: 200), () {
                      ShowFilterSheet();
                    }),
                    elevation: 15,
                    splashColor: appColors.clrDark,
                    backgroundColor: appColors.clrGrey,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.white.withOpacity(1),
                                  spreadRadius: 10,
                                  blurRadius: 25,
                                  offset: Offset(11, 5)),
                            ],
                          ),
                        ),
                        Container(
                          child: Icon(Icons.settings, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),

                //Previous Title Button
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: phoneWidth * 0.18, height: 50),
                  child: ElevatedButton(
                    onPressed: canGoPrevTitle && !isSearchingTitle
                        ? () {
                            ShowPrevTitle();
                          }
                        : null,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(appColors.clrPurple),
                        elevation: MaterialStateProperty.all(10),
                        shadowColor:
                            MaterialStateProperty.all(appColors.clrPurple),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    side:
                                        BorderSide(color: Colors.transparent))),
                        overlayColor:
                            MaterialStateProperty.all(appColors.clrDark)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: Icon(Icons.arrow_back_ios_outlined, size: 28),
                    ),
                  ),
                ),

                //Suggest Me Button
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: phoneWidth * 0.5, height: 50),
                  child: ElevatedButton(
                    onPressed: !isSearchingTitle
                        ? () {
                            setState(() {
                              stckLastTitles.push(titleIdNow);
                              canGoPrevTitle = true;
                              //Maksimum kaçıncı sayfadan aramaya başlıcaz
                              SuggestParameters
                                  .pageSearchNow = Random().nextInt(
                                      SuggestParameters.maxPageStartSearch) +
                                  1;
                              RunSuggestMe();
                              //Burda maksimumdan aramaya başlıyoruz
                            });
                            isSearchingTitle = true;
                          }
                        : null,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(appColors.clrPurple),
                        elevation: MaterialStateProperty.all(10),
                        shadowColor:
                            MaterialStateProperty.all(appColors.clrPurple),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                    side:
                                        BorderSide(color: Colors.transparent))),
                        overlayColor:
                            MaterialStateProperty.all(appColors.clrDark)),
                    child: Text(
                      "Suggest ME",
                      style: TextStyle(fontSize: 23),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        toolbarHeight: 50,
      ),
      drawer: Container(
        width: 250,
        child: Drawer(
          backgroundColor: appColors.clrDark,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  color: appColors.clrRed.withOpacity(0.9),
                  padding: EdgeInsets.all(10),
                  width: phoneWidth,
                  alignment: Alignment.center,
                  child: Text("Home",style: TextStyle(fontSize: 22,color: Colors.white,fontFamily: "Montserrat",),),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/AboutMe');
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: phoneWidth,
                  alignment: Alignment.center,
                  child: Text("About Me",style: TextStyle(fontSize: 22,color: Colors.white,fontFamily: "Montserrat",),),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

}

Future<void> PrefsRemove() async {
  final SharedPreferences prefs = await _prefs;

  await prefs.clear();

  print("Last Title Id Removed");
}
