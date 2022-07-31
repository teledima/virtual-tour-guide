const { createLogger, format, transports } = require('winston')

module.exports = createLogger({
    level: 'debug',
    format: format.combine(
        format.timestamp(),
        format.printf((info) => {
            return `${info.timestamp} - [${info.level.toUpperCase().padEnd(7)}]: ${
              info.message
            }`
          }),
        format.colorize({ all: true })
    ),
    transports: [
        new transports.Console(),
    ]
})
