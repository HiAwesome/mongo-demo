use test

// insertOne
db.products.insertOne({item: "card", qty: 15})
// insertMany
db.products.insertMany(
    [
        {
            _id: 10,
            item: "large box",
            qty: 20
        },
        {
            _id: 11,
            item: "small box",
            qty: 55
        },
        {
            _id: 12,
            item: "medium box",
            qty: 30
        }
    ]
    )

db.movies.insertMany(
    [
        {year: 1989, title: "Batman", category: "action"},
        {year: 1994, title: "The Shawshank Redemption", category: "action"},
        {year: 1994, title: "Forrest Gump", category: "person"},
    ]
    )

db.movies.insertMany(
    [
        {
            "title": "Batman", "category": ["action", "adventure"], "imdb_rating": 7.6, "budget": 35
        },
        {
            "title": "Godzilla", "category": ["action", "adventure", "sci-fi"], "imdb_rating": 6.6
        },
        {
            "title": "Home Alone", "category": ["family", "comedy"], "imdb_rating": 7.4
        }
    ])

// find
// all
db.movies.find()
// 单条件
db.movies.find({year: 1989})
// 多条件 and
db.movies.find({year: 1994, title: "Forrest Gump"})
// 多添件 or
db.movies.find({$or: [{year: 1989}, {category: "action"}]})
// 正则查找
db.movies.find({title: /^B/})

// update
// updateOne
db.movies.updateMany({year: 1994}, {$set: {"comment": "fancy movie year"}})
// updateMany
db.movies.updateMany({title: "Batman"}, {$set: {"imdb_rating": 7.7}})
// upsert: true 参数：不存在就插入一条新数据，默认 false
db.movies.updateOne({title: "Jaws"}, {$inc: {budget: 5}}, {upsert: true})

// deleteOne
db.products.deleteOne({item: "card"})
// deleteMany
db.products.deleteMany({qty: {$gte: 30}})

db.products.find()

// drop
db.products.drop()

show collections

use tempDB

db.dropDatabase()

show dbs

show collections
