//
//  WMSocketViewController.m
//  WMGameProxy
//
//  Created by 谢吴军 on 2021/5/28.
//  Copyright © 2021 zali. All rights reserved.
//

#import "WMSocketViewController.h"
#import "GCDAsyncSocket.h"

@interface WMSocketViewController () <
GCDAsyncSocketDelegate>

@property (strong, nonatomic) GCDAsyncSocket *asyncSocket;
@property (strong, nonatomic) NSMutableArray *connectedSockets;

@end

@implementation WMSocketViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)showTCPUDP {
    // 1.TCP协议
    // 1>.概述：传输控制协议，TCP协议可以提供可靠的、面向连接、面向字节流的网络数据传输服务
    // 2>.特点
    // a、建立连接，形成传输数据的通道（必须建立连接，效率低）
    // b、在连接中进行数据传输（数据大小不做限制）
    // c、通过三次握手完成连接（可靠协议）
    
    // 2.UDP协议
    // 1>.概述：用户数据报协议，UDP协议是一种无连接的传输层协议，提供面向事务的不可靠信息传送服务
    // 2>.特点
    // a、不需要建立连接，将数据封装到数据报中（因为不需要建立连接，因此是不可靠协议，速度快）
    // b、每个数据报的大小限制在64K之内
    // 3>.什么时候使用UDP协议？
    // 当对网络通讯质量要求不高，网络通讯速度尽量快的时候使用UDP协议，如果语音、视频
    
    /*
     TCP协议和UDP协议有什么异同点？
     // TCP协议和UDP协议都是传输层协议：为应用层提供会话和数据报通信服务
     1.TCP协议面向连接，UDP协议无连接
     2.TCP协议提供可靠的网络传输服务（数据传输可靠、稳定、保证数据顺序正确），UDP协议尽最大努力交付（数据传输快，不保证可靠交付）
     3.TCP协议面向字节流，UDP协议面向报文
     */
    /*
     TCP协议怎么保证可靠性的？
     超时重发、丢弃重复数据
     */
    /*
     TCP协议超时重发具体步骤是什么？
     1.发送端每发送一个报文段，TCP协议便为其保留一个副本，设计启动一个定时器并等待确认信息
     2.接收端成功接收数据后返回确认信息，若在定时器超时前发送的报文段中的数据未能被确认，TCP协议就认为数据已丢失，需要对报文段中的数据重传，直到发送成功为止
     */
    /*
     TCP协议的“三次握手”/“四次挥手”的步骤？为什么需要三次握手？为什么需要四次挥手？
     // TCP协议的“三次握手”/“四次挥手”的步骤？
     1>.三次握手建立连接
     注意：握手过程中传送的包里不包含数据，三次握手完毕后，客户端与服务器才正式开始传送数据（理想状态下，tcp连接一旦建立，在通信双方中的任何一方主动关闭连接之前，tcp连接都将被一直保持下去）
     第一次握手：客户端发送syn包(syn = j)到服务器，并进入SYN_SEND状态，等待服务器确认
     第二次握手：服务器收到syn包，必须确认客户的SYN(ack = j + 1)，同时自己也发送一个SYN包(syn = k)，即SYN+ACK包，此时服务器进入SYN_RECV状态
     第三次握手：客户端收到服务器的SYN+ACK包，向服务器发送确认包ACK(ack = k + 1)，此包发送完毕，客户端和服务器建立连接
     2>.四次挥手断开连接：客户端和服务器均可以主动发起断开tcp连接的请求
     第一次挥手：首先客户端向服务端发送`释放连接的标志位FIN`，客户端进入`FIN_WAIT_1`状态，等待服务端确认
     第二次挥手：服务端收到`标志位FIN`后发送`确认标志位ACK`给客户端，确认序号为`收到序号+1`(与SYN相同，一个FIN占用一个序号)，服务端进入`CLOSE_WAIT`状态
     第三次挥手：服务端发送自己的`释放连接的标志位FIN`，服务端进入`LAST_ACK`状态
     第四次挥手：客户端收到`标志位FIN`后进入`TIME_WAIT`状态，然后发送一个`确认标志位ACK`给服务端，确认序号为`收到序号+1`，服务端进入`CLOSED`状态
     // 为什么需要三次握手？
     为了防止已失效的连接请求报文段突然又传送到了服务端，因而产生错误，假设这是一个早已失效的报文段。但`server`收到此失效的连接请求报文段后，就误认为是`client`再次发出的一个新的连接请求。于是就向`client`发出确认报文段，同意建立连接。假设不采用“三次握手”，那么只要server发出确认，新的连接就建立了。由于现在`client`并没有发出建立连接的请求，因此不会理睬`server`的确认，也不会向`server`发送数据。但`server`却以为新的运输连接已经建立，并一直等待`client`发来数据。这样，`server`的很多资源就白白浪费
     为了解决超时导致重复建立的问题（如果是两次握手会出现问题。客户端发送SYN请求建立连接时，如果网络发生延迟超时后客户端会重复发送SYN消息，服务器接收到第二次发送的建立连接请求，返回确认信息，连接建立完成。第一次发送SYN建立连接请求经过一段时间后到达服务器，服务器会认为客户端要建立新的连接，会重新发送应答响应。这就导致了重复建立连接的情况）
     // 为什么需要四次挥手？
     因为TCP协议是全双工通信（可以同时发送和接收），在关闭连接的时候必须关闭传输和发送两个方向上的连接（客户端发送FIN请求切断连接，服务器端发送ACK应答切断，当前连接处于半关闭状态，服务器端向客户端发送FIN请求切断连接，客户端返回ACK应答请求，此时连接才真正的关闭）
     */
}


-(void)showSocket {
    // 1.socket套接字
    // 1>.概述：网络上的两个程序通过一个双向的通信连接实现数据的交换，这个连接的一端称为一个socket
    // a、客户端 -socket-> 通信管道 -socket-> 服务端：应用程序通过“socket套接字”向网络发出请求或应答请求
    // 2>.网络通信的要素
    // a、网络上的请求是通过“socket套接字”来建立连接然后互相通信
    // ip地址 - 网络上主机设备的唯一标识
    // 端口号 - 用于标示进程的逻辑地址（有效端口0-65535、0-1024保留端口、开发中建议使用1024以上的端口）
    // 传输协议 - tcp、udp
    
    // 2.使用CocoaAsyncSocket第三方框：https://github.com/robbiehanson/CocoaAsyncSocket
    // 1>.步骤：服务端利用Socket监听端口 --> 客户端发起连接 --> 服务端返回信息，建立连接，开始通信 --> 客户端和服务端断开连接
    // 2>.建立socket连接
    // a.建立Socket连接至少需要一对套接字：一个运行于客户端ClientSocket、一个运行于服务器端ServerSocket
    // b.套接字之间的连接过程：服务器监听（服务器端套接字并不定位具体的客户端套接字，而是处于等待连接的状态，实时监控网络状态，等待客户端的连接请求） -> 客户端请求（客户端的套接字提出连接请求：首先描述它要连接的服务器的套接字，指出服务器端套接字的地址和端口号，然后就向服务器端套接字提出连接请求） -> 连接确认（当服务器端套接字监听到或者接收到客户端套接字的连接请求时，就响应客户端套接字的请求，建立一个新的线程，把服务器端套接字的描述发给客户端，一旦客户端确认了此描述，双方就正式建立连接，这时候服务器端套接字继续处于监听状态，继续接收其他客户端套接字的连接请求）
    // 3>.socket连接和tcp连接
    // a.创建socket连接时，可以指定使用的传输层协议：支持不同的传输层协议tcp/upd、当使用tcp协议进行连接时，该socket连接就是一个tcp连接
    
    // 3>.socket连接过程
    // a.创建一个socket
    self.asyncSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    self.connectedSockets = [NSMutableArray array];
    if (!self.asyncSocket) {
        // init失败
    } else {
        NSError *error = nil;
        uint16_t port = 8888;
        if (![self.asyncSocket acceptOnPort:port error:&error]) {
            // 启动失败
        }
    }
    // b.设置socket属性
    // c.绑定IP地址、端口等信息到socket
    // d.设置需要连接的对方的IP地址和端口等属性
    // e.连接服务器
    // f.发送接收数据
    // g.关闭网络连接

    /*
     在平时开发的时候有没有使用过socket？一般socket有哪些使用场景？如何预防socket丢包？
     // 在平时开发的时候有没有使用过socket？
     使用的比较少
     // 一般socket有哪些使用场景？
     心跳检测、即时通讯
     // 如何预防socket丢包？
     发送心跳包检测客户端和服务端是否还处于active状态
     */
    /*
     网络七层协议
     应用层http
     表示层
     会话层
     传输层tcp/udp
     网络层ip
     数据链路层
     物理层
     */
    /*
     socket连接和http连接有什么不同？
     // socket连接
     socket不是协议而是套接字，由ip和端口两部分组成，socket连接是长连接（理论上客户端和服务器端一旦建立起连接将不会主动断掉，但是由于各种环境因素可能会是连接断开：服务器端或客户端主机宕机、网络故障、两者之间长时间没有数据传输，网络防火墙可能会断开该连接以释放网络资源）
     // http连接
     http协议是超文本传输协议，基于请求和响应模式的应用协议，http连接是短连接（客户端向服务器端发送一次请求，服务器端响应以后连接即会断掉）
     */
}


-(void)showXMPP {
    // 1.XMPP协议
    // 1>.概念：XMPP是基于XML通讯的协议（基于tcp发送xml数据，一般用于即时通讯）
    // 2>.原理：节点连接到服务器 -> 服务器利用本地目录系统中的证书对其认证 -> 节点指定目标地址，让服务器告知目标状态 -> 服务器查找、连接并进行相互认证 -> 节点之间进行交互
    // 3>.组成：服务器、网关、客户端（可以任意两者双向发生）
}


#pragma mark - GCDAsyncSocketDelegate
- (void)socket:(GCDAsyncSocket *)sock didAcceptNewSocket:(GCDAsyncSocket *)newSocket {
    
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag {
    
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err {
    self.asyncSocket = nil;
    self.asyncSocket.delegate = nil;
}

- (void)dealloc {
    [self.asyncSocket setDelegate:nil];
    [self.asyncSocket disconnect];
}

@end
