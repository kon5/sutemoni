class AddUserIdToStates < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM states;'
    add_reference :states, :user, null: false, index: true
  end

  def down
    remove_reference :states, :user, index: true
  end
end
