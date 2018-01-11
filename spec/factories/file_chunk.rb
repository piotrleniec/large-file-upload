FactoryBot.define do
  factory :file_chunk do
    chunked_upload_task
    data { StringIO.new('Hello there.') }
  end
end
