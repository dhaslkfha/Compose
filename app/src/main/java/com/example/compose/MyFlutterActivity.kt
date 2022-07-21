package com.example.compose

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MyFlutterActivity : FlutterActivity() {
    private val CHANNEL = "samples.flutter.dev/battery"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "getBatteryLevel"){
                val batteryLevel = getBatteryLevel()
                if (batteryLevel != -1){
                    result.success(batteryLevel)
                }else{
                    result.error("UNAVAILABLE","Battery Level not available",null)
                }
            }else{
                result.notImplemented()
            }
        }
    }

    fun getBatteryLevel(): Int {
        return if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
            val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
            batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
        } else {
            val intent = ContextWrapper(applicationContext).registerReceiver(
                null, IntentFilter(
                    Intent.ACTION_BATTERY_CHANGED
                )
            )
            intent!!.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100 / intent!!.getIntExtra(
                BatteryManager.EXTRA_SCALE,
                -1
            )
        }
    }
}