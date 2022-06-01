import 'dart:ui';

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'APIData.dart';
import 'FlashMessage.dart';
import 'main.dart';

class MovieTop extends StatefulWidget {
  const MovieTop({Key? key}) : super(key: key);

  @override
  State<MovieTop> createState() => _MovieTopState();
}

class _MovieTopState extends State<MovieTop> {


  //Video tam ekran olunca gerekli ayarlar burada yapılıyor
  double widthFactor = 0.6;
  double heightFactor = 0.5;
  EdgeInsetsGeometry fullHeightPadding = EdgeInsets.fromLTRB(10, 0, 10, 10);

  //Veri gelmediğinde de görünen temel sayfa görünümü
  Widget BasePage(Widget childWidget) {
    return Container(
      padding: fullHeightPadding,
      child: Card(
        color: appColors.clrDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        elevation: 25,
        shadowColor: Colors.black,
        child: Container(
            height: phoneHeight * heightFactor,
            width: phoneWidth * widthFactor,
            alignment: Alignment.center,
            child: childWidget
        ),
      ),
    );
  }

  //Çalışır halde youtube videosunu çekiyor
  Widget GetTrailerFromId() {
    // print("Video Çekiliyor: Trailer");

    return FutureBuilder<String>(
      future: movieTrailer,
      builder: (context, snapshot) {

        late Widget videoWidget;
        bool isDataLoaded = true;

        if (snapshot.connectionState != ConnectionState.done) {
          isDataLoaded = false;
          videoWidget = Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          isDataLoaded = false;
          videoWidget = Center(child: Text(snapshot.error.toString()));
        } else if (!snapshot.hasData) {
          isDataLoaded = false;
          videoWidget = Center(child: CircularProgressIndicator());
        }

        if (isDataLoaded) {

          YoutubePlayerController _controller = YoutubePlayerController(
            initialVideoId: snapshot.data!.toString(),
            flags: YoutubePlayerFlags(
              mute: false,
              enableCaption: true,
              loop: true,
            ),
          );

          //Veriler gelmiş herhangi bir sorun yok o zaman video widgetı yüklenebilir
          videoWidget = YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            builder: (context,player){
              return Container(child: player,);
            },
            onEnterFullScreen: (){
              setState(() {
                widthFactor = 1;
                heightFactor = 1;
                fullHeightPadding = EdgeInsets.zero;
                btnWidthFactor = 0;
              });
            },
            onExitFullScreen: (){
              widthFactor = 0.6;
              heightFactor = 0.5;
              fullHeightPadding = EdgeInsets.fromLTRB(10, 50, 10, 10);
              btnWidthFactor = 1;
            },
          );
        }

        return videoWidget;
      },
    );
  }

  // //Çalışır halde image çekiyor
  late Widget topWidget = FutureBuilder<String>(
    future: imageFromId,
    builder: (context, snapshot) {
      bool isDataLoaded = true;
      Widget? widgetTurn;

      if (snapshot.connectionState != ConnectionState.done) {
        isDataLoaded = false;
        widgetTurn = Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        isDataLoaded = false;
        widgetTurn = Center(child: Text(snapshot.error.toString()));
      } else if (!snapshot.hasData) {
        isDataLoaded = false;
        widgetTurn = Center(child: CircularProgressIndicator());
      }

      if (isDataLoaded) {


        Widget imageUrl = (snapshot.data != "no-image" && snapshot.data != "no-internet") ? Image.network(snapshot.data.toString(),fit: BoxFit.cover,)
            : (snapshot.data != "no-internet") ? Image.asset("assets/images/No-Image.jpg",fit: BoxFit.cover)
            : Center(child: Text("Internet Connection Lost",style: TextStyle(fontSize: 20,color: Colors.white)));

        // imageUrl =Image.asset("assets/images/No-Image.jpg",fit: BoxFit.cover);
        //Veriler gelmiş herhangi bir sorun yok o zamna video widgetı yüklenebilir
        widgetTurn = Stack(
          children: [
            //Poster Image
            ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Center(
                child: Container(
                  child: imageUrl,
                  height:800 ,
                  width:800 ,
                ),
              )
            ),
            //Watch Trailer
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints.tightFor(width: phoneWidth * 0.45),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        //MovieBottom yüklenmeden WatchTrailer a tıklanırsa çalışmayabilir çünkü
                        //movieTrailer ın dolması lazım aşağısı yüklenince
                        if(movieTrailer != null)
                          topWidget = GetTrailerFromId();
                        else
                          FlashMessage.ShowFlashMessage(context: context,text: "Please Wait for All Content to Load");
                      });
                    },
                    child: Text(
                      "Watch Trailer",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              side: BorderSide(color: Colors.transparent))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          appColors.clrRed.withOpacity(0.7)),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }

      return widgetTurn!;
    },
  );


  @override
  Widget build(BuildContext context) {
    return BasePage(topWidget);
  }
}
