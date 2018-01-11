class ChunkedUploadTask < ApplicationRecord
  has_many :file_chunks, dependent: :destroy

  validates :file_size, presence: true, numericality: {
    only_integer: true, greater_than: 0
  }
end
