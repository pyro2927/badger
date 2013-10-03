class User < ActiveRecord::Base
  rolify
  has_many :badges, through: :achievements
  validates_presence_of :name

  def admin
    role_ids
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
