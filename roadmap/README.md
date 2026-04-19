# Mobil Uygulama Geliştirici 14 Haftalık Yol Haritası

Flutter, Android ve iOS ekseninde; temelden portföye, portföyden işe alınabilir seviyeye uzanan yapılandırılmış bir öğrenme planı.

## İçindekiler
- [Genel Bakış](#genel-bakış)
- [Bu Dokümanın Amacı](#bu-dokümanın-amacı)
- [Hedef Kitle](#hedef-kitle)
- [Öğrenme Yaklaşımı](#öğrenme-yaklaşımı)
- [Platform Seçim Rehberi](#platform-seçim-rehberi)
- [Her Yol İçin Ortak Temel](#her-yol-için-ortak-temel)
- [14 Haftalık Öğrenme Planı](#14-haftalık-öğrenme-planı)
- [6–9 Aylık Geniş Öğrenme Perspektifi](#69-aylık-geniş-öğrenme-perspektifi)
- [Portföy Proje Sıralaması](#portföy-proje-sıralaması)
- [İşe Alınabilir Seviye İçin Kritik Yetkinlikler](#işe-alınabilir-seviye-için-kritik-yetkinlikler)
- [Bu Yol Haritası Nasıl Kullanılmalı?](#bu-yol-haritası-nasıl-kullanılmalı)
- [Önerilen Çalışma Disiplini](#önerilen-çalışma-disiplini)
- [Önerilen Repo Düzeni](#önerilen-repo-düzeni)
- [Çıktılar ve Beklenen Kazanımlar](#çıktılar-ve-beklenen-kazanımlar)
- [Kaynak Dosya](#kaynak-dosya)
- [Hazırlayan](#hazırlayan)

---

## Genel Bakış

Bu çalışma, mobil uygulama geliştirici olmak isteyenler için hazırlanmış **14 haftalık yoğunlaştırılmış bir öğrenme yol haritasını** sunar. Yol haritası; **Flutter**, **Android Native (Kotlin)** ve **iOS Native (Swift)** ekseninde ilerleyen, ancak önce ortak mühendislik temellerini kurmayı öneren bir yapıya sahiptir.

Doküman yalnızca konu listesi vermekle kalmaz; aynı zamanda:
- hangi sırayla öğrenilmesi gerektiğini,
- hangi becerilerin portföyde görünür olması gerektiğini,
- küçük uygulamalardan capstone projeye nasıl geçileceğini,
- yayınlama, test, mimari ve ürünleşme gibi profesyonel başlıkların ne zaman devreye alınacağını
sistematik biçimde açıklar.

Bu nedenle doküman, hem **ders materyali**, hem **kişisel gelişim planı**, hem de **repo/portföy rehberi** olarak kullanılabilecek niteliktedir.

---

## Bu Dokümanın Amacı

Bu PDF'nin temel amacı, öğreneni sadece “arayüz yapan kişi” seviyesinde bırakmayıp; **gerçek veri ile çalışan, test yazabilen, temiz mimari kurabilen ve ürününü yayınlamaya yaklaştırabilen geliştirici** seviyesine taşımaktır.

Doküman şu dönüşümü hedefler:

> Temel programlama bilgisi → Uygulama geliştirme pratiği → Üretim seviyesi disiplin → Portföy değeri taşıyan proje

---

## Hedef Kitle

Bu yol haritası özellikle aşağıdaki profiller için uygundur:

- Mobil uygulama geliştirmeye yeni başlayan öğrenciler
- Flutter ile hızlı ürün geliştirmek isteyenler
- Android tarafında Kotlin ve modern Android mimarilerini öğrenmek isteyenler
- iOS tarafında Swift/SwiftUI/UIKit ekseninde ilerlemek isteyenler
- Ders/lab projesini gerçek portföy çıktısına dönüştürmek isteyenler
- 3–9 aylık planla işe alınabilir profil oluşturmak isteyen junior geliştiriciler

---

## Öğrenme Yaklaşımı

Doküman, öğrenmeyi üç katmanlı bir yapı üzerinden kurgular:

### 1. Temel Katman
Bu aşamada amaç, mobil geliştirme öncesi ortak zemini oluşturmaktır.

Odak başlıklar:
- Programlama mantığı ve temel algoritmik düşünme
- Geliştirme araçlarının kurulumu
- Dil temelleri ve sözdizimi
- İlk çalışan uygulamaların geliştirilmesi

### 2. Uygulama Katmanı
Bu aşamada kullanıcı arayüzü ve etkileşimli uygulama akışları kurulur.

Odak başlıklar:
- Widget ve arayüz tasarımı
- Sayfa akışları ve navigasyon
- Formlar, listeler ve etkileşim
- Veri akışı ve yerel durum yönetimi

### 3. Üretim Katmanı
Bu katmanda uygulama, profesyonel düzeye taşınır.

Odak başlıklar:
- API ve veri saklama entegrasyonları
- Mimari ve state management
- Kimlik doğrulama ve bulut servisleri
- Test, CI/CD ve mağaza dağıtımı

---

## Platform Seçim Rehberi

Doküman, öğrenme yoluna başlamadan önce stratejik bir seçim yapılmasını önerir:

### Flutter ile Başlamak
Flutter; tek kod tabanı ile hızlı ürün çıkarma, prototipleme ve eğitim/lab projeleri için güçlü bir başlangıç sağlar. Dart dili, widget mantığı ve çoklu platform düşüncesi kazandırır.

### Android Native (Kotlin)
Android tarafı; Gradle, Android yaşam döngüsü, Google ekosistemi ve modern Android bileşenleri üzerinden derinleşmek isteyenler için uygundur.

### iOS Native (Swift)
iOS tarafı; Xcode, Apple tasarım yaklaşımı, Swift/SwiftUI/UIKit ve App Store odaklı daha premium bir ürün geliştirme çizgisi sunar.

### Stratejik Öneri
Yeni başlayanlar için en dengeli başlangıç genellikle:

1. Önce **Flutter + Dart** ile ürün geliştirme mantığını kavramak,
2. Sonra kariyer hedefi doğrultusunda **Android** veya **iOS native** tarafta uzmanlaşmaktır.

---

## Her Yol İçin Ortak Temel

Platform değişse bile değişmeyen çekirdek yetkinlikler şunlardır:

- **Programlama temeli:** değişkenler, veri tipleri, fonksiyonlar, kontrol yapıları
- **OOP ve veri yapıları:** sınıf, nesne, koleksiyonlar, temel algoritmik düşünme
- **Git ve repo yönetimi:** commit disiplini, sürüm takibi, GitHub kullanımı
- **Geliştirme ortamı:** IDE, emülatör/simülatör, paket yöneticisi ve debug araçları
- **HTTP/JSON mantığı:** API ile iletişim, veri alma, ayrıştırma, hata yönetimi
- **Test ve kalite kültürü:** unit test, widget/UI test, performans farkındalığı

Bu temel kurulmadan framework odaklı ilerlemek kısa vadede hız kazandırsa da, orta ve uzun vadede proje karmaşasını artırır.

---

## 14 Haftalık Öğrenme Planı

Aşağıdaki plan, PDF içeriğinin düzenli ve repo-dostu bir özetidir. Dokümanda ilk iki hafta tek bir temel blok olarak ele alınmıştır.

| Hafta | Tema | Ana Odak | Örnek Çıktı |
|---|---|---|---|
| 1–2 | Dart Temelleri ve Akıcılık | Syntax, veri tipleri, kontrol akışları, fonksiyonlar, koleksiyonlar, OOP, async temelleri | Konsol tabanlı hesap makinesi, veri modeli denemeleri |
| 3 | Widget ve Uygulama Mimarisi | Widget tree, Stateless/Stateful ayrımı, Scaffold, temel state mantığı | Sayaç uygulaması, profil/detay ekranı |
| 4 | Layout ve Temel Arayüz | Row, Column, Container, Stack, Text, Image, Icon, Buttons | Landing page veya profil ekranı |
| 5 | Formlar ve Kullanıcı Etkileşimi | Form yapıları, validator, controller, dialog/snackbar/popup | Giriş / kayıt ekranı |
| 6 | Navigasyon ve Çok Ekranlı Uygulama | Navigator, named routes, bottom navigation, drawer, geçişler | 3–4 ekranlı katalog uygulaması |
| 7 | Listeler, Kartlar, Tema ve Assets | ListView, GridView, ListTile, tema sistemi, asset yönetimi | Ürün/not listesi, dark-light tema denemesi |
| 8 | Yerel Veri Saklama ve JSON | SharedPreferences, SQLite, modelleme, JSON dönüşümleri | Günlük/not uygulaması, CRUD akışı |
| 9 | API Tüketimi ve Asenkron Veri Akışı | HTTP istekleri, Future/Stream, loading/error/empty durumları | Hava durumu veya haber uygulaması |
| 10 | State Management ve Proje Mimarisi | Provider/BLoC, klasörleme, reusable widget, SOLID | Önceki projeyi refactor etme |
| 11 | Firebase, Kimlik Doğrulama ve Bulut Veri | Authentication, Firestore, güvenlik kuralları, push notifications | Login + profil + bulut veri prototipi |
| 12 | Test, Hata Ayıklama ve Performans | Unit/widget/integration test, debug araçları, profiling, linting | Kritik akışları testlenmiş proje |
| 13 | CI/CD, Yayınlama Hazırlığı ve Ürünleşme | GitHub, Codemagic/Fastlane, signing, build, store materyalleri | README, demo videosu, release adayı |
| 14 | Capstone Teslimi ve Sonraki Uzmanlaşma | Bug fixing, demo, platform seçimi, mülakat hazırlığı | Auth + UI + test + README içeren güçlü final proje |

---

## 6–9 Aylık Geniş Öğrenme Perspektifi

Doküman, 14 haftalık yoğun plana ek olarak daha geniş bir zaman perspektifi de sunar:

### 1–2. Ay: Temeller
- Dil temeli (Dart/Kotlin/Swift)
- IDE ve emülatör/simülatör kurulumu
- 2 küçük demo uygulama

### 3–4. Ay: Gelişim
- UI, form, liste, navigasyon
- State mantığı
- Orta ölçekli ilk proje

### 5–6. Ay: Uzmanlık
- API, local storage, auth
- Temel test ve debug süreçleri
- Veri odaklı portföy uygulaması

### 7–9. Ay: Final
- Temiz mimari
- CI/CD ve dağıtım hazırlığı
- Capstone proje ve GitHub düzeni

Bu yapı, düzenli pratik ile 9 ay içinde sektöre yaklaşan bir profil oluşturmayı hedefler.

---

## Portföy Proje Sıralaması

Doküman, portföy inşasını rastgele değil, beceri katmanları halinde önerir:

### Proje 1 — Temel Başlangıç
- To-do / not alma / görev takibi
- Hedef: temel UI, form ve local state

### Proje 2 — Veri Yönetimi
- Hava durumu / haber / katalog uygulaması
- Hedef: API tüketimi, liste-detay akışı, hata yönetimi

### Proje 3 — Full Entegrasyon
- Firebase tabanlı auth + CRUD uygulaması
- Hedef: kullanıcı yönetimi, persistence ve gerçek veri akışı

### Proje 4 — Final Masterpiece
- Gerçek problemi çözen capstone proje
- Hedef: mimari, test, ürünleşme ve yayınlama hazırlığı

**Kritik ilke:** Her yeni proje, portföyde görünür biçimde yeni bir beceri eklemelidir.

---

## İşe Alınabilir Seviye İçin Kritik Yetkinlikler

PDF'nin en güçlü mesajlarından biri, sadece ekran tasarlamanın yeterli olmadığıdır. İşe alınabilir seviyeye yaklaşmak için aşağıdaki bileşenlerin birlikte görünmesi gerekir:

### Mimari ve Veri
- MVVM / BLoC / Provider gibi yaklaşımlarla temiz yapı
- State management ve dependency ayrımı
- Yerel veri saklama ve API entegrasyonu

### Kalite ve Süreç
- Unit/UI testleri
- Debugging ve hata takibi
- CI/CD ve sürüm hazırlığı
- Erişilebilirlik ve dokümantasyon

### Portföyde Görünmesi Gereken Kombinasyon
En az bir projede aşağıdaki dörtlü birlikte görünmelidir:

- veri saklama
- API entegrasyonu
- test
- temiz mimari

Bu kombinasyon, junior seviyeden üretim yapabilen profile geçişte güçlü bir sinyal üretir.

---

## Bu Yol Haritası Nasıl Kullanılmalı?

Bu doküman aşağıdaki üç farklı senaryoda kullanılabilir:

### 1. Bireysel Öğrenme Planı Olarak
Her haftayı bir sprint gibi düşünerek konu, mini uygulama ve haftalık çıktı odaklı ilerleyebilirsiniz.

### 2. Ders / Atölye Planı Olarak
Haftalık tema + uygulama + raporlama yapısı, üniversite dersi veya bootcamp düzeni için uygundur.

### 3. Portföy ve GitHub Yönetim Rehberi Olarak
Her haftanın çıktısını ayrı klasör veya branch mantığıyla kaydederek, ilerlemenizi görünür kılabilirsiniz.

---

## Önerilen Çalışma Disiplini

Yol haritasından maksimum verim almak için şu çalışma modeli önerilir:

- Her hafta **tek bir ana odak** belirleyin.
- Teoriyi aynı hafta içinde mutlaka **mini proje** ile pekiştirin.
- Her hafta sonunda kısa bir **ilerleme notu** veya **öğrenme günlüğü** yazın.
- Her 2–3 haftada bir önceki kodu dönüp **iyileştirin/refactor edin**.
- GitHub üzerinde düzenli commit geçmişi oluşturarak gelişiminizi belgelendirin.
- PDF'deki planı birebir uygulamak yerine, kendi hızınıza göre **uyarlanabilir sprintler** oluşturun.

---

## Önerilen Repo Düzeni

Aşağıdaki yapı, bu PDF'yi temel alan bir öğrenme reposu için **öneri** niteliğindedir:

```text
mobile-developer-roadmap/
├─ README.md
├─ docs/
│  ├─ Mobil_Uygulama_Gelistirici_14_Haftalik_Yol_Haritasi.pdf
│  ├─ weekly-notes/
│  │  ├─ week-01-02.md
│  │  ├─ week-03.md
│  │  ├─ week-04.md
│  │  └─ ...
│  └─ portfolio-notes/
├─ projects/
│  ├─ 01-basic-ui/
│  ├─ 02-api-app/
│  ├─ 03-firebase-crud/
│  └─ 04-capstone/
├─ assets/
│  ├─ screenshots/
│  └─ demo-videos/
└─ adr/
   ├─ 001-state-management-choice.md
   ├─ 002-folder-structure.md
   └─ 003-release-strategy.md
```

Bu yapı sayesinde hem öğrenme süreci hem de teknik kararlar düzenli biçimde izlenebilir.

---

## Çıktılar ve Beklenen Kazanımlar

Bu yol haritası sonunda öğrenenin aşağıdaki çıktılara ulaşması beklenir:

- Mobil geliştirme ekosisteminin temel kavramlarını anlama
- Flutter veya native bir hatta üretim yapabilecek seviyeye yaklaşma
- Çok ekranlı, veri odaklı uygulamalar geliştirme
- Yerel veri, API ve bulut servislerini entegre etme
- Temiz klasör yapısı ve sürdürülebilir state yönetimi kurma
- Test, hata ayıklama ve performans farkındalığı kazanma
- README, demo videosu ve yayınlama hazırlığı olan bir proje sunma
- İşe alım sürecinde gösterilebilecek güçlü bir capstone proje üretme

---

## Kaynak Dosya

Bu README, aşağıdaki sunum/doküman temel alınarak hazırlanmıştır:

- `Mobil_Uygulama_Gelistirici_14_Haftalik_Yol_Haritasi.pdf`

İdeal kullanım:
1. Önce PDF'yi genel bakış için inceleyin.
2. Sonra README üzerinden yapılandırılmış öğrenme planını takip edin.
3. Her bölümün sonunda kendi proje çıktınızı üretin.

---

## Hazırlayan

**Prof. Dr. İsmail KIRBAŞ**  
19 Nisan 2026, Burdur

---

## Not

Bu README, PDF içeriğini GitHub veya benzeri bir repo ortamında daha okunabilir, sürdürülebilir ve yeniden kullanılabilir hale getirmek amacıyla hazırlanmıştır. Doğrudan ders materyali, öğrenme planı, proje deposu açıklaması veya portföy reposu ana sayfası olarak kullanılabilir.
