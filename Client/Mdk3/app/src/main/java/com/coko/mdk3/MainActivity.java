package com.coko.mdk3;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;
import android.widget.ListView;

import com.coko.mdk3.adapter.DrawerItemCustomAdapter;
import com.coko.mdk3.adapter.ImageDashboardAdapter;
import com.coko.mdk3.model.LauncherIcon;
import com.coko.mdk3.model.ObjectDrawerItem;
import com.coko.mdk3.utility.SessionManager;


public class MainActivity extends AppCompatActivity {

    private String[] mNavigationDrawerItemTitles;
    private DrawerLayout mDrawerLayout;
    private ListView mDrawerList;
    private Toolbar toolbar;
    private GridView gridView;

    SessionManager session;
    private int selectedPosition;

    static final ObjectDrawerItem[ ] drawerItems = {
            new ObjectDrawerItem(R.drawable.ic_action_copy, "Help"),
            new ObjectDrawerItem(R.drawable.ic_menu_logout, "Logout")
    };
    static final LauncherIcon[] icons = {
            new LauncherIcon(R.drawable.ic_logo_golkar,"Golkar","ic_logo_golkar.png"),
            new LauncherIcon(R.drawable.ic_logo_pdi,"PDI","ic_logo_pdi.jpg"),
            new LauncherIcon(R.drawable.ic_logo_pks,"PKS","ic_logo_pks.png"),
            new LauncherIcon(R.drawable.ic_logo_nasdem,"Nasdem","ic_logo_nasdem.jpg")
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        session  = new SessionManager(getApplicationContext());
        if(!session.isLoggedIn()){
            Intent intent = new Intent(MainActivity.this,LoginActivity.class);
            startActivity(intent);
        }

        mNavigationDrawerItemTitles = getResources().getStringArray(R.array.navigation_drawer_items_array);
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        mDrawerList = (ListView) findViewById(R.id.navlist);
        toolbar = (Toolbar) findViewById(R.id.toolbar);
        gridView = (GridView) findViewById(R.id.dashboard_grid);

        /* ====== Toolbar layout ============= */
        toolbar.setNavigationIcon(R.drawable.ic_drawer);
        if(toolbar != null) {
            setSupportActionBar(toolbar);
        }

        /*======= Drawer Layout =========== */
        mDrawerLayout.setDrawerShadow(R.drawable.drawer_shadow, GravityCompat.START);

        DrawerItemCustomAdapter adapter = new DrawerItemCustomAdapter(this,R.layout.navdrawer_list_item_row,drawerItems);
        mDrawerList.setAdapter(adapter);
        mDrawerList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                selectedPosition = position;

               // updateFragment();
                mDrawerLayout.closeDrawer(mDrawerList);

                if(drawerItems[selectedPosition].name.equals("Logout")){
                    session.clearAllSession();
                    Intent intent = new Intent(MainActivity.this,LoginActivity.class);
                    startActivity(intent);
                    finish();
                }
            }
        });

        /* ========== Grid Layout ========== */

        ImageDashboardAdapter imageDashboardAdapter = new ImageDashboardAdapter(getApplicationContext(),R.layout.dashboard_icon,icons);
        gridView.setAdapter(imageDashboardAdapter);
        gridView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
//                Intent intent = new Intent(this,DetailPartaiActivity.class);
//                startActivity(intent);
            }
        });
        //disable gridview scrolling
        gridView.setOnTouchListener(new View.OnTouchListener() {
            @Override
            public boolean onTouch(View v, MotionEvent event) {
                return event.getAction() == MotionEvent.ACTION_MOVE;
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                mDrawerLayout.openDrawer(GravityCompat.START);
                return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onStop(){
        super.onStop();
        this.finish();
    }
}
