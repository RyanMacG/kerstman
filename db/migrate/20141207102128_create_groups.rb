class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.string :limit
      t.string :year
      t.boolean :matched, default: false, null: false
      t.integer :user_id
      t.timestamps null: false
    end
    add_index :groups, [:user_id, :created_at]
  end
end
