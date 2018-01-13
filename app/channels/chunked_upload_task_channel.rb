class ChunkedUploadTaskChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chunked_upload_task_#{params[:id]}"
  end
end
