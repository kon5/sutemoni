class CreateStates < ActiveRecord::Migration[5.2]
  def change
    create_table :states do |t|
      t.string :status
      t.boolean :private

      t.timestamps
    end
  end
end
