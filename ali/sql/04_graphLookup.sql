// 图搜索 graphLookup
// 在单个集合中
db.employees.drop()
db.employees.insertMany([
    {"_id": 1, "name": "Dev"},
    {"_id": 2, "name": "Eliot", "reportsTo": "Dev"},
    {"_id": 3, "name": "Ron", "reportsTo": "Eliot"},
    {"_id": 4, "name": "Andrew", "reportsTo": "Eliot"},
    {"_id": 5, "name": "Asya", "reportsTo": "Ron"},
    {"_id": 6, "name": "Dan", "reportsTo": "Andrew"},

])

db.employees.find()

/**
 [
 {
    "_id": 1,
    "name": "Dev",
    "reportingHierarchy": []
  },
 {
    "_id": 2,
    "name": "Eliot",
    "reportingHierarchy": [
      {
        "_id": 1,
        "name": "Dev"
      }
    ],
    "reportsTo": "Dev"
  },
 {
    "_id": 3,
    "name": "Ron",
    "reportingHierarchy": [
      {
        "_id": 1,
        "name": "Dev"
      },
      {
        "_id": 2,
        "name": "Eliot",
        "reportsTo": "Dev"
      }
    ],
    "reportsTo": "Eliot"
  },
 {
    "_id": 4,
    "name": "Andrew",
    "reportingHierarchy": [
      {
        "_id": 1,
        "name": "Dev"
      },
      {
        "_id": 2,
        "name": "Eliot",
        "reportsTo": "Dev"
      }
    ],
    "reportsTo": "Eliot"
  },
 {
    "_id": 5,
    "name": "Asya",
    "reportingHierarchy": [
      {
        "_id": 1,
        "name": "Dev"
      },
      {
        "_id": 3,
        "name": "Ron",
        "reportsTo": "Eliot"
      },
      {
        "_id": 2,
        "name": "Eliot",
        "reportsTo": "Dev"
      }
    ],
    "reportsTo": "Ron"
  },
 {
    "_id": 6,
    "name": "Dan",
    "reportingHierarchy": [
      {
        "_id": 1,
        "name": "Dev"
      },
      {
        "_id": 4,
        "name": "Andrew",
        "reportsTo": "Eliot"
      },
      {
        "_id": 2,
        "name": "Eliot",
        "reportsTo": "Dev"
      }
    ],
    "reportsTo": "Andrew"
  }
 ]
 */
db.employees.aggregate([
    {
        $graphLookup: {
            from: "employees",
            startWith: "$reportsTo",
            connectFromField: "reportsTo",
            connectToField: "name",
            as: "reportingHierarchy"
        }
    }
])

// 横跨多个集合
db.airports.drop()
db.airports.insertMany(
    [{"_id": 0, "airport": "JFK", "connects": ["BOS", "ORD"]},
        {"_id": 1, "airport": "BOS", "connects": ["JFK", "PWM"]},
        {"_id": 2, "airport": "ORD", "connects": ["JFK"]},
        {"_id": 3, "airport": "PWM", "connects": ["BOS", "LHR"]},
        {"_id": 4, "airport": "LHR", "connects": ["PWM"]}]
    )
db.travelers.drop()
db.travelers.insertMany(
    [{"_id": 1, "name": "Dev", "nearestAirport": "JFK"},
        {"_id": 2, "name": "Eliot", "nearestAirport": "JFK"},
        {"_id": 3, "name": "Jeff", "nearestAirport": "BOS"}]
    )

db.airports.find()
db.travelers.find()

/**
 [
 {
    "_id": 1,
    "destinations": [
      {
        "_id": 3,
        "airport": "PWM",
        "connects": ["BOS", "LHR"],
        "numConnections": 2
      },
      {
        "_id": 2,
        "airport": "ORD",
        "connects": ["JFK"],
        "numConnections": 1
      },
      {
        "_id": 0,
        "airport": "JFK",
        "connects": ["BOS", "ORD"],
        "numConnections": 0
      },
      {
        "_id": 1,
        "airport": "BOS",
        "connects": ["JFK", "PWM"],
        "numConnections": 1
      }
    ],
    "name": "Dev",
    "nearestAirport": "JFK"
  },
 {
    "_id": 2,
    "destinations": [
      {
        "_id": 3,
        "airport": "PWM",
        "connects": ["BOS", "LHR"],
        "numConnections": 2
      },
      {
        "_id": 2,
        "airport": "ORD",
        "connects": ["JFK"],
        "numConnections": 1
      },
      {
        "_id": 0,
        "airport": "JFK",
        "connects": ["BOS", "ORD"],
        "numConnections": 0
      },
      {
        "_id": 1,
        "airport": "BOS",
        "connects": ["JFK", "PWM"],
        "numConnections": 1
      }
    ],
    "name": "Eliot",
    "nearestAirport": "JFK"
  },
 {
    "_id": 3,
    "destinations": [
      {
        "_id": 3,
        "airport": "PWM",
        "connects": ["BOS", "LHR"],
        "numConnections": 1
      },
      {
        "_id": 4,
        "airport": "LHR",
        "connects": ["PWM"],
        "numConnections": 2
      },
      {
        "_id": 2,
        "airport": "ORD",
        "connects": ["JFK"],
        "numConnections": 2
      },
      {
        "_id": 0,
        "airport": "JFK",
        "connects": ["BOS", "ORD"],
        "numConnections": 1
      },
      {
        "_id": 1,
        "airport": "BOS",
        "connects": ["JFK", "PWM"],
        "numConnections": 0
      }
    ],
    "name": "Jeff",
    "nearestAirport": "BOS"
  }
 ]
 */
db.travelers.aggregate([
    {
        $graphLookup: {
            from: "airports",
            startWith: "$nearestAirport",
            connectFromField: "connects",
            connectToField: "airport",
            maxDepth: 2,
            depthField: "numConnections",
            as: "destinations"
        }
    }
])

// 使用查询过滤器
db.people.drop()
db.people.insertMany(
    [
        {
            "_id": 1,
            "name": "Tanya Jordan",
            "friends": ["Shirley Soto", "Terry Hawkins", "Carole Hale"],
            "hobbies": ["tennis", "unicycling", "golf"]
        },
        {
            "_id": 2,
            "name": "Carole Hale",
            "friends": ["Joseph Dennis", "Tanya Jordan", "Terry Hawkins"],
            "hobbies": ["archery", "golf", "woodworking"]
        },
        {
            "_id": 3,
            "name": "Terry Hawkins",
            "friends": ["Tanya Jordan", "Carole Hale", "Angelo Ward"],
            "hobbies": ["knitting", "frisbee"]
        },
        {
            "_id": 4,
            "name": "Joseph Dennis",
            "friends": ["Angelo Ward", "Carole Hale"],
            "hobbies": ["tennis", "golf", "topiary"]
        },
        {
            "_id": 5,
            "name": "Angelo Ward",
            "friends": ["Terry Hawkins", "Shirley Soto", "Joseph Dennis"],
            "hobbies": ["travel", "ceramics", "golf"]
        },
        {
            "_id": 6,
            "name": "Shirley Soto",
            "friends": ["Angelo Ward", "Tanya Jordan", "Carole Hale"],
            "hobbies": ["frisbee", "set theory"]
        }
    ]
    )

db.people.find()

/**
 [
 {
    "_id": 1,
    "connections who play golf": ["Tanya Jordan", "Joseph Dennis", "Carole Hale", "Angelo Ward"],
    "friends": ["Shirley Soto", "Terry Hawkins", "Carole Hale"],
    "name": "Tanya Jordan"
  }
 ]
 */
db.people.aggregate([
    {$match: {name: "Tanya Jordan"}},
    {
        $graphLookup: {
            from: "people",
            startWith: "$friends",
            connectFromField: "friends",
            connectToField: "name",
            as: "golfers",
            restrictSearchWithMatch: {"hobbies": "golf"}
        }
    },
    {
        $project: {
            "name": 1,
            "friends": 1,
            "connections who play golf": "$golfers.name"
        }
    }
])