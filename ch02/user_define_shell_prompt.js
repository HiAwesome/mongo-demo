// user_define_shell_prompt.js

/**
 * 定制 shell 提示
 * 可以将 prompt 函数放在 .mongorc.js 中
 * 或者将 prompt 函数粘贴到 mongo shell 中即可
 *
 * Created by moqi
 * On 1/4/21 15:56
 */

/**
 * 显示 shell 时间
 *
 * @returns {string}
 */
prompt = function () {
    return (new Date()) + "> ";
}

/**
 * 显示当前使用的数据库
 *
 * @returns {string}
 */
prompt = function () {
    if (typeof db == 'undefined') {
        return '(nodb)> ';
    }

    // 检查最后的数据库操作
    try {
        db.runCommand({getLastError: 1});
    } catch (e) {
        print(e);
    }

    return db + "> ";
}
