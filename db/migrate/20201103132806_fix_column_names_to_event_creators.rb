class FixColumnNamesToEventCreators < ActiveRecord::Migration[6.0]
  def change
    rename_column :event_creators, :user_id, :creator_id
    rename_column :event_creators, :event_id, :created_event_id
  end
end
