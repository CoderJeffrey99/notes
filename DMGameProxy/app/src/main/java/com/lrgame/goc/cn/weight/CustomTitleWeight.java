package com.lrgame.goc.cn.weight;

import android.app.Activity;
import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;

import com.lrgame.goc.cn.R;

public class CustomTitleWeight extends ConstraintLayout { // 这里必须继承布局

    // 1.构造方法
    public CustomTitleWeight(Context context, AttributeSet attributeSet) {
        super(context, attributeSet);
        // 2.动态加载布局文件
        /**
         * 1>.第一种方式
         * 创建LayoutInflater对象
         * @param int resource布局文件的id
         * @param ViewGroup root布局文件的父布局
         */
        LayoutInflater.from(context).inflate(R.layout.title, this);
        LayoutInflater.from(context).setFactory(new LayoutInflater.Factory() {
            @Nullable
            @Override
            public View onCreateView(@NonNull String s, @NonNull Context context, @NonNull AttributeSet attributeSet) {
                // 什么时候调用：布局文件中定义的控件被创建的时候调用
                // 什么作用：替换控件
                if ("myText".equals(s)) {
                    return new CustomTitleWeight(context, attributeSet);
                }
                return null;
            }
        });
        // 2>.第二种方式
        View view = View.inflate(context, R.layout.title, null);
        this.addView(view);
        // 3>.第三种方式
        View view1 = View.inflate(context, R.layout.title, this);
        // 3.实现控件方法
        Button titleBack = findViewById(R.id.title_back);
        titleBack.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View view) {
                // 销毁掉当前的活动
                ((Activity)getContext()).finish();
                // FIXME：这里怎么回调出去
            }
        });
        // 4.获取属性
        for (int i = 0; i < attributeSet.getAttributeCount(); i++) {
            attributeSet.getAttributeName(i);
            attributeSet.getAttributeValue(i);
        }
        attributeSet.getAttributeValue("http://schemas.android.com/apk/res/com.lrgame.goc.cn", "属性名");
    }
}
