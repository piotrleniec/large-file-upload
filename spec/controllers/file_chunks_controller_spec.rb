require 'rails_helper'

describe FileChunksController do
  describe 'POST #create' do
    let(:chunked_upload_task) { FactoryBot.create(:chunked_upload_task) }

    context 'when params are valid' do
      it 'saves file chunk' do
        expect_any_instance_of(ValidateFileChunk).to receive(:call).and_return(%i[ok])
        expect_any_instance_of(SaveFileChunk).to receive(:call).and_return(name: 'FileChunk')

        post :create, params: {
          chunked_upload_task_id: chunked_upload_task.id,
          file_chunk: { data: 'This is a "file".' }
        }

        expect(response).to have_http_status :created
        response_body = JSON.parse(response.body)
        expect(response_body).to eq('name' => 'FileChunk')
      end
    end

    context 'when params are invalid' do
      it "doesn't save file chunk" do
        expect_any_instance_of(ValidateFileChunk).to receive(:call).and_return([:error, 'Error message.'])

        post :create, params: {
          chunked_upload_task_id: chunked_upload_task.id,
          file_chunk: { data: 'This is a "file".' }
        }

        expect(response).to have_http_status :unprocessable_entity
        response_body = JSON.parse(response.body)
        expect(response_body).to eq('message' => 'Error message.')
      end
    end
  end
end
