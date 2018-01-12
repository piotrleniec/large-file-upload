class ValidateFileChunk
  MAX_CHUNK_SIZE = 1_000_000

  def initialize(chunked_upload_task, file_chunk_params)
    @chunked_upload_task = chunked_upload_task
    @file_chunk_params = file_chunk_params
  end

  def call
    if remaining_bytes >= MAX_CHUNK_SIZE && file_chunk_size != MAX_CHUNK_SIZE
      return [:error, "Invalid chunk size. Should be #{MAX_CHUNK_SIZE}."]
    end

    if remaining_bytes < MAX_CHUNK_SIZE && file_chunk_size != remaining_bytes
      return [:error, "Invalid chunk size. Should be #{remaining_bytes}."]
    end

    %i[ok]
  end

  private

  def file_chunk_size
    @file_chunk_size ||= FileChunk.new(@file_chunk_params).data_file_size
  end

  def remaining_bytes
    @remaining_bytes ||= calculate_remaining_bytes
  end

  def calculate_remaining_bytes
    uploaded_bytes = @chunked_upload_task.file_chunks
                                         .map(&:data_file_size)
                                         .sum
    @chunked_upload_task.file_size - uploaded_bytes
  end
end
