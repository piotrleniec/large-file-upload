import initiateUpload from './initiateUpload'
import uploadChunk from './uploadChunk'

export default file => (dispatch, getState) => {
  if (getState().chunkedUpload.fileSize !== null) return

  dispatch(initiateUpload(file.size))
  dispatch(uploadChunk(file))
}
