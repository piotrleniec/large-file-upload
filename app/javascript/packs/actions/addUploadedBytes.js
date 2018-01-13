import * as acionTypes from '../actionTypes'

export default bytes => ({
  type: acionTypes.ADD_UPLOADED_BYTES,
  payload: { bytes }
})
