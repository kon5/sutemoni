# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

state_data = ['元気です', '食事してます', '仕事中です', '家にいます', '外出中です', '散歩してます', '買物してます', 'のんびりしてます', '寝てます']

state_data.each do |state|
  PresetState.find_or_create_by!(state: state) do |p_state|
    p_state.state = state
  end
end
