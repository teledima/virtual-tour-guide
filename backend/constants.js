module.exports = {
    server_port: Number.parseInt(process.env.SERVER_PORT || 8080),
    jwt_secret: process.env.JWT_SECRET || 'secret',
    salt_length: Number.parseInt(process.env.SALT_LENGTH || 10),
    minio_host: process.env.MINIO_HOST || 'localhost',
    minio_port: Number.parseInt(process.env.MINIO_PORT || 9000),
    minio_access_key: process.env.MINIO_ACCESS_KEY || 'minio',
    minio_secret_key: process.env.MINIO_SECRET_KEY || 'minio',
    mongo_host: process.env.MONGO_HOST || 'localhost',
    mongo_port: Number.parseInt(process.env.MONGO_PORT || 27017),
    mongo_user: process.env.MONGO_USER || 'mongo',
    mongo_password: process.env.MONGO_PASSWORD || 'mongo',
    mongo_db: process.env.MONGO_DB || 'mongo'
}
