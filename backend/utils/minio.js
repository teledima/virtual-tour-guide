const minio = require('minio')

const minioClient = new minio.Client({
    endPoint: 'localhost',
    port: 9000,
    useSSL: false,
    accessKey: 'minio',
    secretKey: 'minio-admin'
})

module.exports = minioClient;