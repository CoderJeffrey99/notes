package com.lrgame.goc.cn.weight;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.view.View;

public class GameWeight extends View {
    int miCount = 0;
    int y = 0;
    
    public GameWeight(Context context) {
        super(context);
    }

    public void onDraw(Canvas canvas) {
        if (miCount < 100) {
            miCount++;
        } else {
            miCount = 0;
        }

        Paint paint = new Paint();
        switch (miCount % 4) {
            case 0:
                paint.setColor(Color.BLUE);
                break;
            case 1:
                paint.setColor(Color.GREEN);
                break;
            case 2:
                paint.setColor(Color.RED);
                break;
            case 3:
                paint.setColor(Color.YELLOW);
                break;
            default:
                paint.setColor(Color.WHITE);
                break;
        }
        canvas.drawRect((320 - 80) / 2, y, (320 - 80) / 2 + 80, y + 40, paint);
    }
}
