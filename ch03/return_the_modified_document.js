// return_the_modified_document.js

/**
 * 返回被更新的文档 代码练习
 *
 * Created by moqi
 * On 1/5/21 11:21
 */
/**
 * 不是很好的算法，可能会导致竞态条件：两个线程会运行相同的处理过程
 */
var returnTheModifiedDocumentV1 = function () {
    var cursor = db.processes.find({"status": "READY"});
    ps = cursor.sort({"priority": -1}).limit(1).next();
    db.processes.update({"_id": ps._id}, {"$set": {"status": "RUNNING"}});
    do_something(ps);
    db.processes.update({"_id": ps._id}, {"$set": {"status": "DONE"}})
}

/**
 * 这样也有问题，因为有先有后，所以可能会造成活锁
 */
var returnTheModifiedDocumentV2 = function () {
    var cursor = db.processes.find({"status": "READY"});
    cursor.sort({"priority": -1}).limit(1);
    while ((ps = cursor.next()) != null) {
        ps.update({"_id": ps._id, "status": "READY"}, {"$set": {"status": "RUNNING"}});
        var lastOp = db.runCommand({getLastError: 1});
        if (lastOp === 1) {
            do_something(ps);
            db.processes.update({"_id": ps._id}, {"$set": {"status": "DONE"}})
            break;
        }
        cursor = db.processes.find({"status": "READY"});
        cursor.sort({"priority": -1}).limit(1);
    }
}

// 最终解决方案：findAndModify，它能够在一个操作中返回匹配结果并且进行更新

