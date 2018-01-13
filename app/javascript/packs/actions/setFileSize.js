import * as actionTypes from '../actionTypes'

export default fileSize => ({
  type: actionTypes.SET_FILE_SIZE,
  payload: { fileSize }
})
