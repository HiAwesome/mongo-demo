// unwind
db.students.insertOne({
    name: "张三",
    score: [
        {subject: "语文", score: 84},
        {subject: "数学", score: 90},
        {subject: "英语", score: 69},
    ]
})

/** 拆分
 [
 {
    "_id": {"$oid": "5ff85d77c7f04113c0662df8"},
    "name": "张三",
    "score": {
      "subject": "语文",
      "score": 84
    }
  },
 {
    "_id": {"$oid": "5ff85d77c7f04113c0662df8"},
    "name": "张三",
    "score": {
      "subject": "数学",
      "score": 90
    }
  },
 {
    "_id": {"$oid": "5ff85d77c7f04113c0662df8"},
    "name": "张三",
    "score": {
      "subject": "英语",
      "score": 69
    }
  }
 ]
 */
db.students.aggregate([
    {$unwind: '$score'}
])

/** 拆分，排序
 [
 {
    "_id": {"$oid": "5ff85d77c7f04113c0662df8"},
    "name": "张三",
    "score": {
      "subject": "数学",
      "score": 90
    }
  },
 {
    "_id": {"$oid": "5ff85d77c7f04113c0662df8"},
    "name": "张三",
    "score": {
      "subject": "语文",
      "score": 84
    }
  },
 {
    "_id": {"$oid": "5ff85d77c7f04113c0662df8"},
    "name": "张三",
    "score": {
      "subject": "英语",
      "score": 69
    }
  }
 ]
 */
db.students.aggregate([
    {$unwind: '$score'},
    {$sort: {name: 1, "score.score": -1}}
])
