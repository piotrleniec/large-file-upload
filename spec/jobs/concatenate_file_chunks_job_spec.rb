require 'rails_helper'

describe ConcatenateFileChunksJob do
  describe '#perform' do
    let(:chunked_upload_task) { FactoryBot.create(:chunked_upload_task) }

    before do
      chunked_upload_task.file_chunks.create!(data: StringIO.new('Hell'))
      chunked_upload_task.file_chunks.create!(data: StringIO.new('o th'))
      chunked_upload_task.file_chunks.create!(data: StringIO.new('ere.'))
    end

    it 'merges file chunks into a large file' do
      ConcatenateFileChunksJob.perform_now(chunked_upload_task.id)

      expect(File.read(chunked_upload_task.large_file.data.path)).to eq 'Hello there.'
    end
  end
end
