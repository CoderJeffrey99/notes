package com.lrgame.goc.cn.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.lrgame.goc.cn.R;
import com.lrgame.goc.cn.entity.FruitItem;

import java.util.List;

public class FruitAdapter extends ArrayAdapter<FruitItem> {

    private Context currentContext;

    private int resourceId;

    private List<FruitItem> fruitList;

    // 第一步：创建构造方法
    public FruitAdapter(Context context, int textViewResourceId, List<FruitItem> object) {
        super(context, textViewResourceId, object);
        currentContext = context;
        resourceId = textViewResourceId;
        fruitList = object;
    }

    // ListView实现分组
    // xxx

    @NonNull
    @Override
    public View getView(int position, @Nullable View convertView, @NonNull ViewGroup parent) {
        // 每个子项被滚动到屏幕内的时候会被调用

//        // 第一步
//        // 不会给View添加父布局
//        View view = LayoutInflater.from(currentContext).inflate(resourceId, parent, false);

//        // 优化1
//        View view;
//        if (convertView == null) {
//            view = LayoutInflater.from(currentContext).inflate(resourceId, parent, false);
//        } else {
//            view = convertView;
//        }

        // 优化2
        View view;
        ViewHolder viewHolder;
        if (convertView == null) {
            view = LayoutInflater.from(getContext()).inflate(resourceId, parent, false);
            viewHolder = new ViewHolder();
            viewHolder.fruitImageView = view.findViewById(R.id.image_view);
            viewHolder.fruitTextView = view.findViewById(R.id.text_view);
            view.setTag(viewHolder); // 保存
        } else {
            view = convertView;
            viewHolder = (ViewHolder) view.getTag(); // 获取
        }

        if (position < fruitList.size()) {
            // Android中的资源使用int表示
            viewHolder.fruitImageView.setImageResource(fruitList.get(position).getImageId());
            viewHolder.fruitTextView.setText(fruitList.get(position).getName());
        }

//        if (viewHolder.fruitImageView != null) {
//            viewHolder.fruitImageView.setImageResource(fruitList.get(position).getImageId());
//        }
//        if (viewHolder.fruitTextView != null) {
//            viewHolder.fruitTextView.setText(fruitList.get(position).getText());
//        }
        return view;
    }

    class ViewHolder {
        ImageView fruitImageView;
        TextView fruitTextView;
    }
}
