package com.coko.mdk3;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.view.GravityCompat;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.GridView;

import com.coko.mdk3.adapter.ImageDashboardAdapter;
import com.coko.mdk3.model.LauncherIcon;


public class MainActivity extends BaseActivity {

    private GridView gridView;

    static final LauncherIcon[] icons = {
            new LauncherIcon(R.drawable.ic_logo_golkar,"Golkar","ic_logo_golkar.png"),
            new LauncherIcon(R.drawable.ic_logo_pdi,"PDI","ic_logo_pdi.jpg"),
            new LauncherIcon(R.drawable.ic_logo_pks,"PKS","ic_logo_pks.png"),
            new LauncherIcon(R.drawable.ic_logo_nasdem,"Nasdem","ic_logo_nasdem.jpg")
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setActionBarIcon(R.drawable.ic_drawer);

        if(!session.isLoggedIn()){
            Intent intent = new Intent(MainActivity.this,LoginActivity.class);
            startActivity(intent);
        }


        gridView = (GridView) findViewById(R.id.dashboard_grid);

        /* ============ News Layout ====================*/
        //TODO : Add news layout between toolbar and gridview, slider type

        /* ========== Grid Layout ========== */
        // TODO : create activity for detail on image is clicked
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
    protected int getLayoutResource(){
        return R.layout.activity_main;
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
            case R.id.action_notification:
                Intent intent = new Intent(this,ElectionScheduleActivity.class);
                startActivity(intent);
                return true;
        }

        return super.onOptionsItemSelected(item);
    }
}

//    @Override
//    public void onStop(){
//        super.onStop();
//        this.finish();
//    }
