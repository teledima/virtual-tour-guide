const { MongoClient } = require('mongodb')
const db_user = process.env.MONGO_USER || 'test'
const db_password = process.env.MONGO_PASSWORD || 'test'
const db_name = process.env.MONGO_DATABASE || 'virtual_tour'
const db_url = process.env.DB_URL || 'localhost:27017'
const url = `mongodb://${db_user}:${db_password}@${db_url}?authMechanism=DEFAULT&authSource=${db_name}`

module.exports = { 
    mongoClient: new MongoClient(url), db_name 
};