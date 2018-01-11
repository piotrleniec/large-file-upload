class ChunkedUploadTasksController < ApplicationController
  def create
    chunked_upload_task = ChunkedUploadTask.new(create_params)

    if chunked_upload_task.save
      render json: chunked_upload_task, status: :created
    else
      render json: chunked_upload_task.errors, status: :unprocessable_entity
    end
  end

  private

  def create_params
    params.require(:chunked_upload_task).permit(:file_size)
  end
end
