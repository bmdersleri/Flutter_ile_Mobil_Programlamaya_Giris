
import 'package:flutter/material.dart';

class bikari extends StatelessWidget {


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
                height: 1200,
                width: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white54,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15 , right: 6),
                  child: Text(''
                     'بیکاری و تنهایی از دیگر عواملی است که خواسته‌های نفسانی را برمی‌انگیزد. هنگامی که دختر یا پسر جوانی تنها می‌شود، فکرهای زیادی به ذهنش خطور می‌کند؛ در آن هنگام شیطان نیز می‌کوشد تا زمام کار به دست گیرد و جوان را در فکر و خیال لذایذ جنسی بیندازد. همه چیز از فکر و خیال شروع می‌شود و سپس دامنه‌ی فکر و خیال گسترش می‌یابد و به قصد و نیت می‌انجامد و آنگاه به تصمیمی قطعی تبدیل می‌گردد و سپس...!'
                  'کم‌‌ترین پیامد تنهایی و فکر و خیال‌های پس از آن منش و رفتاری پنهانی همچون خودارضایی خواهد بود که پیامدهای ناگواری به دنبال دارد؛ از جمله'': غم و اندوه، کم‌هوشی، سست اراده‌شدن، از بین‌رفتن غیرت و مردانگی، آسیب‌دیدن حافظه و بینایی، افتادگی و خمیدگی شانه‌ها، ضعف و نارسایی گوارشی''.'
                  'همچنین تداوم خودارضایی فرد را از انجام وظیفه‌ی زناشویی ناتوان می‌کند، البته این عمل پیش از آنکه پیامدهای مذکور را به دنبال داشته باشد، کرداری غیر شرعی است که این فرموده‌ی الهی در باره‌اش صادق می‌باشد:'' ﴿فَمَنِ ٱبۡتَغَىٰ وَرَآءَ ذَٰلِكَ فَأُوْلَٰٓئِكَ هُمُ ٱلۡعَادُونَ٧﴾ [المؤمنون: 7]. «افرادی که در پی راهی غیر از این (''دو راه)'' هستند، تجاوزکنندگان (''از حدود شریعت) می‌باشند».'
                'بسیاری از جوانان به این نکته اذعان دارند که بیش‌تر در مواقعی خودارضایی می‌کنند که تنها و بیکارند.'
                'همچنین تنهایی خاستگاه و آغاز برقراری رابطه‌ی بسیاری از دختران با پسرها بوده است',


                    style: TextStyle(
                      fontFamily: 'Tajawal',
                      fontSize: 18,
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