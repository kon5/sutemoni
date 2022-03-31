class CreatePresetStates < ActiveRecord::Migration[5.2]
  def change
    create_table :preset_states do |t|
      t.string :state

      t.timestamps
    end
  end
end
