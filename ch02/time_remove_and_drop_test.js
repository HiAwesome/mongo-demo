// time_remove_and_drop_test.js

/**
 * remove vs drop 速度测试
 * load('/Users/moqi/Code/mongo-demo/ch02/time_remove_and_drop_test.js')
 *
 * Created by moqi
 * On 1/4/21 16:40
 */
/**
 * 创建一百万条数据的集合
 *
 * 插入数据大概需要五分钟
 * Mon Jan 04 2021 16:47:43 GMT+0800 (CST)> createSpeedData()
 * Mon Jan 04 2021 16:52:11 GMT+0800 (CST)>
 */
var createSpeedData = function () {
    for (var i = 0; i < 1000000; i++) {
        db.tester.insert({"foo": "bar", "baz": i, "z": 10 - i})
    }
}

/**
 * 使用 remove 命令移除一百万数据
 *
 * 移除数据大概需要 210 秒
 * Mon Jan 04 2021 16:52:11 GMT+0800 (CST)> timeRemoves()
 * Remove took: 21769ms
 */
var timeRemoves = function () {
    var start = (new Date()).getTime();

    db.tester.remove({});
    db.tester.findOne(); // make sure the remove finishes before continuing

    var timeDiff = (new Date()).getTime() - start;
    print("Remove took: " + timeDiff + "ms")
}

/**
 * 使用 drop 命令移除一百万数据
 *
 * 移除数据大概需要 0.055 秒
 * Mon Jan 04 2021 17:02:20 GMT+0800 (CST)> timeDrops()
 * Drop took: 55ms
 */
var timeDrops = function () {
    var start = (new Date()).getTime();

    db.tester.drop();
    db.tester.findOne(); // make sure the remove finishes before continuing

    var timeDiff = (new Date()).getTime() - start;
    print("Drop took: " + timeDiff + "ms")
}