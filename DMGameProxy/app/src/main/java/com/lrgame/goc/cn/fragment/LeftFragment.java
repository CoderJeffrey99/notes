package com.lrgame.goc.cn.fragment;

import android.app.Activity;
import android.os.Bundle;

import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.lrgame.goc.cn.MainActivity;
import com.lrgame.goc.cn.R;

public class LeftFragment extends Fragment {
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        Activity currentActivity = (MainActivity) getActivity(); // 和当前碎片相关联的活动
//        currentActivity.getSupportFragmentManager().findFragmentById(R.id.right_fragment);
        return inflater.inflate(R.layout.fragment_left, container, false);
    }
}