package com.coko.mdk3;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ListView;

import com.coko.mdk3.adapter.DrawerItemCustomAdapter;
import com.coko.mdk3.model.ObjectDrawerItem;
import com.coko.mdk3.utility.SessionManager;

public abstract class BaseActivity extends AppCompatActivity {

    private Toolbar toolbar;
    private String[] mNavigationDrawerItemTitles;
    public DrawerLayout mDrawerLayout;
    private ListView mDrawerList;
    private int selectedPosition;
    SessionManager session;

    static final ObjectDrawerItem[ ] drawerItems = {
            new ObjectDrawerItem(R.drawable.ic_action_copy, "Help"),
            new ObjectDrawerItem(R.drawable.ic_logout, "Logout")
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(getLayoutResource());

        session  = new SessionManager(getApplicationContext());

        mNavigationDrawerItemTitles = getResources().getStringArray(R.array.navigation_drawer_items_array);
        mDrawerLayout = (DrawerLayout) findViewById(R.id.drawer_layout);
        mDrawerList = (ListView) findViewById(R.id.navlist);
        toolbar = (Toolbar) findViewById(R.id.toolbar);

        /* ====== Toolbar layout ============= */
        if(toolbar != null) {
            setSupportActionBar(toolbar);
            getSupportActionBar().setDisplayHomeAsUpEnabled(true);
        }

          /*======= Drawer Layout =========== */
        // TODO :  Add my profile icon and preview in drawer layout, delete unecessary menu

        if(mDrawerLayout != null) {
            mDrawerLayout.setDrawerShadow(R.drawable.drawer_shadow, GravityCompat.START);

            DrawerItemCustomAdapter adapter = new DrawerItemCustomAdapter(this, R.layout.navdrawer_list_item_row, drawerItems);
            mDrawerList.setAdapter(adapter);
            mDrawerList.setOnItemClickListener(new AdapterView.OnItemClickListener() {
                @Override
                public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                    selectedPosition = position;

                    mDrawerLayout.closeDrawer(mDrawerList);

                    if (drawerItems[selectedPosition].name.equals("Logout")) {
                        session.clearAllSession();
                        Intent intent = new Intent(getApplicationContext(), LoginActivity.class);
                        startActivity(intent);
                        finish();
                    }
                }
            });
        }
    }


    protected abstract int getLayoutResource();

    protected void setActionBarIcon(int icon){
        toolbar.setNavigationIcon(icon);
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_base, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case R.id.action_notification:
                Intent intent = new Intent(this,ElectionScheduleActivity.class);
                startActivity(intent);
                return true;
        }

        return super.onOptionsItemSelected(item);
    }
}
