package ilyas.belfar.tp_tdm;

import android.content.Context;

import androidx.annotation.NonNull;

import java.util.ArrayList;
import java.util.HashMap;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class MainActivity implements MethodChannel.MethodCallHandler {
    private static final String CHANNEL_NAME  = "ilyas.belfar.tp_tdm/musicservice";
    private Audio_Picker audio_picker;
    private Audio_Player audio_player;

    private MainActivity(Context context) {
        audio_picker = new Audio_Picker(context.getContentResolver());
    }

    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), CHANNEL_NAME);
        channel.setMethodCallHandler(new MainActivity(registrar.activeContext()));
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        switch (call.method) {
            case "audio_picker.getAudios":
                ArrayList<HashMap<String, Object>> audioMapList = new ArrayList<>();
                for (Audio song : audio_picker.getAudios()) {
                    audioMapList.add(song.toHashMap());
                }
                result.success(audioMapList);
                break;
        }
    }
}