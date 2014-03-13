
    # add query
    ./local/ruby-2.1/bin/norikra-client query add order_logs.price_10s 'select count(*) as cnt, sum(price) as total_price, avg(price) as avg_price from order_logs.win:time_batch(10 sec)'
    ./local/ruby-2.1/bin/norikra-client query add order_logs.price_10s_user 'select user, count(*) as cnt, sum(price) as total_price, avg(price) as avg_price from order_logs.win:time_batch(10 sec) group by user'

    # add log
    echo '{"user":"user1", "price":1000}' |./local/ruby-2.1/bin/fluent-cat data.order_logs
    echo '{"user":"user1", "price":3000}' |./local/ruby-2.1/bin/fluent-cat data.order_logs
    echo '{"user":"user2", "price":4000}' |./local/ruby-2.1/bin/fluent-cat data.order_logs
    echo '{"user":"user3", "price":10000}' |./local/ruby-2.1/bin/fluent-cat data.order_logs
    echo '{"user":"user5", "price":1500}' |./local/ruby-2.1/bin/fluent-cat data.order_logs
    echo '{"user":"user2", "price":70000}' |./local/ruby-2.1/bin/fluent-cat data.order_logs
    echo '{"user":"user3", "price":100000}' |./local/ruby-2.1/bin/fluent-cat data.order_logs

    # mongo
    mongo
    > show dbs
    local   0.078125GB
    norikra 0.515625GB
    > use norikra
    switched to db norikra
    > show collections
    order_logs.price_10s
    order_logs.price_10s_user
    system.indexes
    > db.order_logs.price_10s.find()
    { "_id" : ObjectId("532145889e1a30068400000d"), "cnt" : 7, "avg_price" : 27071.428571428572, "total_price" : 189500, "time" : ISODate("2014-03-13T05:43:07Z") }
