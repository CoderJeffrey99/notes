package com.lrgame.goc.cn.entity;

public class FruitItem {
    private String name;
    private int imageId;

    public FruitItem(String name, int imageId) {
        this.name= name;
        this.imageId = imageId;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setImageId(int imageId) {
        this.imageId = imageId;
    }

    public int getImageId() {
        return imageId;
    }
}
