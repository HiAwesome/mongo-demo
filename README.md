# MongoDB 学习

## 玩转 MongoDB 从入门到实战（目前基于 4.4.2）

[玩转 MongoDB 从入门到实战 PDF](book/%E7%8E%A9%E8%BD%AC%20MongoDB%20%E4%BB%8E%E5%85%A5%E9%97%A8%E5%88%B0%E5%AE%9E%E6%88%98.pdf)

## [中文文档（目前基于 4.2）](https://docs.mongoing.com/)

## Golang with MongoDB

* [How to Get Connected to Your MongoDB Cluster with Go](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--starting-and-setup)
* [Creating MongoDB Documents with Go](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--how-to-create-documents)
* [Retrieving and Querying MongoDB Documents with Go](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--how-to-read-documents)
* [Updating MongoDB Documents with Go](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--how-to-update-documents)
* [Deleting MongoDB Documents with Go](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--how-to-delete-documents)
* [Modeling MongoDB Documents with Native Go Data Structures](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--modeling-documents-with-go-data-structures)
* [Performing Complex MongoDB Data Aggregation Queries with Go](https://www.mongodb.com/blog/post/quick-start-golang--mongodb--data-aggregation-pipeline)
* [Reacting to Database Changes with MongoDB Change Streams and Go](https://developer.mongodb.com/quickstart/golang-change-streams)
* [Multi-Document ACID Transactions in MongoDB with Go](https://developer.mongodb.com/quickstart/golang-multi-document-acid-transactions)

## [MongoDB 权威指南（第2版）](https://book.douban.com/subject/25798102/)

### 过时警告

* **书中以 mongo 2.3 为基础进行讲解，大多数命令内容已不具有实际参考性，阅读仅需关注想法和内容组织结构。**
* 阅读进度目前停在第十一章: 从应用程序连接副本集。

### 书中引用

* MongoDB 的一个主要目标是提供卓越的性能，这很大程度上决定了 MongoDB 的设计。虽然 MongoDB 非常强大并试图保留关系型数据库的很多特性，但它并不追求具备关系型数据库的所有功能。只要有可能，数据库服务器就会将处理和逻辑交给客户端。这种精简方式的设计是 MongoDB 能够实现如此高性能的原因之一。    ——P5
* MongoDB 自带 JavaScript shell, 可在 shell 中使用命令行与 MongoDB 实例交互。shell 是一个功能完备的  JavaScript 解释器，可运行任意 JavaScript 程序。    ——P13
* 自动生成 _id: 前面讲到，如果插入文档时没有"_id"键，系统会自动帮你创建一个。可以由 MongoDB 服务器来做这件事，但通常会在客户端由驱动程序完成。这一做法非常好地体现了 MongoDB 的哲学: 能交给客户端驱动程序来做的事情就不要交给服务器来做。这种理念背后的原因是，即便是像 MongoDB 这样扩展性非常好的数据库，扩展应用层也要比扩展数据库层容易得多。将工作交给客户端来处理，就减轻了数据库扩展的负担。  ——P21
* 由于 mongo 是一个简化的 JavaScript shell，可以通过查看 JavaScript 的在线文档得到大量帮助。如果想知道一个函数是做什么用的，可以直接在 shell 输入函数名（函数名后不要输入小括号），这样就可以看到相应函数的 JavaScript 实现代码。   ——P22
* save 是一个 shell 函数，如果文档不存在，它会自动创建文档；如果文档存在，它就更新这个文档。它只有一个参数：文档。要是这个文档含有"_id"键，save 会调用 upsert，否则回调用 insert。    ——P46
* MongoDB 使用 Perl 兼容的正则表达式（PCRE）库来匹配正则表达式，任何 PCRE 支持的正则表达式语法都能被 MongoDB 接受。MongoDB 可以为前缀型正则表达式（比如 /^joey/）查询创建索引，所以这种类型的查询会非常高效。    ——P59
* 键值对是一种表达能力非常好的查询方式，但是依然有些需求它无法表达。其他方法都败下阵来时，就轮到 $where 子句登场了，用它可以在查询中执行任意的 JavaScript。这样就能在查询中做（几乎）任何事情。为安全起见，应该严格限制或者消除 $where 语句的使用。应该禁止终端用户使用任意的 $where 语句。    ——P65
* 不是非常必要时，一定要避免使用 $where 查询，因为它们在速度上比常规查询慢得多。每个文档都要从 BSON 转换成 JavaScript 对象，然后通过 $where 表达式来运行。而且 $where 语句不能使用索引，所以只在走投无路时才考虑 $where 这种用法。     ——P66
* **比较顺序**：MongoDB 处理不同类型的数据是有一定顺序的。有时一个键的值可能是多种类型的，例如，整形和布尔型，或者字符串和 null。如果对这种混合类型的键排序，其排序顺序是预先定义好的。优先级从小到大，其顺序如下：最小值、null、数字（整形、长整形、双精度）、字符串、对象/文档、数组、二进制数据、对象ID、布尔型、日期型、时间戳、正则表达式、最大值。   ——P70
* explain\(\) 能够提供大量与查询有关的信息。对于速度比较慢的查询来说，这是最重要的诊断工具之一。通过查看一个查询的 explain\(\) 输出信息，可以知道查询使用了哪个索引，以及是如何使用的。   ——P98
* 需要考虑的另一个重要问题是，信息更新更频繁还是信息读取更频繁？如果这些数据会定期更新，那么范式化是比较好的选择。如果数据变化不频繁，为了优化更新效率而牺牲读取效率就不值得了。例如，教科书上介绍范式化的一个例子可能是将用户和用户地址保存在不同的集合中。但是，人们几乎不会改变住址，所以不应该为了这种概率极小的情况（某人改变了住址）而牺牲每一次查询的效率。在这种情况下，应该将地址内嵌在用户文档中。 ——P158
* 使用仲裁者的一个好处是：如果你拥有的节点数是偶数，那么可能会出现一般节点投票给 A，但是另一半节点投票给 B 的情况。仲裁者这时就可以投出决定胜负的关键一票。   ～P185
