const minio = require('minio')

const { minio_host, minio_port, minio_access_key, minio_secret_key } = require('../constants')

const minioClient = new minio.Client({
    endPoint: minio_host,
    port: minio_port,
    useSSL: false,
    accessKey: minio_access_key,
    secretKey: minio_secret_key
})

module.exports = minioClient;