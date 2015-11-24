package com.coko.mdk3.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.coko.mdk3.R;
import com.coko.mdk3.model.LauncherIcon;

/**
 * Created by User on 11/23/2015.
 */
public class ImageDashboardAdapter extends BaseAdapter {
    private Context mContext;
    private int layoutResourceId;
    private LauncherIcon[] icons = null;

    public ImageDashboardAdapter(Context context, int layoutResourceId,LauncherIcon[] icons){
        this.mContext = context;
        this.layoutResourceId = layoutResourceId;
        this.icons = icons;
    }

    @Override
    public int getCount(){
        return icons.length;
    }

    @Override
    public LauncherIcon getItem(int position){
        return null;
    }

    @Override
    public long getItemId(int position){
        return  0;
    }
    static class ViewHolder{
        public ImageView icon;
        public TextView text;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent){
        View v = convertView;
        ViewHolder holder;

        if(v == null){
            LayoutInflater vi = (LayoutInflater) mContext.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            v = vi.inflate(layoutResourceId,null);

            holder = new ViewHolder();
            holder.text = (TextView) v.findViewById(R.id.dashboard_icon_text);
            holder.icon = (ImageView) v.findViewById(R.id.dashboard_icon_img);
            v.setTag(holder);
        }else{
            holder = (ViewHolder) v.getTag();
        }
        holder.icon.setImageResource(icons[position].imgId);
        holder.text.setText(icons[position].text);

        return v;
    }
}
