import 'package:flutter/material.dart';

import '../../utils/constants.dart';
import '../widgets/app_title.dart';

class InstructionPage extends StatelessWidget {
  const InstructionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle? headline6 = Theme.of(context).textTheme.headline6;
    TextStyle? bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(
          leadingTitle: 'S.S.S',
        ),
        actions: const [
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          ),
          Icon(
            Icons.ac_unit,
            color: Colors.transparent,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Yapılacaklar listesine nasıl öğe eklenir?',
                style: headline6,
              ),
              Text(
                'Ne yapman gerekiyor? yazılı büyük kutuya dokunup görevinizi yazın ve enter tuşuna basın.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Listedeki bir öğe tamamlandı olarak nasıl işaretlenir?',
                style: headline6,
              ),
              Text(
                'Yapılacaklar listesindeki öğe adının başındaki boş kutucuğa dokunun.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Yapılacaklar kalıcı olarak nasıl silinir?',
                style: headline6,
              ),
              Text(
                'Silmek istediğiniz öğeyi herhangi bir yönden kaydırmanız yeterlidir.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Yapılacaklar nasıl yıldızlı olarak işaretlenir?',
                style: headline6,
              ),
              Text(
                'Yıldızlı olarak işaretlemek istediğiniz öğe isminin yanındaki yıldız\'a dokunmanız gerekmektedir.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Yapılacaklar listesindeki bir öğeyi nasıl düzenlerim?',
                style: headline6,
              ),
              Text(
                'Düzenlemek istediğiniz öğenin adına dokunmanız yeterlidir.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Yedekleme nasıl yapılır?',
                style: headline6,
              ),
              Text(
                '\'Yedekle & Geri Yükle\' sekmesine girip ardından \'Yedek oluştur\' butonuna dokunun. Yedeğiniz "/Android/data/$appName/files/" klasöründe oluşturulmuştur. Lütfen uygulamanın dosyalarınıza erişmesine izin veriniz.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Yedekleme nasıl geri yüklenir?',
                style: headline6,
              ),
              Text(
                '\'Yedekle & Geri Yükle\' sekmesine girip ardından \'Yedekten geri yükle\' butonuna dokunun. Yüklemek istediğiniz yedeğin üzerine tıklayın ve \'Geri yükle\' butonuna basın.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Yedeklerimi nasıl paylaşabilirim?',
                style: headline6,
              ),
              Text(
                '\'Yedekle & Geri Yükle\' sekmesine girip ardından \'Yedekten geri yükle\' butonuna dokunun. Saat ve tarihe göre oluşturulan tüm yedeklemeleri bulabileceğiniz \'Yedekleme Listesi\' sayfasına yönlendirileceksiniz. Yedek dosya adının yanındaki paylaş simgesine dokunun. JSON dosya formatında paylaşmak istediğiniz her yerde paylaşın.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Yedekleme dosyası depolamadan nasıl geri yüklenir?',
                style: headline6,
              ),
              Text(
                '\'Yedekle & Geri Yükle\' sayfasına gidin ve \'Depolamadan yükle\' butonuna dokunun. Ardından, geçerli bir JSON dosyası seçin ve yedekleme tamamlandı.',
                style: bodyText1,
              ),
              const Divider(height: 16),
              Text(
                'Oluşturduğum yedekleme dosyalarını nerede bulabilirim?',
                style: headline6,
              ),
              Text(
                'Dosya yöneticinizde "/Android/data/$appName/files/" konumuna gidin. Oluşturulan tüm yedekleme dosyalarını bu klasörde bulacaksınız.',
                style: bodyText1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
