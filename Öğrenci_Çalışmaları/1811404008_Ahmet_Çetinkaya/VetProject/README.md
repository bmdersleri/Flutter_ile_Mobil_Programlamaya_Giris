# VetProject

Not: Demo ürün sağlamak adına, servisler backend api'ı taklit edecek şekilde local storage'da yer alan json database'den üzerinden faaliyet gösteren fake servisler olarak değiştirildi.

## Install

- `flutter pub get` komutunu çalıştırarak paketleri yükleyin.
- `.env.example` dosyasını `.env` isimlendirmesiyle kopyasını oluşturun ve ilgili alanları doldurun.

## Dev Guide

- Commit'ler, uygulamaya yeni bir özellik eklediğinizde özelliğin yaptığı işlevle birlikte commit'i isimlendirerek push etmeniz projenin takip edilebilmesi ve referans gösterilebilmesi daha kolay olacaktır.
- Yeni feature'lar eklerken PathologyReports feature'u `lib/src/features/pathologyReports` örnek alınabilir ve diğer alt bölümleri alt formlar halinde eklenebilir. Kod örneği hakkında sorunuz varsa ilgili e-posta adresimden ulaşabilirsiniz [ahmetcetinkaya7@outlook.com](mailto:ahmetcetinkaya7@outlook.com).

# Flutter

## Getting Started

This project is a starting point for a Flutter application that follows the
[simple app state management
tutorial](https://flutter.dev/docs/development/data-and-backend/state-mgmt/simple).

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Assets

The `assets` directory houses images, fonts, and any other files you want to
include with your application.

The `assets/images` directory contains [resolution-aware
images](https://flutter.dev/docs/development/ui/assets-and-images#resolution-aware).

## Localization

This project generates localized messages based on arb files found in
the `lib/src/localization` directory.

To support additional languages, please visit the tutorial on
[Internationalizing Flutter
apps](https://flutter.dev/docs/development/accessibility-and-localization/internationalization)
