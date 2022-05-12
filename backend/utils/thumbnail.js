const sharp = require('sharp')
const fs = require('fs')
const path = require('path')
const axios = require('axios')

async function createThumbnail() {
    axios({ url: 'http://192.168.1.44:8080/images/home-kitchen.jpg', responseType: 'arraybuffer'} )
      .then(response => {
          const image = sharp(response.data); 
          image
          .metadata()
          .then(metadata => {
              const width = 2240;
              const height = 1260;
              image
                  .extract({ width, height, left: (metadata.width - width) / 2, top: (metadata.height - height) / 2})
                  .toFile(path.join(__dirname, 'home-kitchen_thumbnail.jpg'))
                  .then(_ => console.log('Success'))
                  .catch(_ => console.log('An error occured'))
          })
  
      })  

}