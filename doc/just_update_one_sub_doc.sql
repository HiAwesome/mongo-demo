// 仅更新一个子文档
//   父文档的 id 作为查询条件或者作为查询条件之一来缩小数据范围
//   子文档的唯一性需要自身的 id 来保证
//   子文档的其他所有字段需要组合成 map 传入


// 第一种方法: 条件中放入点限定，set 中使用仅美元符号
// https://stackoverflow.com/a/30059057
// $  https://docs.mongodb.com/manual/reference/operator/update/positional/?
db.m1.drop()
db.m1.insertOne({_id: 1, a: 1, arr: [{_id: 1, pid: 1, b: 1}, {_id: 2, pid: 1, b: 2}]})
db.m1.findOne()

db.m1.updateOne({_id: 1, "arr._id": 1}, {$set: {"arr.$.b": 10}})
db.m1.findOne()

// 第二种方法: arrayFilters 中放入点限定，set 中用美元加使用的别名
// 也就是说 arr 可以换成其他词，只要保持两端一致即可
// $[<identifier>]  https://docs.mongodb.com/manual/reference/operator/update/positional-filtered/
db.m8.drop()
db.m8.insertOne({_id: 1, a: 1, arr: [{_id: 1, pid: 1, b: 1}, {_id: 2, pid: 1, b: 2}]})
db.m8.findOne()

db.m8.updateOne(
    {_id: 1},
    {$set: {"arr.$[arr].b": 100}},
    {arrayFilters: [{"arr._id": 1}]}
    )
db.m8.findOne()
