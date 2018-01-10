import React from 'react'
import UploadButton from './UploadButton'
import ProgressBar from './ProgressBar'
import './App.scss'

export default () => (
  <div className="row">
    <div className="col-xs-offset-4 col-xs-4">
      <div className="panel panel-primary">
        <div className="panel-body">
          <UploadButton />
          <ProgressBar />
        </div>
      </div>
    </div>
  </div>
)
