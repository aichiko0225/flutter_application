package com.example.flutter_application;
import android.app.Activity;
import android.content.Intent;
import android.util.Log;

import com.idlefish.flutterboost.FlutterBoost;
import com.idlefish.flutterboost.FlutterBoostDelegate;
import com.idlefish.flutterboost.FlutterBoostRouteOptions;
import com.idlefish.flutterboost.containers.FlutterBoostActivity;

import io.flutter.embedding.android.FlutterActivityLaunchConfigs;

/**
 * @author yubiao
 */
public class SSIDelegate implements FlutterBoostDelegate {
    private static String TAG = "SSIDelegate";

    @Override
    public void pushNativeRoute(FlutterBoostRouteOptions options) {
        //这里根据options.pageName来判断你想跳转哪个页面，这里简单给一个
        String router = options.pageName();
        Log.e(TAG, router + " argument = " + options.arguments());

//        Class<? extends Activity> page = Router.router(router);
//        if (page != null) {
//            Intent intent = new Intent(FlutterBoost.instance().currentActivity(), page);
//            FlutterBoost.instance().currentActivity().startActivityForResult(intent, 123);
//        } else {
//            Log.e(TAG, "ERROR 未找到匹配路由");
//        }
    }

    @Override
    public void pushFlutterRoute(FlutterBoostRouteOptions options) {
        Intent intent = new FlutterBoostActivity.CachedEngineIntentBuilder(FlutterBoostActivity.class)
                .backgroundMode(FlutterActivityLaunchConfigs.BackgroundMode.transparent)
                .destroyEngineWithActivity(false)
                .uniqueId(options.uniqueId())
                .url(options.pageName())
                .urlParams(options.arguments())
                .build(FlutterBoost.instance().currentActivity());
        FlutterBoost.instance().currentActivity().startActivityForResult(intent, options.requestCode());
    }
}
