/**
 * 生成数据工具
 *
 * Created by moqi
 * On 2021/1/5 22:03:37
 */
var createUsersData = function () {
    db.users.drop()
    for (i = 0; i < 100000; i++) {
        db.users.insert(
            {
                "i": i,
                "username": "user" + i,
                "age": Math.floor(Math.random() * 120),
                "created": new Date()
            }
        )
    }
}

