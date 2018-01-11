require 'rails_helper'

describe ChunkedUploadTasksController do
  describe 'POST #create' do
    context 'when request params are valid' do
      it 'creates chunked upload task' do
        post :create, params: { chunked_upload_task: { file_size: 1024 } }

        expect(response).to have_http_status :created
        response_body = JSON.parse(response.body)
        expect(response_body['id']).not_to be nil
        expect(response_body['file_size']).to eq 1024
      end
    end

    context 'when request params are invalid' do
      it "doesn't create chunked upload task" do
        post :create, params: { chunked_upload_task: { file_size: 'Umm... What?' } }

        expect(response).to have_http_status :unprocessable_entity
        response_body = JSON.parse(response.body)
        expect(response_body['file_size']).to match_array ["is not a number"]
      end
    end
  end
end
