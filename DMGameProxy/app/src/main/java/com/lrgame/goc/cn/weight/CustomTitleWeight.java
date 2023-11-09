package com.lrgame.goc.cn.weight;

import android.app.Activity;
import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;

import androidx.constraintlayout.widget.ConstraintLayout;

import com.lrgame.goc.cn.R;

public class CustomTitleWeight extends ConstraintLayout { // 这里必须继承布局

    public CustomTitleWeight(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        /**
         * 动态加载布局文件
         * 1>.创建LayoutInflater对象
         * @param int resource布局文件的id
         * @param ViewGroup root布局文件的父布局
         * p125
         */
        LayoutInflater.from(context).inflate(R.layout.title, this);

        Button titleBack = findViewById(R.id.title_back);
        titleBack.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                // 销毁掉当前的活动
                ((Activity)getContext()).finish();
            }
        });

    }
}
