class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.date :date
      t.time :start_time
      t.time :end_time
      t.string :meeting_id1,             default: ""
      t.string :meeting_id2,             default: ""
      t.string :meeting_id3,             default: ""
      t.string :attachment_url1,         default: ""
      t.string :attachment_url2,         default: ""
      t.string :attachment_url3,         default: ""
      t.timestamps
    end
  end
end
