package ilyas.belfar.tp_tdm;

import android.media.MediaPlayer;

import java.io.IOException;

public class Audio_Player {
    private MediaPlayer player;

    public Audio_Player() {

    }
    public boolean isPlaying() {
        if (player != null) {
            return player.isPlaying();
        }
        return false;
    }

    public void pause() {
        if (player != null && player.isPlaying()) {
            player.pause();
        }
    }

    public void prepare(String path) {
        try {
            player = new MediaPlayer();
            player.setDataSource(path);
            player.prepare();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void start() {
        if (player != null && !player.isPlaying()) {
            player.start();
        }
    }

    public void stop() {
        if (player != null) {
            player.stop();
            player.reset();
            player.release();
            player = null;
        }
    }
}
