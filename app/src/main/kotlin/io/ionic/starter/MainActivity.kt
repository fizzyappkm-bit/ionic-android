package io.ionic.starter

import android.os.Bundle
import com.getcapacitor.BridgeActivity

/**
 * MainActivity - Hybrydowy approach
 * 
 * Ta aktywność może obsługiwać zarówno:
 * - WebView z Vue (dla ekranów jeszcze nie zmigrowanych)
 * - Natywne ekrany Kotlin (dla zmigrowanych ekranów)
 * 
 * Stopniowo będziemy podmieniać ekrany Vue na natywne Kotlin
 */
class MainActivity : BridgeActivity() {
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        
        // Dla teraz używamy WebView (Vue)
        // W przyszłości możemy dodać logikę routingu do natywnych ekranów
    }
}

