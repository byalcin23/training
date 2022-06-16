// Requires official MongoShell 3.6+
db = db.getSiblingDB("vodafone");
db.getCollection("user_data").find(
    { 
        "insert_date" : { 
            "$gte" : ISODate("2022-04-01T14:16:30.228+0000")
        }, 
        "gsm" : { 
            "$ne" : null
        }
    }
);

