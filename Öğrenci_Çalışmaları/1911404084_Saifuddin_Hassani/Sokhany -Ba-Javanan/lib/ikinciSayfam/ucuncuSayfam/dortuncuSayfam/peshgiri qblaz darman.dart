
import 'package:flutter/material.dart';

class peshgiri extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('پیش گیری قبل از درمان'),
        backgroundColor: Colors.teal,
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 1000,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white54,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15 , right: 6),
                  child: Text(
                      'کدامین راه آسان‌تر است و شما کدام یک راه را انتخاب می‌کنید؟ این راه که مهار نفستان را رها کنید و تمام درها را به رویش باز بگذارید تا شما را به هلاکت و نابودی بکشد و سپس از درِ رویارویی با شهوت و هوای نفس برآیید یا این راه که از همان اول تمام درهای سرکشی را بر نفستان ببندید و ابزار طغیان را از آن باز بدارید؟.'
                     ' بدون تردید هر عاقل و خردمندی راه دوم را انتخاب می‌کند و تمام درها و راه‌های سرکشی را بر نفسش می‌بندد؛ باید دانست که رهنمود دین و شریعت نیز همین است''. آیا از نگاه عقل و شرع درست است که انسان هم چشم‌چرانی بکند و هم از تخیلات جنسی و چیرگی شهوت بر قلب و احساساتش بنالد؟''! مگر درست و عاقلانه است که انسان مجله‌های آکنده از تصاویر مبتذل را ورق بزند و یا فیلم‌های فاسد و فرومایه ببیند و باز بپرسد که چطور می‌توانم عفیف و پاک‌دامن باشم؟''! اصلاً آیا انسانی که ترانه‌های عاشقانه و مبتذل گوش می‌دهد، می‌تواند از منجلاب فساد و هرزگی رهایی یابد؟''!.'
                  'ای خواهر و برادر گرامی''!'' اگر می‌خواهید در دام فساد نیفتید، از همان ابتدا راهتان را کوتاه کنید و هر روزنه‌ای را که از آن بادی برای به دام‌انداختن شما می‌وزد، ببندید؛ خودتان از حال خود بیش‌تر خبر دارید.'' بنابراین، به هر دوست بد کتاب مجله و نواری که شما را به معصیت و گناه فرا می‌خواند و غرایز و خواسته‌های نفسانیتان را برمی‌انگیزد، بگویید: پس از این دیگر با تو کاری ندارم',


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