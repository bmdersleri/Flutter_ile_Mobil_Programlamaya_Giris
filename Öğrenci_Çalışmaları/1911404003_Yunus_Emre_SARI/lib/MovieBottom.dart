import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'AppColors.dart';
import 'FlashMessage.dart';
import 'MovieTitle.dart';
import 'main.dart';
import 'GetDataFromAPI.dart';

class MovieBottom extends StatefulWidget {
  MovieBottom({Key? key}) : super(key: key);

  @override
  State<MovieBottom> createState() => _MovieBottomState();
}

class _MovieBottomState extends State<MovieBottom> {
  Widget BasePage(Widget chilWidget) {
    return Container(
      margin: EdgeInsets.only(top: 15, bottom: 75),
      width: phoneWidth * 0.92,
      constraints: BoxConstraints(minHeight: 250),
      decoration: BoxDecoration(
        color: appColors.clrDark,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            spreadRadius: 0.5,
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(25),
      ),
      child: chilWidget,
    );
  }

  Widget MovieInfoText(String txt) {
    return Text(
      txt,
      style: TextStyle(
          fontSize: 18,
          color: appColors.clrGrey.withOpacity(0.7),
          fontFamily: "Montserrat",
          fontWeight: FontWeight.bold,
          overflow: TextOverflow.ellipsis),
    );
  }

  static void SetMovieName(String movieName,String type) {

    movieTrailer = GetDataFromAPI(
        authority: "simple-youtube-search.p.rapidapi.com",
        path: "/search",
        params: {
          // Future içerisinde aşağıda gönderdiğimiz movie name ile trailer id çekicez
          // "query": 'Fight Club Trailer',
          // "safesearch": 'false'
        },
        headers: {
          "x-rapidapi-key":
              "fffe7d0acbmshff9c36b2802f723p166e95jsnc241f6da8ec4",
          "x-rapidapi-host": "simple-youtube-search.p.rapidapi.com",
        }).GetTrailerFromTitleId(movieName,type);
  }

  late Widget bottomWidget = FutureBuilder<MovieTitle>(
    future: movieInfos,
    builder: (context, snapshot) {

      late Widget movieInfoWidget;
      bool isDataLoaded = true;

      if (snapshot.connectionState != ConnectionState.done) {
        isDataLoaded = false;
        movieInfoWidget = Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        isDataLoaded = false;
        movieInfoWidget =
            Center(child: Text("HATA:" + snapshot.error.toString()));
        print(snapshot.error.toString());
      } else if (!snapshot.hasData) {
        isDataLoaded = false;
        movieInfoWidget = Center(child: CircularProgressIndicator());
      }

      if (isDataLoaded) {
        SetMovieName(snapshot.data!.movieName,snapshot.data!.type);

        movieInfoWidget = Column(
          children: [
            //Movie Title
            Container(
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Expanded(
                      child: Text(
                        snapshot.data!.movieName,
                        style: TextStyle(
                            fontSize: 22,
                            color: appColors.clrGrey,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //Movie Infos
            Container(
                padding: EdgeInsets.fromLTRB(30, 12, 35, 0),
                alignment: Alignment.centerLeft,
                width: phoneWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        //IMDB & Category
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Align(
                                  widthFactor: 1,
                                  heightFactor: 0,
                                  child: Icon(
                                    Icons.stars,
                                    size: 25,
                                    color: appColors.clrRed,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Align(
                                  widthFactor: 1,
                                  heightFactor: 0,
                                  child: MovieInfoText(" IMDB: " +
                                      snapshot.data!.imdbRating.toString()),
                                ),
                              ),
                            ]),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        InkWell(
                          onTap: (){
                            FlashMessage.ShowFlashMessage(context: context, text: snapshot.data!.genre.toString(),miliseconds: 5000);
                          },
                          child: Container(
                          color: Colors.red,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Align(
                                  widthFactor: 1,
                                  heightFactor: 0,
                                  child: Icon(
                                    Icons.category,
                                    size: 25,
                                    color: appColors.clrRed,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Align(
                                  widthFactor: 1,
                                  heightFactor: 0,
                                  child: Container(
                                    width: phoneWidth * 0.4,
                                      child: MovieInfoText(" " +snapshot.data!.genre.toString())
                                  ),
                                ),
                              ),
                            ]),
                          ),
                          alignment: Alignment.centerLeft,
                            ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Year & Type
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 50),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Align(
                                  widthFactor: 1,
                                  heightFactor: 0,
                                  child: Icon(
                                    Icons.access_time_sharp,
                                    size: 25,
                                    color: appColors.clrRed,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Align(
                                  widthFactor: 1,
                                  heightFactor: 0,
                                  child: MovieInfoText(
                                      " " + snapshot.data!.releaseYear),
                                ),
                              ),
                            ]),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: RichText(
                            text: TextSpan(children: [
                              WidgetSpan(
                                child: Align(
                                  widthFactor: 1,
                                  heightFactor: 0,
                                  child: Icon(
                                    Icons.movie,
                                    size: 25,
                                    color: appColors.clrRed,
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                child: Align(
                                  widthFactor: 1,
                                  heightFactor: 0,
                                  child:
                                      MovieInfoText(" " + snapshot.data!.type),
                                ),
                              ),
                            ]),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                      ],
                    ),
                  ],
                )),

            //Movie Description
            Container(
              padding: EdgeInsets.fromLTRB(35, 0, 35, 15),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Text(
                      "Description",
                      style: TextStyle(
                        fontSize: 18,
                        color: appColors.clrRed,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                  Container(
                    child: Text(
                      snapshot.data!.description.toString(),
                      style: TextStyle(
                        fontSize: 17,
                        color: appColors.clrGrey.withOpacity(0.7),
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                  ),
                ],
              ),
            ),
          ],
        );
      }

      return movieInfoWidget;
    },
  );

  @override
  Widget build(BuildContext context) {
    return BasePage(bottomWidget);
  }
}
