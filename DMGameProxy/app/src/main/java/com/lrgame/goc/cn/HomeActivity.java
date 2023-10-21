package com.lrgame.goc.cn;

import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;

public class HomeActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_home);

        Intent intent = getIntent();
        int age = intent.getIntExtra("age", 18); // 传递的是int类型
        String name = intent.getStringExtra("name"); // 传递的是String类型
    }

    @Override
    public void onBackPressed() {
        // 按下返回键触发
        Intent intent = new Intent();
        intent.putExtra("name", "wy");
        setResult(100, intent);
        finish();
    }
}