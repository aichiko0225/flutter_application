package com.example.flutter_application;


import android.os.Bundle;
import android.util.Log;

import io.flutter.embedding.android.FlutterActivity;
import com.idlefish.flutterboost.EventListener;
import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.ListenerRemover;
import com.idlefish.flutterboost.containers.FlutterBoostActivity;

import java.util.HashMap;
import java.util.Map;

public class MainActivity extends FlutterBoostActivity {

    private ListenerRemover remover;

    @Override
    public String getUrl() {
        return "/main";
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EventListener listener = (key, args) -> {
            //deal with your event here
            Log.e("MainActivity", "key = " + key + "  args = " + args);
            if ("flutter_events".equals(key)) {
                String eventName = args.get("eventName").toString();
                if ("PrivacyAgree".equals(eventName)) {
                    int privacyAgreeStatus = (int) args.get("privacyAgreeStatus");
                    if (privacyAgreeStatus == 1) {
//                        initPrivate();
                    } else {
//                        exit();
                    }
                }
            }
        };
//        BoostChannel.instance.sendEventToNative("flutter_events", {"eventName": "PrivacyAgree", "privacyAgreeStatus": "1"});
        //flutter事件
        remover = FlutterBoost.instance().addEventListener("flutter_events", listener);
    }
}
