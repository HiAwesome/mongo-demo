# [MongoDB 权威指南（第2版）](https://book.douban.com/subject/25798102/)

## 书中引用

* MongoDB 的一个主要目标是提供卓越的性能，这很大程度上决定了 MongoDB 的设计。虽然 MongoDB 非常强大并试图保留关系型数据库的很多特性，但它并不追求具备关系型数据库的所有功能。只要有可能，数据库服务器就会将处理和逻辑交给客户端。这种精简方式的设计是 MongoDB 能够实现如此高性能的原因之一。    ——P5
* MongoDB 自带 JavaScript shell, 可在 shell 中使用命令行与 MongoDB 实例交互。shell 是一个功能完备的  JavaScript 解释器，可运行任意 JavaScript 程序。    ——P13
* 自动生成 _id: 前面讲到，如果插入文档时没有"_id"键，系统会自动帮你创建一个。可以由 MongoDB 服务器来做这件事，但通常会在客户端由驱动程序完成。这一做法非常好地体现了 MongoDB 的哲学: 能交给客户端驱动程序来做的事情就不要交给服务器来做。这种理念背后的原因是，即便是像 MongoDB 这样扩展性非常好的数据库，扩展应用层也要比扩展数据库层容易得多。将工作交给客户端来处理，就减轻了数据库扩展的负担。  ——P21
* 由于 mongo 是一个简化的 JavaScript shell，可以通过查看 JavaScript 的在线文档得到大量帮助。如果想知道一个函数是做什么用的，可以直接在 shell 输入函数名（函数名后不要输入小括号），这样就可以看到相应函数的 JavaScript 实现代码。   ——P22
