// mongorc.js

/**
 * 这个文件会在启动 mongo shell 的时候自动运行
 * 需要放在 HOME 下面，且文件名为 .mongorc.js, 需要前面一个点
 *
 * 官方文档: https://docs.mongodb.com/manual/reference/program/mongo/#mongo-mongorc-file
 *
 * Created by moqi
 * On 1/4/21 15:36
 */
const compliment = ["attractive", "intelligent", "like Batman"];
const index = Math.floor(Math.random() * 3);

print("Hello, you're looking particularly " + compliment[index] + " today!")

// 编辑复合常量，使用 edit VAR 时进入编辑器模式
// 本机设定为 Sublime Text
EDITOR="/Applications/Sublime\\ Text.app/Contents/SharedSupport/bin/subl --new-window --wait"

// .mongorc.js 最常见的用途之一是移除那些比较"危险"的 shell 辅助函数
// 以下内容并未配置在本机 .mongorc.js 中，仅用作举例
var no = function () {
    print("Not on my watch.")
}

// 禁止删除数据库
db.dropDatabase = DB.prototype.dropDatabase = no;

// 禁止删除集合
DBCollection.prototype.drop = no;

// 禁止删除索引
DBCollection.prototype.dropIndex = no;
