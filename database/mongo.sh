# *****************************************************************************
# BASICS
# *****************************************************************************


db.getCollectionNames()        # 获取所有表的名字

mongoexport -h ip:port-u username -p passwords -d database  -c collection -o file --type json	        # 导出单个表
mongoimport  -h ip:port  -u username -p passwords -d database  -c collection --file inputFile	        # 导入单个表

mongodump  --db brgz_mixed_cn_cs_001 --port 30000 -u brgzsqlcommon -p brgzcncs001 -c ConditionEntity	# dump数据库
mongorestore -h 127.0.0.1:30000  -u username -p passwords -d database  path	                          # 导入数据，和mongodump 配套


db.stats(1024)	                                                                                      # 数据库 数据和index的大小
db.collection.stats()	                                                                                # 表 数据和index的大小
db.setProfilingLevel(1, 1000);	                                                                      # 0:关闭profile 1：只对大于多少ms的command profile 2：对所有的profile
db.system.profile.find()	                                                                            # 查看profile

# *****************************************************************************
# db.collection.find(query, projection)
# *****************************************************************************

db.collection.find({name:'xx'},{ name: 1, contribs: 1, _id: 0 })          # 基础用法
db.collection.find().sort({weight: -1}).limit(2).skip(1)                  # 分页
db.unicorns.find().count()	                                              # 查询出来的count
db.collection.find().explain("executionStats")                            # profile find语句
# find加入$表达式
db.collection.find({"urlContent":{$exists: true}})                      	# 是否有字段
db.collection.find({diamondsValue:{$gt:500}},{name:1})	                  # 逗号后面，过滤显示字段
db.collection.find({$where:"Object.bsonsize({context:this.context})>21"})	# 看context的size
db.collection.find({"des":{$regex: ".*tex.*"}})	                          # 字符串正则查询
db.collection.find({'family.mother' : Chani})	                            # 查询embeded document，注意key必须加引号


# *****************************************************************************
# db.collection.update(query, update, options)
# *****************************************************************************

update
db.collection.update({},{$set: {field: 590}})	                                  # update document
db.collection.update({},{$push: {field: 'sugar'}})                              # 对loves数组，加'sugar'
db.collection.update({},{$inc: {hits: 1}}, {upsert:true});                      # upsert,有就更新，没有就insert
db.collection.update({cid:'618_023'},{$set:{itemType:3}},{multi:true})	        # 要更新多行，需要指定multi,默认只更新一个

db.PlayerActivity.remove({})
# *****************************************************************************
# db.collection.aggregate(pipeline, options)
# *****************************************************************************
db.collection.aggregate({$match:{"field1":value }},{$group:{_id:'$field2',sum: { $sum: 1 }}})       # 查找field1后，按field2来group。
# 更多的操作符
$unwind                     # 展开数组
$sort                       # 排序


# *****************************************************************************
# db.collection.aggregate(pipeline, options)
# *****************************************************************************
db.collection.getIndexes()	                 # show indexes
db.collection.createIndex({url:1})           # 在url上创建索引，1或者-1
