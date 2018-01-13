import { range } from 'lodash-es'
import { MAX_CHUNK_SIZE } from '../constants'
import actionCableConsumer from '../actionCable'
import setFileSize from './setFileSize'
import addUploadedBytes from './addUploadedBytes'
import showUploadedFileLink from './showUploadedFileLink'

const readFileSlice = fileSlice => new Promise(resolve => {
  const fileReader = new FileReader()
  fileReader.onload = event => {
    const arrayBuffer = event.target.result
    resolve(arrayBuffer)
  }
  fileReader.readAsArrayBuffer(fileSlice)
})

export default file => async dispatch => {
  dispatch(setFileSize(file.size))

  const response = await fetch('/chunked_upload_tasks', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ chunked_upload_task: { file_size: file.size } })
  })
  const chunkedUploadTask = await response.json()

  actionCableConsumer.subscriptions.create({
    channel: 'ChunkedUploadTaskChannel',
    id: chunkedUploadTask.id
  }, {
    received: data => {
      dispatch(showUploadedFileLink(data.large_file.path))
    }
  })

  for (const index of range(Math.ceil(file.size / MAX_CHUNK_SIZE))) {
    const fileSlize = file.slice(index * MAX_CHUNK_SIZE, (index + 1) * MAX_CHUNK_SIZE)
    const arrayBuffer = await readFileSlice(fileSlize)

    const formData = new FormData()
    formData.append('file_chunk[data]', new Blob([arrayBuffer]))

    await fetch(`/chunked_upload_tasks/${chunkedUploadTask.id}/file_chunks`, {
      method: 'POST',
      body: formData
    })

    dispatch(addUploadedBytes(fileSlize.size))
  }
}
