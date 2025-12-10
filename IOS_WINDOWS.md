# 🍎 Jak uruchomić aplikację iOS na Windowsie

## Problem
Xcode i budowanie aplikacji iOS wymaga macOS. Na Windowsie nie możesz bezpośrednio zbudować aplikacji iOS.

## ✅ Rozwiązania (od najłatwiejszych)

---

## 1. GitHub Actions (DARMOWE, NAJŁATWIEJSZE) ⭐⭐⭐

### Krok 1: Przygotuj repozytorium GitHub

1. **Utwórz konto na GitHub** (jeśli nie masz): https://github.com/signup

2. **Utwórz nowe repozytorium:**
   - Kliknij "+" → "New repository"
   - Nazwij np. "kalendarz-smieci"
   - Wybierz "Public" (darmowe) lub "Private"
   - **NIE** zaznaczaj "Initialize with README"

3. **Wgraj kod do GitHub:**
```bash
# W folderze projektu
git init
git add .
git commit -m "Initial commit"
git branch -M main
git remote add origin https://github.com/TWOJA_NAZWA/kalendarz-smieci.git
git push -u origin main
```

### Krok 2: Uruchom build

1. **W GitHub** przejdź do swojego repozytorium
2. Kliknij zakładkę **"Actions"**
3. Wybierz workflow **"Build iOS App"**
4. Kliknij **"Run workflow"** → **"Run workflow"**
5. Poczekaj ~5-10 minut na zakończenie builda

### Krok 3: Pobierz aplikację

1. Po zakończeniu builda kliknij na niego
2. Przewiń w dół do sekcji **"Artifacts"**
3. Kliknij **"ios-build"** aby pobrać
4. Rozpakuj archiwum ZIP

### Krok 4: Zainstaluj na iPhone

Zobacz sekcję "Instalacja na iPhone" poniżej.

---

## 2. Codemagic (DARMOWY TIER) ⭐⭐

### Krok 1: Rejestracja

1. **Zarejestruj się:** https://codemagic.io/signup
2. Wybierz darmowy plan (500 minut builda/miesiąc)

### Krok 2: Połącz repozytorium

1. Kliknij **"Add application"**
2. Wybierz GitHub/GitLab/Bitbucket
3. Wybierz swoje repozytorium z kodem
4. Wybierz **"Flutter"** jako typ projektu

### Krok 3: Konfiguracja

1. Codemagic automatycznie wykryje Flutter
2. Kliknij **"Start your first build"**
3. Wybierz **"iOS"** jako platformę
4. Kliknij **"Start new build"**

### Krok 4: Pobierz aplikację

1. Poczekaj na zakończenie builda (~10-15 minut)
2. Pobierz plik **.ipa** z sekcji Artifacts

---

## 3. Usługa chmurowa z macOS (PŁATNE) ⭐

### MacinCloud

1. **Zarejestruj się:** https://www.macincloud.com
2. Wybierz plan (od ~$20/miesiąc)
3. Połącz się z wirtualnym Maciem przez RDP/VNC
4. Zainstaluj Flutter i Xcode na wirtualnym Macu
5. Zbuduj aplikację normalnie

**Alternatywy:**
- **MacStadium** - https://www.macstadium.com
- **AWS EC2 Mac instances** - https://aws.amazon.com/ec2/instance-types/mac/

---

## 4. Znajomy z Maciem

1. Wyślij mu kod projektu (GitHub, pendrive, itp.)
2. Niech zbuduje aplikację na swoim Macu:
   ```bash
   flutter build ios --release
   ```
3. Niech wyśle Ci plik `.ipa` z folderu `build/ios/iphoneos/`

---

## 📱 Instalacja na iPhone (gdy masz już plik .ipa lub .app)

### Metoda 1: Sideloadly (NAJŁATWIEJSZE) ⭐⭐⭐

1. **Pobierz Sideloadly:** https://sideloadly.io
2. **Zainstaluj** na Windowsie
3. **Podłącz iPhone** przez USB
4. **Otwórz Sideloadly**
5. **Zaloguj się** swoim Apple ID (darmowe konto wystarczy)
6. **Wybierz iPhone** z listy
7. **Przeciągnij plik .ipa** (lub .app) do Sideloadly
8. **Kliknij "Start"**
9. **Na iPhone:** Ustawienia → Ogólne → VPN i zarządzanie urządzeniem → Zaufaj deweloperowi

**Uwaga:** Aplikacja wygaśnie po 7 dniach. Musisz ponownie zainstalować.

### Metoda 2: AltStore (DARMOWE)

1. **Pobierz AltServer:** https://altstore.io
2. **Zainstaluj AltServer** na Windowsie
3. **Zainstaluj AltStore** na iPhone przez iTunes/Finder
4. **Przenieś plik .ipa** na iPhone (AirDrop, email, itp.)
5. **Otwórz w AltStore** i zainstaluj

### Metoda 3: TestFlight (wymaga Apple Developer Account - $99/rok)

1. **Zbuduj aplikację** przez GitHub Actions/Codemagic
2. **Wgraj do App Store Connect** (wymaga konta deweloperskiego)
3. **Dodaj do TestFlight**
4. **Zainstaluj TestFlight** na iPhone
5. **Zainstaluj aplikację** z TestFlight

**Zalety:** Aplikacja nie wygasa, łatwa dystrybucja

---

## ⚠️ Ważne informacje

### Ograniczenia darmowych metod:

- **Sideloadly/AltStore z darmowym Apple ID:**
  - Aplikacja wygasa po **7 dniach**
  - Musisz ponownie instalować co tydzień
  - Limit 3 aplikacji jednocześnie

- **Płatne Apple Developer Account ($99/rok):**
  - Aplikacja wygasa po **1 roku**
  - Możesz zainstalować więcej aplikacji
  - Dostęp do TestFlight i App Store

### Rozwiązywanie problemów:

**"Untrusted Developer" na iPhone:**
- Ustawienia → Ogólne → VPN i zarządzanie urządzeniem
- Znajdź swojego dewelopera i kliknij "Zaufaj"

**Aplikacja się nie instaluje:**
- Sprawdź czy masz wystarczająco miejsca na iPhone
- Upewnij się, że iPhone jest odblokowany podczas instalacji
- Spróbuj ponownie

**Błąd podpisu:**
- Użyj innego Apple ID
- Lub wykup Apple Developer Account

---

## 🎯 Rekomendacja

**Najszybsza i najłatwiejsza metoda:**
1. ✅ GitHub Actions (darmowe, automatyczne)
2. ✅ Sideloadly (łatwa instalacja na iPhone)

**Całkowity czas:** ~15-20 minut (pierwszy raz), ~5 minut (kolejne razy)

