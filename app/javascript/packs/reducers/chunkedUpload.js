import * as actionTypes from '../actionTypes'

const initialState = {
  fileSize: null,
  uploadedBytes: 0,
  path: null
}

export default (state = initialState, { type, payload }) => {
  switch (type) {
  case actionTypes.SET_FILE_SIZE:
    return { ...state, fileSize: payload.fileSize }
  case actionTypes.ADD_UPLOADED_BYTES:
    return { ...state, uploadedBytes: state.uploadedBytes + payload.bytes }
  case actionTypes.SHOW_UPLOADED_FILE_LINK:
    return { ...state, path: payload.path }
  default:
    return state
  }
}
