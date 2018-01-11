class SaveFileChunk
  def initialize(chunked_upload_task, file_chunk_params)
    @chunked_upload_task = chunked_upload_task
    @file_chunk_params = file_chunk_params
  end

  def call
    file_chunk = @chunked_upload_task.file_chunks.create!(@file_chunk_params)
    uploaded_bytes = @chunked_upload_task.file_chunks
                                         .map(&:data_file_size)
                                         .sum

    if @chunked_upload_task.file_size == uploaded_bytes
      ConcatenateFileChunksJob.perform_later(@chunked_upload_task.id)
    end

    file_chunk
  end
end
