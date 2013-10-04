class Badge < ActiveRecord::Base
  belongs_to :background
  has_many :achievements, dependent: :delete_all
  has_many :users, through: :achievements
  has_attached_file :image

  def image_html
    ActionController::Base.helpers.image_tag image.url, :size => "100x100"
  end
end
