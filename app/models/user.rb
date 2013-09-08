class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :authentications, :dependent => :destroy
  has_one :cart
  has_many :orders
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :gender, :inclusion => {:in => ['M', 'F']}

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'],
                          :uid => omni['uid'],
                          :token => omni['credentials'].token,
                          :token_secret => omni['credentials'].secret)
  end

  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def connected_with_facebook?
    authentications.map{|a| a.provider}.include?('facebook')
  end

  def facebook_authentication
    authentications.where(:provider => 'facebook').first
  end

  # def friends
  #   friends_from_facebook
  # end

  def friends_from_facebook
    graph = Koala::Facebook::API.new(facebook_authentication.token)
    friends = graph.get_connections('me', 'friends')
    friends_from_facebook = []
    friends.each do |friend|
      friends_auth = Authentication.where(:uid => friend['id']).first
      friends_from_facebook << friends_auth.user unless friends_auth.nil?
    end
    return friends_from_facebook
  end

  def profile_picture(type)
    if connected_with_facebook?
      graph = Koala::Facebook::API.new(facebook_authentication.token)      
      return graph.get_picture('me', :type => type)
    else
      return gender == 'M' ? 'user-icon-male.png' : 'user-icon-female.png'
    end
  end

  def bought_products
    orders.collect{|o| o.order_items.collect{|item| item.product}}.flatten.uniq
  end

end
