package com.example.flutter_application;
import android.content.Context;
import android.util.Log;

import com.idlefish.flutterboost.FlutterBoost;

import io.flutter.app.FlutterApplication;

public class SSIApp extends FlutterApplication {
    @Override
    public void onCreate() {
        super.onCreate();
        Log.e("SSIApp", "onCreate FlutterBoost ");

        FlutterBoost.instance().setup(this, new SSIDelegate(), engine -> {
        });
    }

    @Override
    protected void attachBaseContext(Context base) {
        super.attachBaseContext(base);
//        MultiDex.install(this);
    }
}
