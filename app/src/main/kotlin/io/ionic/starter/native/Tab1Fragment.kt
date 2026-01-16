package io.ionic.starter.native

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.Button
import android.widget.TextView
import androidx.fragment.app.Fragment
import io.ionic.starter.R

/**
 * Tab1Fragment - Natywny ekran licznika w Kotlin
 * 
 * To jest natywna implementacja ekranu Tab1 (licznik)
 * który wcześniej był w Vue (Tab1.vue)
 * 
 * Migracja: Tab1.vue (Vue) -> Tab1Fragment.kt (Kotlin)
 */
class Tab1Fragment : Fragment() {
    
    private var counter: Int = 0
    private lateinit var counterDisplay: TextView
    private lateinit var incrementButton: Button
    
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? {
        return inflater.inflate(R.layout.fragment_tab1, container, false)
    }
    
    override fun onViewCreated(view: View, savedInstanceState: Bundle?) {
        super.onViewCreated(view, savedInstanceState)
        
        counterDisplay = view.findViewById(R.id.counterDisplay)
        incrementButton = view.findViewById(R.id.incrementButton)
        
        // Przywróć stan licznika jeśli istnieje
        savedInstanceState?.let {
            counter = it.getInt(KEY_COUNTER, 0)
        }
        
        updateCounterDisplay()
        
        incrementButton.setOnClickListener {
            incrementCounter()
        }
    }
    
    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        outState.putInt(KEY_COUNTER, counter)
    }
    
    private fun incrementCounter() {
        counter++
        updateCounterDisplay()
    }
    
    private fun updateCounterDisplay() {
        counterDisplay.text = counter.toString()
    }
    
    companion object {
        private const val KEY_COUNTER = "counter"
        
        fun newInstance(): Tab1Fragment {
            return Tab1Fragment()
        }
    }
}

