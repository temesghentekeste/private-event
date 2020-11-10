class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_datetime
      t.datetime :end_datetime

      t.timestamps
    end
  end
end
