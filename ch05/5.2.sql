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

// fixme 书中以 mongo 2.3 为基础进行讲解，大多数 explain() 内容已不具有实际参考性
// 阅读仅需关注想法和内容组织结构
// 实际操作部分参考中文文档跟进: https://docs.mongoing.com/



















































































































































































































































