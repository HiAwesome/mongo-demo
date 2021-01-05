// 索引简介
db.users.count()

db.users.find()

db.users.find({username: "user101"})

/**
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": false,
  "parsedQuery": {
    "username": {
      "$eq": "user101"
    }
  },
  "queryHash": "379E82C5",
  "planCacheKey": "379E82C5",
  "winningPlan": {
    "stage": "COLLSCAN",
    "filter": {
      "username": {
        "$eq": "user101"
      }
    },
    "direction": "forward"
  },
  "rejectedPlans": []
}
 */
db.users.find({username: "user101"}).explain()


/**
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": "false",
  "parsedQuery": {
    "username": {
      "$eq": "user101"
    }
  },
  "winningPlan": {
    "stage": "LIMIT",
    "limitAmount": 1,
    "inputStage": {
      "stage": "FETCH",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "username": 1
        },
        "indexName": "username_1",
        "isMultiKey": "false",
        "multiKeyPaths": {
          "username": []
        },
        "isUnique": "false",
        "isSparse": "false",
        "isPartial": "false",
        "indexVersion": 2,
        "direction": "forward",
        "indexBounds": {
          "username": [
            "[\"user101\", \"user101\"]"
          ]
        }
      }
    }
  },
  "rejectedPlans": []
}
 */
db.users.find({username: "user101"}).limit(1).explain()

// 创建索引
db.users.ensureIndex({"username": 1})

db.currentOp()

/**
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": "false",
  "parsedQuery": {
    "username": {
      "$eq": "user101"
    }
  },
  "winningPlan": {
    "stage": "LIMIT",
    "limitAmount": 1,
    "inputStage": {
      "stage": "FETCH",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "username": 1
        },
        "indexName": "username_1",
        "isMultiKey": "false",
        "multiKeyPaths": {
          "username": []
        },
        "isUnique": "false",
        "isSparse": "false",
        "isPartial": "false",
        "indexVersion": 2,
        "direction": "forward",
        "indexBounds": {
          "username": [
            "[\"user101\", \"user101\"]"
          ]
        }
      }
    }
  },
  "rejectedPlans": []
}
 */
db.users.find({username: "user101"}).explain()

// 加了索引之后速度极快
db.users.find({username: "user99999"})

// 复合索引
db.users.ensureIndex({age: 1, username: 1})

// 使用复合索引
db.users.find().sort({age: 1, username: 1}).limit(10)

/**
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": "false",
  "parsedQuery": {},
  "winningPlan": {
    "stage": "LIMIT",
    "limitAmount": 1,
    "inputStage": {
      "stage": "FETCH",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "age": 1,
          "username": 1
        },
        "indexName": "age_1_username_1",
        "isMultiKey": "false",
        "multiKeyPaths": {
          "age": [],
          "username": []
        },
        "isUnique": "false",
        "isSparse": "false",
        "isPartial": "false",
        "indexVersion": 2,
        "direction": "forward",
        "indexBounds": {
          "age": [
            "[MinKey, MaxKey]"
          ],
          "username": [
            "[MinKey, MaxKey]"
          ]
        }
      }
    }
  },
  "rejectedPlans": []
}
 */
db.users.find().sort({age: 1, username: 1}).limit(10).explain()

/** 点查询 point query
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": "false",
  "parsedQuery": {
    "age": {
      "$eq": 21
    }
  },
  "winningPlan": {
    "stage": "LIMIT",
    "limitAmount": 1,
    "inputStage": {
      "stage": "FETCH",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "age": 1,
          "username": 1
        },
        "indexName": "age_1_username_1",
        "isMultiKey": "false",
        "multiKeyPaths": {
          "age": [],
          "username": []
        },
        "isUnique": "false",
        "isSparse": "false",
        "isPartial": "false",
        "indexVersion": 2,
        "direction": "backward",
        "indexBounds": {
          "age": [
            "[21, 21]"
          ],
          "username": [
            "[MaxKey, MinKey]"
          ]
        }
      }
    }
  },
  "rejectedPlans": []
}
 */
db.users.find({age: 21}).sort({username: -1}).explain()

/** 多值查询 multi-value query
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": "false",
  "parsedQuery": {
    "$and": [
      {
        "age": {
          "$lte": 30
        }
      },
      {
        "age": {
          "$gte": 21
        }
      }
    ]
  },
  "winningPlan": {
    "stage": "LIMIT",
    "limitAmount": 1,
    "inputStage": {
      "stage": "FETCH",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "age": 1,
          "username": 1
        },
        "indexName": "age_1_username_1",
        "isMultiKey": "false",
        "multiKeyPaths": {
          "age": [],
          "username": []
        },
        "isUnique": "false",
        "isSparse": "false",
        "isPartial": "false",
        "indexVersion": 2,
        "direction": "forward",
        "indexBounds": {
          "age": [
            "[21, 30]"
          ],
          "username": [
            "[MinKey, MaxKey]"
          ]
        }
      }
    }
  },
  "rejectedPlans": []
}
 */
db.users.find({age: {"$gte": 21, "$lte": 30}}).explain()

/** 使用 hint 来强制 mongoDB 使用某个特定的索引
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": "false",
  "parsedQuery": {
    "$and": [
      {
        "age": {
          "$lte": 30
        }
      },
      {
        "age": {
          "$gte": 21
        }
      }
    ]
  },
  "winningPlan": {
    "stage": "FETCH",
    "inputStage": {
      "stage": "SORT",
      "sortPattern": {
        "username": 1
      },
      "memLimit": 104857600,
      "limitAmount": 1,
      "type": "default",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "age": 1,
          "username": 1
        },
        "indexName": "age_1_username_1",
        "isMultiKey": "false",
        "multiKeyPaths": {
          "age": [],
          "username": []
        },
        "isUnique": "false",
        "isSparse": "false",
        "isPartial": "false",
        "indexVersion": 2,
        "direction": "forward",
        "indexBounds": {
          "age": [
            "[21, 30]"
          ],
          "username": [
            "[MinKey, MaxKey]"
          ]
        }
      }
    }
  },
  "rejectedPlans": []
}
 */
db.users.find({age: {"$gte": 21, "$lte": 30}}).sort({username: 1}).hint({age: 1, username: 1}).explain()

/** 加上 limit，4.4.3 版本的 mongo 的执行计划似乎没什么变化
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": "false",
  "parsedQuery": {
    "$and": [
      {
        "age": {
          "$lte": 30
        }
      },
      {
        "age": {
          "$gte": 21
        }
      }
    ]
  },
  "winningPlan": {
    "stage": "FETCH",
    "inputStage": {
      "stage": "SORT",
      "sortPattern": {
        "username": 1
      },
      "memLimit": 104857600,
      "limitAmount": 1,
      "type": "default",
      "inputStage": {
        "stage": "IXSCAN",
        "keyPattern": {
          "age": 1,
          "username": 1
        },
        "indexName": "age_1_username_1",
        "isMultiKey": "false",
        "multiKeyPaths": {
          "age": [],
          "username": []
        },
        "isUnique": "false",
        "isSparse": "false",
        "isPartial": "false",
        "indexVersion": 2,
        "direction": "forward",
        "indexBounds": {
          "age": [
            "[21, 30]"
          ],
          "username": [
            "[MinKey, MaxKey]"
          ]
        }
      }
    }
  },
  "rejectedPlans": []
}
 */
db.users.find({age: {"$gte": 21, "$lte": 30}}).sort({username: 1}).limit(1000).hint({age: 1, username: 1}).explain()


db.example.insertOne({i: 10})

/** $ne 取反的效率通常较低
 {
  "plannerVersion": 1,
  "namespace": "test.example",
  "indexFilterSet": "false",
  "parsedQuery": {
    "i": {
      "$not": {
        "$eq": 3
      }
    }
  },
  "winningPlan": {
    "stage": "LIMIT",
    "limitAmount": 1,
    "inputStage": {
      "stage": "COLLSCAN",
      "filter": {
        "i": {
          "$not": {
            "$eq": 3
          }
        }
      },
      "direction": "forward"
    }
  },
  "rejectedPlans": []
}
 */
db.example.find({i: {"$ne": 3}}).explain()

// 索引对象和数组
db.users.insertOne(
    {
        "username": "sid",
        "location": {
            "ip": "1.1.1.1",
            "city": "beijing",
            "state": "haidian"
        }
    }
    )

// 建立一个索引嵌套文档
db.users.ensureIndex({"location.city": 1})

db.multi.insertOne({x: [1, 2, 3], y: 1})
db.multi.insertOne({x: 1, y: [4, 5, 6]})
// mongo 4.4.3 可以合法插入这条数据
db.multi.insertOne({x: [1, 2, 3], y: [4, 5, 6]})

/**
 [
 {
    "_id": {"$oid": "5ff47be3f4c81651551e8338"},
    "x": [1, 2, 3],
    "y": 1
  },
 {
    "_id": {"$oid": "5ff47bf6f4c81651551e833a"},
    "x": 1,
    "y": [4, 5, 6]
  },
 {
    "_id": {"$oid": "5ff47c08f4c81651551e833c"},
    "x": [1, 2, 3],
    "y": [4, 5, 6]
  }
 ]
 */
db.multi.find()



















































































































