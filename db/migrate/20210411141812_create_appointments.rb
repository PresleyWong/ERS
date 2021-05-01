class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.string      :join_url
      t.references  :user, null: false, foreign_key: true
      t.references  :event, null: false, foreign_key: true
      t.boolean     :paid, default: false
      t.string      :language

      t.timestamps
    end

    add_index :appointments, [:user_id, :event_id], unique: true
    
  end
end
