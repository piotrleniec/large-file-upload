import React from 'react'
import { connect } from 'react-redux'

const Link = props => (
  <div>
    You can download you file <a href={props.path} download>here</a>.
  </div>
)

const mapStateToProps = state => ({
  path: state.chunkedUpload.path
})

export default connect(mapStateToProps)(Link)
