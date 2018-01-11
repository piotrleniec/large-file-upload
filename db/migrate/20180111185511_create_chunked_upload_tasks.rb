class CreateChunkedUploadTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :chunked_upload_tasks do |t|
      t.integer :file_size, null: false

      t.timestamps
    end
  end
end
