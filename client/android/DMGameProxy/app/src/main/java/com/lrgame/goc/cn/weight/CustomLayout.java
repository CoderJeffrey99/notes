package com.lrgame.goc.cn.weight;

import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.widget.Button;
import android.widget.LinearLayout;

import com.lrgame.goc.cn.R;

public class CustomLayout extends LinearLayout {

    public CustomLayout(Context context, AttributeSet attr) {
        super(context, attr);

        LayoutInflater.from(context).inflate(R.layout.show_tip, this);

        Button left_btn = findViewById(R.id.left_button);

    }
}
