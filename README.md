# Kalendarz Śmieci

Aplikacja mobilna do automatycznego dodawania dat wywozu śmieci do kalendarza telefonu na podstawie zdjęcia.

## Funkcjonalności

- 📸 Zrobienie zdjęcia lub wybór z galerii
- 🔍 Automatyczne rozpoznawanie dat ze zdjęcia (OCR)
- 📅 Dodawanie wszystkich znalezionych dat do kalendarza telefonu
- ⏰ Automatyczne ustawienie przypomnienia 1 dzień wcześniej

## Wymagania

- Flutter SDK (3.0.0 lub nowszy)
- Android Studio / Xcode (dla iOS)
- Telefon z systemem Android lub iOS

## Instalacja i uruchomienie

### 1. Zainstaluj Flutter

Jeśli nie masz Flutter:
1. Pobierz Flutter SDK z: https://flutter.dev/docs/get-started/install
2. Rozpakuj archiwum do wybranego folderu (np. `C:\src\flutter`)
3. Dodaj Flutter do PATH systemowego:
   - Windows: Dodaj `C:\src\flutter\bin` do zmiennej środowiskowej PATH
   - Lub użyj: `setx PATH "%PATH%;C:\src\flutter\bin"` w PowerShell (jako Administrator)

### 2. Sprawdź konfigurację

Otwórz terminal w folderze projektu i uruchom:

```bash
flutter doctor
```

Upewnij się, że wszystkie wymagane komponenty są zainstalowane. Jeśli brakuje czegoś, postępuj zgodnie z instrukcjami.

### 3. Zainstaluj zależności

W folderze projektu uruchom:

```bash
flutter pub get
```

### 4. Konfiguracja dla Android

#### AndroidManifest.xml
Upewnij się, że w pliku `android/app/src/main/AndroidManifest.xml` są uprawnienia:

```xml
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.READ_CALENDAR" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />
```

#### build.gradle
W pliku `android/app/build.gradle` upewnij się, że:
- `minSdkVersion` jest ustawione na co najmniej 21
- `targetSdkVersion` jest ustawione na co najmniej 33

### 5. Konfiguracja dla iOS

#### Info.plist
W pliku `ios/Runner/Info.plist` dodaj:

```xml
<key>NSCameraUsageDescription</key>
<string>Potrzebujemy dostępu do aparatu, aby zrobić zdjęcie z datami wywozu śmieci</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>Potrzebujemy dostępu do galerii, aby wybrać zdjęcie z datami wywozu śmieci</string>
<key>NSCalendarsUsageDescription</key>
<string>Potrzebujemy dostępu do kalendarza, aby dodać daty wywozu śmieci</string>
```

### 6. Uruchomienie na telefonie

#### Android:
1. **Włącz tryb deweloperski na telefonie:**
   - Przejdź do Ustawienia → O telefonie
   - Kliknij 7 razy na "Numer kompilacji" lub "Wersja oprogramowania"
   - Powinieneś zobaczyć komunikat "Jesteś teraz deweloperem"

2. **Włącz debugowanie USB:**
   - Przejdź do Ustawienia → Opcje deweloperskie
   - Włącz "Debugowanie USB"
   - Podłącz telefon przez USB do komputera
   - Na telefonie zaakceptuj prośbę o autoryzację komputera

3. **Sprawdź połączenie:**
```bash
flutter devices
```
Powinieneś zobaczyć swój telefon na liście.

4. **Uruchom aplikację:**
```bash
flutter run
```

#### iOS:

**⚠️ Ważne:** Xcode działa tylko na macOS. Jeśli masz Windowsa, zobacz sekcję poniżej.

##### Jeśli masz macOS:
1. **Zainstaluj Xcode** (dostępne w App Store)

2. **Otwórz projekt w Xcode:**
```bash
open ios/Runner.xcworkspace
```

3. **Skonfiguruj podpisanie:**
   - W Xcode wybierz projekt "Runner" w lewym panelu
   - Przejdź do zakładki "Signing & Capabilities"
   - Wybierz swój zespół (Team) - wymaga konta Apple ID
   - Xcode automatycznie wygeneruje certyfikat

4. **Podłącz iPhone przez USB**

5. **Wybierz telefon jako urządzenie docelowe** w górnym pasku Xcode

6. **Uruchom aplikację:**
   - Kliknij przycisk "Run" w Xcode
   - Lub w terminalu: `flutter run`
   - Na telefonie: Ustawienia → Ogólne → Zarządzanie urządzeniem → Zaufaj deweloperowi

##### Jeśli masz Windowsa (bez macOS):

**Opcja 1: GitHub Actions (DARMOWE, NAJŁATWIEJSZE)** ⭐
1. Utwórz konto na GitHub i wgraj kod
2. W projekcie jest już plik `.github/workflows/build-ios.yml`
3. W GitHub: Actions → Build iOS App → Run workflow
4. Pobierz zbudowaną aplikację z Artifacts
5. Zainstaluj na iPhone używając Sideloadly lub AltStore

**Opcja 2: Codemagic (DARMOWY TIER)**
1. Zarejestruj się na https://codemagic.io
2. Połącz z repozytorium (GitHub/GitLab/Bitbucket)
3. Uruchom build - automatycznie zbuduje aplikację iOS
4. Pobierz plik .ipa i zainstaluj na telefonie

**Opcja 3: Usługa chmurowa z macOS**
- MacinCloud, MacStadium - wynajmij wirtualnego Maca (~$20/miesiąc)
- Połącz się przez RDP/VNC i zbuduj aplikację

**Instalacja pliku .ipa na iPhone:**
- **Sideloadly** (darmowe): https://sideloadly.io
- **AltStore** (darmowe): https://altstore.io
- Wymaga podłączenia iPhone przez USB i zalogowania Apple ID

**Uwaga:** Aplikacje zainstalowane bez App Store wygasają po 7 dniach (darmowe Apple ID) lub 1 roku (płatne konto deweloperskie).

### 7. Budowanie APK (Android)

Aby stworzyć plik APK do instalacji:

```bash
flutter build apk
```

Plik znajdziesz w: `build/app/outputs/flutter-apk/app-release.apk`

### 8. Budowanie IPA (iOS)

Aby stworzyć plik IPA (wymaga konta deweloperskiego Apple):

```bash
flutter build ios
```

Następnie użyj Xcode do archiwizacji i dystrybucji.

## Jak używać aplikacji

1. Otwórz aplikację
2. Kliknij "Zrób zdjęcie" lub "Wybierz z galerii"
3. Wybierz zdjęcie z harmonogramem wywozu śmieci
4. Kliknij "Przetwórz zdjęcie"
5. Sprawdź znalezione daty
6. Kliknij "Dodaj do kalendarza"
7. Zatwierdź dodanie wydarzeń w kalendarzu telefonu

## Obsługiwane formaty dat

Aplikacja rozpoznaje następujące formaty dat:
- DD.MM.YYYY (np. 15.03.2024)
- DD/MM/YYYY (np. 15/03/2024)
- DD-MM-YYYY (np. 15-03-2024)
- DD MMMM YYYY (np. 15 marca 2024)
- YYYY-MM-DD (np. 2024-03-15)

## Rozwiązywanie problemów

### Błąd: "Nie udało się odczytać tekstu"
- Upewnij się, że zdjęcie jest wyraźne
- Sprawdź, czy daty są czytelne
- Spróbuj zrobić zdjęcie w lepszym świetle

### Błąd: "Nie znaleziono dat"
- Sprawdź, czy daty są w obsługiwanym formacie
- Upewnij się, że tekst na zdjęciu jest wyraźny

### Problem z uprawnieniami
- Sprawdź ustawienia aplikacji w telefonie
- Upewnij się, że aplikacja ma dostęp do aparatu, galerii i kalendarza

