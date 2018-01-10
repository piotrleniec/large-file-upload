import incrementChunkIndex from './incrementChunkIndex'

const CHUNK_SIZE = 1000000

const uploadChunk = file => (dispatch, getState) => {
  const { chunkIndex } = getState().chunkedUpload
  const fileSlice = file.slice(chunkIndex * CHUNK_SIZE, (chunkIndex + 1) * CHUNK_SIZE)
  if (fileSlice.size === 0) return

  const fileReader = new FileReader()
  fileReader.onload = event => {
    const arrayBuffer = event.target.result
    console.log('CHUNK INDEX', chunkIndex, 'CHUNK LENGTH', arrayBuffer.byteLength)
    dispatch(incrementChunkIndex())
    dispatch(uploadChunk(file))
  }
  fileReader.readAsArrayBuffer(fileSlice)
}

export default uploadChunk
