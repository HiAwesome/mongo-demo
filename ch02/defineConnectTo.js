// defineConnectTo.js

/**
 * 连接到指定的数据库，并且将 db 指向这个连接
 *
 * @param port 端口
 * @param dbname 数据库
 * @returns {*}
 */
const connectTo = function (port, dbname) {
    if (!port) {
        port = 27017;
    }

    if (!dbname) {
        dbname = "test";
    }

    db.connect("localhost:" + port + "/" + dbname);
    return db;
};
