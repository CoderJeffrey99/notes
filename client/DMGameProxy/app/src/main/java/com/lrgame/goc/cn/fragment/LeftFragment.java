package com.lrgame.goc.cn.fragment;

import android.content.Context;
import android.os.Bundle;

import androidx.annotation.NonNull;
import androidx.fragment.app.Fragment;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.lrgame.goc.cn.page.MainActivity;
import com.lrgame.goc.cn.R;

public class LeftFragment extends Fragment {
    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // 为Fragment碎片创建视图（加载布局）时调用
        MainActivity currentActivity = (MainActivity) getActivity(); // 和当前碎片相关联的活动
//        // fragment获取另一个fragment
//        currentActivity.getSupportFragmentManager().findFragmentById(R.id.right_fragment);
        return inflater.inflate(R.layout.fragment_left, container, false);
    }

    // 当碎片和活动建立关联的时候调用
    @Override
    public void onAttach(@NonNull Context context) {
        super.onAttach(context);
    }

    // 当与碎片关联的视图被移除的时候调用
    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }

    // 当碎片和活动解除关联的时候调用
    @Override
    public void onDetach() {
        super.onDetach();
    }
}