# Szybka instrukcja uruchomienia

## Krok po kroku - jak uruchomić aplikację na telefonie

### Wymagania wstępne:
- ✅ Flutter SDK zainstalowany
- ✅ Telefon z Androidem lub iOS
- ✅ Kabel USB do podłączenia telefonu

---

## 🚀 Szybki start (Android)

### 1. Zainstaluj Flutter (jeśli jeszcze nie masz)

**Windows:**
1. Pobierz Flutter SDK: https://docs.flutter.dev/get-started/install/windows
2. Rozpakuj do `C:\src\flutter` (lub innego folderu)
3. Dodaj do PATH: `C:\src\flutter\bin`

**Sprawdź instalację:**
```bash
flutter doctor
```

### 2. Przygotuj projekt

Otwórz terminal w folderze projektu i uruchom:

```bash
# Zainstaluj zależności
flutter pub get

# Sprawdź czy telefon jest podłączony
flutter devices
```

### 3. Przygotuj telefon Android

1. **Włącz tryb deweloperski:**
   - Ustawienia → O telefonie
   - Kliknij 7 razy na "Numer kompilacji"
   
2. **Włącz debugowanie USB:**
   - Ustawienia → Opcje deweloperskie → Debugowanie USB (ON)
   
3. **Podłącz telefon przez USB**

4. **Zaakceptuj autoryzację** na telefonie (pojawi się okno)

### 4. Uruchom aplikację

```bash
flutter run
```

Aplikacja automatycznie zainstaluje się i uruchomi na telefonie!

---

## 🍎 Szybki start (iOS) - opcje dla Windows

**⚠️ Ważne:** Xcode działa tylko na macOS. Jeśli masz Windowsa, masz kilka opcji:

### Opcja 1: GitHub Actions (NAJŁATWIEJSZE - DARMOWE) ⭐

1. **Utwórz konto na GitHub** (jeśli nie masz): https://github.com

2. **Utwórz nowe repozytorium** i wgraj tam swój kod:
```bash
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/TWOJA_NAZWA/kalendarz-smieci.git
git push -u origin main
```

3. **Utwórz plik `.github/workflows/build-ios.yml`** w projekcie:
```yaml
name: Build iOS
on:
  workflow_dispatch:

jobs:
  build:
    runs-on: macos-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
      - run: flutter pub get
      - run: flutter build ios --release --no-codesign
      - uses: actions/upload-artifact@v3
        with:
          name: ios-build
          path: build/ios/iphoneos/Runner.app
```

4. **W GitHub:** Actions → Build iOS → Run workflow
5. **Pobierz zbudowaną aplikację** z Artifacts

### Opcja 2: Codemagic (DARMOWY TIER) ⭐

1. **Zarejestruj się na Codemagic:** https://codemagic.io (darmowe konto)
2. **Połącz z GitHub/GitLab/Bitbucket** (wgraj tam swój kod)
3. **Dodaj aplikację** w Codemagic
4. **Użyj gotowego szablonu Flutter**
5. **Kliknij "Start new build"**
6. **Pobierz zbudowaną aplikację** (.ipa)

### Opcja 3: Usługa chmurowa z macOS

**MacinCloud** (płatne, ~$20/miesiąc):
1. Zarejestruj się: https://www.macincloud.com
2. Połącz się z wirtualnym Maciem przez RDP/VNC
3. Zainstaluj Flutter i Xcode na wirtualnym Macu
4. Zbuduj aplikację jak na normalnym Macu

### Opcja 4: Znajomy z Maciem

1. Wyślij mu kod projektu
2. Niech zbuduje aplikację na swoim Macu
3. Wyśle Ci plik .ipa do instalacji

### Opcja 5: TestFlight (wymaga konta deweloperskiego Apple - $99/rok)

Jeśli masz Apple Developer Account:
1. Użyj GitHub Actions lub Codemagic do zbudowania
2. Wgraj do App Store Connect
3. Dodaj do TestFlight
4. Zainstaluj z TestFlight na telefonie

---

## 📱 Instalacja na iPhone (gdy masz już plik .ipa)

### Metoda 1: AltStore (DARMOWE, bez jailbreak)

1. **Zainstaluj AltStore** na komputerze: https://altstore.io
2. **Zainstaluj AltStore na iPhone** przez iTunes/Finder
3. **Przenieś plik .ipa** na iPhone
4. **Otwórz w AltStore** i zainstaluj

### Metoda 2: Sideloadly (DARMOWE)

1. **Pobierz Sideloadly:** https://sideloadly.io
2. **Podłącz iPhone** przez USB
3. **Zaloguj się** swoim Apple ID
4. **Przeciągnij plik .ipa** do Sideloadly
5. **Kliknij Start** - aplikacja zainstaluje się na telefonie

**Uwaga:** Aplikacje zainstalowane przez Sideloadly/AltStore wygasają po 7 dniach (darmowe Apple ID) lub 1 roku (płatne konto deweloperskie).

---

## 🍎 Jeśli masz macOS (tradycyjna metoda)

### 1. Zainstaluj Xcode z App Store

### 2. Otwórz projekt w Xcode

```bash
open ios/Runner.xcworkspace
```

### 3. Skonfiguruj podpisanie

1. W Xcode: Runner → Signing & Capabilities
2. Wybierz swój Team (Apple ID)
3. Xcode automatycznie wygeneruje certyfikat

### 4. Podłącz iPhone i uruchom

1. Wybierz telefon w górnym pasku Xcode
2. Kliknij "Run" ▶️
3. Na telefonie: Ustawienia → Ogólne → Zarządzanie urządzeniem → Zaufaj

---

## 📦 Budowanie pliku instalacyjnego (APK dla Android)

Jeśli chcesz stworzyć plik APK do instalacji bezpośrednio na telefonie:

```bash
flutter build apk
```

Plik znajdziesz w: `build/app/outputs/flutter-apk/app-release.apk`

Możesz go przesłać na telefon i zainstalować ręcznie (wymaga włączenia "Instalacja z nieznanych źródeł" w ustawieniach).

---

## ❓ Rozwiązywanie problemów

### "No devices found"
- Sprawdź czy telefon jest podłączony: `flutter devices`
- Upewnij się, że debugowanie USB jest włączone
- Spróbuj odłączyć i ponownie podłączyć kabel

### "Gradle build failed"
- Uruchom: `flutter clean`
- Następnie: `flutter pub get`
- Spróbuj ponownie: `flutter run`

### Błędy uprawnień
- Sprawdź czy w `AndroidManifest.xml` są wszystkie uprawnienia
- Na telefonie: Ustawienia → Aplikacje → Kalendarz Śmieci → Uprawnienia

### Problem z OCR
- Upewnij się, że zdjęcie jest wyraźne
- Sprawdź czy daty są czytelne
- Spróbuj zrobić zdjęcie w lepszym świetle

---

## 🎯 Jak używać aplikacji

1. Otwórz aplikację na telefonie
2. Kliknij "Zrób zdjęcie" lub "Wybierz z galerii"
3. Wybierz zdjęcie z harmonogramem wywozu śmieci
4. Kliknij "Przetwórz zdjęcie"
5. Sprawdź znalezione daty
6. Kliknij "Dodaj do kalendarza"
7. Zatwierdź w kalendarzu telefonu

Gotowe! Wszystkie daty będą w kalendarzu z przypomnieniem 1 dzień wcześniej! 🎉

