import React from 'react'
import { connect } from 'react-redux'

const ProgressBar = props => (
  <div className="progress">
    <div
      className="progress-bar progress-bar-striped active"
      style={{ width: `${100 * (props.uploadedBytes / props.fileSize)}%` }}
    >
    </div>
  </div>
)

const mapStateToProps = state => ({
  fileSize: state.chunkedUpload.fileSize,
  uploadedBytes: state.chunkedUpload.uploadedBytes
})

export default connect(mapStateToProps)(ProgressBar)
