package com.example.compose

import androidx.multidex.MultiDexApplication
import com.example.compose.utlis.MConstant.Engine_ID
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApp : MultiDexApplication() {
    override fun onCreate() {
        super.onCreate()
        Companion.flutterEngine = FlutterEngine(this)
        flutterEngine.navigationChannel.setInitialRoute("homepage")
        Companion.flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put(Engine_ID, Companion.flutterEngine)
    }

    companion object {
        lateinit var flutterEngine: FlutterEngine
    }
}