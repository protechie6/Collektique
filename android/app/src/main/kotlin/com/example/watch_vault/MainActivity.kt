package com.example.watch_vault

import io.flutter.embedding.android.FlutterFragmentActivity 
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.embedding.engine.FlutterEngine
import androidx.annotation.NonNull; 

class MainActivity: FlutterFragmentActivity  () {
    override fun configureFlutterEngine(@NonNull FlutterEngine: FlutterEngine){
        GeneratedPluginRegistrant.registerWith(FlutterEngine);
    }
}
