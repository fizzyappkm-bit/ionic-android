#!/bin/bash

# Skrypt do szybkiego tworzenia nowego Fragment z layoutem
# Użycie: ./scripts/create-fragment.sh Tab2

set -e

if [ -z "$1" ]; then
    echo "❌ Błąd: Podaj nazwę fragmentu"
    echo "Użycie: ./scripts/create-fragment.sh Tab2"
    exit 1
fi

FRAGMENT_NAME=$1
FRAGMENT_NAME_LOWER=$(echo "$FRAGMENT_NAME" | tr '[:upper:]' '[:lower:]')
FRAGMENT_FILE="${FRAGMENT_NAME}Fragment.kt"
LAYOUT_FILE="fragment_${FRAGMENT_NAME_LOWER}.xml"
PACKAGE_PATH="io/ionic/starter/native"
FULL_PATH="app/src/main/kotlin/${PACKAGE_PATH}"
RES_PATH="app/src/main/res/layout"

echo "🔨 Tworzenie fragmentu: $FRAGMENT_NAME"
echo ""

# Sprawdź czy pliki już istnieją
if [ -f "$FULL_PATH/$FRAGMENT_FILE" ]; then
    echo "⚠️  Fragment $FRAGMENT_FILE już istnieje!"
    read -p "Nadpisać? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

# Utwórz katalog jeśli nie istnieje
mkdir -p "$FULL_PATH"
mkdir -p "$RES_PATH"

# Utwórz plik Fragment
cat > "$FULL_PATH/$FRAGMENT_FILE" << EOF
package io.ionic.starter.native

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import io.ionic.starter.R

/**
 * ${FRAGMENT_NAME}Fragment - Natywny ekran w Kotlin
 * 
 * Migracja z: ionic-source/src/views/${FRAGMENT_NAME}.vue
 */
class ${FRAGMENT_NAME}Fragment : Fragment() {
    
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_${FRAGMENT_NAME_LOWER}, container, false)
    }
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        // TODO: Inicjalizuj widoki i logikę
        // Przykład:
        // val button = view.findViewById<Button>(R.id.button)
        // button.setOnClickListener { /* ... */ }
    }
    
    companion object {
        fun newInstance(): ${FRAGMENT_NAME}Fragment {
            return ${FRAGMENT_NAME}Fragment()
        }
    }
}
EOF

# Utwórz plik Layout XML
cat > "$RES_PATH/$LAYOUT_FILE" << EOF
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:orientation="vertical"
    android:padding="16dp"
    android:gravity="center">

    <!-- TODO: Dodaj elementy UI tutaj -->
    <!-- Przykład: -->
    <!--
    <TextView
        android:id="@+id/textView"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Hello ${FRAGMENT_NAME}!" />
    
    <Button
        android:id="@+id/button"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Button" />
    -->

</LinearLayout>
EOF

echo "✅ Utworzono:"
echo "   - $FULL_PATH/$FRAGMENT_FILE"
echo "   - $RES_PATH/$LAYOUT_FILE"
echo ""
echo "📝 Następne kroki:"
echo "   1. Otwórz $FRAGMENT_FILE i zaimplementuj logikę"
echo "   2. Otwórz $LAYOUT_FILE i dodaj elementy UI"
echo "   3. Zaktualizuj NativeNavigationHelper.kt"
echo "   4. Dodaj ekran do migratedScreens w NativeNavigationHelper"
echo ""
echo "💡 Przykład użycia w NativeNavigationHelper:"
echo "   \"/tabs/${FRAGMENT_NAME_LOWER}\" -> ${FRAGMENT_NAME}Fragment.newInstance()"

