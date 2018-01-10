import React from 'react'

const CHUNK_SIZE = 1000000

export default class extends React.Component {
  constructor(props) {
    super(props)

    this.processFile = this.processFile.bind(this)
  }

  processFile(event) {
    this.uploadChunk(event.target.files[0], 0)
  }

  uploadChunk(file, chunkIndex) {
    const fileSlice = file.slice(chunkIndex * CHUNK_SIZE, (chunkIndex + 1) * CHUNK_SIZE)
    if (fileSlice.size === 0) return

    const fileReader = new FileReader()
    fileReader.onload = event => {
      const arrayBuffer = event.target.result
      console.log('CHUNK INDEX', chunkIndex, 'CHUNK LENGTH', arrayBuffer.byteLength)
      this.uploadChunk(file, chunkIndex + 1)
    }
    fileReader.readAsArrayBuffer(fileSlice)
  }

  render() {
    return (
      <input type="file" onChange={this.processFile} />
    )
  }
}
