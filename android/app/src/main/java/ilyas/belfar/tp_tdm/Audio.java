package ilyas.belfar.tp_tdm;

import java.util.HashMap;

public class Audio {
    public String title;
    public String path;

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public HashMap<String, Object> toHashMap() {
        HashMap<String, Object> audioMap = new HashMap<>();
        audioMap.put("title", title);
        audioMap.put("path", path);
        return audioMap;
    }
}
