module Publisher
  def self.share(product, product_url, user, post)
    graph = Koala::Facebook::API.new(user.facebook_authentication.token)
    options = {
      :message => post,
      :name => "#{product.name}",
      :link => product_url,
      :caption => "#{product.manufacturer}",
      :description => "Price: #{ActionController::Base.helpers.number_to_currency(product.price, :unit => 'HRK ', :separator => ',', :delimiter => '.')}",
      :picture => product.image_medium
    }
    graph.put_object("me", "feed", options)
  end
end