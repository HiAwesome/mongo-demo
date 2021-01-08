// 视图 https://docs.mongodb.com/manual/core/views/index.html
db.survey.drop()
db.survey.insertMany([
    {_id: 1, empNumber: "abc123", feedback: {management: 3, environment: 3}, department: "A"},
    {_id: 2, empNumber: "xyz987", feedback: {management: 2, environment: 3}, department: "B"},
    {_id: 3, empNumber: "ijk555", feedback: {management: 3, environment: 4}, department: "A"}
])

db.survey.find()

db.managementFeedback.drop()
db.createView(
    "managementFeedback",
    "survey",
    [
        {$project: {"management": "$feedback.management", department: 1}}
    ]
    )

show collections

/**
 [
 {
    "_id": 1,
    "department": "A",
    "management": 3
  },
 {
    "_id": 2,
    "department": "B",
    "management": 2
  },
 {
    "_id": 3,
    "department": "A",
    "management": 3
  }
 ]
 */
db.managementFeedback.find()

// 在视图上执行聚合
/**
 [
 {
    "_id": "A",
    "count": 2
  },
 {
    "_id": "B",
    "count": 1
  }
 ]
 */
db.managementFeedback.aggregate([{$sortByCount: "$department"}])

// 从多个集合创建视图
db.orders.drop()
db.orders.insertMany([
    {"_id": 1, "item": "abc", "price": NumberDecimal("12.00"), "quantity": 2},
    {"_id": 2, "item": "jkl", "price": NumberDecimal("20.00"), "quantity": 1},
    {"_id": 3, "item": "abc", "price": NumberDecimal("10.95"), "quantity": 5},
    {"_id": 4, "item": "xyz", "price": NumberDecimal("5.95"), "quantity": 5},
    {"_id": 5, "item": "xyz", "price": NumberDecimal("5.95"), "quantity": 10}
])
db.orders.find()

db.inventory.drop()
db.inventory.insertMany([
    {"_id": 1, "sku": "abc", description: "product 1", "instock": 120},
    {"_id": 2, "sku": "def", description: "product 2", "instock": 80},
    {"_id": 3, "sku": "ijk", description: "product 3", "instock": 60},
    {"_id": 4, "sku": "jkl", description: "product 4", "instock": 70},
    {"_id": 5, "sku": "xyz", description: "product 5", "instock": 200}
])
db.inventory.find()

db.orderDetails.drop()
db.createView(
    "orderDetails",
    "orders",
    [
        {$lookup: {from: "inventory", localField: "item", foreignField: "sku", as: "inventory_docs"}},
        {$project: {"inventory_docs._id": 0, "inventory_docs.sku": 0}}
    ]
    )

/**
 [
 {
    "_id": 1,
    "inventory_docs": [
      {
        "description": "product 1",
        "instock": 120
      }
    ],
    "item": "abc",
    "price": {"$numberDecimal": "12.00"},
    "quantity": 2
  },
 {
    "_id": 2,
    "inventory_docs": [
      {
        "description": "product 4",
        "instock": 70
      }
    ],
    "item": "jkl",
    "price": {"$numberDecimal": "20.00"},
    "quantity": 1
  },
 {
    "_id": 3,
    "inventory_docs": [
      {
        "description": "product 1",
        "instock": 120
      }
    ],
    "item": "abc",
    "price": {"$numberDecimal": "10.95"},
    "quantity": 5
  },
 {
    "_id": 4,
    "inventory_docs": [
      {
        "description": "product 5",
        "instock": 200
      }
    ],
    "item": "xyz",
    "price": {"$numberDecimal": "5.95"},
    "quantity": 5
  },
 {
    "_id": 5,
    "inventory_docs": [
      {
        "description": "product 5",
        "instock": 200
      }
    ],
    "item": "xyz",
    "price": {"$numberDecimal": "5.95"},
    "quantity": 10
  }
 ]
 */
db.orderDetails.find()

// 在视图上执行聚合
/**
 [
 {
    "_id": "abc",
    "count": 2
  },
 {
    "_id": "xyz",
    "count": 2
  },
 {
    "_id": "jkl",
    "count": 1
  }
 ]
 */
db.orderDetails.aggregate([{$sortByCount: "$item"}])

// 使用默认语言规则创建视图
// collation: https://docs.mongodb.com/manual/reference/bson-type-comparison-order/#collation
db.places.drop()
db.places.insertMany(
    [
        {_id: 1, category: "café"},
        {_id: 2, category: "cafe"},
        {_id: 3, category: "cafE"}
    ]
    )
db.places.find()


db.placesView.drop()
db.createView(
    "placesView",
    "places",
    [
        {$project: {category: 1}}
    ],
    {collation: {locale: "fr", strength: 1}}
    )

// 3
db.placesView.count({category: "cafe"})

