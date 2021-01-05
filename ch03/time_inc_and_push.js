// time_inc_and_push.js

/**
 * 原地更新与文档移动的速度差别
 * /Users/moqi/Code/mongo-demo/ch03/time_inc_and_push.js
 * 4.4 版本看起来区别不大
 *
 * Created by moqi
 * On 1/5/21 10:51
 */

/**
 * Inc Updates took: 34472ms
 */
var timeInc = function () {
    var start = (new Date()).getTime()

    for (var i = 0; i < 100000; i++) {
        db.tester.update({}, {"$inc":{"x":1}});
        db.getLastError();
    }

    var timeDiff = (new Date()).getTime() - start
    print("Inc Updates took: " + timeDiff + "ms");
}

/**
 * Push Updates took: 33968ms
 */
var timePush = function () {
    var start = (new Date()).getTime()

    for (var i = 0; i < 100000; i++) {
        db.tester.update({}, {"$inc":{"x":1}});
        db.getLastError();
    }

    var timeDiff = (new Date()).getTime() - start
    print("Push Updates took: " + timeDiff + "ms");
}

