package ilyas.belfar.tp_tdm;

import android.content.ContentResolver;
import android.content.Context;
import android.database.Cursor;
import android.net.Uri;
import android.provider.MediaStore;

import java.util.ArrayList;

public class Audio_Picker {
    private ContentResolver contentResolver;
    public Audio_Picker(ContentResolver contentResolver) {
        this.contentResolver = contentResolver;
    }

    public ArrayList<Audio> getAudios() {
        Cursor cursor = contentResolver.query(
                MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
                null,
                MediaStore.Audio.Media.IS_MUSIC + "=1",
                null,
                null
        );
        if (cursor == null) {
            return new ArrayList<Audio>();
        }
        ArrayList<Audio> audioList = new ArrayList<>();
        try{
            if (cursor.moveToFirst()) {
                int title = cursor.getColumnIndex(MediaStore.Audio.Media.TITLE);
                int path = cursor.getColumnIndex(MediaStore.Audio.Media.DATA);
                do {
                    Audio song = new Audio();
                    song.setTitle(cursor.getString(title));
                    song.setPath(cursor.getString(path));
                    audioList.add(song);
                } while(cursor.moveToNext());
            }
        } finally {
            cursor.close();
        }
        return audioList;
    }
}
