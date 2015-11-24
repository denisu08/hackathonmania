package com.coko.mdk3.adapter;

import android.app.Activity;
import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.coko.mdk3.R;
import com.coko.mdk3.model.ObjectDrawerItem;

/**
 * Created by User on 11/22/2015.
 */
public class DrawerItemCustomAdapter extends ArrayAdapter<ObjectDrawerItem>{
    Context context;
    int layoutResourceId;
    ObjectDrawerItem data[] = null;

    public DrawerItemCustomAdapter(Context context, int layoutResourceId, ObjectDrawerItem[] data){
        super(context, layoutResourceId, data);
        this.layoutResourceId = layoutResourceId;
        this.context = context;
        this.data = data;
    }
    public View getView(int position, View convertView, ViewGroup parent){
        View listItem = convertView;

        LayoutInflater inflater = ((Activity) context).getLayoutInflater();
        listItem = inflater.inflate(layoutResourceId,parent,false);

        ImageView imageViewIcon = (ImageView) listItem.findViewById(R.id.iconNavDrawer);
        TextView textViewName = (TextView) listItem.findViewById(R.id.textNavDrawer);

        ObjectDrawerItem folder = data[position];

        imageViewIcon.setImageResource(folder.icon);
        textViewName.setText(folder.name);

        return listItem;
    }
}
