# Android Native Migration - Kotlin

## Przegląd

Ten projekt zawiera stopniową migrację z Ionic Vue/TypeScript na natywny Android Kotlin.

**Ważne**: W tym repo masz dostęp do plików źródłowych Vue przez submodule `ionic-source/`, które służą jako referencja podczas migracji.

## Struktura

```
ionic-android/
├── app/
│   └── src/main/
│       └── kotlin/io/ionic/starter/
│           ├── MainActivity.kt              # Główna aktywność (hybrydowa)
│           └── native/
│               ├── Tab1Fragment.kt          # ✅ Zmigrowany
│               ├── Tab2Fragment.kt         # ⏳ Do migracji
│               └── NativeNavigationHelper.kt
├── ionic-source/                            # Submodule → pliki Vue/TypeScript
│   └── src/views/
│       ├── Tab1.vue                        # Referencja (już zmigrowany)
│       ├── Tab2.vue                        # Migruj ten plik
│       └── Tab3.vue                        # Migruj ten plik
└── res/layout/
    ├── fragment_tab1.xml                   # ✅ Layout dla Tab1
    ├── fragment_tab2.xml                   # ⏳ Utwórz dla Tab2
    └── fragment_tab3.xml                   # ⏳ Utwórz dla Tab3
```

## Status Migracji

✅ **Tab1 (Licznik)** - Zmigrowany do Kotlin
- Vue: `ionic-source/src/views/Tab1.vue`
- Kotlin: `app/src/main/kotlin/io/ionic/starter/native/Tab1Fragment.kt`
- Layout: `res/layout/fragment_tab1.xml`

⏳ **Tab2, Tab3** - Do migracji

## Jak Uruchomić

1. **Zainicjalizuj submodule** (jeśli jeszcze nie):
   ```bash
   git submodule update --init --recursive
   ```

2. Otwórz projekt w Android Studio
3. Zsynchronizuj projekt Gradle
4. Uruchom aplikację na emulatorze lub urządzeniu

## Jak Migrować Kolejny Ekran

1. **Przeanalizuj plik Vue** z `ionic-source/src/views/`
2. **Utwórz Fragment Kotlin** w `app/src/main/kotlin/io/ionic/starter/native/`
3. **Utwórz Layout XML** w `res/layout/`
4. **Zaimplementuj logikę** migrując z TypeScript do Kotlin
5. **Dodaj do NativeNavigationHelper**
6. **Przetestuj**

## 📚 Przewodniki

- **[WORKFLOW_SUMMARY.md](./WORKFLOW_SUMMARY.md)** - ⭐ **ZACZNIJ TUTAJ!** Podsumowanie workflow i szybki start
- **[STEP_BY_STEP_MIGRATION.md](./STEP_BY_STEP_MIGRATION.md)** - Szczegółowy przewodnik krok po kroku jak podmieniać elementy
- **[MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md)** - Ogólny przewodnik migracji ekranów
- **[QUICK_REFERENCE.md](./QUICK_REFERENCE.md)** - Szybka referencja mapowania Vue → Android

## 🛠️ Skrypty Pomocnicze

```bash
# Utwórz nowy Fragment z layoutem
./scripts/create-fragment.sh Tab2

# Aktualizuj pliki Vue z submodule
./scripts/update-ionic-source.sh
```

## Aktualizacja Plików Vue (ionic-source)

Gdy w głównym repo pojawią się nowe zmiany w plikach Vue:

```bash
cd ionic-source
git pull origin main
cd ..
git add ionic-source
git commit -m "Update ionic-source submodule"
git push
```

## Zależności

- Kotlin 1.9.22
- AndroidX Navigation
- Capacitor (dla hybrydowego podejścia)

