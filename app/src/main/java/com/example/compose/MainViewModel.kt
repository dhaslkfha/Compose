package com.example.compose

import androidx.lifecycle.ViewModel
import dagger.hilt.android.lifecycle.HiltViewModel

@HiltViewModel
class MainViewModel:ViewModel() {
    val name = "Ning"
    val age = "31"

    fun add(a:Int,b:Int) = a +b

}