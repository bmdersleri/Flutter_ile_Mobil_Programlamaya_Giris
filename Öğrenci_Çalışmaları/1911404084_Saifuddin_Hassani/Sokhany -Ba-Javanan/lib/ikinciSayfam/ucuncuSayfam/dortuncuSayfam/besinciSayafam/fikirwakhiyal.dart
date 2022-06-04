
import 'package:flutter/material.dart';

class fikri extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green[100],
      appBar: AppBar(
        title: Text('فکر وخیال در مورد مسایل جنسی'),
        backgroundColor: Colors.teal,
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                height: 900,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white54,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20 , right: 6),
                  child: Text(
                      'این از رحمت و عدل الهی است که بندگانش را به خاطر فکرها و خیال‌هایی که به ذهنشان می‌رسد، بازخواست نمی‌کند مگر آنکه فکر و خیال در قالب گفتار و کردار نمایان گردد.'
                      'هنگامی که فردی در فکر و خیال مسایل جنسی فرو می‌رود، قدری لذت می‌برد و این حالت در ابتدا فقط افکار و خیالاتی می‌باشد که ممکن است انجام آن بر شخص از افتادن از آسمان هم دشوارتر باشد؛ اما تداوم این خیال‌ها سبب می‌شود که این افکار در حال نماز نیز به سراغ انسان بیاید''! چنانچه جوانان زیادی در این باره با من سخن گفته و از چنین حالتی نالیده‌اند... زمانی که تصورات و تخیلات جنسی سراغ دختر یا پسر جوان می‌آید و این حالت به درازا می‌کشد، خواهشات نفسانی در جوان به جوش و حرکت می‌آید، بر قلب و وجودش چیره می‌گردد و آتش خواسته‌های درون زبانه می‌کشد، از این رو با جدیت تمام از راه‌دادن افکار و تخیلات جنسی به خود بپرهیز و هرگاه که چنین تصوراتی به سراغت آمد، تمام راه‌ها را بر آن ببند تا در تو نفوذ نکند؛ بدین منظور سمت و سوی فکر و خیالت را متوجه چیزهایی کن که در دنیا و آخرت سودمند است''. در آفریده‌های الهی، در عظمت الهی، در واقعیت‌های دردناک امت اسلامی و نیز پیرامون آخرت و قیامت بیندیش',



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