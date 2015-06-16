class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.integer :inviter_id
      t.integer :invited_id
      t.string :invite_token
      t.timestamps
    end
  end
end
