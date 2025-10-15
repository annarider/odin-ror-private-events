class RenameHostToCreatorInEvents < ActiveRecord::Migration[8.0]
  def change
    rename_column :events, :host_id, :creator_id
    rename_index :events, 'index_events_on_host_id', 'index_events_on_creator_id'
  end
end
