package com.example.compose.model

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel

@HiltViewModel
class HomeViewModel : ViewModel() {
    var num = 10
    fun add(add: Int) {
        num += add
    }
}