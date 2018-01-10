import * as actionTypes from '../actionTypes'

const initialState = {
  fileSize: null,
  chunkIndex: null,
}

export default (state = initialState, { type, payload }) => {
  switch (type) {
  case actionTypes.INITIATE_UPLOAD:
    return { fileSize: payload.fileSize, chunkIndex: 0 }
  case actionTypes.INCREMENT_CHUNK_INDEX:
    return { fileSize: state.fileSize, chunkIndex: state.chunkIndex + 1 }
  default:
    return state
  }
}
