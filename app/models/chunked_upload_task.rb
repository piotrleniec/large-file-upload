class ChunkedUploadTask < ApplicationRecord
  has_one :large_file
  has_many :file_chunks, dependent: :destroy

  validates :file_size, presence: true, numericality: {
    only_integer: true, greater_than: 0
  }
end
