require 'rails_helper'

describe SerializeChunkedUploadTask do
  let(:large_file) { FactoryBot.create(:large_file) }

  subject { described_class.new(large_file.chunked_upload_task) }

  describe '#call' do
    it 'serializes chunked upload task' do
      expect(subject.call).to eq(
        id: large_file.chunked_upload_task.id,
        large_file: {
          id: large_file.id,
          path: large_file.data.url
        }
      )
    end
  end
end
