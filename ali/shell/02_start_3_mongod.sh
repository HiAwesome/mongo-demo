#!/bin/zsh

# 启动三个 MongoDB 服务
# 由于 27017 端口已被 brew 默认启动占用，以 27018 开始
mongod --replSet rs --dbpath ./../mongoRs/rs1 --port 27018 --fork --logpath ./../mongoRs/rs1/mongod.log

mongod --replSet rs --dbpath ./../mongoRs/rs2 --port 27019 --fork --logpath ./../mongoRs/rs2/mongod.log

mongod --replSet rs --dbpath ./../mongoRs/rs3 --port 27020 --fork --logpath ./../mongoRs/rs3/mongod.log
echo "start 3 mongod success"

# 连接方式
# mongo --port 27018
