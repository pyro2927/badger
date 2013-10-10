class User < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  rolify
  has_many :achievements
  has_many :badges, through: :achievements
  validates_presence_of :name

  def admin
    role_ids
  end

  def profile_image
    ActionController::Base.helpers.link_to ActionController::Base.helpers.image_tag(Gravatar.new(email).image_url + "?size=150", :class => 'img-circle'), user_path(self)
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      if auth['info']
         user.name = auth['info']['name'] || ""
         user.email = auth['info']['email'] || ""
      end
    end
  end

end
