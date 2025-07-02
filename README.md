# RhythmMonitor 

Bluetooth özellikli kalp hızı cihazlarına bağlanarak gerçek zamanlı kardiyovasküler izleme ve veri analizi yapan, SwiftUI ile geliştirilmiş gelişmiş bir iOS uygulaması.

![iOS](https://img.shields.io/badge/iOS-15.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.0+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-green.svg)
![Bluetooth](https://img.shields.io/badge/Bluetooth-BLE-lightblue.svg)

## 🎬 Uygulama Tanıtım Videosu

https://github.com/user-attachments/assets/50da7fed-94e1-480a-805e-434123edf984

## 🌟 Genel Bakış

RhythmMonitor, fitness meraklıları, sağlık profesyonelleri ve araştırmacılar için tasarlanmış kapsamlı bir kalp hızı izleme çözümüdür. Uygulama, Rhythm24 cihazları ve diğer Bluetooth Low Energy kalp hızı monitörleri ile sorunsuz entegrasyon sağlayarak, güzel animasyonlu görselleştirmelerle gerçek zamanlı kardiyovasküler veriler sunar.

## ✨ Ana Özellikler

### 🔄 Gerçek Zamanlı İzleme
- **Canlı Kalp Hızı Gösterimi**: Animasyonlu kalp ikonu ile büyük, okunması kolay BPM sayacı
- **Dinamik Görselleştirmeler**: Kalp hızıyla senkronize nabız animasyonları
- **Kalp Hızı Bölgeleri**: Otomatik kategorizasyon (Dinlenme, Aktif, Aerobik, Zirve)
- **Durum Göstergeleri**: Renk kodlu geri bildirimle gerçek zamanlı sağlık durumu

### 📊 Veri Toplama ve Analiz
- **60 Saniyelik Veri Toplama**: Her saniye sistematik kalp hızı veri toplama
- **CSV Dışa Aktarma**: Araştırma ve analiz için profesyonel veri dışa aktarma
- **İstatistiksel Analiz**: Ortalama, minimum ve maksimum kalp hızı hesaplamaları
- **Paylaşma İşlevi**: iOS paylaşım sayfası ile kolay veri paylaşımı

### 🔗 Bluetooth Bağlantısı
- **Cihaz Tarama**: Yakındaki BLE kalp hızı monitörlerinin otomatik algılanması
- **Sinyal Gücü Göstergeleri**: Bağlantı kalitesinin görsel temsili
- **Test Cihazı Modu**: Geliştirme ve demonstrasyon için yerleşik simülasyon
- **Bağlantı Yönetimi**: Durum güncellemeleri ile sağlam bağlantı işleme

### 📈 Analitik ve Geçmiş
- **Geçmiş Veriler**: Zaman damgalı kapsamlı oturum geçmişi
- **Haftalık Özetler**: Toplu istatistikler ve trendler
- **Görsel Analitik**: Grafikler ve şemalar (uygulamaya hazır)
- **Oturum Takibi**: Süre ve performans metrikleri

### 🎨 Modern UI/UX
- **Glassmorphism Tasarım**: Modern, yarı saydam arayüz öğeleri
- **Dinamik Arka Planlar**: Kalp hızı bölgelerine uyum sağlayan renk şemaları
- **Partikül Efektleri**: Gelişmiş kullanıcı deneyimi için ince animasyonlar
- **Duyarlı Tasarım**: Tüm iPhone ekran boyutları için optimize edilmiş

## 📱 Ekran Görüntüleri

### Hoş Geldiniz Ekranı
<img width="412" alt="Welcome Screen" src="https://github.com/user-attachments/assets/d6bd7f12-42c2-43f7-9755-5f32c5ea032d" />

### Cihaz Seçimi
<img width="412" alt="Device Selection" src="https://github.com/user-attachments/assets/a10eb012-acd3-45d2-8b16-551656092610" />

### Ana Sayfa - Canlı İzleme
<img width="402" alt="Live Monitoring" src="https://github.com/user-attachments/assets/9753de21-700d-4798-89e9-44ac6234b2e9" />

### Veri Toplama
<img width="420" alt="Data Collection" src="https://github.com/user-attachments/assets/0326edda-91fd-4d72-bade-53807c8a20b5" />

### Analitik
<img width="411" alt="Analytics" src="https://github.com/user-attachments/assets/327352a7-c2e2-4060-a734-57047ce9ac3e" />

### Geçmiş
<img width="418" alt="History" src="https://github.com/user-attachments/assets/0ee8ef45-e2c8-44be-9bd0-80f3f9bdd737" />

## 🛠 Teknik Mimari

### Temel Teknolojiler
- **SwiftUI**: Modern bildirimsel UI framework'ü
- **Core Bluetooth**: BLE cihaz iletişimi
- **Combine**: Veri akışı için reaktif programlama
- **CoreGraphics**: Özel animasyonlar ve görsel efektler

### Uygulama Yapısı
```
RhythmMonitorApp/
├── Views/
│   ├── welcome_page.swift          # Animasyonlu hoş geldiniz ekranı
│   ├── DeviceSelectionView.swift   # Bluetooth cihaz bağlantısı
│   ├── ContentView.swift           # Ana tab konteyner
│   ├── LiveMonitorView.swift       # Gerçek zamanlı izleme
│   ├── DataCollectionView.swift    # Veri toplama arayüzü
│   ├── AnalyticsView.swift         # İstatistikler ve trendler
│   ├── HistoryView.swift           # Geçmiş veriler
│   └── ProfileView.swift           # Kullanıcı ayarları
├── Managers/
│   └── BluetoothManager.swift      # BLE iletişimi
├── Models/
│   └── HeartbeatData.swift         # Veri yapıları
└── ViewModels/
    └── HeartbeatViewModel.swift    # İş mantığı
```

## 🚀 Kurulum ve Kurulum

### Ön Koşullar
- Xcode 14.0+
- iOS 15.0+ hedef cihaz
- Bluetooth özellikli kalp hızı monitörü (isteğe bağlı - test modu mevcut)

### Derleme Talimatları
1. **Repository'yi klonlayın**
   ```bash
   git clone [repository-url]
   cd RhythmMonitorApp
   ```

2. **Xcode'da açın**
   ```bash
   open RhythmMonitorApp.xcodeproj
   ```

3. **Bluetooth İzinlerini Yapılandırın**
   - Info.plist'te `NSBluetoothAlwaysUsageDescription` ayarlandığından emin olun
   - Bluetooth erişimi için gizlilik kullanım açıklamaları ekleyin

4. **Derleyin ve Çalıştırın**
   - Hedef cihazı veya simülatörü seçin
   - Projeyi derleyin ve çalıştırın (⌘+R)

## 📱 Kullanım Kılavuzu

### Başlarken
1. **Uygulamayı Başlatın**: Animasyonlu hoş geldiniz ekranıyla başlayın
2. **Cihaz Bağlayın**: Bluetooth taramaya erişmek için "Cihaz Bağla"yı seçin
3. **Monitör Seçin**: Kalp hızı cihazınızı seçin veya "Test Cihazı"nı kullanın
4. **İzlemeyi Başlatın**: Gerçek zamanlı kalp hızı verilerine erişin

### Veri Toplama
1. **Toplama Sekmesine Git**: Ana arayüzdeki "Toplama" sekmesine dokunun
2. **Toplamayı Başlat**: 60 saniyelik veri toplama için "Toplamayı Başlat"a basın
3. **İlerlemeyi İzleyin**: Dairesel ilerleme göstergesini izleyin
4. **Veriyi Dışa Aktar**: Toplanan verileri CSV dosyası olarak paylaşın

### İzleme Özellikleri
- **Canlı Görünüm**: Animasyonlu görselleştirmelerle gerçek zamanlı BPM
- **Bölge Algılama**: Otomatik kalp hızı bölgesi sınıflandırması
- **Oturum Takibi**: Antrenman süresi ve ortalamaları izleyin
- **Geçmiş**: Geçmiş oturumları ve trendleri gözden geçirin

## 🎯 Kalp Hızı Bölgeleri

| Bölge | BPM Aralığı | Renk | Açıklama |
|-------|-------------|------|----------|
| Dinlenme | 0-60 | Mavi | Dinlenme kalp hızı |
| Aktif | 60-100 | Yeşil | Normal aktif aralık |
| Aerobik | 100-140 | Sarı | Aerobik egzersiz bölgesi |
| Zirve | 140+ | Kırmızı | Yüksek yoğunluk bölgesi |


## 👨‍💻 Geliştirici

**Furkan Cinko**
- E-posta: [furkan_cinko@outlook.com]
- LinkedIn: [https://www.linkedin.com/in/furkancinko/]

---
