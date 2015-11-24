package com.coko.mdk3.utility;

import android.content.Context;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;

import java.util.Iterator;
import java.util.Map;

/**
 * Created by User on 11/19/2015.
 */
public class SessionManager {

    private static final String PREF_FILE_KEY = "com.example.user.mdk3.PREFERENCE_FILE_KEY";
    private static final String IS_LOGIN = "isLogin";
    private static final String USER_NIK = "userNIK";

    Context context;
    Editor editor;
    SharedPreferences preferences;


    public SessionManager(Context context){
        this.context = context;
        preferences = context.getSharedPreferences(PREF_FILE_KEY,Context.MODE_PRIVATE);
        editor =  preferences.edit();
    }

    public void setLoginSession(Map userMap){
        editor.putBoolean(IS_LOGIN,true);

        Iterator iterator = userMap.entrySet().iterator();
        while(iterator.hasNext()){
            Map.Entry pair = (Map.Entry)iterator.next();
            editor.putString((String)pair.getKey(),(String)pair.getValue());
        }
        editor.commit();
    }
    public boolean isLoggedIn(){
        return preferences.getBoolean(IS_LOGIN,false);
    }

    public void clearAllSession(){
        editor.clear();
        editor.commit();
    }
}
