// 查询内嵌文档
db.people.insertOne({name: {first: 'joe', last: 'smith'}})

db.people.findOne({name: {first: 'joe', last: 'smith'}})

db.people.find({name: {last: 'smith', first: 'joe'}})

db.people.find({"name.first": "joe", "name.last": "smith"})

db.people.find({"name.last": "smith", "name.first": "joe"})

db.blog.find()

db.blog.insertOne(
    {
        "content": "...",
        "comments": [{"author": "joe", "score": 3, "comment": "nice post"}, {
            "author": "mary",
            "score": 6,
            "comment": "terrible post"
        }

        ]

    }
    )

db.blog.findOne()

db.blog.find({"comments": {"author": "joe", "score": {"$gte": 5}}})

db.blog.findOne({"comments.author": "joe", "comments.score": {"$gte": 5}})

db.blog.findOne({"comments": {"$elemMatch": {"author": "joe", "score": {"$lt": 5}}}})

db.foo.insertOne({"apple": 1, "banana": 6, "peach": 3})
db.foo.insertOne({"apple": 8, "spinach": 4, "watermelon": 4})

// IDEA 的 mongo 插件报错 java.lang.Exception: MongoshUnimplementedError: 'for in' and 'for of' statements are not supported at this time.
// 命令行可以运行成功
db.foo.find({
    "$where": function () {
        for (var current in this) {
            for (var other in this) {
                if (current !== other && this[current] === this[other]) {
                    return true;
                }
            }
        }
        return false;
    }
});



