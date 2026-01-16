# Przewodnik Migracji Ekranów Vue → Kotlin

## Struktura Projektu

W tym repo masz dostęp do plików źródłowych Vue/TypeScript przez submodule `ionic-source`:

```
ionic-android/
├── app/
│   └── src/main/
│       └── kotlin/io/ionic/starter/
│           ├── MainActivity.kt
│           └── native/
│               ├── Tab1Fragment.kt      # ✅ Zmigrowany
│               ├── Tab2Fragment.kt       # ⏳ Do migracji
│               └── NativeNavigationHelper.kt
├── ionic-source/                         # Submodule → ionic repo
│   └── src/
│       └── views/
│           ├── Tab1.vue                  # Referencja do migracji
│           ├── Tab2.vue                  # Migruj ten plik
│           └── Tab3.vue                  # Migruj ten plik
└── res/
    └── layout/
        ├── fragment_tab1.xml            # ✅ Layout dla Tab1
        ├── fragment_tab2.xml            # ⏳ Utwórz dla Tab2
        └── fragment_tab3.xml            # ⏳ Utwórz dla Tab3
```

## Jak Migrować Ekran

### Krok 1: Przeanalizuj Plik Vue

Otwórz plik Vue z `ionic-source/src/views/` który chcesz zmigrować:

```bash
# Przykład: Tab2.vue
cat ionic-source/src/views/Tab2.vue
```

Przeanalizuj:
- **Template** - Jakie komponenty UI są używane? (ion-button, ion-card, etc.)
- **Script** - Jaka logika biznesowa? (stan, metody, lifecycle hooks)
- **Style** - Jakie style są używane?

### Krok 2: Utwórz Fragment Kotlin

Utwórz nowy plik Fragment w `app/src/main/kotlin/io/ionic/starter/native/`:

```kotlin
package io.ionic.starter.native

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment

class Tab2Fragment : Fragment() {
    
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        // Załaduj layout
        return inflater.inflate(R.layout.fragment_tab2, container, false)
    }
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        // Inicjalizuj widoki i logikę
        // Migruj logikę z Vue script section
    }
}
```

### Krok 3: Utwórz Layout XML

Utwórz plik layout w `app/src/main/res/layout/fragment_tab2.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <!-- Migruj elementy z Vue template -->
    <!-- Przykład: ion-button → Button -->
    <Button
        android:id="@+id/button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Button" />

</LinearLayout>
```

**Mapowanie komponentów Ionic → Android:**
- `ion-button` → `Button` lub `MaterialButton`
- `ion-card` → `CardView`
- `ion-input` → `EditText`
- `ion-label` → `TextView`
- `ion-list` → `RecyclerView`
- `ion-header` → `Toolbar` lub `AppBarLayout`

### Krok 4: Zaimplementuj Logikę

Migruj logikę z sekcji `<script>` w Vue do Kotlin:

**Vue (TypeScript):**
```typescript
export default {
  data() {
    return {
      count: 0
    }
  },
  methods: {
    increment() {
      this.count++
    }
  }
}
```

**Kotlin:**
```kotlin
class Tab2Fragment : Fragment() {
    private var count = 0
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        val button = view.findViewById<Button>(R.id.button)
        button.setOnClickListener {
            increment()
        }
    }
    
    private fun increment() {
        count++
        // Zaktualizuj UI
    }
}
```

### Krok 5: Dodaj do NativeNavigationHelper

Zaktualizuj `NativeNavigationHelper.kt` aby dodać nowy ekran:

```kotlin
private val migratedScreens = setOf(
    "/tabs/tab1",
    "/tabs/tab2"  // Dodaj tutaj
)
```

### Krok 6: Zaktualizuj MainActivity (jeśli potrzeba)

Jeśli potrzebujesz specjalnej logiki routingu, zaktualizuj `MainActivity.kt`.

### Krok 7: Przetestuj

1. Zbuduj aplikację w Android Studio
2. Uruchom na emulatorze/urządzeniu
3. Sprawdź czy ekran działa identycznie jak w Vue

## Przykład: Migracja Tab1 (Już Zrobione)

**Vue:** `ionic-source/src/views/Tab1.vue`
- Prosty licznik z przyciskiem
- Stan: `count`
- Metoda: `increment()`

**Kotlin:** `app/src/main/kotlin/io/ionic/starter/native/Tab1Fragment.kt`
- Fragment z ViewBinding
- Stan: `private var count = 0`
- Metoda: `private fun increment()`

**Layout:** `res/layout/fragment_tab1.xml`
- Button i TextView

## Aktualizacja ionic-source

Gdy w głównym repo pojawią się nowe zmiany w plikach Vue:

```bash
# W repo android
cd ionic-source
git pull origin main
cd ..
git add ionic-source
git commit -m "Update ionic-source submodule"
git push
```

## Wskazówki

1. **Zachowaj funkcjonalność** - Zmigrowany ekran powinien działać identycznie jak w Vue
2. **Używaj Material Design** - Android ma własne komponenty UI, użyj ich zamiast próbować dokładnie kopiować Ionic
3. **Testuj dokładnie** - Sprawdź wszystkie edge cases
4. **Dokumentuj** - Zaktualizuj `MIGRATION_PLAN.md` po każdej migracji

## Status Migracji

✅ **Tab1** - Zmigrowany  
⏳ **Tab2** - Do migracji  
⏳ **Tab3** - Do migracji  

