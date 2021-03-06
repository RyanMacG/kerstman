class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :name
      t.string :email
      t.integer :group_id
      t.integer :partner_id
      t.integer :giftee_id
      t.boolean :matched, default: false, null: false
      t.timestamps null: false
    end
    add_index :participants, [:group_id, :partner_id, :giftee_id]
  end
end
