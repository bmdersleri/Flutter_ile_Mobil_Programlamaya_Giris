
import 'package:flutter/material.dart';

class Zafiman extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        backgroundColor: Colors.teal,
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 600,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white54,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15 , right: 6),
                  child: Text(''
                     'ایمان به خدای متعال انسان را از معصیت و نافرمانی باز می‌دارد و بسان سنگی سخت خواسته‌های نفس سرکش را در هم می‌شکند. از این رو هرچه ایمان انسان رو به ضعف و سستی نهد، انسان در نافرمانی خدا جرأت و گستاخی بیش‌تری می‌یابد. چنانچه در حدیثی از رسول اکرم ج به این نکته اشاره شده که انسان زمانی مرتکب عمل زشتی می‌شود که ایمانش رو به ضعف و سستی نهاده است. رسول الله صلی الله علیه وسلم فرموده است: «لاَ يَزْنِي الزَّانِي حِينَ يَزْنِي وَهُوَ مُؤْمِن»( ). یعنی: «زناکار هنگام ارتکاب عمل زنا مؤمن نیست».'
              ' کسی که ایمانش را تقویت نماید و به رتبه‌ای برسد که در حال عبادت گویا خدا را می‌بیند، در انجام گناه و معصیت خدا نیز بی‌پروا و گستاخ نخواهد بود؛ چنین فردی اگر به هنگامی دچار شود، از ادامه‌ی آن عمل خودداری می‌کند و خیلی زود توبه می‌نماید'
                    '\n'
                        '\n'
                        '\n'
                    '..........................'
                    '\n'
                    ' . روایت بخاری، حدیث (2475)؛ مسلم (57) -',
                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 17,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ),
          ],
        ),

      ),
    );


  }
}