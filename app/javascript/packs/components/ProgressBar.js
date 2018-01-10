import React from 'react'
import { connect } from 'react-redux'
import { CHUNK_SIZE } from '../constants'

const ProgressBar = props => (
  <div className="progress">
    <div
      className="progress-bar progress-bar-striped active"
      style={{ width: `${props.percentage}%` }}
    >
    </div>
  </div>
)

const mapStateToProps = state => {
  const { fileSize, chunkIndex } = state.chunkedUpload

  return { percentage: 100 * fileSize / (chunkIndex * CHUNK_SIZE) }
}

export default connect(mapStateToProps)(ProgressBar)
