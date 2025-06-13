package com.lrgame.goc.cn.receiver;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.telephony.SmsMessage;
import android.widget.Toast;

public class BootCompleteReceiver extends BroadcastReceiver {

    @Override
    public void onReceive(Context context, Intent intent) {
        // 不允许开启线程：不要进行耗时操作
        // onReceive()运行较长时间不结束就会报错
        Toast.makeText(context, "Boot Complete", Toast.LENGTH_LONG).show();
        // 截断广播
        abortBroadcast();

        // 不能开线程，不能做耗时操作
        Bundle bundle = intent.getExtras();
        Object msg[] = (Object[])bundle.get("obj");
        SmsMessage smsMessage[] = new SmsMessage[msg.length];

        for (int i = 0; i < msg.length; i++) {
            smsMessage[i] = SmsMessage.createFromPdu((byte[]) msg[i]);
        }

        Toast.makeText(context, "短信内容：" + smsMessage[0].getMessageBody(), Toast.LENGTH_SHORT).show();
    }
}