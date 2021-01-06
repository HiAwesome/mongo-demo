// 使用 explain() 和 hint()

/**
 {
  "plannerVersion": 1,
  "namespace": "test.users",
  "indexFilterSet": "false",
  "parsedQuery": {
    "age": {
      "$eq": 42
    }
  },
  "winningPlan": {
    "stage": "LIMIT",
    "limitAmount": 1,
    "inputStage": {
      "stage": "COLLSCAN",
      "filter": {
        "age": {
          "$eq": 42
        }
      },
      "direction": "forward"
    }
  },
  "rejectedPlans": []
}
 */
db.users.find({"age": 42}).explain()
