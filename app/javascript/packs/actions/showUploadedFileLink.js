import * as actionTypes from '../actionTypes'

export default path => ({
  type: actionTypes.SHOW_UPLOADED_FILE_LINK,
  payload: { path }
})
