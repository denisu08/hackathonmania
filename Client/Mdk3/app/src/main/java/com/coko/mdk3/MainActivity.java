package com.coko.mdk3;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.ListView;

import com.coko.mdk3.adapter.DrawerItemCustomAdapter;
import com.coko.mdk3.model.ObjectDrawerItem;
import com.coko.mdk3.utility.SessionManager;


public class MainActivity extends AppCompatActivity {

    private String[] mNavigationDrawerItem;
    private DrawerLayout mDrawerLayout;
    private ListView mDrawerList;
    private ActionBarDrawerToggle mDrawerToggle;
    private CharSequence mDrawerTitle;
    private CharSequence mTitle;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        mNavigationDrawerItem = getResources().getStringArray(R.array.navigation_drawer_items_array);
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        mDrawerList = (ListView) findViewById(R.id.navlist);
        mTitle = mDrawerTitle = getTitle();

        ObjectDrawerItem[ ] drawerItems = new ObjectDrawerItem[2];
        drawerItems[0] = new ObjectDrawerItem(R.drawable.ic_action_copy,"Help");
        drawerItems[1] = new ObjectDrawerItem(R.drawable.ic_menu_logout,"Logout");

        DrawerItemCustomAdapter adapter = new DrawerItemCustomAdapter(this,R.layout.navdrawer_list_item_row,drawerItems);
        mDrawerList.setAdapter(adapter);

        mDrawerToggle = new ActionBarDrawerToggle(this,mDrawerLayout,R.string.drawer_open,R.string.drawer_close){
            public void onDrawerClosed(View view){
                super.onDrawerClosed(view);
                getActionBar().setTitle(mTitle);
            }

            public void onDrawerOpened(View view){
                super.onDrawerOpened(view);
                getActionBar().setTitle(mDrawerTitle);
            }
        };

        mDrawerLayout.setDrawerListener(mDrawerToggle);

        SessionManager session  = new SessionManager(getApplicationContext());
        if(!session.isLoggedIn()){
            Intent intent = new Intent(MainActivity.this,LoginActivity.class);
            startActivity(intent);
        }

        getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        getSupportActionBar().setHomeButtonEnabled(true);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }
    // TODO : onBack from main activity close / finish app
}
