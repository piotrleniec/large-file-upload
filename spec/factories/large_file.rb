FactoryBot.define do
  factory :large_file do
    data { StringIO.new('Hello there.') }
    chunked_upload_task
  end
end
