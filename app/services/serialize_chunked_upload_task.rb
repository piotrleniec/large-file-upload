class SerializeChunkedUploadTask
  def initialize(chunked_upload_task)
    @chunked_upload_task = chunked_upload_task
  end

  def call
    {
      id: @chunked_upload_task.id,
      large_file: serialize_large_file
    }
  end

  private

  def serialize_large_file
    large_file = @chunked_upload_task.large_file

    {
      id: large_file.id,
      path: large_file.data.url
    }
  end
end
