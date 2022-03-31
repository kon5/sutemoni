class AddMakerToGroups < ActiveRecord::Migration[5.2]
  def change
    #add_column :groups, :maker_id, :references, null: false

    execute 'DELETE FROM groups;'
    add_column :groups, :maker_id, :bigint, null: false
  end
end
