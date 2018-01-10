import * as actionTypes from '../actionTypes'

export default fileSize => ({
  type: actionTypes.INITIATE_UPLOAD,
  payload: { fileSize }
})
