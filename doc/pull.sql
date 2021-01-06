// pull  https://docs.mongodb.com/manual/reference/operator/update/pull/
db.stores.drop()
db.stores.insertMany(
    [
        {
            _id: 1,
            fruits: ["apples", "pears", "oranges", "grapes", "bananas"],
            vegetables: ["carrots", "celery", "squash", "carrots"]
        },
        {
            _id: 2,
            fruits: ["plums", "kiwis", "oranges", "bananas", "apples"],
            vegetables: ["broccoli", "zucchini", "carrots", "onions"]
        }
    ]
    )

db.stores.find()

// IDEA 执行失败，命令行执行成功
db.stores.updateMany(
    {},
    {$pull: {fruits: {$in: ["apples", "oranges"]}, vegetables: "carrots"}},
    {multi: true}
    )

db.stores.find()

db.profiles.drop()
db.profiles.insertOne({_id: 1, votes: [3, 5, 6, 7, 7, 8]})

db.profiles.findOne()

db.profiles.updateOne({_id: 1}, {$pull: {votes: {$gte: 6}}})

db.profiles.findOne()


db.survey.drop()
db.survey.insertMany(
    [
        {
            _id: 1,
            results: [
                {item: "A", score: 5},
                {item: "B", score: 8, comment: "Strongly agree"}
            ]
        },
        {
            _id: 2,
            results: [
                {item: "C", score: 8, comment: "Strongly agree"},
                {item: "B", score: 4}
            ]
        }
    ]
    )

db.survey.find()

// IDEA 执行失败，命令行执行成功
db.survey.updateMany(
    {},
    {$pull: {results: {score: 8, item: "B"}}},
    {multi: true}
    )

db.survey1.drop()
db.survey1.insertMany(
    [
        {
            _id: 1,
            results: [
                {item: "A", score: 5},
                {item: "B", score: 8, comment: "Strongly agree"}
            ]
        },
        {
            _id: 2,
            results: [
                {item: "C", score: 8, comment: "Strongly agree"},
                {item: "B", score: 4}
            ]
        }
    ]
    )

db.survey1.find()

// 因为 elemMatch 要求完全匹配，但是复合要求的数据 {item: "B", score: 8, comment: "Strongly agree"} 中里面含有 comment 这个 kv
// 所以这个操作不会移除任何内容
// IDEA 执行失败，命令行执行成功
db.survey1.updateMany(
    {},
    {$pull: {results: {$elemMatch: {score: 8, item: "B"}}}},
    {multi: true}
    )


db.survey3.drop()
db.survey3.insertMany(
    [
        {
            _id: 1,
            results: [
                {item: "A", score: 5, answers: [{q: 1, a: 4}, {q: 2, a: 6}]},
                {item: "B", score: 8, answers: [{q: 1, a: 8}, {q: 2, a: 9}]}
            ]
        },
        {
            _id: 2,
            results: [
                {item: "C", score: 8, answers: [{q: 1, a: 8}, {q: 2, a: 7}]},
                {item: "B", score: 4, answers: [{q: 1, a: 0}, {q: 2, a: 8}]}
            ]
        }
    ]
    )

db.survey3.find()

// 因为 elemMatch 要求完全匹配，所以含有 {q: 2, a: 9} 和 {q: 2, a: 8} 的 retults 里的条目被移除
// IDEA 执行失败，命令行执行成功
db.survey3.updateMany(
    {},
    {$pull: {results: {answers: {$elemMatch: {q: 2, a: {$gte: 8}}}}}},
    {multi: true}
    )

db.survey3.find()
