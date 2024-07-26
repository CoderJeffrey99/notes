
-- 1.sql概述
-- 1>.什么是sql：sql是用于操作数据库（存储、操作、检索存储在关系型数据库中的数据）的结构化查询语言（关系型数据库系统的标准语言、有许多不同版本的sql语言）
-- 2>.诞生：1970年-IBM描述了数据库的关系模型、1986年-IBM开发了第一个关系型数据库原型（第一个关系型数据库后来被命名为oracle）
-- 3>.注意：sql只是一种查询语言（不是数据库...sql语句必须以;结尾），执行sql语句必须安装任意数据库oracle mysql MongoDB SQL_Server

-- 2.关系数据库管理系统RDMS
-- 1>.什么是数据库：数据库是有组织的数据集合
-- 2>.数据库的目的：通过存储、检索、管理来操作大量数据信息
-- 3>.什么是表：表是关系型数据库中最常见、最简单的数据存储形式（有行（记录）有列（字段））
/*
>.NULL表示值为空（没有任何值）
>.创建表的时候不确定存储什么可以先存储NULL表示...与0还有''有区别
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Matthew    | Han       | 8000   |
| Alexander  | Lee       | 9000   |
| Daniel     | Chen      | NULL   |
+------------+-----------+--------+
*/
-- 4>.关系数据库管理系统RDMS有哪些：MySQL Oracle MS_Access
/*
Mysql 开源关系型数据库 支持windows Linux unix macOS 商用付费 非商用免费
Oracle 一个非常大的基于多用户的关系型数据库管理系统
MS_Access 入门级数据库
*/

-- 3.数据类型
-- 1>.前提；在数据库中，表的每一列都有特定的数据类型
-- 2>.数字类型
-- bigint int smallint tinyint bit decimal numeric money smallmoney float real
-- 3>.日期和时间
-- datetime smalldatetime date存储日期（比如1997-5-21） time存储时间（比如下午12:30）
-- 4>.字符串
-- char非Unicode字符固定长度 varchar非Unicode数据可变长度 text非Unicode数据可变长度
-- ncharUnicode字符固定长度 nvarcharUnicode数据可变长度 ntextUnicode数据可变长度
-- 5>.二进制
-- binary固定长度的二进制数据 varbinary可变长度二进制数据 image可变长度二进制数据
-- 6>.其它数据类型
-- timestamp存储数据库范围的唯一编号（每次更新行时都会更新） uniqueidentifier存储全局唯一标识符 cursor引用游标对象 table存储结果集（供以后处理）

-- 4.运算符：一般用于sql的where子句，用于指定sql语句中的条件
-- 1>.算术运算符：+ - * / %
-- 2>.比较运算符：= != <>不相等 > < >= <= !< !>
-- 比较运算符的结果只能是三个值：true/false/unknown其中一个
/*
a>.=等于
SELECT 
    employee_id, first_name, last_name
FROM
    employees
WHERE
    last_name = 'Lee';
+-------------+------------+-----------+
| employee_id | first_name | last_name |
+-------------+------------+-----------+
|         100 | Steven     | Lee       |
|         103 | Alexander  | Lee       |
+-------------+------------+-----------+
b>.IS NULL
SELECT 
    employee_id, first_name, last_name, phone_number
FROM
    employees
WHERE
    phone_number = NULL;
以上语句始终返回空结果集，因为phone_number = NULL始终返回false...=不能用于比较NULL
SELECT 
    employee_id, first_name, last_name, phone_number
FROM
    employees
WHERE
    phone_number IS NULL;
+-------------+------------+-----------+--------------+
| employee_id | first_name | last_name | phone_number |
+-------------+------------+-----------+--------------+
|         145 | John       | Liu       | NULL         |
|         146 | Karen      | Liu       | NULL         |
|         176 | Jonathon   | Yang      | NULL         |
|         177 | Jack       | Yang      | NULL         |
|         178 | Kimberely  | Yang      | NULL         |
|         179 | Charles    | Yang      | NULL         |
+-------------+------------+-----------+--------------+
c>.<>不相等
SELECT 
    employee_id, first_name, last_name, department_id
FROM
    employees
WHERE
    department_id <> 8
ORDER BY first_name, last_name;
+-------------+------------+-----------+---------------+
| employee_id | first_name | last_name | department_id |
+-------------+------------+-----------+---------------+
|         103 | Alexander  | Lee       |             6 |
|         115 | Alexander  | Su        |             3 |
|         114 | Avg        | Su        |             3 |
|         193 | Britney    | Zhao      |             5 |
|         104 | Bruce      | Wong      |             6 |
|         109 | Daniel     | Chen      |            10 |
... ...
|         100 | Steven     | Lee       |             9 |
|         203 | Susan      | Zhou      |             4 |
|         106 | Valli      | Chen      |             6 |
|         206 | William    | Wu        |            11 |
+-------------+------------+-----------+---------------+
d>.AND运算符
SELECT 
    employee_id, first_name, last_name, department_id
FROM
    employees
WHERE
    department_id <> 8
        AND department_id <> 10
ORDER BY first_name, last_name;
+-------------+------------+-----------+---------------+
| employee_id | first_name | last_name | department_id |
+-------------+------------+-----------+---------------+
|         103 | Alexander  | Lee       |             6 |
|         115 | Alexander  | Su        |             3 |
|         114 | Avg        | Su        |             3 |
|         193 | Britney    | Zhao      |             5 |
|         104 | Bruce      | Wong      |             6 |
|         105 | David      | Liang     |             6 |
|         107 | Diana      | Chen      |             6 |
|         118 | Guy        | Zhang     |             3 |
... ...
|         117 | Sigal      | Zhang     |             3 |
|         100 | Steven     | Lee       |             9 |
|         203 | Susan      | Zhou      |             4 |
|         106 | Valli      | Chen      |             6 |
|         206 | William    | Wu        |            11 |
+-------------+------------+-----------+---------------+
e>.>大于：可以与AND/OR一起使用
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary > 12000 AND department_id = 8
ORDER BY salary DESC;
+-------------+------------+-----------+--------+
| employee_id | first_name | last_name | salary |
+-------------+------------+-----------+--------+
|         145 | John       | Liu       | 14000  |
|         146 | Karen      | Liu       | 13500  |
+-------------+------------+-----------+--------+
*/
-- 3>.逻辑运算符
/*
a>.AND运算符 - 允许在sql句的where子句中指定多个条件，如果两个表达式的计算结果为true，则AND运算符返回true...支持短路运算
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary > 5000 AND salary < 7000
ORDER BY salary;
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Bruce      | Wong      | 6000   |
| Pat        | Zhou      | 6000   |
| Charles    | Yang      | 6200   |
| Shanta     | Liu       | 6500   |
| Susan      | Zhou      | 6500   |
| Min        | Su        | 6900   |
+------------+-----------+--------+
b>.OR运算符 - 用于组合sql语句的where子句中的多个条件，如果任一表达式为true，则返回true...支持短路运算
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary = 8000 OR salary = 9000
ORDER BY salary;
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Matthew    | Han       | 8000   |
| Alexander  | Lee       | 9000   |
| Daniel     | Chen      | 9000   |
+------------+-----------+--------+
c>.IS NULL运算符 - 将列的值与null值进行比较，如果比较的值为null，则返回true，否则，它返回false
SELECT 
    first_name, last_name, phone_number
FROM
    employees
WHERE
    phone_number IS NULL
ORDER BY first_name , last_name;
+------------+-----------+--------------+
| first_name | last_name | phone_number |
+------------+-----------+--------------+
| Charles    | Yang      | NULL         |
| Jack       | Liu       | NULL         |
| John       | Yang      | NULL         |
| Jonathon   | Yang      | NULL         |
| Karen      | Liu       | NULL         |
| Kimberely  | Yang      | NULL         |
+------------+-----------+--------------+
d>.BETWEEN运算符 - 用于搜索在给定最小值和最大值内的值，如果操作数在一个指定范围内，则返回true
salary >= 8000 && salary <= 10000
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary BETWEEN 8000 AND 10000
ORDER BY salary;
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Matthew    | Han       | 8000   |
| John       | Chen      | 8200   |
| Max        | Han       | 8200   |
| William    | Wu        | 8300   |
| Jack       | Yang      | 8400   |
| Jonathon   | Yang      | 8600   |
| Alexander  | Lee       | 9000   |
| Daniel     | Chen      | 9000   |
| Hermann    | Wu        | 10000  |
+------------+-----------+--------+
e>.IN运算符 - 用于将值与已指定的文字值列表进行比较，如果操作数等于列表中的值之一，则返回true
SELECT 
    first_name, last_name, department_id
FROM
    employees
WHERE
    department_id IN (1, 9)
ORDER BY department_id;
+------------+-----------+---------------+
| first_name | last_name | department_id |
+------------+-----------+---------------+
| Jennifer   | Zhao      |             1 |
| Steven     | Lee       |             9 |
| Neena      | Wong      |             9 |
| Lex        | Liang     |             9 |
+------------+-----------+---------------+
f>.LIKE运算符 - 使用通配符运算符将值与类似值进行比较、sql提供了两个与LIKE运算符一起使用的通配符
>>.百分号(%)表示零个，一个或多个字符
SELECT 
    employee_id, first_name, last_name
FROM
    employees
WHERE
    first_name LIKE 'Ma%'
ORDER BY first_name;
+-------------+------------+-----------+
| employee_id | first_name | last_name |
+-------------+------------+-----------+
|         120 | Matthew    | Han       |
|         112 | Max        | Su        |
|         121 | Max        | Han       |
+-------------+------------+-----------+
>>.下划线符号(_)表示单个字符
SELECT 
    employee_id, first_name, last_name
FROM
    employees
WHERE
    first_name LIKE '_i%'
ORDER BY first_name;
+-------------+------------+-----------+
| employee_id | first_name | last_name |
+-------------+------------+-----------+
|         107 | Diana      | Chen      |
|         178 | Kimberely  | Yang      |
|         201 | Michael    | Zhou      |
|         113 | Min        | Su        |
|         122 | Min        | Liu       |
|         117 | Sigal      | Zhang     |
|         206 | William    | Wu        |
+-------------+------------+-----------+
g>.ALL运算符 - 用于将值与另一个值集中的所有值进行比较，如果所有比较都为true，则返回true
>>.查找salary大于department_id = 8的这个员工的薪水的其他员工
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary >= ALL (SELECT 
            salary
        FROM
            employees
        WHERE
            department_id = 8)
ORDER BY salary DESC;
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Steven     | Lee       | 24000  |
| Neena      | Wong      | 17000  |
| Lex        | Liang     | 17000  |
| John       | Liu       | 14000  |
+------------+-----------+--------+
-- h>.ANY运算符 - 用于根据条件将值与列表中的任何适用值进行比较，如果任何一个比较为true，则返回true
-- SOME是ANY的别名，使用的时候可以互换
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary > ANY(SELECT 
            AVG(salary)
        FROM
            employees
        GROUP BY department_id)
ORDER BY first_name , last_name;
+------------+-----------+--------+
| first_name | last_name | salary |
+------------+-----------+--------+
| Alexander  | Lee       | 9000   |
| Avg        | Su        | 11000  |
| Bruce      | Wong      | 6000   |
| Charles    | Yang      | 6200   |
| Daniel     | Chen      | 9000   |
... ...
| Shelley    | Wu        | 12000  |
| Steven     | Lee       | 24000  |
| Susan      | Zhou      | 6500   |
| Valli      | Chen      | 4800   |
| William    | Wu        | 8300   |
+------------+-----------+--------+
i>.EXISTS运算符 - 用于搜索指定表中是否存在满足特定条件的行，如果子查询有结果集，则返回true
SELECT 
    first_name, last_name
FROM
    employees e
WHERE
    EXISTS (SELECT 
            1
        FROM
            dependents d
        WHERE
            d.employee_id = e.employee_id);
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| Steven     | Lee       |
| Neena      | Wong      |
| Lex        | Liang     |
| Alexander  | Lee       |
| Bruce      | Wong      |
| David      | Liang     |
| Valli      | Chen      |
| Diana      | Chen      |
... ...
| Shelley    | Wu        |
| William    | Wu        |
+------------+-----------+
j>.NOT运算符 - 反转使用它的逻辑运算符的含义（NOT EXISTS、NOT BETWEEN、NOT IN）
salary < 8000 && salary > 10000
SELECT 
    first_name, last_name, salary
FROM
    employees
WHERE
    salary NOT BETWEEN 8000 AND 10000
ORDER BY salary;
k>.UNIQUE运算符 - 搜索指定表的每一行的唯一性（无重复项）
*/

/*
5>.创建数据库：数据库名称必须唯一/必须有管理员权限
create database database_name;
查看所有数据库：是否删除成功
show databases;
删除数据库
drop database database_name;
重命名数据库
rename database old_db_name to new_db_name;
如果sql模式中有多个数据库，那么在开始操作数据库以前必须先选择一个数据库
use database_name;
*/

-- 6>.表
-- 1>.概念：表是关系型数据库中最常见、最简单的数据存储形式（有行（记录）有列（字段））
-- 2>.特点：一种数据库对象，数据存储在表中
-- create 创建新表、创建表视图、创建其他对象
-- 创建表：必须有表名和字段
-- 表名在数据库中必须唯一：不然会发生错误
-- 一个表中有且仅有一个primary key
create table employees(
    -- 字段名1 数据类型 默认值 多个列约束条件
    -- primary key约束只能有一个，不允许是NULL
    employee_id int NOT NULL primary key,
    -- 字段名2
    name varchar(20) unique
)
-- 创建课程表
create table courses(
    course_id INT NOT NULL auto_increment primary key,
    course_name varchar(50) NOT NULL
)
-- 创建训练数据表
create table trainings(
    employee_id INT,
    course_id INT,
    taken_date DATE,
    -- 如果primary key是多个列组成就必须这样写
    primary key(employee_id, course_id)
)
-- select 从表中检索某些记录
-- select * from table_name
select * from employees; -- 查询所有数据
-- select 字段名1, 字段名2 from table_name;
select employee_id, name from employees;
-- select 字段名1, 字段名2 from table_name where [布尔表达式|];
-- 如果有where语句，where语句必须在order by语句之前
-- order by后面有多个字段则先排序第一个字段，再排序第二个字段
-- ASC升序（默认）/DESC降序
select employee_id, name from employees where employee_id = 208 order by employee_id desc;
-- insert 创建并插入一条记录
-- 插入值的数量必须和列数相同，必须一一对应（因为数据库系统会根据他们在数据表中的相对位置来匹配他们）
-- 插入新行的时候数据库系统会检查所有完整性约束（如果违法一个约束数据库系统就会发出错误信息并终止语句：不向表中插入新行）
-- 所有列insert into table_name values (value1, value2)
insert into employees values (208, 'xwj');
-- 指定列insert into table_name(字段名1, 字段名2) values (value1, value2)
insert into employees(
    employee_id, 
    name
) values (
    208, 
    'xwj'
); -- 如果插入成功数据库系统就会返回受影响的行数
select * from employees where name = "xwj"; -- 通过select语句可以检查是否插入成功
-- 插入多行数据
insert into employees (
    name,
    age
) values (
    "xwj",
    18
), (
    "xwj1",
    19
), (
    "xwj2",
    20
)
-- update 更新表中记录
-- update table_name set 字段名1 = value1, 字段名2 = value2 where 条件1 and/or 条件2
update employees set name = 'cfj' where employee_id = 208
/*
-- drop 删除整个表
-- drop table table_name1, table_name2
-- 如果表不存在会报错
drop table employees;
*/
-- drop table if exist table_name
-- 如果表不存在不会报错
drop table employees if exist employees;
/*
-- delete 删除表中记录（外键表中的行也会被删除）
delete from table_name where 条件 in ()
delete from table_name where 条件 between ... and ...
delete from table_name where 条件 like{}
delete from table_name where 条件 order by 字段名1 {asc|desc}
delete from table_name where 条件 group by 字段名1
*/
delete from employees where name like '_wj';
/*
-- 删除重复数据项:按照指定的字段先排序，在查看相邻是否相同，删除后一个（排序，检索有点费时）
-- 主键可以保证数据表中没有重复的行：但是通过查询可能会出现重复的数据
select distinct 字段1, 字段2 from table_name // 一列按照一列算，多列按照多列组合算
select employee_id, first_name, last_name
-- 只返回5行（跳过前3行）
from employees order by first_name limit 5 offset 3;
-- 还有一种写法
select employee_id, first_name, last_name from employees
offset 5 rows fetch next 4 rows only;
*/
-- alter 修改现有数据库对象（例如：表）
-- alter table table_name1
alter table employees
-- grant 为用户提供权限
-- revoke 撤销用户授予的权限
/*
-- 从另一个表中复制行（记录）
INSERT INTO table_name1(column1, column2) 
SELECT
    column1,
    column2
FROM
    table_name2
WHERE
    condition1;
*/

/*
// 聚合函数：对一组数据进行操作
AVG() 返回集合平均值 --- 忽略null
COUNT() 返回集合中的项目数 --- 不忽略null
MIN()  返回集合中最大值 --- 忽略null
MAX()  返回集合中最小值 --- 忽略null
SUM(all(默认) | distinct)  集合中所有值ALL/不用值distinct的总和 --- 忽略null

select AVG(salary) from employees

group by
要指定分组的条件，请使用HAVING子句
HAVING子句通常与SELECT语句中的GROUP BY子句一起使用。 如果使用带GROUP BY子句的HAVING子句，HAVING子句的行为类似于WHERE子句
SELECT
    column1,
    column2,
    AGGREGATE_FUNCTION (column3)
FROM
    table1
GROUP BY
    column1,
    column2
HAVING
    group_condition;
请注意，HAVING子句紧跟在GROUP BY子句之后出现

HAVING与WHERE
在通过GROUP BY子句将行汇总到分组之前，WHERE子句将条件应用于各个行。 但是，HAVING子句在将行分组到组之后将条件应用于组
在GROUP BY子句之前应用WHERE子句之后应用HAVING子句

-- 获取经理及其下属员工数量，请使用GROUP BY子句按管理员对员工进行分组，并使用COUNT函数计算下属员工数量
SELECT 
    manager_id,
    first_name,
    last_name,
    COUNT(employee_id) direct_reports
FROM
    employees
WHERE
    manager_id IS NOT NULL
GROUP BY manager_id;

-- 要查找至少包含五个下属员工的经理，请在上面的查询中添加HAVING子句
SELECT 
    manager_id,
    first_name,
    last_name,
    COUNT(employee_id) direct_reports
FROM
    employees
WHERE
    manager_id IS NOT NULL
GROUP BY manager_id
HAVING direct_reports >= 5;
+------------+------------+-----------+----------------+
| manager_id | first_name | last_name | direct_reports |
+------------+------------+-----------+----------------+
|        100 | Neena      | Wong      |             14 |
|        101 | Nancy      | Chen      |              5 |
|        108 | Daniel     | Chen      |              5 |
|        114 | Alexander  | Su        |              5 |
+------------+------------+-----------+----------------+

-- 计算公司为每个部门支付的工资总和，并仅选择工资总和在20000和30000之间的部门
SELECT 
    department_id, SUM(salary)
FROM
    employees
GROUP BY department_id
HAVING SUM(salary) BETWEEN 20000 AND 30000
ORDER BY SUM(salary);
+---------------+-------------+
| department_id | SUM(salary) |
+---------------+-------------+
|            11 | 20300.00    |
|             3 | 24900.00    |
|             6 | 28800.00    |
+---------------+-------------+

-- 查找具有最低工资大于10000的员工的部门
SELECT
    e.department_id,
    department_name,
    MIN(salary)
FROM
    employees e
INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY
    e.department_id
HAVING
    MIN(salary) >= 10000
ORDER BY
    MIN(salary);
+---------------+-----------------+-------------+
| department_id | department_name | MIN(salary) |
+---------------+-----------------+-------------+
|             7 | 公共关系        | 10000       |
|             9 | 行政人员        | 17000       |
+---------------+-----------------+-------------+
首先，使用GROUP BY子句按部门对员工进行分组
其次，使用MIN函数查找每个分组最低工资
第三，将条件应用于HAVING子句


-- 查找员工平均薪水在5000到7000之间的部门，请使用AVG函数如下查询语句：
SELECT
    e.department_id,
    department_name,
    ROUND(AVG(salary), 2)
FROM
    employees e
INNER JOIN departments d ON d.department_id = e.department_id
GROUP BY
    e.department_id
HAVING
    AVG(salary) BETWEEN 5000
AND 7000
ORDER BY
    AVG(salary);
+---------------+-----------------+-----------------------+
| department_id | department_name | ROUND(AVG(salary), 2) |
+---------------+-----------------+-----------------------+
|             6 | IT              | 5760                  |
|             5 | 运输             | 5885.71               |
|             4 | 人力资源         | 6500                  |
+---------------+-----------------+-----------------------+
*/

/*
-- 子查询：放在括号内的查询称为子查询，也称为内部查询或内部选择，包含子查询的查询称为外部查询或外部选择
-- 先执行子查询，再执行外部查询
SELECT 
    employee_id, first_name, last_name
FROM
    employees
WHERE
    department_id IN (SELECT 
            department_id
        FROM
            departments
        WHERE
            location_id = 1700)
ORDER BY first_name , last_name;
+-------------+------------+-----------+
| employee_id | first_name | last_name |
+-------------+------------+-----------+
|         103 | Alexander  | Lee       |
|         193 | Britney    | Zhao      |
|         104 | Bruce      | Wong      |
|         179 | Charles    | Yang      |
|         105 | David      | Liang     |
|         107 | Diana      | Chen      |
|         204 | Hermann    | Wu        |
|         126 | Irene      | Liu       |
|         177 | Jack       | Yang      |
|         145 | John       | Liu       |
|         176 | Jonathon   | Yang      |
|         146 | Karen      | Liu       |
|         178 | Kimberely  | Yang      |
|         120 | Matthew    | Han       |
|         121 | Max        | Han       |
|         201 | Michael    | Zhou      |
|         122 | Min        | Liu       |
|         202 | Pat        | Zhou      |
|         192 | Sarah      | Yang      |
|         123 | Shanta     | Liu       |
|         203 | Susan      | Zhou      |
|         106 | Valli      | Chen      |
+-------------+------------+-----------+
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary = (SELECT 
            MAX(salary)
        FROM
            employees)
ORDER BY first_name , last_name;
+-------------+------------+-----------+--------+
| employee_id | first_name | last_name | salary |
+-------------+------------+-----------+--------+
|         100 | Steven     | Lee       | 24000  |
+-------------+------------+-----------+--------+
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary > (SELECT 
            AVG(salary)
        FROM
            employees);
SELECT 
    department_name
FROM
    departments d
WHERE
    EXISTS(SELECT 
            1
        FROM
            employees e
        WHERE
            salary > 10000
                AND e.department_id = d.department_id)
ORDER BY department_name;
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary >= ALL (SELECT 
            MIN(salary)
        FROM
            employees
        GROUP BY department_id)
ORDER BY first_name , last_name;
SELECT 
    employee_id, first_name, last_name, salary
FROM
    employees
WHERE
    salary >= SOME (SELECT 
            MAX(salary)
        FROM
            employees
        GROUP BY department_id);
+-------------+------------+-----------+--------+
| employee_id | first_name | last_name | salary |
+-------------+------------+-----------+--------+
|         100 | Steven     | Lee       | 24000  |
|         101 | Neena      | Wong      | 17000  |
|         102 | Lex        | Liang     | 17000  |
|         103 | Alexander  | Lee       | 9000   |
|         104 | Bruce      | Wong      | 6000   |
|         105 | David      | Liang     | 4800   |
|         106 | Valli      | Chen      | 4800   |
|         108 | Nancy      | Chen      | 12000  |
... ... 
|         200 | Jennifer   | Zhao      | 4400   |
|         201 | Michael    | Zhou      | 13000  |
|         202 | Pat        | Zhou      | 6000   |
|         203 | Susan      | Zhou      | 6500   |
|         204 | Hermann    | Wu        | 10000  |
|         205 | Shelley    | Wu        | 12000  |
|         206 | William    | Wu        | 8300   |
+-------------+------------+-----------+--------+
SELECT 
    ROUND(AVG(average_salary), 0)
FROM
    (SELECT 
        AVG(salary) average_salary
    FROM
        employees
    GROUP BY department_id) department_salary;
+-------------------------------+
| ROUND(AVG(average_salary), 0) |
+-------------------------------+
| 8536                          |
+-------------------------------+
*/

/*
sql别名

// 联表查询
// inner join 内连接
// left join 左连接
// full outer join 完全外连接
// 没有right join吗？？？
// cross join 交叉连接

// sql自连接：将表连接到自身
// 因为同一个表会至少出现2次，所以必须使用别名
// 也可以使用left join
select * from table_name A inner join table_name B on A.字符1 = B.字段2
*/

/*
### SQL结构化查询语言
 sql是用于访问和处理数据库的标准的计算机语言（用于管理关系数据库管理系统）
 数据插入、数据查询、数据更新、数据删除、数据库模式创建、数据库模式修改、数据访问控制
 一个数据库包含多个表（每个包含带有数据的记录行）
 sql不区分大小写
 select // 从数据库中提取数据
    select * from Websites;
    select name, country from Websites;
    select distinct country from Websites; // 选取唯一不同的值
    // 文本使用''
    // = <>/!= > < >= <= between在某个范围内 like搜索某种模式 in指定针对某个列的多个可能值
    select * from Websites where country = 'CN'; // 提取那些满足指定条件的记录
    // 逻辑运算
    // 优先级：not > and > or
    select * from Websites where not id < 5; // NOT
    select * from Websites where id > 1 and id < 5; // And
    select * from Websites where id > 1 or id < 5; // OR
    select * from Websites where (id > 1 or id < 5) and country = 'CN'; // and和or结合使用
    // 空值判断
    select * from Websites where name is null;
    // between
    select * from Websites where id between 1 and 5; // 1 <= id <= 5
    // in
    select * from Websites where id in (1, 3, 5); // id = 1, 3, 5
    // like模糊查询
    // %表示多个字符
    // _表示一个字符
    select * from Websites where id like '%M'; // xxxM
    select * from Websites where id like 'M%'; // Mxxx
    select * from Websites where id like '%M%'; // xxxMxxx
    select * from Websites where id like '_M'; // xM
    select * from Websites where id like 'M_'; // Mx
    select * from Websites where id like '_M_'; // xMx
    select * from Websites where id like '%M_'; // xxxMx
    // 不带运算符
    select * from Websites where id where 0; // 返回一个空集
    select * from Websites where id where 1; // 所有列的值
    // 用于对结果集按照一个列或多个列进行排序（默认升序）
    select * from Websites order by alexa;
    // 按升序排序
    select * from Websites order by alexa ASC;
    // 按降序排序
    select * from Websites order by alexa DESC;
    // 先按照country排序，在同一类型的country内部再按照alexa排序
    select * from Websites order by country alexa;
 update // 更新数据库中的数据
    // 一行代表一条记录：更新一条记录必须带上指定条件（不然所有的记录都会被更新）
    // ！！！执行该语句必须特别慎重！！！
    update Websites set alexa = '5000', country = 'CN' where name='taobao';
 delete // 从数据库中删除数据
    // 一行代表一条记录：删除一条记录必须带上指定条件（删除所有数据）
    delete from Websites where name='taobao' and country='CN';
 insert into // 向数据库中插入新数据：插入新row
    // 无需指定要插入数据的列名
    insert into Websites values ('百度', 'https:www.baidu.com', 'CN');
    // 需要指定要插入数据的列名
    insert into Websites (name, url, country) values ('百度', 'https:www.baidu.com', 'CN');
 create database // 创建新数据库
    create database my_db; // 创建一个名为"my_db"的数据库
 alter database // 修改数据库
 create table // 创建新表
    create table if not exists Websites(
        // 主键：必须包含唯一的值、主键列不能包含null值
        // 主键可以是一个或者多个联合主键
        id int not null primary key,
        // 指示某列不能存储null值：如果不向该列添加值，就无法插入新记录或者更新记录
        // 两个约束条件之间不需要逗号和分号
        name text not null unique,
        // 保证某列的每行必须有唯一的值（提供唯一性保证：可以有多个）
        url text unique,
        // 外键对应另一个表Persons主键
        alexa text foreign key (alexa) references Persons(alexa),
        // A表中的某个字段KEY指向B表中的unique key：key是A表的Fforeign key、key是B表的primary key
        country text,
        // 一个列的unique约束
        unique (name),
        // 多个列的unique约束
        constraint wm_WebsitesID unique (name, url),
        // primary key约束
        primary key(id),
        // 主键是sy_WebsitesID
        constraint sy_WebsitesID primary key (id, url),
        // 外键对应另一个表Persons主键
        foreign key (alexa) references Persons(alexa),
        constraint dm_WebsitesID foreign key (alexa) references Persons(alexa)
    )
 alter table // 变更数据库表
    // 给一个已创建的表的name字段添加约束
    alter table Websites modify name text not null;
    // 删除not null约束
    alter table Websites modify name text null;
    // 给一个已创建的表的一个列添加unique约束
    alter table Websites add unique(name),
    // 给一个已创建的表的多个列添加unique约束
    alter table Websites add constraint wm_WebsitesID unique (name, url)
    // 删除unique约束
    alter table Websites drop index wm_WebsitesID,
    alter table Websites drop constraint wm_WebsitesID,
    // 给一个已创建的表创建primary key约束
    alter table Websites add primary key(name),
    // 给一个已创建的表创建primary key约束
    // 主键是sy_WebsitesID
    alter table Websites add constraint sy_WebsitesID PRIMARY KEY (id, url)
    // 删除primary key约束
    alter table Websites drop primary key,
    alter table Websites drop constraint sy_WebsitesID,
    // 给一个已创建的表创建foreign key约束
    alter table Websites add constraint dm_WebsitesID foreign key (alexa) references Persons(alexa),
    // 删除primary key约束
    alter table Websites drop foreign key dm_WebsitesID,
    alter table Websites drop constraint dm_WebsitesID
 drop table // 删除表
 create index // 创建索引
    // 索引：对数据库表中一列或者多列的值进行排序的一种结构
    // 通过索引可以快速的访问数据表中的特定信息
 drop index // 删除索引

 CHECK - 保证列中的值符合指定的条件。
 DEFAULT - 规定没有给列赋值时的默认值。


 1.使用sql语句查询出省名以湖开头，邮编为436001所在的市区
 select * from citys where postcode=436001 and province='湖%'


 # SQL结构化查询语言
https://www.runoob.com
 sql是用于访问和处理数据库的标准的计算机语言（用于管理关系数据库管理系统）
 数据插入、数据查询、数据更新、数据删除、数据库模式创建、数据库模式修改、数据访问控制
 一个数据库包含多个表（每个包含带有数据的记录行）
 sql不区分大小写
 select // 从数据库中提取数据
    select * from Websites;
    select name, country from Websites;
    select distinct country from Websites; // 选取唯一不同的值
    // 文本使用''
    // = <>/!= > < >= <= between在某个范围内 like搜索某种模式 in指定针对某个列的多个可能值
    select * from Websites where country = 'CN'; // 提取那些满足指定条件的记录
    // 逻辑运算
    // 优先级：not > and > or
    select * from Websites where not id < 5; // NOT
    select * from Websites where id > 1 and id < 5; // And
    select * from Websites where id > 1 or id < 5; // OR
    select * from Websites where (id > 1 or id < 5) and country = 'CN'; // and和or结合使用
    // 空值判断
    select * from Websites where name is null;
    // between
    select * from Websites where id between 1 and 5; // 1 <= id <= 5
    // in
    select * from Websites where id in (1, 3, 5); // id = 1, 3, 5
    // like模糊查询
    // %表示多个字符
    // _表示一个字符
    select * from Websites where id like '%M'; // xxxM
    select * from Websites where id like 'M%'; // Mxxx
    select * from Websites where id like '%M%'; // xxxMxxx
    select * from Websites where id like '_M'; // xM
    select * from Websites where id like 'M_'; // Mx
    select * from Websites where id like '_M_'; // xMx
    select * from Websites where id like '%M_'; // xxxMx
    // 不带运算符
    select * from Websites where id where 0; // 返回一个空集
    select * from Websites where id where 1; // 所有列的值
    // 用于对结果集按照一个列或多个列进行排序（默认升序）
    select * from Websites order by alexa;
    // 按升序排序
    select * from Websites order by alexa ASC;
    // 按降序排序
    select * from Websites order by alexa DESC;
    // 先按照country排序，在同一类型的country内部再按照alexa排序
    select * from Websites order by country alexa;
 update // 更新数据库中的数据
    // 一行代表一条记录：更新一条记录必须带上指定条件（不然所有的记录都会被更新）
    // ！！！执行该语句必须特别慎重！！！
    update Websites set alexa = '5000', country = 'CN' where name='taobao';
 delete // 从数据库中删除数据
    // 一行代表一条记录：删除一条记录必须带上指定条件（删除所有数据）
    delete from Websites where name='taobao' and country='CN';
 insert into // 向数据库中插入新数据：插入新row
    // 无需指定要插入数据的列名
    insert into Websites values ('百度', 'https:www.baidu.com', 'CN');
    // 需要指定要插入数据的列名
    insert into Websites (name, url, country) values ('百度', 'https:www.baidu.com', 'CN');
 create database // 创建新数据库
    create database my_db; // 创建一个名为"my_db"的数据库
 alter database // 修改数据库
 create table // 创建新表
    create table if not exists Websites(
        // 主键：必须包含唯一的值、主键列不能包含null值
        // 主键可以是一个或者多个联合主键
        id int not null primary key,
        // 指示某列不能存储null值：如果不向该列添加值，就无法插入新记录或者更新记录
        // 两个约束条件之间不需要逗号和分号
        name text not null unique,
        // 保证某列的每行必须有唯一的值（提供唯一性保证：可以有多个）
        url text unique,
        // 外键对应另一个表Persons主键
        alexa text foreign key (alexa) references Persons(alexa),
        // A表中的某个字段KEY指向B表中的unique key：key是A表的Fforeign key、key是B表的primary key
        country text,
        // 一个列的unique约束
        unique (name),
        // 多个列的unique约束
        constraint wm_WebsitesID unique (name, url),
        // primary key约束
        primary key(id),
        // 主键是sy_WebsitesID
        constraint sy_WebsitesID primary key (id, url),
        // 外键对应另一个表Persons主键
        foreign key (alexa) references Persons(alexa),
        constraint dm_WebsitesID foreign key (alexa) references Persons(alexa)
    )
 alter table // 变更数据库表
    // 给一个已创建的表的name字段添加约束
    alter table Websites modify name text not null;
    // 删除not null约束
    alter table Websites modify name text null;
    // 给一个已创建的表的一个列添加unique约束
    alter table Websites add unique(name),
    // 给一个已创建的表的多个列添加unique约束
    alter table Websites add constraint wm_WebsitesID unique (name, url)
    // 删除unique约束
    alter table Websites drop index wm_WebsitesID,
    alter table Websites drop constraint wm_WebsitesID,
    // 给一个已创建的表创建primary key约束
    alter table Websites add primary key(name),
    // 给一个已创建的表创建primary key约束
    // 主键是sy_WebsitesID
    alter table Websites add constraint sy_WebsitesID PRIMARY KEY (id, url)
    // 删除primary key约束
    alter table Websites drop primary key,
    alter table Websites drop constraint sy_WebsitesID,
    // 给一个已创建的表创建foreign key约束
    alter table Websites add constraint dm_WebsitesID foreign key (alexa) references Persons(alexa),
    // 删除primary key约束
    alter table Websites drop foreign key dm_WebsitesID,
    alter table Websites drop constraint dm_WebsitesID
 drop table // 删除表
 create index // 创建索引
    // 索引：对数据库表中一列或者多列的值进行排序的一种结构
    // 通过索引可以快速的访问数据表中的特定信息
 drop index // 删除索引
 
 CHECK - 保证列中的值符合指定的条件。
 DEFAULT - 规定没有给列赋值时的默认值。


 1.使用sql语句查询出省名以湖开头，邮编为436001所在的市区
 select * from citys where postcode=436001 and province='湖%'
 
 
 // sql语句
// 什么事sql语句：结构化查询语言
// 作用：管理关系型数据库
// 不区分大小写
// 1.创建数据库
create database my_db;
// 2.创建表
create table if not exists Website {
    id not null primary key,
    name text,
    url text, unique,
    index(id)
}
create index IndexName on Website(id);
// 增
insert into Website (name, url) values ("百度", "https://www.baidu.com");
insert into Website values ("百度", "https://www.baidu.com");
// 删
delete from Website Where name = "百度";
// 改
update Website name = "百度", url = "https://www.baidu.com" set name = "百度", url = "https://www.baidu.com"
// 查
select * from Website;
select name, url from Website;
select * from Website where name = "百度";
select * from Website where name = "百度" and url = "";
select * from Website where not name = "百度";
select * from Website where name = "百度" or url = "";
select * from Website where id between 1 and 5; [1, 5]
select * from Website where id > 5;
select * from Website where name = "%M_" // xxxxxMx
select * from Website order by id ASC;
select * from Website order by id DESC;
// 联表查询
id = 1, 2, 5
site_id = 2, 5, 7, 8
select Website1.name, Website2.url from Website1 inner join Website2 on Website1.id = Website2.site_id; // 2, 5
left join // 1, 2, 5
left join webiste2.site_id = NULL // 1, 2
right join // 2, 5, 7, 8
right join webiste1.site_id = NULL // 7, 8
full outer join // 1, 2, 5, 7, 8

使用sql语句查询出省名以湖开头，邮编为436001所在的市区

select * from citys where provinName like "湖%" and postcode = "436001";

现有两张表：用户表Z_User和黑名单表Z_BlackUser，其中userid是用户表Z_User的主键，黑名单表Z_BlackUser的外键。查询在用户表Z_User中不在黑名单表Z_BlackUser中的数据，写出sql语句
select * from Z_User left join Z_BlackUser on Z_User.userid = Z_BlackUser.userid where Z_BlackUser.userid = NULL;


id = 1, 2, 5
site_id = 2, 5, 7, 8

inner join  // 2, 5
left join // webiste2.site_id = NULL

drop table
update website set name = "", url="" where id = "xxx";

select * from table id in (1, 3, 4)
name like ""

// SQL语句
// 1.什么是SQL语句：SQL语句叫做结构化查询语言
// 2.SQL的作用：用于管理关系型数据库
// 3.sql不区分大小写
// 创建一个名为"my_db"的数据库
create database my_db;
// 创建新表
create table if not exists WebSites {
// 主键：必须包含唯一的值、主键列不能包含null值
id int not null primary key,
name text,
// 保证某列的每行必须有唯一的值
url text unique
// 创建索引
index (id)
}
// 创建索引（唯一）
create index Index_Name on WebSites(id)
// 删除表
drop table WebSites;
// 增：插入
insert into WebSites (name, url) values ('百度', 'https:www.baidu.com');
insert into WebSites values ('百度', 'https:www.baidu.com');
// 删：删除（删除一条记录必须带上指定条件（不然所有的记录都会被删除））
delete from WebSites where name = '百度';
// 改：更新（更新一条记录必须带上指定条件（不然所有的记录都会被更新））
update WebSites set name = '百度', url = 'https:www.baidu.com' where id = 2;
// 查
select * from WebSites;
select name, url from WebSites;
select * from WebSites where id = 2;
select * from WebSites where not id < 5;
select * from WebSites where id > 5 and id < 10;
select * from Websites where (id > 1 or id < 5) and name = '百度';
select * from Websites where id between 1 and 5; // [1, 5]
select * from Websites where id in (1, 3, 5); // id = 1, 3, 5
select * from Websites where id like '%M_' // xxxMx
select * from Websites order by alexa; // ASC默认
select * from Websites order by alexa DESC;
// 联表查询
/*
id 2 3 5 7
site_id 2 5 8 9
/
select WebSites1.name, WebSites1.url, WebSite1.country from WebSites1 inner join WebSites2 on WebSite1.id = WebSite2.site_id // (2, 5)
select WebSites1.name, WebSites1.url, WebSite1.country from WebSites1 left join WebSites2 on WebSite1.id = WebSite2.site_id // (2, 3, 5, 7)
select WebSites1.name, WebSites1.url, WebSite1.country from WebSites1 right join WebSites2 on WebSite1.id = WebSite2.site_id // (2, 5, 8, 9)
select WebSites1.name, WebSites1.url, WebSite1.country from WebSites1 full outer join WebSites2 on WebSite1.id = WebSite2.site_id // (2, 3, 5, 7, 8, 9)
/
1.使用sql语句查询出省名以湖开头，邮编为436001所在的市区
select * from citys where postcode=436001 and province='湖%'
*/
现有两张表：用户表Z_User和黑名单表Z_BlackUser，其中userid是用户表Z_User的主键，黑名单表Z_BlackUser的外键。查询在用户表Z_User中不在黑名单表Z_BlackUser中的数据，写出sql语句

// 连表查询
select * from Z_User where xxx


// SQL语句
// 1.什么是SQL语句：SQL语句叫做结构化查询语言
// 2.SQL的作用：用于管理关系型数据库
// 3.sql不区分大小写
// 创建一个名为"my_db"的数据库
create database my_db;
// 创建新表
create table if not exists WebSites {
    // 主键：必须包含唯一的值、主键列不能包含null值
    id int not null primary key,
    name text,
    // 保证某列的每行必须有唯一的值
    url text unique
    // 创建索引
    index (id)
}
// 创建索引（唯一）
create index Index_Name on WebSites(id)
// 删除表
drop table WebSites;
// 增：插入
insert into WebSites (name, url) values ('百度', 'https:www.baidu.com');
insert into WebSites values ('百度', 'https:www.baidu.com');
// 删：删除（删除一条记录必须带上指定条件（不然所有的记录都会被删除））
delete from WebSites where name = '百度';
// 改：更新（更新一条记录必须带上指定条件（不然所有的记录都会被更新））
update WebSites set name = '百度', url = 'https:www.baidu.com' where id = 2;
// 查
select * from WebSites;
select name, url from WebSites;
select * from WebSites where id = 2;
select * from WebSites where not id < 5;
select * from WebSites where id > 5 and id < 10;
select * from Websites where (id > 1 or id < 5) and name = '百度';
select * from Websites where id between 1 and 5; // [1, 5]
select * from Websites where id in (1, 3, 5); // id = 1, 3, 5
select * from Websites where id like '%M_' // xxxMx
select * from Websites order by alexa; // ASC默认
select * from Websites order by alexa DESC;
// 联表查询
/*
id 2 3 5 7
site_id 2 5 8 9
*/
select WebSites1.name, WebSites1.url, WebSite1.country from WebSites1 inner join WebSites2 on WebSite1.id = WebSite2.site_id // (2, 5)
select WebSites1.name, WebSites1.url, WebSite1.country from WebSites1 left join WebSites2 on WebSite1.id = WebSite2.site_id // (2, 3, 5, 7)
select WebSites1.name, WebSites1.url, WebSite1.country from WebSites1 right join WebSites2 on WebSite1.id = WebSite2.site_id // (2, 5, 8, 9)
select WebSites1.name, WebSites1.url, WebSite1.country from WebSites1 full outer join WebSites2 on WebSite1.id = WebSite2.site_id // (2, 3, 5, 7, 8, 9)
/*
 1.使用sql语句查询出省名以湖开头，邮编为436001所在的市区
 select * from citys where postcode=436001 and province='湖%'
 */
**现有两张表：用户表Z_User和黑名单表Z_BlackUser，其中userid是用户表Z_User的主键，黑名单表Z_BlackUser的外键。查询在用户表Z_User中不在黑名单表Z_BlackUser中的数据，写出sql语句**
```
// 连表查询
select * from Z_User where xxx
```
*/

/*
// 添加new字段在字段1的后面
add 字段名 字段数据类型 默认值 多个列约束条件 after 字段名1,
add 字段名 字段数据类型 默认值 多个列约束条件 after 字段名1,

create unique index index_name on table_name1(
   字段名1,
   字段名2
)

2. SQL ALTER TABLE MODIFY列

MODIFY子句用于更改现有列的某些属性，例如，NOT NULL，UNIQUE和数据类型。

UNIQUE

在本教程中，将学习如何使用SQLUNIQUE约束强制列或一组列中值的唯一性。

1. 什么是SQL UNIQUE约束

有时，希望确保一列或多列中的值不重复。 例如，employees表中不能接受的重复电子邮件。由于电子邮件列不是主键的一部分，因此防止电子邮件列中重复值的唯一方法是使用UNIQUE约束。

根据定义，SQLUNIQUE约束定义了一个规则，该规则可防止存储在不参与主键的特定列中有重复值。

UNIQUE与PRIMARY KEY约束比较

PRIMARY KEY约束最多只能有一个，而表中可以有多个UNIQUE约束。 如果表中有多个UNIQUE约束，则所有UNIQUE约束必须在不同的列集。

与PRIMARY KEY约束不同，UNIQUE约束允许NULL值。 这取决于RDBMS要考虑NULL值是否唯一。

例如，MySQL将NULL值视为不同的值，因此，可以在参与UNIQUE约束的列中存储多个NULL值。 但是，Microsoft SQL Server或Oracle数据库不是这种情况。

下表说明了UNIQUE约束和PRIMARY KEY约束之间的区别：

比较项 PRIMARY KEY约束 UNIQUE约束
约束的数量 一个 多个
NULL值 不允许 允许
2. 创建UNIQUE约束

通常，在创建表时创建UNIQUE约束。 以下CREATE TABLE语句定义users表，其中username列是唯一的。

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);
要为列创建UNIQUE约束，需要在列定义中添加UNIQUE关键字。 在这个示例中，创建了UNIQUE约束作为列约束。

如果插入或更新与username列中已存在的值相同的值，则RDBMS将拒绝更改并返回错误。以下语句等效于使用表约束语法创建的UNIQUE约束的上述语句。

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255) NOT NULL,
    CONSTRAINT uc_username UNIQUE (username)
);
在这个示例中，将CONSTRAINT子句放在CREATE TABLE语句的末尾。

3. 将UNIQUE约束添加到现有表

如果表已存在，则可以为列添加UNIQUE约束，前提条件是参与UNIQUE约束的列或列组合必须包含唯一值。

假设创建的users表没有为username列定义UNIQUE约束。 要将UNIQUE约束添加到username列，请使用ALTER TABLE语句，如下所示：

ALTER TABLE users
ADD CONSTRAINT uc_username UNIQUE(username);
如果要添加新列并为创建UNIQUE约束，请使用以下形式的ALTER TABLE语句。

ALTER TABLE users
ADD new_column data_type UNIQUE;
例如，以下语句将带有UNIQUE约束的email列添加到users表。

ALTER TABLE users
ADD email VARCHAR(255) UNIQUE;
4. 删除UNIQUE约束

要删除UNIQUE约束，请使用ALTER TABLE语句，如下所示：

ALTER TABLE table_name
DROP CONSTRAINT unique_constraint_name;
例如，要删除users表中的uc_username唯一约束，请使用以下语句。

ALTER TABLE users
DROP CONSTRAINT uc_username;
在本教程中，我们学习了UNIQUE约束以及如何应用它来强制一列或多列中值的唯一性。

以下语句显示带有MODIFY子句的ALTER TABLE语句的语法。

ALTER TABLE table_name
MODIFY column_definition;
请注意，应该修改没有数据的表的列的属性。 因为更改已包含数据的表中列的属性可能会导致永久性数据丢失。

例如，如果列的数据类型为VARCHAR，并且将其更改为INT，则数据库系统必须将数据从VARCHAR转换为INT。 如果转换失败，数据库系统可能会使用列的默认值，这可能与预期不符。

以下ALTER TABLE MODIFY语句将fee列的属性更改为NOT NULL。

ALTER TABLE courses 
MODIFY fee NUMERIC (10, 2) NOT NULL;
3. SQL ALTER TABLE DROP列

当表的列已过时且未被任何其他数据库对象(如触发器，视图，存储过程和存储过程)使用时，需要将其从表中删除。

要删除一个或多个列，请使用以下语法：

ALTER TABLE table_name
DROP column_name,
DROP colum_name,
...
例如，要删除courses表中的fee列，请使用以下语句。

ALTER TABLE courses DROP COLUMN fee;
若要同时删除多个列，请使用以逗号(,)分隔的多个DROP COLUMN子句。

例如，以下语句删除courses表中的max_limit和credit_hours。

ALTER TABLE courses 
DROP COLUMN max_limit,
DROP COLUMN credit_hours;
在本教程中，我们逐步学习了如何使用SQLALTER TABLE语句在表中添加，修改和删除一个或多个列。

// 删除表：表名不存在则数据库报错
drop table [if exist] table_name
// 有些数据库要求表中记录为空的时候才可以删除表（防止意外删除）：删除表中数据（1.禁用/删除外部约束 2.delete table）
delete from table_name // 对于大数据库表很慢
truncate table table_name // 删除大数据库表所有行。。。很快

// 更改数据库的表名
alter table table_name1
rename to table_name2
或者
rename old_table_name to new_table_name

// 复制表A中的数据到表B
select * into 表B名 from 表A名


临时表的概念由SQL服务器引入的，它以多种方式帮助开发人员。

临时表可以在运行时创建，并且可以像普通表一样执行各种操作。 这些临时表是在tempdb数据库中创建的。

根据行为和范围，有两种类型的临时表。

局部临时变量
全局临时变量
1. 局部临时变量

局部临时变量表仅在当前连接时可用。 当用户与实例断开连接时，它会自动删除。 它以哈希(#)符号开头。

CREATE TABLE #local temp table (  
    User_id int,  
    User_name varchar (50),  
    User_address varchar (150)  
)
2. 全局临时变量

全局临时表名称以双哈希(##)开头。 创建此表后，它就像一个永久表。 它始终为所有用户准备好，并且在撤消总连接之前不会被删除。

CREATE TABLE ##new global temp table (  
    User_id int,  
    User_name varchar (50),  
    User_address varchar (150)  
)


使用ALTER TABLE语句的SQLADD COLUMN子句将一个或多个列添加到现有表中。

1. SQL ADD COLUMN子句简介

要向表中添加新列，可使用ALTER TABLE ADD COLUMN语句，如下所示：

ALTER TABLE table_name
ADD [COLUMN] column_definition;
在这个声明中，

首先，指定要添加新列的表名称。
其次，在ADD COLUMN子句后指定列定义。
列定义的典型语法如下：

column_name data_type constraint;
如果要使用单个语句将多个列添加到现有表，请使用以下语法：

ALTER TABLE table_name
ADD [COLUMN] column_definition,
ADD [COLUMN] column_definition,
 ...;
不同的数据库系统支持ALTER TABLE ADD COLUMN语句以及一些小的差异。 请在下一节中查看参考资料。

2. SQL ADD COLUMN示例

以下语句创建一个名为candidate的新表：

CREATE TABLE candidates (
    id INT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE
);
要将phone列添加到candidates表，请使用以下语句：

ALTER TABLE candidates
ADD COLUMN phone VARCHAR(50);
要在candidates表中添加三列：home_address，dob和linkedin帐户，请使用以下语句：

ALTER TABLE candidates
ADD COLUMN home_address VARCHAR(255),
ADD COLUMN dob DATE,
ADD COLUMN linkedin_account VARCHAR(255);
3. 一些常见数据库系统中的SQL ADD COLUMN语句

以下部分提供了一些常见数据库系统中ALTER TABLE ADD COLUMN语句的语法。

PostgreSQL

在PostgreSQL中向表中添加一列：

ALTER TABLE table_name
ADD COLUMN column_definition;
在PostgreSQL中向表中添加多列：

    ALTER TABLE table_name
    ADD COLUMN column_definition,
    ADD COLUMN column_definition,
    ...
    ADD COLUMN column_definition;
MySQL

在MySQL中的表中添加一列：

ALTER TABLE table_name
    ADD [COLUMN] column_definition;
在MySQL中向表中添加多列：

ALTER TABLE table_name
    ADD [COLUMN] column_definition,
    ADD [COLUMN] column_definition,
    ...
    ADD [COLUMN] column_definition;
Oracle

在Oracle中的表中添加一列：

ALTER TABLE table_name
ADD column_definition;
在Oracle中向表中添加多列：

ALTER TABLE table_name 
ADD (
    column_definition,
    column_definition,
    ...
);
SQL Server

在SQL Server中的表中添加一列：

ALTER TABLE table_name
ADD column_definition;
在SQL Server中向表中添加多列：

ALTER TABLE table_name
ADD
    column_definition,
    column_definition,
    ...;
DB2

在DB2中的表中添加一列：

ALTER TABLE table_name
ADD column_definition;
在DB2中向表中添加多列：

ALTER TABLE table_name
ADD
    column_definition
    column_definition
    ...;
请注意，列之间没有逗号。

如何使用SQLDROP COLUMN子句从现有表中删除一个或多个列。

1. SQL DROP COLUMN语句简介

有时，想要从现有表中删除一个或多个未使用的列。 为此，请使用ALTER TABLE，如下所示：

ALTER TABLE table_name
DROP COLUMN column_name1,
[DROP COLUMN column_name2];
在上面语法中，

table_name是包含要删除列的表名称。
column_name1，column_name2是将要删除的列。
MySQL和PostgreSQL支持上述语法。

Oracle和SQL Server的语法略有不同：

ALTER TABLE table_name
  DROP COLUMN  
    column_name1, 
    [column_name2];
2. SQL DROP COLUMN示例

以下语句为演示创建一个名为persons的新表：

CREATE TABLE persons (
    person_id INT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    date_of_birth DATE NOT NULL,
    phone VARCHAR(25),
    email VARCHAR(255)
);
2.1. 删除一列示例

以下语句从persons表中删除email列：

ALTER TABLE persons
DROP COLUMN email;
2.2. 删除多列示例

以下语句从persons表中删除ate_of_birth和phone列：

ALTER TABLE persons
DROP COLUMN date_of_birth,
DROP COLUMN phone;
上面语句适用于MySQL和PostgreSQL。对于Oracle和SQL Server，需要使用以下语句：

ALTER TABLE persons
    DROP COLUMN 
        date_of_birth,
        phone;
*/


/*
+---------------+--------------+------+-----+---------+----------------+
| Field         | Type         | Null | Key | Default | Extra          |
+---------------+--------------+------+-----+---------+----------------+
| employee_id   | int(11)      | NO   | PRI | NULL    | auto_increment |
| first_name    | varchar(20)  | YES  |     | NULL    |                |
| last_name     | varchar(25)  | NO   |     | NULL    |                |
| email         | varchar(100) | NO   |     | NULL    |                |
| phone_number  | varchar(20)  | YES  |     | NULL    |                |
| hire_date     | date         | NO   |     | NULL    |                |
| job_id        | int(11)      | NO   | MUL | NULL    |                |
| salary        | decimal(8,2) | NO   |     | NULL    |                |
| manager_id    | int(11)      | YES  | MUL | NULL    |                |
| department_id | int(11)      | YES  | MUL | NULL    |                |
+---------------+--------------+------+-----+---------+----------------+

// 使用primary key约束向表中添加主键
// sql外键：创建foreign key约束以强制表之间的关系
// UNIQUE约束
// not null约束
// check约束
约束
列级别约束
表级别约束
NOT NULL - 列中不能具有NULL值
DEFAULT - 未指定列的时候为列指定默认值
unique - 确保列中所有值都不同
primary键 - 唯一标识表中每一行
外键 - 唯一标识其它数据库表中每一行
检查约束 - 确保列中每一个值都满足特定条件
索引 - 用于快速的从数据库中创建和检索数据

sql约束
列级别约束
NOT NULL -- 表示列中不能具有NULL值
default 未指定列时为列提供默认值
unique 列中的所有值都不相同

primary键 -- 唯一标识表中每一行
check 检查约束

表级别约束
create table customers(
   id int NOT NULL,
   name varchar(20) unique,
   age int default 18 check(age >= 0),
   primary key (id)
)
http://www.360doc.com/content/22/0716/12/277688_1040065077.shtml
https://blog.csdn.net/Python84310366/article/details/131557987
*/

/*
数据库是相关数据的集合
数据库和文件系统对比
>.冗余较少：直接使用文件不可避免的会存储大量的重复信息
>.避免不一致性：大量的冗余会带来更多的不一致性的可能
>.效率：主要指查询效率
>.数据完整性
>.机密性

### 数据库管理系统

数据库管理系统是用于定义、创建、维护数据库的一种工具
组成：硬件 软件 数据 用户 规程（用户需要遵循的规则）

## 数据库体系结构

数据库管理系统有三层体系结构：
+ 内层：数据在存储设备中的实际存储和组织方式。内层直接与硬件交互
+ 概念层：定义数据的逻辑视图。数据库管理系统的主要功能（增删查改）都在这一层
+ 外层：与用户交互的一层

数据库模型
数据库模型有三种：层次模型，网状模型，关系模型。

### 关系数据库模型：数据是通过关系的集合来表示的
insert into插入
delete删除
update更新
select检索

并集UNION - 两个表的并集
交集INTERSECTION - 两个表的交集
差集MINUS - 第一个表减第二个表

数据库设计
1.建立实体关系模型ERM
通过E-R图表示实体关系模型

### 规范化
+ 第一范式（1NF）：每个元组的每个属性只能有一个值，并且属性需要相互独立（不能有子属性）。。。不满足第一范式的话连存都存不下
+ 第二范式（2NF）：每个非主键属性的值依赖于整个主键

10:写一个sql 语句，查询出部门表 DEP 中张姓员工的相关信息。

11:写一个 sql 语句,查询出 DEP 表中部门名(dep_name)为“软件测试部”的员工相关信息，并根据工资(salary)从低到高进行排序:

12:写一个SQL 语句，查询出以上表中部门员工工资前三名:

13:内连接和外连接的区别?  

// 两个必须要会的技能
sql语句编写
设计数据库表

经典面试题
1. MySQL索引的最左原则
2. InnoDB 和 MyIsam 引擎的区别？
3. 有哪些优化数据库性能的方法？
4. 如何定位慢查询？
5. MySQL 支持行锁还是表锁？分别有哪些优缺点？

http://xuesql.cn
https://www.bejson.com/runcode/sql
https://www.runoob.com/sql/sql-tutorial.html
https://www.runoob.com/mysql/mysql-tutorial.html