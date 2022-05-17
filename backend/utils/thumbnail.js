const sharp = require('sharp')
const fs = require('fs')
const path = require('path')
const axios = require('axios')

async function createThumbnail(buffer) {
    const image = sharp(buffer); 
    const width = 2240;
    const height = 1260;
    
    const metadata = await image.metadata();
    if (metadata.width < width || metadata.height < height)
        throw Error('Small size');
    return image
      .extract({ width, height, left: (metadata.width - width) / 2, top: (metadata.height - height) / 2})
      .toBuffer()
}

module.exports = createThumbnail;