# MySQL PowerShell Tools -

## English

### Overview
This repository contains three PowerShell scripts for MySQL database administration:

1. **Get-MySqlProcessList.ps1** - Shows active processes in MySQL server
2. **Get-MySqlTables.ps1** - Lists all tables in a specified database
3. **Get-MySqlStatus.ps1** - Displays server status variables

### Requirements
- PowerShell 5.1 or later
- MySQL Connector/NET installed
- MySQL server access credentials

### Installation
1. Install MySQL Connector/NET from [MySQL website](https://dev.mysql.com/downloads/connector/net/)
2. Clone this repository or download the script files

### Usage
Run any script with basic parameters:
```powershell
.\Get-MySqlProcessList.ps1 -server "localhost" -port 3306 -db "your_database"
```

Common parameters for all scripts:
- `-server`: MySQL server address (default: localhost)
- `-port`: MySQL port (default: 3306)
- `-db`: Database name (default: quiz_app)
- `-verbose`: Show detailed output
- `-debug`: Enable debug mode

### Features
- Secure credential prompting
- Detailed error handling
- Configurable connection settings
- Clean tabular output

## Türkçe

### Genel Bakış
Bu depo, MySQL veritabanı yönetimi için üç PowerShell scripti içerir:

1. **Get-MySqlProcessList.ps1** - MySQL sunucusundaki aktif işlemleri gösterir
2. **Get-MySqlTables.ps1** - Belirtilen veritabanındaki tüm tabloları listeler
3. **Get-MySqlStatus.ps1** - Sunucu durum değişkenlerini gösterir

### Gereksinimler
- PowerShell 5.1 veya üzeri
- MySQL Connector/NET kurulu olmalı
- MySQL sunucusu erişim bilgileri

### Kurulum
1. [MySQL websitesinden](https://dev.mysql.com/downloads/connector/net/) MySQL Connector/NET'i yükleyin
2. Bu depoyu klonlayın veya script dosyalarını indirin

### Kullanım
Temel parametrelerle herhangi bir scripti çalıştırın:
```powershell
.\Get-MySqlProcessList.ps1 -server "localhost" -port 3306 -db "veritabaniniz"
```

Tüm scriptlerde ortak parametreler:
- `-server`: MySQL sunucu adresi (varsayılan: localhost)
- `-port`: MySQL portu (varsayılan: 3306)
- `-db`: Veritabanı adı (varsayılan: quiz_app)
- `-verbose`: Detaylı çıktı göster
- `-debug`: Hata ayıklama modunu etkinleştir

### Özellikler
- Güvenli kimlik bilgisi girişi
- Detaylı hata yönetimi
- Yapılandırılabilir bağlantı ayarları
- Düzenli tablo formatında çıktı

### Katkı
Hatalar veya geliştirme önerileri için issue açabilir veya pull request gönderebilirsiniz.

### Lisans
Bu proje MIT lisansı altında dağıtılmaktadır.
