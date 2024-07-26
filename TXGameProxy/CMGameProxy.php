<?php
    // php是弱类型语言

    // XAMPP for mac组件环境搭建：配置自己的电脑成为服务器

    // 告诉浏览器按照哪种文本编码解析：防止出现中文无法显示
    // 内置函数
    header('content-type=html/text;charset=utf-8'); // 必须以;结尾

    // 单行注释
    /* 多行注释 */

    // 定义变量：必须以$开头、严格区分大小写
    $num = 1; // 整数
    echo gettype($num);
    $s = '123'; // 字符串
    $pi = 3.14; // 小数
    $isOk = true; // 布尔类型
    // 如果字符串中的内容和变量名一致：双引号会认为这个一个变量的值、单引号会认为这是一个字符串
    echo "$num"; // 1：如果是双引号可以直接echo $num;
    echo '$num'; // $num：推荐使用单引号
    // 为了区分：单引号和双引号可以混合使用（也可以直接使用转义字符）
    echo '<input type="button">';
    echo '<input type=\'button\'>';

    // 输出
    echo 'hello world';
    echo '<br>'; // 可以输出标签
    echo $num;
    echo '<input type="button" value="点我试试">';
    // 输出变量的详细内容
    print_r($num);

    // 运算符
    // 算数运算符：+, -, *, /, %
    $a = 10;
    $b = 6;
    echo ($a + $b); // 16
    echo ($a - $b); // 4
    echo ($a * $b); // 60
    echo ($a / $b); // 1.6666666667
    echo ($a % $b); // 4
    // 赋值运算符：+=, *=...

    // 条件语句
    // 1>.if语句
    if ($num == 1) {
        echo '男';
    } else {
        echo '女';
    }
    // 2>.switch语句
    switch ($s) {
    case '123':
        echo '男';
    break;
    case '456':
        echo '女';
    break; 
    default:
        echo '未知';
    break;
    }

    // 循环语句
    // 1>.while循环
    while ($num <= 10) {
        // $num = $num + 1;
        $num++;
        if ($num == 5) {
            continue;
            break;
        }
    }
    // 2>.for循环
    for ($i=0; $i < 10; $i++) {
        // 拼接字符串使用.
        echo '感觉自己萌萌哒'.$i;
    }

    // 数组
    // 1>.普通数组
    // 可以放数字、字符串、布尔类型
    $foods = array('西红柿炒鸡蛋', '西红柿炒番茄', '韭菜炒鸡蛋');
    echo $foods[0];
    $foods[0] = '白菜豆腐汤'; // 替换元素
    $foods[] = '白菜汤'; // 添加元素
    unset($foods[2]); // 删除元素
    foreach ($food as $foods) {
        // 数组遍历
        echo $food;
    }
    // 2>.关系型数组
    $persons = array(
        // 一般语言的':'使用'=>'表示
        'name' => '小李子',
        'age' => 35,
        'skill' => '发福'
    );
    echo $person['name'];
    foreach ($person as $persons) {
        // 数组遍历
    }
    // 3>.二维数组
    $mPersons = array(
        array('西红柿炒鸡蛋1', '西红柿炒番茄1', '韭菜炒鸡蛋1'),
        array('西红柿炒鸡蛋2', '西红柿炒番茄2', '韭菜炒鸡蛋2'),
        array('西红柿炒鸡蛋3', '西红柿炒番茄3', '韭菜炒鸡蛋3')
    );
    echo $mPersons[0][2];
    $p1 = $mPersons[1];
    
    // 函数
    // 1>.概念：可以重复使用的代码块
    // 2>.特点：页面加载的时候不会执行，只有在被调用的时候才会执行
    // 3>.无参无返回值
    function test1() {
        echo 'hello world';
    }
    test1();
    // 3>.有参无返回值
    function test2($name) {

    }
    test2('xwj');
    // 3>.有参无返回值：参数有默认值
    function test3($name = 'xwj') {

    }
    test3(); // 如果不传入参数：直接使用默认值
    test3('cfj'); // 如果传入参数：使用传入的参数
    // 3>.有参有返回值
    function test4($name, $age) {
        return $name.'is'.$age.'岁';
    }
    test4('xwj', 18);

    // class
    class Fox {
        // 公共属性
        public $name = 'itcast';
        // 私有属性
        var $age = 18;
        
        // 构造函数
        function Fox($name) {
            $this->name = $name;
        }
    }
    $fox = new Fox();
    // 一般语言的'.'使用'->'表示
    $fox->name = 'cfj';
    echo($fox->name);
    
    // 预定义
    // 1>.超全局变量$_GET
    // 获取数据：$_GET['key']
    if (array_key_exists('userName', $_GET)) {
        echo $_GET['userName'];
    }
    if (array_key_exists('userSkill', $_GET)) {
        echo $_GET['userSkill'];
    }
    // 2>.超全局变量$_POST
    // 获取数据：$_POST['key']
    if (array_key_exists('userName', $_POST)) {
        echo $_GET['userName'];
    }
    if (array_key_exists('userSkill', $_POST)) {
        echo $_GET['userSkill'];
    }
    // 3>.超全局变量$_FILES
    print_r($_FILES);
    $upFiles = $_FILES['upLoad']; // 获取文件的相关信息：返回关系型数组
    $fileName =  $upFiles['name']; // 获取上传的文件的原本名字
    $filePath =  $upFiles['tmp_name']; // 获取保存在服务器的哪个位置
    // 参数1：xxx
    // 参数2：newPath（相对路径）
    move_uploaded_file($filePath, 'files/'.$fileName); // 保存文件

    // 操作数据库
    // 1>.连接数据库
    $link = mysqli_connect('', '', '');
    if ($link) {
        echo('数据库连接成功');
    }
    mysqli_close($link);
    // 2>.查询表
    // "$result != 0"代表成功
    $result = mysqli_query($link, 'select * from person');
    mysqli_free_result($result);
    // 返回结果行数
    mysqli_num_rows($result);
    // 返回操作影响行数
    mysqli_affected_rows($link);
    // 返回查询结果的一条数据
    $row = mysqli_fetch_array($result);
    // 返回字段个数
    $count = mysqli_num_fields($result);
    // 返回第$index个字段名
    echo mysqli_field_seek($result, $index);
?>