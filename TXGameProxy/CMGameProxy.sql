















































-- 单行注释
/*
多行注释
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