class CreateFileChunks < ActiveRecord::Migration[5.1]
  def change
    create_table :file_chunks do |t|
      t.references :chunked_upload_task, foreign_key: true, null: false
      t.attachment :data, null: false

      t.timestamps
    end
  end
end
