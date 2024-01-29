














































# 在VSCode中使用py
# https://zhuanlan.zhihu.com/p/639597093


# # 1.概述
# # 1>.概念：py是一种通用的、解释型、交互式、面向对象的高级编程语言（脚本语言）
# # 2>.py为什么这么流行：简单易学、生态丰富（想做什么功能基本都有现成的代码）、免费开源、跨平台、数据科学和人工智能的首选语言
# # 3>.发布：py3.0在2008年发布（py3.0不与py2.0向后兼容）
# # 4>.特点：py由解释器在运行时处理（不需要编译程序）、py支持面向对象
# # 5>.运行py：$python xxx.py
# # 6>.py不适合找工作：大多数的企业都不用py来开发应用（运行速度太慢，远不如C++）
# # 7>.py不适合做为你的主语言：学习py基础来编写py脚本实现自动化办公
# # 8>.py内容：基础语法 + 常用类库 + py处理表格 + py处理pdf

# # 2.怎么在macOS环境下安装py开发环境
# # 1>.访问https://www.python.org/downloads/macos
# # 2>下载适合macOS的py安装包
# # 3>.安装py安装包
# # 4>.验证安装结果：python3 -V
# # 5>.更新pip（可选）：pip install --upgrade pip

# # 3.标识符：用于标识变量、函数、类、模块和其它对象的名称
# # 1>.概念：包含“数字、字母、_”，不允许使用$、@，严格区分大小写
# # 2>.规范
# # >>类名首字母大写：其它标识符都是小写字母开头
# # >>用单个前导下划线表示私有：与dart语言类似
# # >>用两个前导下划线表示强大的私有标识符
# # >>如果标识符也以两个尾随下划线结尾：标识符是语言定义的特殊名称

# # 4.关键字：保留字、关键字不能作为标识符、关键字全部小写
# s1 = 'hello world'
# s2 = "hello world"
# # 多行字符串
# s3 = '''
# hello world
# good game
# '''
# # 输出语句
# print('hello world')

# # 5.注释：python没有多行注释
# # 单行注释
# a1 = 10; a2 = 20; a3 = 30; # python支持多个语言在一行

# # 6.数据类型
# # 1>.py变量不需要显式声明：当你给变量赋值的时，声明会自动发生
# s4 = 'John'
# # 2>.多重分配：py允许同时为多个变量分配单个值
# a4 = a5 = a6 = 1
# # 多个对象分配给多个变量
# a7, a8, a9 = 1, 2, 'John'
# # 3>.py有5种数据类型：Number数字、String字符串、List列表、Tuple元组、Dictionary字典
# # a.Number数字：int有符号整数、float浮点数实数值、complex复数
# # >>int有符号整数
# a10 = 10
# a11 = -10
# # >>float浮点数实数值
# a12 = 3.14
# a13 = -3.14
# # >>complex复数
# a14 = 4 - 36j
# # b.String字符串
# # >>字符串基础
# s5 = 'Hello World'
# s6 = 'XWJ'
# s7 = 'a' # 字符类型表示长度为1的字符串
# print(s5); # Hello World
# print(s5[0]) # H
# print(s5[2:5]) # [2, 5) -> llo
# print(s5[2:]) # llo World
# print(s5 * 2) # Hello WorldHello World
# print(s4 + s5) # Hello WorldXWJ
# # >>转义字符
# # \' -> '
# # \" -> "
# # \n -> 换行
# # >>字符串格式化
# # %s -> 字符串
# # %d -> 整数
# # %u -> 无符号整数
# # %f -> 浮点数
# print('My name is %s and weight is %d kg' % (s1, a1))
# # c.List列表：数据类型可以不同、可以更新数据
# list = ['abc', 11, 'joke', 15]
# list[1] = 'xwj' # 更新列表
# del list[1] # 删除一个列表元素
# tempList = [123, 'hello']
# print(list) # ['abc', 11, 'joke', 15]
# print(list[0]) # abc
# print(list[1:3]) # [1, 3) -> [11, 'joke']
# print(list[2:]) # ['joke', 15]
# print(tempList * 2) # ['abc', 11, 'joke', 15, 'abc', 11, 'joke', 15]
# print(list + tempList) # ['abc', 11, 'joke', 15, 123, 'hello']
# print(len(list)) # 返回列表长度
# print(max(list)) # 返回列表元素的最大值
# print(max(list)) # 返回列表元素的最大值
# print(min(list)) # 返回列表元素的最小值
# list.append('a') # 在列表末尾追加元素
# print(list.count('a')) # 统计某个元素在列表中出现的次数
# print(list.index('a')) # 返回某个元素第一次出现的时候的索引值
# list.insert(1, 'a') # 将元素插入到列表
# list.remove('a') # 删除列表中第一个元素
# list.reverse() # 列表反转
# # d.Tuple元组：：数据类型可以不同、不可以更新数据
# tuple = ('abc', 11, 'joke', 15)
# tempTuple = (123, 'hello')
# print(tuple) # ('abc', 11, 'joke', 15)
# print(tuple[0]) # abc
# print(tuple[1:3]) # [1, 3) -> (11, 'joke')
# print(tuple[2:]) # ('joke', 15)
# print(tempTuple * 2) # ('abc', 11, 'joke', 15, 'abc', 11, 'joke', 15)
# print(tuple + tempTuple) # ('abc', 11, 'joke', 15, 123, 'hello')
# # tuple[0] = 'xwj' # 无效
# # e.Dictionary字典：key&value均可以是任意类型
# dict = {
#     'key': 'value',
#     1: 'xwj',
#     2: 'cfj',
#     'key1': 3
# }
# dict['key2'] = 4
# print(dict['key']) # value
# print(dict[2]) # cfj
# print(dict) # {'key': 'value', 1: 'xwj', 2: 'cfj', 'key1': 3}
# print(dict.keys()) # ['key', 1, 2, 'key1']
# print(dict.values()) #['value', 'xwj', 'cfj', 3]
# # 4>.数据类型转换
# s9 = 'xwj'
# print(int(s7)) # 将s7转换成一个整数
# print(float(s7)) # 将s7转换成一个浮点数
# print(complex(s7)) # 将s7转换成一个复数
# print(str(s7)) # 将s7转换成一个字符串
# print(tuple(s7)) # 将s7转换成一个元组
# print(list(s7)) # 将s7转换成一个列表
# s10 = (('key', 'value'), (1, 'xwj'), ('key1', 3))
# print(dict(s10)) # 将s8转换成一个字典：s8必须是一个序列(key, value)元组

# # 7.运算符
# # 1>.算术运算符
# a15 = 9
# a16 = 4
# print(a15 + a16) # 13
# print(a15 - a16) # 5
# print(a15 * a16) # 36
# print(a15 / a16) # 2.25
# print(a15 % a16) # 1
# print(a15 ** a16) # a15^a16 = 81 * 81 = 6561
# print(a15 // a16) # 整除 -> 2
# # 2>.比较运算符：True和False
# # == != > < >= <=
# # 3>.赋值运算符
# a15 = a16
# a15 += a16 # a15 = a15 + a16
# a15 -= a16 # a15 = a15 - a16
# a15 *= a16 # a15 = a15 * a16
# a15 /= a16 # a15 = a15 / a16
# a15 %= a16 # a15 = a15 % a16
# a15 **= a16 # a15 = a15 ** a16
# a15 //= a16 # a15 = a15 // a16
# # 4>.位运算符
# a17 = 60
# a18 = 13
# print(a17 & a18) # 12...按位与运算
# print(a17 | a18) # 61...按位或运算
# print(a17 ^ a18) # 49...按位异或运算
# print(~a17) # -61...按位取反运算
# print(a17 << 2) # 240...左移动运算符
# print(a17 >> 2) # 15...右移动运算符
# # 5>.逻辑运算符：and、or、not
# # py规定“任何非零值和非空值”假定为true、“任何零值和空值”假定为false
# print(a17 and a18) # a17为False则返回False，否则返回a18
# print(a17 or a18) # a17为True则返回a17，否则返回a18
# print(not a17) # a17为False则返回True，否则返回False
# # 6>.成员运算符：in、not in
# print(a17 in list) # 在指定的序列中找到值则返回True，否则返回False
# print(a17 not in list) # 在指定的序列中找不到则返回True，否则返回False
# # 7>.身份运算符：is、is not
# print(a17 is a18); # 判断两个标识符是否引用自同一个对象
# print(a17 is not a18) # 判断两个标识符是否引用自不同对象

# # 8.条件控制
# # 1>.py规定“任何非零值和非空值”假定为true、“任何零值和空值”假定为false
# # 2>.py不支持switch语句
# # 第一种方式
# # py不使用{}来限定代码块：而是使用“线条缩进”表示（缩进的空格数可变：同一个代码块中所有的语句必须缩进相同的数量）
# # 在py中，所有用相同数量的空格缩进的连续行将组成一个代码块
# if a17:
#     # py允许使用"行连续字符\"来表示该行应该继续
#     s11 = "我的名字：" + \
#     "谢吴军"
#     print(a17)
#     print(s11)
# # 第二种方式
# if a17:
#     print(a17)
# else:
#     print('错误')
# # 第三种方式
# if a17:
#     print(a17)
# elif a18:
#     print(a18)
# else:
#     print('错误')
# # if嵌套
# if a17:
#     print(a17)
#     if a18:
#         print(a18)
#     else:
#         print('错误')
# else:
#     print('错误')

# # 9.循环语句
# # 1>.while循环
# # a、基本格式
# count = 0
# while (count < 9):
#     print(count)
#     count = count + 1
# # 条件为false的时候调用
# else:
#     print('end')
# # b、死循环
# # loopCount = 0
# # while loopCount == 0:
# #     print(count)
# # c、只有一行语句的时候可以写在一行
# while (count < 9): count = count + 1
# # 2>.for循环
# # range(5) -> 生成“0 ~ (n - 1)”的迭代器
# for num in list(range(5)):
#     # 0, 1, 2, 3, 4
#     print(num)
# # [1, 10)
# for num in range(1, 10):
#     # 1, 2, 3, 4, 5, 6, 7, 8, 9
#     print(num)
#     # # 跳出循环
#     # break
#     # # 跳出本次循环，开始下次循环
#     # continue
#     # # 空操作：执行时没有任何反应
#     # pass
# # for循环结束的时候调用
# else:
#     print('end')
# fruits = ['apple', 'banana', 'mango']
# # 遍历value
# for fruit in fruits:
#     print(fruit)
# # 遍历index
# # len(fruits) -> 列表的长度
# for index in range(len(fruits)):
#     print(fruits[index])
# # 3>.嵌套循环
# # for循环和while循环可以相互嵌套
# for fruit in fruits:
#     for index in range(len(fruits)):
#         print(fruits[index])
# # 4>.迭代器和生成器
# # 生成一个迭代器（一个可以记住遍历的位置的对象）
# # >>迭代器对象从集合的第一个元素开始访问，直到所有的元素被访问完结束...迭代器只能往前不会后退
# it = iter(list)
# # 输出迭代器的下一个元素
# print(next(it))
# # 遍历迭代器
# for index in it:
#     print(index)

# ### 接下来：12.Python3元组

















































# import sys

# print('hello world')

# age = input('请输入你的年龄：')
# age = input(age)
# if age > 18:
#     print('你太老...')
# else:
#     print('你还年轻...')

# def show(args):
#     if not isinstance(args, int):
#         print('args is not int')
#         return
#     print('show')
# show('123')

# for index in sys.argv:
#     print(index)
# print('python路径：', sys.path)

# # 元组中只包含一个元素时：需要在元素后面添加','
# tup = (1, 2, 3, 4, 5)
# tup[0] = 10 # 元组的值不能修改
# print(type(tup))

# # 4.Python基础
# # Python简介
# # 变量：定义变量、关键字、命名规则
# # 基本数据类型：类型转换
# # 运算符和表达式
# # 语句：选择语句、循环语句、跳转语句
# # 基本数据结构：字符串、列表、元组、集合、字典
# # 函数：函数定义、参数传递、作用域、lambda表达式、常用内置函数

# # 5.面向对象编程
# # 面向对象概述
# # 类和对象
# # 三大特性：封装、继承、多态
# # 设计思想
# # 设计原则

# # 6.py核心
# # 模块、包、异常处理
# # 迭代、生成器
# # Lambda表达式、高阶函数
# # 闭包、装饰器

# # 7.算法
# # 数据结构：链表操作
# # 二叉树
# # 查找排序算法

# # 8.Linux
# # Linux使用
# # 文件IO

# # 9.网络编程
# # 网络基础
# # TCP编程
# # UDP编程
# # 套接字属性
# # 广播、http协议
# # struct模块
# # HTTPServer 3.0

# # 10.多线程
# # 多任务编程、fork多进程
# # 网络聊天室、multiprocessing进程
# # 进程间通信、同步互斥、threading线程
# # IO模型、协程编程
# # 多进程并发、ftp文件服务器
# # 多进程并发、HTTPServer 2.0
# # 正则表达式、re模块

# # 11.数据库
# # 数据库基础、数据表设计、数据库数据表创建
# # 数据类型、高级查询、增删改查
# # git使用
# # 外键、索引、事务、关联关系
# # 子查询、数据库优化
# # PyMYSQL使用：持久化层的实现
# # Python工具使用
# # web与服务器
# # MVC和MTV模式
# # Django介绍
# # Django中的应用：应用的url路由配置、模板的设置、模板的加载方式、url()中的name参数
# # 模版中的语法、模型、ORM、创建和使用模型、配置数据库
# # 编写Models

# # 12.web技术
# # html基础
# # css基础
# # js基础

# # 11：Python3列表

# ### 面试题

# - ⭐ 牛客 Python 专项练习：https://www.nowcoder.com/intelligentTest
# - 牛客 Python 试题：https://www.nowcoder.com/search?query=python&type=question
# - 牛客机器学习面试题：https://www.nowcoder.com/search?type=question&query=%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0
# - 牛客机器学习笔试：https://www.nowcoder.com/search?type=paper&query=%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0
# - Python 面试题整理：https://github.com/taizilongxu/interview_python（高星）
# - Python 面试题整理：https://github.com/kenwoodjw/python_interview_question
# - 机器学习面试题：https://geektutu.com/post/qa-ml.html



# ### 其他

# - ⭐ Python 常见问题：https://docs.python.org/zh-cn/3/faq/general.html（官方提供的 ）
# - GitHub Python 趋势：https://github.com/trending/python
# - Python 模块推荐：https://pymotw.com/3/
# - Python 练习册：https://github.com/Yixiaohan/show-me-the-code（一些 Python 练习题目）

# 五、学习方法
# ---------------------------------------
# ### *知乎问答*：[零基础，应当如何开始学习 Python ？](http://www.zhihu.com/question/20039623?nr=1)--by@黎敏

# 虽然我不是Python高手，但我是零基础，之前会的都是软件PS，PPT之类。

# 如果目的是想成为程序员，参考教学大纲。

# 如果只是学程序，理解科技，解决工作问题，我的方式可以参考使用：

# 1. 找到合适的入门书籍，大致读一次，循环啊判断啊，常用类啊，搞懂（太难的跳过）

# 2. 做些简单习题，字符串比较，读取日期之类
#    《Python Cookbook》不错（太难太无趣的，再次跳过，保持兴趣是最重要的，不会的以后可以再学）

# 3. 加入Python讨论群，态度友好笑眯眯（很重要，这样高手才会耐心纠正你错误常识）。
#       很多小问题，纠结许久，对方一句话点播思路，真的节约你很多时间。耐心指教我的好人，超级超级多谢。

# 4. 解决自己电脑问题。
#       比如下载美剧，零散下载了2，4，5，8集，而美剧共12集，怎样找出漏下的那几集？然后问题分解，1读取全部下载文件名，2提取集的数字，3数字排序和（1--12）对比，找出漏下的。

# 5. 时刻记住目的，不是为了当程序员，是为了解决问题。

#   比如，想偷懒抓网页内容，用urllib不行，用request也不行，才发现抓取内容涉及那么多方面（cookie，header，SSL，url，javascript等等），当然可以听人家劝，回去好好读书，从头读。

#   或者，不求效率，只求解决，用ie打开网页再另存为行不行？ie已经渲染过全部结果了。

#   问题变成：1--打开指定的10个网页（一行代码就行）。更复杂的想保存呢？利用已经存在的包，比如PAM30（我的是Python3），直接打开ie，用函数outHTML另存为文本，再用搜索函数（str搜索也行，re正则也行） 找到数据。简单吧？而且代码超级短。

# 6. 保持兴趣，用最简单的方式解决问题，什么底层驱动，各种交换，留给大牛去写吧。我们利用已经有的包完成。

# 7. 耐心读文档，并且练习快速读文档。拿到新包，找到自己所需要的函数，是需要快速读一次的。这个不难，读函数名，大概能猜到是干嘛的，然后看看返回值，能判断是不是自己需要的。

# 8. 写帮助文件和学习笔记，并发布共享。教别人的时候，其实你已经自己再次思考一次了。

#   我觉得学程序就像学英文，把高频率的词（循环，判断，常用包，常用函数）搞懂，就能拼装成自己想要的软件。

#   然后，<http://stackoverflow.com> 和 <http://Google.com> 是很好用的。

#   然后，坚持下去。


#   一定要保持兴趣，太复杂的跳过，就像小学数学，小学英语，都是由简入深。

#   网络很平面，无数国际大牛著作好书，关于Python，算法，电脑，网络，或者程序员思路，或者商业思维（浪潮之巅是本好书）等等，还有国际名校的网络公开课（中英文字幕翻译完毕，观看不是难事），讲计算机，网络，安全，或者安卓系统，什么都有，只要能持续保持兴趣，一点点学习下去，不是难事。

#   所有天才程序员，都曾是儿童，回到儿童思维来理解和学习。觉得什么有趣，先学，不懂的，先放着，遇到问题再来学，效果更好。

#   唯一建议是，不要太贪心，耐心学好一门优雅的语言，再学其它。虽然Javascript做特效很炫，或提某问题时，有大牛建议，用Ruby来写更好之类，不要改方向。就像老笑话：“要学习递归，必须首先理解递归。”然后死循环一直下去。坚持学好一门语言，再研究其他。

#   即使一门语言，跟网络，数据库等等相关的部分，若都能学好，再学其他语言，是很快的事情。

#   另外就是，用学英文的耐心来学计算机，英文遇到不懂的词，抄下，查询。

#   python里，看到Http，查查定义，看到outHtml，查查定义，跟初学英语时候一样，不要直接猜意思，因为精确描述性定义，跟含糊自然语有区别的。而新人瞎猜，很容易错误理解，wiki，google很有用。


# ### *芝麻问答*：如何学习Python [点击打开链接](http://www.zhimaq.com/questions/70/python)作者：@halida
# #### 如何学习python

# 我们假设你是一个初级程序员, 只懂得一点点的基础知识, 希望能够用python来做开发. 这篇文档就是为了满足以上目标而写的.

# **大纲** 

# 按照这篇文档所指示的任务过一遍, 你就能够做到:

# 熟悉python语言, 以及学会python的编码方式. 熟悉python库, 遇到开发任务的时候知道如何去找对应的模块. 知道如何查找和获取第三方的python库, 以应付开发任务. 学习步骤

# **安装开发环境**

# 如果你在window下, 去下载pythonxy安装起来, 然后运行python, 进入python解释环境.

# 如果你在ubuntu下, 执行: sudo apt-get install python, 然后在命令行下运行python, 进入python解释环境.

# **学习方法**

# 作为一名成熟的开发人员, 我学习新东西(假设是pyqt)的习惯方式是:

# 直接用google搜索pyqt的官方网站. 按照官方网站的说明, 下载pyqt. (如果是用ubuntu, 看看软件库里面是否有足够新的版本) 下载过程中, 开始阅读官方网站上面的教程. 一边看教程, 一遍按照教程使用pyqt. 如果发现教程不够全面, 用google搜索是否有对应的教学书籍可以看. 示例学习完毕, 开发一个玩具程序, 用来检验自己是否需要用到的功能. 开始学习python

# 我建议你学习的过程也按照上面来, 首先过一遍python官方文档:

# <http://docs.python.org/tutorial/index.html>

# 然后做 <http://www.pythonchallenge.com/> 这个网站上面的题目.

# 如果卡在某一关太久, 可以看答案(google python challenge answer), 做完后看看别人的编码方式和自己有什么区别.

# **小项目**

# 做完一遍后, 你会发现已经熟悉了基本的python开发. 然后做点小项目吧. 这里是一些题目, 挑感兴趣的去做.

# * 写一个简单的计算器/记账软件/扫雷游戏(用pyqt库做界面)
# * 写一个聊天室网站(用webpy框架, jquery刷新新的回复)
# * 写一个爬虫, 获取douban上面所有用户的地点, 画地点分布的直方图(用lxml解析, 保存数据到sqlite里面去, 用matplotlib画图)

# **FAQ**

# Q: 遇到了问题, 到哪里求助?

# A: 上 <http://groups.google.com/group/python-cn> (需要翻墙) 或者 <http://stackoverflow.com> 提问就可以了.

# Q: 如何查找python的某个功能?

# A: 看官方文档. <http://docs.python.org/library/index.html>

# Q: 如何用python完成一个任务(比如写网站)?

# A: google: python 写网站, 或者 google: python web development.



# ### *知乎问答*：你是如何自学 Python 的？[点击打开链接](http://www.zhihu.com/question/20702054)  作者:@成增存

# **阶段一**：前辈领进门。
# 第一眼是一个前辈给我看了看Python的代码，因为自己最早学习的是Java语言，第一眼看到Python的时候，前辈说，“Python是面向对象的”，然后就 打印了几句代码。可我怎么也看不出到底哪里是“面向对象”的。前辈说“在Python里，一切皆对象”，我才有点领悟的说道：“原来把什么看成对象，就是面向对象”，哈哈。
 
# **阶段二**：开始看的是《Dive into Python》、《Leaning python》、《Python Doc》。
# 因为有很多语言学习经历，很快就完成了初步语法和使用学习。太复杂的特性还是在使用中逐步掌握的。
 
# **阶段三**：开始使用Python做自己的一些日常工作。
# 比如Python搜索文件，Python批量处理等，使用最多的还是re模块和socket相关模块。写了大量的例子，让自己对Python更加喜爱，也更加熟悉。此时翻阅最多的是《Python Doc》的指南。不管是语言参考、库参考、Demo参考，都有大量可使用的内容，内容质量很高堪比JDK。
 
# **阶段四**：生产上马。
# 开始使用Django，Flask，Tornado开发一些web应用，写一些日常使用的工具包等。逐步提升设计能力，和整体代码的管理能力。
 
# **阶段五**：更合理的分配好C，Java，Python三门语言各自擅长的部分。
# 把合适的语言用到合适的地方。尽管一门语言有时候可以搞定所有的，但用擅长的语言解决合适的问题才是效率最高的。这也是“Python的大道至简”的理念带给我的帮助和认识。
 
# PS：其中过程中主要的一些 **方法** :  

# 1. 看书。学习的基础。

# 2. 自己本地练习。编程还是要实践出真知。</br>  

# 3. 资料查询。google，stackoverflow等多关注。</br>  

# 4. 交流。各种论坛上的python group，论坛。最早去的CU，JavaEye，不过现在貌似去的少了。**google group** 必须订阅。</br>  

#    学习+实践+总结，掌握语言的法宝。

# 好吧，最好一篇文章《我在学习编程中犯的两个 **最大错误** 》[点击打开链接](http://blog.jobbole.com/26552/)


# 七、更新
# --------------------------------------
#  [Python技术博客、招聘、开源软件、Python中文网站导航](http://simple-is-better.com/sites/)

#  [遇到python问题怎么样解决？python help dir stackoverflow docs google](http://blog.csdn.net/xiaowanggedege/article/details/8753013)

# [Python应用与实践](http://www.cnblogs.com/skynet/archive/2013/05/06/3063245.html) Python是什么？谁在用它？相关工具？作者：@吴秦

# [Python模块学习](http://blog.csdn.net/JGood/article/category/554799/4) 相当于翻译官网文档

# [PyCoder’s Weekly 中文翻译](http://pycoders-weekly-chinese.readthedocs.org/en/latest/index.html) 说明：文章质量很高

# [PEP 20 (Python之禅) 的实例](http://artifex.org/~hblanks/talks/2011/pep20_by_example.html)  说明：code_stype

# [Unicode之痛](http://pycoders-weekly-chinese.readthedocs.org/en/latest/issue5/unipain.html) 必读

# [stackoverflow上Python相关回答整理翻译](https://github.com/wklken/stackoverflow-py-top-qa)

# [Python语言总结-初级中级高级教程](http://www.crifan.com/files/doc/docbook/python_summary/release/html/python_summary.html) 作者：@Crifan Li

# [Python Guide Python 最佳实践（英文）](http://docs.python-guide.org/en/latest/?utm_campaign=Manong_Weekly_Issue_10&utm_medium=EDM&utm_source=Manong_Weekly) 

# [Python 最佳实践指南（中文）](https://github.com/Prodesire/Python-Guide-CN) 关于Python安装、配置、和日常使用的最佳实践手册。

# [Python - 100天从新手到大师](https://github.com/jackfrued/Python-100-Days) 100天从新手到大师

# [Python 和 Diango 学习资料，书籍，文章，以及实战项目](https://github.com/zaxlct/python-django-learning)

# [What the f*ck Python!](https://github.com/satwikkansal/wtfpython)

# [https://github.com/leisurelicht/wtfpython-cn](wtfpython的中文翻译)

# 八、爬虫以及模拟登陆新浪微博

# [知乎：Python 爬虫如何入门学习](http://www.zhihu.com/question/20899988)

# [Python爬虫学习系列教程 @崔庆才](http://cuiqingcai.com/1052.html)系列教程，入门、实战、爬虫利器介绍、进阶

# [Python模拟登录新浪微薄（使用RSA加密方式和Cookies文件）](http://yoyzhou.github.io/blog/2013/03/18/sina-weibo-login-simulator-in-python/)

# [一个简单的分布式新浪微博爬虫](http://qinxuye.me/article/a-distributed-weibo-crawler)

# [网络爬虫系列](http://blog.csdn.net/pleasecallmewhy/article/details/8922826)



# ## 常用类库

# Python 能被广泛应用，很大程度上是因为其丰富的类库，就是他人提前写好并封装的代码。基本你要做什么东西都能找到对应的类库，直接看文档用就行了，大大提高开发效率！

# 开源项目 `awesome-python-cn`（地址：https://github.com/jobbole/awesome-python-cn） 和 `awesome-python`（地址：https://github.com/vinta/awesome-python）已经帮大家整理了各方向的 Python 类库，数量非常多。鱼皮在此基础上筛选了一些相对优质的库，分享给大家。


# #### 日期处理

# - delorean：日期处理库
# - pendulum：日期时间操作库
# - dateutil：对标准 datetime 模块的强大扩展



# #### 终端优化

# - IPython：功能丰富的交互式 Python 解析器
# - Jupyter Notebook：基于网页的用于交互计算的应用程序
# - Prettytable：生成美观的 ASCII 格式的表格
# - Colorama：让终端具有颜色
# - bashplotlib：在终端中进行基本绘图
# - emoji：支持在 Python 终端输出表情
# - Ipyvolume：在 Jupyter notebook 中可视化 3d 体积和字形



# #### 文本处理

# - FlashText：高效的文本查找替换库
# - furl：url 处理库
# - pypinyin：汉字拼音转换工具
# - simplejson：JSON 编 / 解码器
# - JMESPath：JSON 查询语法库



# #### 其他

# - Pipenv：Python 官方推荐的新一代包管理工具
# - threading：自带的线程库
# - multiprocessing：自带的多线程库
# - Chardet：字符编码检测器

# - logging：日志功能
# - PySnooper：Python 调试工具
# - sphinx：Python 文档生成器
# - pyttsx3：文字转语音库
# - PyWin32：提供和 windows 的交互
# - shortuuid：生成唯一 uuid 的库
# - more-itertools：支持迭代操作对象
# - cryptography：密码学工具包



# ### 网络请求 & 解析

# - requests：HTTP 请求库
# - aiohttp：异步 HTTP 网络库
# - scrapy：分布式网页采集框架
# - pyspider：一个强大的爬虫系统
# - BeautifulSoup：从 HTML 或 XML 文件中提取数据的库
# - you-get：网页视频下载器
# - wget：网页文件下载
# - musicdl：Python 音乐下载器



# ### 文件处理

# - openpyxl：Excel 读写库
# - tablib：处理表格数据
# - csvkit：用于转换和操作 CSV 的工具
# - XlsxWriter：操作 Excel
# - python-docx：操作 office word 文档
# - PyPDF2：操作 PDF 文档
# - pdfminer：从 PDF 文档中抽取信息的工具
# - xhtml2pdf：HTML 转 PDF 工具
# - WeasyPrint：可视化网页，并支持导出为 PDF
# - html2text：将 HTML 转换为 Markdown 文档
# - xmltodict：像处理 JSON 一样处理 XML
# - moviepy：基于脚本的视频编辑模块
# - eyeD3：操作音频文件的工具
# - pyAudioAnalysis：音频特征提取分析



# ### 界面开发

# - pyQT：跨平台的用户界面开发框架
# - Turtle：交互式绘画库
# - pyglet：跨平台界面及多媒体框架
# - wxPython：Python 用户界面开发工具
# - Pygame：一组用来开发游戏的 Python 模块
# - Manim：Python 数学动画引擎
# - progressbar：一个滚动条函数库
# - progress：进度条输出
# - tqdm：快速、可扩展的进度条

# 数据结构与算法：py

# ### 测试

# - nose：测试框架
# - faker：生成假数据
# - PyAutoGUI：跨平台 GUI 自动测试模块
# - coverage：代码覆盖率测量
# - sqlmap：自动 SQL 注入和渗透测试工具



# ### Web 开发

# - Django：Python 界最流行的 web 框架
# - Django REST framework：用于开发 web api 的框架
# - FastAPI：快速构建 web 应用程序
# - flask：Python 微型框架
# - Twisted：一个事件驱动的网络引擎



# ### 运维

# - psutil：跨平台的进程和系统工具模块
# - supervisor：进程控制管理系统
# - sh：让 Python 支持 shell 脚本
# - dnspython：DNS 工具包
# - scapy：数据包处理库
# - pexpect：在伪终端中控制交互程序
# - paramiko：远程连接服务
# - Ansible：IT 自动化平台
# - SaltStack：基础设施自动化和管理系统
# - watchdog：管理文件系统事件的 API 和 shell 工具



# ### 图像处理 & 计算机视觉

# - Pillow：图像处理库
# - kornia：计算机视觉库
# - Opencv：开源计算机视觉库
# - Mahotas：计算机视觉和图像处理库
# - Luminoth：计算机视觉的深度学习工具集



# ### 数据分析 & 数据科学

# - NumPy：数值计算工具包
# - Pandas：主流的数据分析工具
# - pyecharts：基于百度 Echarts 的数据可视化库
# - Dash：快速构建 Web 数据可视化应用
# - matplotlib：Python 2D 绘图库
# - Seaborn：使用 Matplotlib 进行统计数据可视化
# - python-recsys：实现推荐系统的库
# - vaex：高速大数据处理库
# - SciPy：算法和数学工具库
# - blaze：NumPy 和 Pandas 的大数据接口
# - statsmodels：统计建模和计量经济学



# ### 人工智能

# - Tensorflow：谷歌开源的最受欢迎的深度学习框架
# - keras：深度学习封装库，快速上手神经网络
# - Pytorch：具有张量和动态神经网络，并有强大 GPU 加速能力的深度学习框架
# - Caffe2：一个轻量、模块化、可扩展的深度学习框架
# - scikit-learn：基于 SciPy 构建的机器学习 Python 模块
# - PyMC：马尔科夫链蒙特卡洛采样工具
# - mmdetection：深度学习目标检测工具箱
# - imbalanced-learn：不平衡学习工具包
# - XGBoost：分布式梯度增强库
# - Gym：强化学习算法的工具包



# ### 自然语言处理

# - NLTK：自然语言处理工具包
# - Gensim：话题建模库
# - Pattern：自然语言处理工具
# - fuzzywuzzy：用于字符串模糊匹配、令牌匹配等
# - TextBlob：为进行普通自然语言处理任务提供一致的 API
# - PyFlux：时间序列处理库
# - jieba：中文分词工具