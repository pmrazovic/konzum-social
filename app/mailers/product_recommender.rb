class ProductRecommender < ActionMailer::Base
  default from: "konzum-social@konzum.hr"

  def recommend(email, product, user)
    @email = email
    @product = product
    @user = user
    mail :to => email, :subject => "[Konzum Social] #{@user.full_name} recommends you product" 
  end  
end
