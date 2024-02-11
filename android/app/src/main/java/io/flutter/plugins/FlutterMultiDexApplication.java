package io.flutter.app;

import android.app.Application;
import androidx.multidex.MultiDex;

public class FlutterMultiDexApplication extends FlutterApplication {
    @Override
    protected void attachBaseContext(android.content.Context base) {
        super.attachBaseContext(base);
        MultiDex.install(this);
    }
}
