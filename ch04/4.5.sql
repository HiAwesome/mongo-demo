// 游标

// 随机选取文档
db.people.insertMany([
    {"name":"tom", "random": Math.random()},
    {"name":"tom", "random": Math.random()},
    {"name":"tom", "random": Math.random()}
]);

db.people.find({"name":"tom"});

db.people.findOne({"random": {"$gt" : Math.random()}});

db.people.findOne({"random": {"$lt" : Math.random()}});

// 高级查询选项

// $showDiskLoc: https://docs.mongodb.com/manual/reference/operator/meta/showDiskLoc/
// IDEA 报错，已提交 bug，命令行运行正常
db.foo.find()._addSpecial('$showDiskLoc', true);



