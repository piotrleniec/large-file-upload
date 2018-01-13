import * as actionTypes from '../actionTypes'

const initialState = {
  fileSize: 1,
  uploadedBytes: 0
}

export default (state = initialState, { type, payload }) => {
  switch (type) {
  case actionTypes.SET_FILE_SIZE:
    return { ...state, fileSize: payload.fileSize }
  case actionTypes.ADD_UPLOADED_BYTES:
    return { ...state, uploadedBytes: state.uploadedBytes + payload.bytes }
  default:
    return state
  }
}
