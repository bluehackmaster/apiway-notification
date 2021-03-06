/**
 * @file
 * @copyright
 * @license
 *
 */
var bunyan = require('bunyan')
var Email = require('./email')

let log = bunyan.createLogger({name:'email'})
/* eslint valid-jsdoc: ["error", {"requireReturnDescription": false}] */

class AwNotification {
   constructor() {
     this.TOPIC_PREFIX = 'apiway'
   }

   dispatch (topic, message) {
     log.info(`topic: ${topic}`)
     log.info(`message: ${message}`)

     let service = topic.split("/")[1]

     if (service == 'smtp') {
       this.sendEmail(message)
     } else if (service == 'webhook') {
     } else if (service == 'push') {
     }
   }

   get topic() {
     return `${this.TOPIC_PREFIX}/+`
   }

   sendEmail (data) {
     var email = new Email()
     email.sendEmail(data)
   }
}

module.exports = AwNotification;
