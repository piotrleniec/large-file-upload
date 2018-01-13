import React from 'react'
import { connect } from 'react-redux'
import UploadButton from './UploadButton'
import ProgressBar from './ProgressBar'
import './App.scss'

const App = props => (
  <div className="row">
    <div className="col-xs-offset-4 col-xs-4">
      <div className="panel panel-primary">
        <div className="panel-body">
          {props.fileSize ? <ProgressBar /> : <UploadButton />}
        </div>
      </div>
    </div>
  </div>
)

const mapStateToProps = state => ({
  fileSize: state.chunkedUpload.fileSize
})

export default connect(mapStateToProps)(App)
