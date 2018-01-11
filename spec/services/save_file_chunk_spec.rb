require 'rails_helper'

describe SaveFileChunk do
  let(:file_chunk_params) { { data: StringIO.new('Hello there.') } }

  subject { described_class.new(chunked_upload_task, file_chunk_params) }

  context 'when saving not the last chunk' do
    let(:chunked_upload_task) do
      FactoryBot.create(:chunked_upload_task, file_size: 24)
    end

    it 'saves the chunk' do
      expect(ConcatenateFileChunksJob).not_to receive :perform_later

      subject.call

      expect(chunked_upload_task.reload.file_chunks.size).to eq 1
    end
  end

  context 'when saving the last chunk' do
    let(:chunked_upload_task) do
      FactoryBot.create(:chunked_upload_task, file_size: 12)
    end

    it 'saves the chunk and dispatches concatenate file chunks job' do
      expect(ConcatenateFileChunksJob).to receive :perform_later

      subject.call

      expect(chunked_upload_task.reload.file_chunks.size).to eq 1
    end
  end
end
