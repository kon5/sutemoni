class ChangeStatesStatusLimit30 < ActiveRecord::Migration[5.2]
  def up
    change_column :states, :status, :string, limit: 30
  end

  def down
    change_column :states, :status, :string
  end
end
