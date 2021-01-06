// elemMatch  https://docs.mongodb.com/manual/reference/operator/query/elemMatch/
db.scores.drop()
db.scores.insertMany(
    [
        {_id: 1, results: [82, 85, 88]},
        {_id: 2, results: [75, 88, 89]}
    ]
    )

// 因为 82 满足条件所以匹配到这一条
db.scores.find(
    {results: {$elemMatch: {$gte: 80, $lt: 85}}}
    )


db.survey4.drop()
db.survey4.insertMany([
    {
        _id: 1, results: [{"product": "abc", "score": 10},
            {"product": "xyz", "score": 5}]
    },
    {
        _id: 2, results: [{"product": "abc", "score": 8},
            {"product": "xyz", "score": 7}]
    },
    {
        _id: 3, results: [{"product": "abc", "score": 7},
            {"product": "xyz", "score": 8}]
    },
    {
        _id: 4, results: [{"product": "abc", "score": 7},
            {"product": "def", "score": 8}]
    }
])

db.survey4.find()

// 只有 {"product": "xyz", "score": 8} 满足
db.survey4.find(
    {results: {$elemMatch: {product: "xyz", score: {$gte: 8}}}}
    )


// 不包含 $not $ne 时两种查询结果相同
db.survey4.find(
    {results: {$elemMatch: {product: "xyz"}}}
    )

db.survey4.find({"results.product": "xyz"})


// 包含 $not $ne 时两种查询结果不同
db.survey4.find({results: {$elemMatch: {product: {$ne: "xyz"}}}})

db.survey4.find({"results.product": {$ne: "xyz"}})

