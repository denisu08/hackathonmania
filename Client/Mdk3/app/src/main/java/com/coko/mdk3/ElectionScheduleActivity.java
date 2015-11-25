package com.coko.mdk3;

import android.app.ActionBar;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.LinearLayout;

public class ElectionScheduleActivity extends BaseActivity {

    private static final String TAG_INFO = "info_id";
    private LinearLayout linearLayout;
    private View.OnClickListener mClickListener = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            v.setBackgroundColor(getResources().getColor(R.color.colorPrimaryDark));
            //TODO: need change to database query for detail data
            Intent intent = new Intent(ElectionScheduleActivity.this, ScheduleDetailActivity.class);
            intent.putExtra(TAG_INFO,v.getId());
            startActivity(intent);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);

        linearLayout = (LinearLayout) findViewById(R.id.menu_list_schedule);

        LinearLayout.LayoutParams params = new LinearLayout.LayoutParams(ActionBar.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        params.setMargins(20,12,20,12);


        for(int i=0;i<2;i++) {
            Button button = new Button(this);
            button.setText("Pilihan " + (i + 1));
            button.setLayoutParams(params);
            button.setBackgroundColor(getResources().getColor(R.color.colorPrimary));
            button.setId(i);
            button.setOnClickListener(mClickListener);
            linearLayout.addView(button);

        }
    }

    @Override
    protected int getLayoutResource(){
        return R.layout.activity_election_schedule;
    }
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_election_schedule, menu);
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
}
