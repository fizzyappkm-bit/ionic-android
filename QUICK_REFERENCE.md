# Szybka Referencja: Mapowanie Vue → Android Kotlin

## 🎯 Szybkie Mapowanie Komponentów

### Podstawowe Komponenty

| Vue/Ionic | Android XML | Kotlin |
|-----------|-------------|--------|
| `<ion-button>` | `<Button>` | `Button` |
| `<ion-label>` | `<TextView>` | `TextView` |
| `<ion-input>` | `<EditText>` | `EditText` |
| `<ion-card>` | `<CardView>` | `CardView` |
| `<ion-list>` | `<RecyclerView>` | `RecyclerView` |
| `<ion-header>` | `<Toolbar>` | `Toolbar` |
| `<div>` | `<LinearLayout>` | `LinearLayout` |
| `<span>` | `<TextView>` | `TextView` |

### Atrybuty i Właściwości

| Vue | Android XML | Kotlin |
|-----|------------|--------|
| `v-model="value"` | `android:text="@{value}"` | `editText.setText(value)` |
| `@click="handler"` | `android:onClick="handler"` | `button.setOnClickListener { handler() }` |
| `v-if="condition"` | - | `view.visibility = if (condition) View.VISIBLE else View.GONE` |
| `v-for="item in items"` | - | `RecyclerView` z `Adapter` |
| `:class="{active: isActive}"` | `android:background="@drawable/active"` | `view.setBackgroundResource(R.drawable.active)` |
| `{{ text }}` | `android:text="text"` | `textView.text = text` |

### Event Handlers

```kotlin
// Vue: @click="handleClick"
button.setOnClickListener { handleClick() }

// Vue: @input="handleInput"
editText.addTextChangedListener(object : TextWatcher {
    override fun afterTextChanged(s: Editable?) {
        handleInput(s.toString())
    }
    // ... inne metody
})

// Vue: @change="handleChange"
switch.setOnCheckedChangeListener { _, isChecked ->
    handleChange(isChecked)
}
```

### Styling

```kotlin
// Vue: style="color: red"
textView.setTextColor(Color.RED)

// Vue: class="primary"
button.setBackgroundColor(ContextCompat.getColor(context, R.color.primary))

// Vue: :style="{ fontSize: size + 'px' }"
textView.textSize = size / resources.displayMetrics.scaledDensity
```

### Listy i Pętle

```kotlin
// Vue: v-for="item in items"
class MyAdapter(private val items: List<Item>) : RecyclerView.Adapter<...>() {
    // Implementacja adaptera
}
```

### Warunkowe Renderowanie

```kotlin
// Vue: v-if="isVisible"
if (isVisible) {
    view.visibility = View.VISIBLE
} else {
    view.visibility = View.GONE
}

// Vue: v-show="isVisible"
view.visibility = if (isVisible) View.VISIBLE else View.INVISIBLE
```

## 📝 Szablony Kodów

### Podstawowy Fragment

```kotlin
class MyFragment : Fragment() {
    
    private lateinit var myView: View
    
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_my, container, false)
    }
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        myView = view.findViewById(R.id.myView)
        // Inicjalizacja
    }
}
```

### Podstawowy Layout XML

```xml
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp">

    <TextView
        android:id="@+id/textView"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello" />

</LinearLayout>
```

### RecyclerView Adapter

```kotlin
class MyAdapter(private val items: List<Item>) : 
    RecyclerView.Adapter<MyAdapter.ViewHolder>() {
    
    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        val textView: TextView = view.findViewById(R.id.itemText)
    }
    
    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        val view = LayoutInflater.from(parent.context)
            .inflate(R.layout.item_layout, parent, false)
        return ViewHolder(view)
    }
    
    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.textView.text = items[position].text
    }
    
    override fun getItemCount() = items.size
}
```

## 🔗 Przydatne Linki

- [Android Developer - UI Components](https://developer.android.com/guide/topics/ui)
- [Material Design Components](https://material.io/components)
- [Kotlin Android Documentation](https://kotlinlang.org/docs/android-overview.html)

