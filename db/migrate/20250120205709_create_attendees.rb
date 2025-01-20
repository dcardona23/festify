class CreateAttendees < ActiveRecord::Migration[7.1]
  def change
    create_table :attendees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false

      t.timestamps
    end

    add_index :attendees, :email, unique: true
  end
end
