class AddBackgroundToBadges < ActiveRecord::Migration
  def change
    add_column :badges, :background_id, :integer
  end
end
