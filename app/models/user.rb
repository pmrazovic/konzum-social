class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  has_many :authentications, :dependent => :destroy
  has_one :cart
  has_many :orders
  has_many :friendships, :dependent => :destroy
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :likes, :dependent => :destroy
  has_many :favorites, :dependent => :destroy
  has_many :recipes, :dependent => :destroy
  has_many :list_users
  has_many :shopping_lists, through: :list_users, source: :list

  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable
         
  validates :first_name, :presence => true
  validates :last_name, :presence => true
  validates :gender, :inclusion => {:in => ['M', 'F']}
  has_many :product_recommendation_factor, :dependent => :destroy
  before_destroy :delete_user_activity
  before_destroy :delete_friendships

  def password_required?
    (authentications.empty? || !password.blank?) && super
  end

  def apply_omniauth(omni)
    authentications.build(:provider => omni['provider'],
                          :uid => omni['uid'],
                          :token => omni['credentials'].token,
                          :token_secret => omni['credentials'].secret)
  end

  def update_facebook_token(omni)
    auth = facebook_authentication
    auth.token = omni['credentials'].token
    auth.token_secret = omni['credentials'].secret
    auth.save
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
      return large_profile_image if type == 'large'
      return small_profile_image if type == 'square'
    else
      return gender == 'M' ? 'user-icon-male.png' : 'user-icon-female.png'
    end
  end

  def bought_products
    orders.collect{|o| o.order_items.collect{|item| item.product}}.flatten.uniq
  end

  def liked_products
    likes.select{|e| e.likeable_type == "PRODUCT"}.uniq.collect{|e| Product.find(e.likeable_id)}
  end

  def favorized_products
    favorites.collect{|e| e.product}
  end

  def confirmed_friends
    friendships.select{|friendship| friendship.pending == false }.collect{|f| f.user == self ? f.friend : f.user }
  end

  def delete_user_activity
    UserActivity.where(:user_id => self.id).each{|activity| activity.destroy }
  end

  def delete_friendships
    Friendship.where(:user_id => self.id).each{|friendship| friendship.destroy}
    Friendship.where(:friend_id => self.id).each{|friendship| friendship.destroy}
  end

end
