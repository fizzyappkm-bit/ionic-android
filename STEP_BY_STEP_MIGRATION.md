# Przewodnik Krok po Kroku: Stopniowa Podmiana Elementów na Android Kotlin

## 🎯 Cel

Ten przewodnik pokazuje jak **stopniowo podmieniać** pojedyncze elementy (przyciski, teksty, komponenty) z Vue na natywne elementy Android Kotlin w repo [ionic-android](https://github.com/fizzyappkm-bit/ionic-android.git).

## 📋 Przygotowanie

### 1. Sklonuj i Skonfiguruj Repo

```bash
# Sklonuj repo ionic-android
git clone https://github.com/fizzyappkm-bit/ionic-android.git
cd ionic-android

# Zainicjalizuj submodule z plikami Vue
git submodule update --init --recursive

# Otwórz w Android Studio
# File → Open → wybierz folder ionic-android
```

### 2. Sprawdź Strukturę

```
ionic-android/
├── app/src/main/
│   ├── kotlin/io/ionic/starter/
│   │   ├── MainActivity.kt
│   │   └── native/
│   │       ├── Tab1Fragment.kt      # ✅ Przykład zmigrowanego ekranu
│   │       └── NativeNavigationHelper.kt
│   └── res/layout/
│       └── fragment_tab1.xml        # ✅ Layout dla Tab1
└── ionic-source/                    # Submodule z plikami Vue
    └── src/views/
        ├── Tab1.vue                 # Referencja
        ├── Tab2.vue                 # Do migracji
        └── Tab3.vue                 # Do migracji
```

## 🔄 Workflow: Podmiana Pojedynczego Elementu

### Przykład 1: Podmiana Przycisku

#### Krok 1: Znajdź Element w Vue

Otwórz plik Vue z `ionic-source/src/views/`:

```vue
<!-- Tab2.vue -->
<template>
  <ion-button @click="handleClick" color="primary">
    Kliknij mnie
  </ion-button>
</template>
```

#### Krok 2: Utwórz Fragment Kotlin (jeśli nie istnieje)

```bash
# Utwórz nowy plik
touch app/src/main/kotlin/io/ionic/starter/native/Tab2Fragment.kt
```

**Tab2Fragment.kt:**
```kotlin
package io.ionic.starter.native

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import androidx.fragment.app.Fragment
import io.ionic.starter.R

class Tab2Fragment : Fragment() {
    
    private lateinit var button: Button
    
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_tab2, container, false)
    }
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        button = view.findViewById(R.id.myButton)
        
        button.setOnClickListener {
            handleClick()
        }
    }
    
    private fun handleClick() {
        // Migruj logikę z Vue
        // Przykład: pokaż Toast
        android.widget.Toast.makeText(
            context,
            "Przycisk kliknięty!",
            android.widget.Toast.LENGTH_SHORT
        ).show()
    }
}
```

#### Krok 3: Utwórz Layout XML

```bash
# Utwórz nowy plik
touch app/src/main/res/layout/fragment_tab2.xml
```

**fragment_tab2.xml:**
```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp"
    android:gravity="center">

    <!-- Przycisk - podmiana z ion-button -->
    <Button
        android:id="@+id/myButton"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Kliknij mnie"
        android:textSize="16sp" />

</LinearLayout>
```

#### Krok 4: Zaktualizuj NativeNavigationHelper

Otwórz `app/src/main/kotlin/io/ionic/starter/native/NativeNavigationHelper.kt`:

```kotlin
object NativeNavigationHelper {
    
    private val migratedScreens = setOf(
        "/tabs/tab1",  // ✅ Już zmigrowany
        "/tabs/tab2"   // ✅ Dodaj tutaj
    )
    
    fun openNativeScreen(activity: FragmentActivity, route: String) {
        when (route) {
            "/tabs/tab1" -> {
                // Otwórz Tab1Fragment
            }
            "/tabs/tab2" -> {
                // Otwórz Tab2Fragment
                val fragment = Tab2Fragment.newInstance()
                activity.supportFragmentManager.beginTransaction()
                    .replace(R.id.container, fragment)
                    .commit()
            }
        }
    }
}
```

#### Krok 5: Przetestuj

```bash
# Zbuduj projekt w Android Studio
# Lub z terminala:
./gradlew assembleDebug

# Uruchom na emulatorze/urządzeniu
```

### Przykład 2: Podmiana Tekstu z Dynamiczną Zawartością

#### Vue (Referencja):
```vue
<template>
  <ion-label>{{ message }}</ion-label>
  <ion-label>{{ user.name }}</ion-label>
</template>

<script setup>
const message = ref('Witaj!')
const user = ref({ name: 'Jan' })
</script>
```

#### Kotlin:
```kotlin
class Tab2Fragment : Fragment() {
    
    private lateinit var messageLabel: TextView
    private lateinit var userNameLabel: TextView
    
    private var message: String = "Witaj!"
    private var user: User = User("Jan")
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        messageLabel = view.findViewById(R.id.messageLabel)
        userNameLabel = view.findViewById(R.id.userNameLabel)
        
        updateLabels()
    }
    
    private fun updateLabels() {
        messageLabel.text = message
        userNameLabel.text = user.name
    }
}
```

#### Layout XML:
```xml
<TextView
    android:id="@+id/messageLabel"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="Witaj!"
    android:textSize="18sp" />

<TextView
    android:id="@+id/userNameLabel"
    android:layout_width="wrap_content"
    android:layout_height="wrap_content"
    android:text="Jan"
    android:textSize="16sp" />
```

### Przykład 3: Podmiana Listy Elementów

#### Vue:
```vue
<template>
  <ion-list>
    <ion-item v-for="item in items" :key="item.id">
      {{ item.name }}
    </ion-item>
  </ion-list>
</template>

<script setup>
const items = ref([
  { id: 1, name: 'Element 1' },
  { id: 2, name: 'Element 2' }
])
</script>
```

#### Kotlin z RecyclerView:
```kotlin
class Tab2Fragment : Fragment() {
    
    private lateinit var recyclerView: RecyclerView
    private lateinit var adapter: ItemsAdapter
    private val items = mutableListOf(
        Item(1, "Element 1"),
        Item(2, "Element 2")
    )
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        recyclerView = view.findViewById(R.id.recyclerView)
        recyclerView.layoutManager = LinearLayoutManager(context)
        
        adapter = ItemsAdapter(items)
        recyclerView.adapter = adapter
    }
}

// Adapter dla RecyclerView
class ItemsAdapter(private val items: List<Item>) : 
    RecyclerView.Adapter<ItemsAdapter.ViewHolder>() {
    
    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val textView: TextView = view.findViewById(R.id.itemText)
    }
    
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_list, parent, false)
        return ViewHolder(view)
    }
    
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.textView.text = items[position].name
    }
    
    override fun getItemCount() = items.size
}
```

#### Layout dla itemu (item_list.xml):
```xml
<?xml version="1.0" encoding="utf-8"?>
<TextView xmlns:android="http://schemas.android.com/apk/res/android"
    android:id="@+id/itemText"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:padding="16dp"
    android:textSize="16sp" />
```

## 📝 Mapowanie Komponentów Vue → Android

| Vue/Ionic | Android Kotlin | Przykład |
|-----------|----------------|----------|
| `ion-button` | `Button` lub `MaterialButton` | [Przykład wyżej](#przykład-1-podmiana-przycisku) |
| `ion-label` | `TextView` | [Przykład wyżej](#przykład-2-podmiana-tekstu-z-dynamiczną-zawartością) |
| `ion-input` | `EditText` | Zobacz sekcję poniżej |
| `ion-card` | `CardView` | Zobacz sekcję poniżej |
| `ion-list` | `RecyclerView` | [Przykład wyżej](#przykład-3-podmiana-listy-elementów) |
| `ion-header` | `Toolbar` lub `AppBarLayout` | Zobacz sekcję poniżej |
| `v-if` | `view.visibility = View.GONE/VISIBLE` | Zobacz sekcję poniżej |
| `v-for` | `RecyclerView` z Adapter | [Przykład wyżej](#przykład-3-podmiana-listy-elementów) |
| `@click` | `setOnClickListener` | [Przykład wyżej](#przykład-1-podmiana-przycisku) |
| `{{ variable }}` | `textView.text = variable` | [Przykład wyżej](#przykład-2-podmiana-tekstu-z-dynamiczną-zawartością) |

## 🔧 Dodatkowe Przykłady

### Input Field (ion-input → EditText)

**Vue:**
```vue
<ion-input v-model="email" placeholder="Email" />
```

**Kotlin:**
```kotlin
private lateinit var emailInput: EditText

override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
    emailInput = view.findViewById(R.id.emailInput)
    
    // Pobierz wartość
    val email = emailInput.text.toString()
    
    // Ustaw wartość
    emailInput.setText("example@email.com")
}
```

**XML:**
```xml
<EditText
    android:id="@+id/emailInput"
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:hint="Email"
    android:inputType="textEmailAddress" />
```

### Card (ion-card → CardView)

**Vue:**
```vue
<ion-card>
  <ion-card-header>
    <ion-card-title>Tytuł</ion-card-title>
  </ion-card-header>
  <ion-card-content>
    Treść karty
  </ion-card-content>
</ion-card>
```

**XML:**
```xml
<androidx.cardview.widget.CardView
    android:layout_width="match_parent"
    android:layout_height="wrap_content"
    android:layout_margin="8dp"
    app:cardCornerRadius="8dp"
    app:cardElevation="4dp">

    <LinearLayout
        android:layout_width="match_parent"
        android:layout_height="wrap_content"
        android:orientation="vertical"
        android:padding="16dp">

        <TextView
            android:id="@+id/cardTitle"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Tytuł"
            android:textSize="20sp"
            android:textStyle="bold" />

        <TextView
            android:id="@+id/cardContent"
            android:layout_width="wrap_content"
            android:layout_height="wrap_content"
            android:text="Treść karty"
            android:textSize="16sp" />

    </LinearLayout>
</androidx.cardview.widget.CardView>
```

### Warunkowe Wyświetlanie (v-if → visibility)

**Vue:**
```vue
<div v-if="isVisible">Widoczny tekst</div>
```

**Kotlin:**
```kotlin
private lateinit var textView: TextView

fun showText() {
    textView.visibility = View.VISIBLE
}

fun hideText() {
    textView.visibility = View.GONE
}
```

## ✅ Checklist Migracji Elementu

Przed commitowaniem upewnij się że:

- [ ] ✅ Fragment Kotlin utworzony
- [ ] ✅ Layout XML utworzony
- [ ] ✅ Wszystkie widoki zdefiniowane w XML mają ID
- [ ] ✅ Logika biznesowa zmigrowana z Vue
- [ ] ✅ Event handlers zaimplementowane (onClick, onChange, etc.)
- [ ] ✅ Stan zapisywany/odtwarzany (savedInstanceState)
- [ ] ✅ Dodano do NativeNavigationHelper
- [ ] ✅ Przetestowano na emulatorze/urządzeniu
- [ ] ✅ Działa identycznie jak w Vue

## 🚀 Commit i Push Zmian

### 1. Sprawdź Status

```bash
cd ionic-android
git status
```

### 2. Dodaj Zmiany

```bash
# Dodaj nowe pliki
git add app/src/main/kotlin/io/ionic/starter/native/Tab2Fragment.kt
git add app/src/main/res/layout/fragment_tab2.xml

# Dodaj zmodyfikowane pliki
git add app/src/main/kotlin/io/ionic/starter/native/NativeNavigationHelper.kt
```

### 3. Commit

```bash
git commit -m "Migrate Tab2: Add button and text elements to Kotlin

- Created Tab2Fragment.kt with button click handler
- Created fragment_tab2.xml layout
- Updated NativeNavigationHelper to support Tab2
- Migrated button and text elements from Vue"
```

### 4. Push

```bash
git push origin main
```

### 5. Zaktualizuj Główne Repo

W głównym repo (`ionic-app`):

```bash
cd ionic-app
cd android
git pull origin main
cd ..
git add android
git commit -m "Update android submodule: Tab2 button migration"
git push
```

## 📚 Dodatkowe Zasoby

- [Android Developer Guide - Fragments](https://developer.android.com/guide/fragments)
- [Material Design Components](https://material.io/components)
- [Kotlin Android Extensions](https://kotlinlang.org/docs/android-overview.html)

## 🎯 Strategia Stopniowej Migracji

1. **Zacznij od prostych elementów** - przyciski, teksty
2. **Migruj jeden ekran na raz** - nie mieszaj wielu ekranów
3. **Testuj każdy element** - upewnij się że działa przed przejściem dalej
4. **Dokumentuj zmiany** - commit messages powinny być opisowe
5. **Aktualizuj NativeNavigationHelper** - po każdej migracji ekranu

## ⚠️ Częste Błędy

### Błąd: "Cannot resolve symbol R"
- **Rozwiązanie**: Zsynchronizuj projekt Gradle w Android Studio (File → Sync Project with Gradle Files)

### Błąd: "View not found"
- **Rozwiązanie**: Sprawdź czy ID w XML (`android:id="@+id/...")` odpowiada ID używanemu w Kotlin (`R.id....`)

### Błąd: "NullPointerException"
- **Rozwiązanie**: Upewnij się że `findViewById` jest wywoływane po `onViewCreated`, nie w `onCreateView`

### Błąd: "Fragment not showing"
- **Rozwiązanie**: Sprawdź czy dodałeś ekran do `NativeNavigationHelper.migratedScreens`

---

**Gotowy do migracji?** Zacznij od prostego elementu i stopniowo przechodź do bardziej złożonych! 🚀

