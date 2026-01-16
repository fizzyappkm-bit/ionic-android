# Android Native Migration - Kotlin

## Przegląd

Ten projekt zawiera stopniową migrację z Ionic Vue/TypeScript na natywny Android Kotlin.

## Struktura

- **MainActivity.kt** - Główna aktywność (hybrydowa - obsługuje zarówno WebView jak i natywne ekrany)
- **native/** - Folder z natywnymi ekranami Kotlin
  - **Tab1Fragment.kt** - Natywny ekran licznika (zmigrowany z Vue)
  - **NativeNavigationHelper.kt** - Pomocnik do nawigacji między ekranami

## Status Migracji

✅ **Tab1 (Licznik)** - Zmigrowany do Kotlin
- Vue: `src/views/Tab1.vue`
- Kotlin: `native/Tab1Fragment.kt`
- Layout: `res/layout/fragment_tab1.xml`

⏳ **Tab2, Tab3** - Do migracji

## Jak Uruchomić

1. Otwórz projekt w Android Studio
2. Zsynchronizuj projekt Gradle
3. Uruchom aplikację na emulatorze lub urządzeniu

## Jak Migrować Kolejny Ekran

Zobacz `MIGRATION_PLAN.md` w głównym katalogu projektu.

## Zależności

- Kotlin 1.9.22
- AndroidX Navigation
- Capacitor (dla hybrydowego podejścia)

