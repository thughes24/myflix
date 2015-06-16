class UpdateInvites < ActiveRecord::Migration
  def change
    rename_column :invites, :invited_id, :invited_email
    change_column :invites, :invited_email, :string
  end
end
