package com.lrgame.goc.cn.content;

import android.content.ContentProvider;
import android.content.ContentValues;
import android.database.Cursor;
import android.net.Uri;

public class MyContentProvider extends ContentProvider {

    public MyContentProvider() {

    }

    @Override
    public int delete(Uri uri, String selection, String[] selectionArgs) {
        return 0;
    }

    @Override
    public String getType(Uri uri) {
        // 根据传入的内容URI来返回相应的MIME类型
        return null;
    }

    @Override
    public Uri insert(Uri uri, ContentValues values) {
        // 向内容提供器中添加一条数据
        // 添加完成，返回一个用于表示这条新记录的Uri
        return null;
    }

    @Override
    public boolean onCreate() {
        // 初始化内容提供器的时候调用：通常会在这里完成对数据库的创建和升级等操作
        // 返回true表示内容提供器初始化成功，返回false则表示失败
        return false;
    }

    @Override
    public Cursor query(Uri uri, String[] projection, String selection,
                        String[] selectionArgs, String sortOrder) {
        // 从内容提供器中查询数据
        // 查询的结果存放在Cursor对象中返回
        return null;
    }

    @Override
    public int update(Uri uri, ContentValues values, String selection,
                      String[] selectionArgs) {
        // 更新内容提供器中已有的数据
        // 受影响的行数将作为返回值返回
        return 0;
    }
}
