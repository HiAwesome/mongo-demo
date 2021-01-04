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
