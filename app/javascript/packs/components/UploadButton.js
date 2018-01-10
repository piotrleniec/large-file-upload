import React from 'react'
import { connect } from 'react-redux'
import startUpload from '../actions/startUpload'

const UploadButton = props => (
  <input type="file" onChange={props.startUpload} />
)

const mapDispatchToProps = dispatch => ({
  startUpload: event => { dispatch(startUpload(event.target.files[0])) }
})

export default connect(null, mapDispatchToProps)(UploadButton)
