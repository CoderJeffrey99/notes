package com.lrgame.goc.cn.adapter;

import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.lrgame.goc.cn.R;
import com.lrgame.goc.cn.entity.FruitItem;

import java.util.List;

public class RecyclerViewFruitAdapter extends RecyclerView.Adapter<RecyclerViewFruitAdapter.ViewHolder> {

    private List<FruitItem> mFruitList;
    // 1>.外界需要传入数据源（因为Android）
    public RecyclerViewFruitAdapter(List<FruitItem> list) {
        mFruitList = list;
        Log.d("TAG", String.valueOf(mFruitList.size()));
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        // 3>.重写ViewHolder实例
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.fruit_item, parent, false);
        ViewHolder viewHolder = new ViewHolder(view);
        // 分别给每个View添加监听事件
        viewHolder.fruitView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                // 利用接口进行回调
            }
        });
        viewHolder.fruitImage.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {

            }
        });
        return viewHolder;
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder holder, int position) {
        // 4>.每个子项滚动到屏幕内部执行赋值
        FruitItem fruitItem = mFruitList.get(position);
        holder.fruitImage.setImageResource(fruitItem.getImageId());
        holder.fruitName.setText(fruitItem.getName());
    }

    @Override
    public int getItemCount() {
        // 5>.一共有多少子项
        return mFruitList.size();
    }

    // 2>.定义内部类
    static class ViewHolder extends RecyclerView.ViewHolder {
        View fruitView;
        ImageView fruitImage;
        TextView fruitName;
        // 传入RecyclerView的子项
        public ViewHolder(View view) {
            super(view);
            // 最外层父视图
            fruitView = view;
            // 子视图
            fruitImage = view.findViewById(R.id.fruit_image);
            // 子视图
            fruitName = view.findViewById(R.id.fruit_name);
        }
    }
}
