const { MongoClient } = require('mongodb')

const { mongo_host, mongo_port, mongo_user, mongo_password, mongo_db } = require('../constants')
const url = `mongodb://${mongo_user}:${mongo_password}@${mongo_host}:${mongo_port}?authMechanism=DEFAULT&authSource=${mongo_db}`

const client = new MongoClient(url)

module.exports = { 
    mongoClient: client,
    tourCollection: client.db(mongo_db).collection('tours'),
    userCollection: client.db(mongo_db).collection('users')
};
