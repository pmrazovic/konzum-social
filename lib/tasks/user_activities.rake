require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")

namespace :user_activities do
  desc "Reset user activities"
  task :reset do
    Like.destroy_all
    Favorite.destroy_all
    Order.destroy_all
    Cart.destroy_all
    ProductRecommendationFactor.destroy_all
    UserActivity.destroy_all
    puts "User activities successfuly cleared."
  end  
end