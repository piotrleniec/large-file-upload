class ConcatenateFileChunksJob < ApplicationJob
  def perform(chunked_upload_task_id)
    chunked_upload_task = ChunkedUploadTask.eager_load(:file_chunks)
                                           .find(chunked_upload_task_id)

    large_file_data = Tempfile.new('large_file_data')
    chunked_upload_task.file_chunks.order(:created_at).each do |file_chunk|
      IO.copy_stream(file_chunk.data.path, large_file_data)
    end

    chunked_upload_task.create_large_file!(data: large_file_data)
  end
end
