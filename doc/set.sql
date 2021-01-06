// set  https://docs.mongodb.com/manual/reference/operator/update/set/
db.products.drop()
db.products.insertOne(
    {
        _id: 100,
        sku: "abc123",
        quantity: 250,
        instock: true,
        reorder: false,
        details: {model: "14Q2", make: "xyz"},
        tags: ["apparel", "clothing"],
        ratings: [{by: "ijk", rating: 4}]
    }
    )

db.products.findOne()

db.products.updateOne(
    {_id: 100},
    {
        $set: {
            quantity: 500,
            details: {model: "14Q3", make: "xyz"},
            tags: ["coats", "outerwear", "clothing"]
        }
    }
    )

db.products.findOne()

db.products.updateOne(
    {_id: 100},
    {$set: {"details.make": "zzz"}}
    )

db.products.findOne()

db.products.updateOne(
    {_id: 100},
    {
        $set: {
            "tags.1": "rain gear",
            "ratings.0.rating": 2
        }
    }
    )

db.products.findOne()
