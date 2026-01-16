package io.ionic.starter.native

import android.content.Context
import android.content.Intent
import androidx.fragment.app.FragmentActivity

/**
 * NativeNavigationHelper - Pomocnik do nawigacji między ekranami
 * 
 * Ta klasa pomaga w stopniowej migracji:
 * - Sprawdza czy ekran jest już zmigrowany do Kotlin
 * - Jeśli tak, otwiera natywny ekran
 * - Jeśli nie, pozostawia WebView (Vue)
 * 
 * Strategia migracji:
 * 1. Zacznij od prostych ekranów (Tab1 - licznik)
 * 2. Stopniowo migruj kolejne ekrany
 * 3. Na końcu usuń WebView całkowicie
 */
object NativeNavigationHelper {
    
    /**
     * Lista ekranów które są już zmigrowane do natywnego Kotlin
     */
    private val migratedScreens = setOf(
        "/tabs/tab1"  // Tab1 jest już w Kotlin
    )
    
    /**
     * Sprawdza czy dany ekran jest już zmigrowany
     */
    fun isScreenMigrated(route: String): Boolean {
        return migratedScreens.contains(route)
    }
    
    /**
     * Otwiera natywny ekran Kotlin
     */
    fun openNativeScreen(activity: FragmentActivity, route: String) {
        when (route) {
            "/tabs/tab1" -> {
                // Otwórz Tab1Fragment
                // TODO: Implementacja nawigacji do fragmentu
            }
            // Dodaj kolejne ekrany tutaj gdy będą migrowane
        }
    }
    
    /**
     * Strategia migracji - krok po kroku:
     * 
     * KROK 1: ✅ Tab1 (licznik) - ZROBIONE
     * KROK 2: Tab2 - TODO
     * KROK 3: Tab3 - TODO
     * KROK 4: Tabs (nawigacja) - TODO
     * KROK 5: Usuń WebView całkowicie
     */
}

