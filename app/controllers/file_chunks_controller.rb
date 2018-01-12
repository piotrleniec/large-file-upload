class FileChunksController < ApplicationController
  def create
    chunked_upload_task = ChunkedUploadTask.find(params[:chunked_upload_task_id])
    validate_file_chunk = ValidateFileChunk.new(chunked_upload_task,
                                                create_params)
    
    status, message = validate_file_chunk.call
    case status
    when :ok
      save_file_chunk = SaveFileChunk.new(chunked_upload_task, create_params)
      file_chunk = save_file_chunk.call

      render json: file_chunk, status: :created
    when :error
      render json: { message: message }, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:file_chunk).permit(:data)
  end
end
