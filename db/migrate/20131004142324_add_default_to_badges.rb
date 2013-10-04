class AddDefaultToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :default, :boolean
  end
end
