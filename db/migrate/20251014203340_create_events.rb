class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.datetime :date
      t.string :location
      t.references :host, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
