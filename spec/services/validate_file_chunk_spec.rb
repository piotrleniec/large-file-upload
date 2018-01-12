require 'rails_helper'

describe ValidateFileChunk do
  subject { described_class.new(chunked_upload_task, file_chunk_params) }

  describe '#call' do
    context 'when remaining bytes are greater than max chunk size' do
      let(:chunked_upload_task) do
        FactoryBot.create(:chunked_upload_task, file_size: 1_000_100)
      end

      context 'and file chunk size is equal max chunk size' do
        let(:file_chunk_params) { { data: StringIO.new('X' * 1_000_000) } }

        it 'returns ok' do
          status, message = subject.call

          expect(status).to eq :ok
          expect(message).to eq nil
        end
      end

      context "and file chunk size isn't equal max chunk size" do
        let(:file_chunk_params) { { data: StringIO.new('Hello there.') } }

        it 'returns error and message' do
          status, message = subject.call

          expect(status).to eq :error
          expect(message).to eq 'Invalid chunk size. Should be 1000000.'
        end
      end
    end

    context 'when remaining bytes are smaller than max chunk size' do
      let(:chunked_upload_task) do
        FactoryBot.create(:chunked_upload_task, file_size: 100)
      end

      context 'and file chunk size is equal to remaining bytes' do
        let(:file_chunk_params) { { data: StringIO.new('X' * 100) } }

        it 'returns ok' do
          status, message = subject.call

          expect(status).to eq :ok
          expect(message).to eq nil
        end
      end

      context "and file chunk size isn't equal to remaining bytes" do
        let(:file_chunk_params) { { data: StringIO.new('Hello there.') } }

        it 'returns error and message' do
          status, message = subject.call

          expect(status).to eq :error
          expect(message).to eq 'Invalid chunk size. Should be 100.'
        end
      end
    end
  end
end
