class CreateLargeFiles < ActiveRecord::Migration[5.1]
  def change
    create_table :large_files do |t|
      t.attachment :data, null: false
      t.references :chunked_upload_task, index: true, null: false

      t.timestamps
    end

    add_foreign_key :large_files, :chunked_upload_tasks
  end
end
