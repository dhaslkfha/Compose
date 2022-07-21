package com.example.compose

import androidx.multidex.MultiDexApplication
import com.example.compose.utlis.MConstant.Engine_ID
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.embedding.engine.FlutterEngineCache
import io.flutter.embedding.engine.dart.DartExecutor

class MyApp : MultiDexApplication() {
    lateinit var flutterEngine: FlutterEngine
    override fun onCreate() {
        super.onCreate()
        flutterEngine = FlutterEngine(this)
//        flutterEngine.navigationChannel.setInitialRoute("homepage")
        flutterEngine.dartExecutor.executeDartEntrypoint(
            DartExecutor.DartEntrypoint.createDefault()
        )
        FlutterEngineCache.getInstance().put(Engine_ID, flutterEngine)
    }
}