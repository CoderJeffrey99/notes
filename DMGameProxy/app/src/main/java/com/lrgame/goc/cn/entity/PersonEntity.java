package com.lrgame.goc.cn.entity;

import java.io.Serializable;

// 让类序列化：将一个对象转换成可存储、可传输的状态
public class PersonEntity implements Serializable {
    private String Name;
    private int Age;

    public void setName(String name) {
        Name = name;
    }

    public void setAge(int age) {
        Age = age;
    }

    public String getName() {
        return Name;
    }

    public int getAge() {
        return Age;
    }
}
