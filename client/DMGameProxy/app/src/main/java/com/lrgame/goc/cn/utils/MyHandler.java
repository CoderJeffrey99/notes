package com.lrgame.goc.cn.utils;

import org.xml.sax.Attributes;
import org.xml.sax.SAXException;
import org.xml.sax.helpers.DefaultHandler;

// a、新建一个class继承DefaultHandler
public class MyHandler extends DefaultHandler {

    private String nodeName;
    private StringBuilder id;
    private StringBuilder name;
    private StringBuilder version;

    @Override
    public void startDocument() throws SAXException {
        super.startDocument();
        // 开始XML解析的时候调用
        id = new StringBuilder();
        name = new StringBuilder();
        version = new StringBuilder();
    }

    @Override
    public void startElement(String uri, String localName, String qName, Attributes attributes) throws SAXException {
        super.startElement(uri, localName, qName, attributes);
        // 开始解析某个节点的时候调用（从XML中解析出的数据就会以参数的形式传入到该方法中）
        // 记录当前节点名
        nodeName = localName;
    }

    @Override
    public void characters(char[] ch, int start, int length) throws SAXException {
        super.characters(ch, start, length);
        // 获取节点中内容的时候调用（从XML中解析出的数据就会以参数的形式传入到该方法中）
        if (nodeName.equals("id")) {
            id.append(ch, start, length);
        } else if (nodeName.equals("name")) {
            name.append(ch, start, length);
        } else if (nodeName.equals("version")) {
            version.append(ch, start, length);
        }
    }

    @Override
    public void endElement(String uri, String localName, String qName) throws SAXException {
        super.endElement(uri, localName, qName);
        // 完成解析某个节点的时候调用（从XML中解析出的数据就会以参数的形式传入到该方法中）
        if (localName.equals("app")) {
            // 最后要将StringBuilder清空
            id.setLength(0);
            name.setLength(0);
            version.setLength(0);
        }
    }

    @Override
    public void endDocument() throws SAXException {
        super.endDocument();
        // 完成整个XML解析的时候调用
    }
}
