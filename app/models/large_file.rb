class LargeFile < ApplicationRecord
  has_attached_file :data

  belongs_to :chunked_upload_task

  validates :data, presence: true
  validates_attachment_content_type :data, content_type: /.+\/.+/
  validates :chunked_upload_task, presence: true
end
