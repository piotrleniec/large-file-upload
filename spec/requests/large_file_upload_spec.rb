require 'rails_helper'

describe 'Large file upload' do
  it 'can be performed' do
    post '/chunked_upload_tasks', params: {
      chunked_upload_task: { file_size: 3_000_000 }
    }

    expect(response).to have_http_status 201
    chunked_upload_task = JSON.parse(response.body).symbolize_keys
    expect(chunked_upload_task[:id]).not_to be nil
    expect(chunked_upload_task[:file_size]).to eq 3_000_000

    3.times do |i|
      expect(ConcatenateFileChunksJob).to receive(:perform_later) if i == 2

      post "/chunked_upload_tasks/#{chunked_upload_task[:id]}/file_chunks", params: {
        file_chunk: { data: fixture_file_upload('1MB_file.txt', 'text/plain') }
      }

      expect(response).to have_http_status 201
      file_chunk = JSON.parse(response.body).symbolize_keys
      expect(file_chunk[:id]).not_to be nil
      expect(file_chunk[:data_file_size]).to eq 1_000_000
    end
  end
end
