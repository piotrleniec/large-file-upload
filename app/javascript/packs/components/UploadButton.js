import React from 'react'
import { connect } from 'react-redux'
import uploadFile from '../actions/uploadFile'

const UploadButton = props => (
  <input type="file" onChange={props.uploadFile} />
)

const mapDispatchToProps = dispatch => ({
  uploadFile: event => { dispatch(uploadFile(event.target.files[0])) }
})

export default connect(null, mapDispatchToProps)(UploadButton)
