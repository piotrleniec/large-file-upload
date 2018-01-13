import * as actionTypes from '../actionTypes'

const initialState = {
  fileSize: null,
  chunkIndex: null,
  uploadedBytes: 0
}

export default (state = initialState, { type, payload }) => {
  switch (type) {
  case actionTypes.INITIATE_UPLOAD:
    return { fileSize: payload.fileSize, chunkIndex: 0 }
  case actionTypes.INCREMENT_CHUNK_INDEX:
    return { fileSize: state.fileSize, chunkIndex: state.chunkIndex + 1 }
  case actionTypes.SET_FILE_SIZE:
    return { ...state, fileSize: payload.fileSize }
  case actionTypes.ADD_UPLOADED_BYTES:
    return { ...state, uploadedBytes: state.uploadedBytes + payload.bytes }
  default:
    return state
  }
}
