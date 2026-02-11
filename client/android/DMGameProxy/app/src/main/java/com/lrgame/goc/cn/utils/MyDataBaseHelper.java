package com.lrgame.goc.cn.utils;

import android.content.Context;
import android.database.sqlite.SQLiteDatabase;
import android.database.sqlite.SQLiteOpenHelper;

public class MyDataBaseHelper extends SQLiteOpenHelper {

    // SQLite底层的全部是以string存储：可以提高运行效率（不同于MySQL）
    // >>id虽然是integer类型但是在底层还是string
    // >>book_name超过20也不会报错
    private static final String create_book = "create table if not exists book_db (\n" +
            " id integer primary key autoincrement,\n" +
            " author text,\n" +
            " book_name varchar(20),\n" +
            " price real,\n" +
            " pages integer)";
    private Context sContext;

    /**
     * 构造方法
     * @param context 上下文
     * @param name 数据库名字
     * @param factory cursor对象
     * @param version 数据库版本：从1开始（小于1会抛出异常）
     */
    public MyDataBaseHelper(Context context, String name, SQLiteDatabase.CursorFactory factory, int version) {
        super(context,name,factory,version);
        sContext = context;
    }

    @Override
    public void onCreate(SQLiteDatabase sqLiteDatabase) {
        // 创建表：当数据库第一次创建的时候调用
        sqLiteDatabase.execSQL(create_book);
    }

    @Override
    public void onUpgrade(SQLiteDatabase sqLiteDatabase, int i, int i1) {
        // 升级数据库：将version改成2就会调用该方法，因为数据库已经创建不会再走onCreate()方法
    }
}
