// addToSet  https://docs.mongodb.com/manual/reference/operator/update/addToSet/
db.colors.drop()
db.colors.find()

db.colors.updateOne(
    {"_id": ObjectId("5ff55835aedeb65eb242caba")},
    {$addToSet: {colors: "blank"}}
    )

db.colors.findOne({"_id": ObjectId("5ff55835aedeb65eb242caba")})


db.letters.insertOne(
    {_id: 1, letters: ["a", "b"]}
    )

db.letters.updateOne(
    {_id: 1},
    {$addToSet: {letters: ["c", "d"]}}
    )

db.letters.findOne()


db.inventory.insertOne(
    {_id: 1, item: "polarizing_filter", tags: ["electronics", "camera"]}
    )

db.inventory.updateOne(
    {_id: 1},
    {$addToSet: {tags: "accessories"}}
    )

db.inventory.findOne()

db.inventory.updateOne(
    {"_id": 1},
    {$addToSet: {tags: "camera"}}
    )

db.inventory.findOne()


db.inventory.insertOne(
    {_id: 2, item: "cable", tags: ["electronics", "supplies"]}
    )


db.inventory.updateOne(
    {_id: 2},
    {$addToSet: {tags: {$each: ["camera", "electronics", "accessories"]}}}
    )

db.inventory.findOne({_id: 2})
