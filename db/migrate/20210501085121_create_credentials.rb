class CreateCredentials < ActiveRecord::Migration[6.0]
  def change
    create_table :credentials do |t|
      t.string :api_name
      t.string :api_key
      t.string :api_secret

      t.timestamps
    end
  end
end
