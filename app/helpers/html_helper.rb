module HtmlHelper

  def get_cached_categories_list
    Rails.cache.fetch('cached_categories') do
      html = ''
      Category.where(:parent_id => nil).sort.each do |root_category|
        html += "<li><label class=\"tree-toggler nav-header\">#{root_category.name}</label>
        <ul class=\"nav nav-list tree\">
        #{generate_collapse_list(root_category)}
        </ul>
        </li>"
      end
      html
    end
  end
  
  def generate_collapse_list(category)
    html = ""

    # ordering categories
    children_cats = []
    leaf_children_cats = []
    category.children.sort_by{|e| e.name}.each do |cat|
      if cat.children.blank?
        leaf_children_cats << cat
      else
        children_cats << cat
      end
    end
    children_cats += leaf_children_cats

    children_cats.each do |child|
      if child.children.blank?
        html_child = "<li><a href=\"" + category_path(child) + "\">#{child.name}</a></li>"
      else
        html_child = "<li><label class=\"tree-toggler nav-header\">#{child.name}</label>
        <ul class=\"nav nav-list tree\">
        #{generate_collapse_list(child)}
        </ul>
        </li>"
      end
      html += html_child
    end
    return html
  end

  def render_category_path(category)
    Rails.cache.fetch('category_path') do
      if category.parent.nil?
        return "<a href=\"" + category_path(category) + "\">#{category.name}</a>"
      else
        return render_category_path(category.parent) + " <i class=\"icon-angle-right\"></i> <a href=\"" + category_path(category) + "\">#{category.name}</a>"
      end    
    end
  end

  def get_cached_categories_list_for_navbar
    Rails.cache.fetch('cached_categories_for_navbar') do
      html = ''
      Category.where(:parent_id => nil).sort.each do |root_category|
        html += "<li class=\"dropdown-submenu\">
        <a href=\"" + category_path(root_category) + "\">#{root_category.name}</a>
        <ul class=\"dropdown-menu\">
        #{generate_collapse_list_for_navbar(root_category)}
        </ul>
        </li>"
      end
      html
    end
  end

  def generate_collapse_list_for_navbar(category)
    html = ""

    # ordering categories
    children_cats = []
    leaf_children_cats = []
    category.children.sort_by{|e| e.name}.each do |cat|
      if cat.children.blank?
        leaf_children_cats << cat
      else
        children_cats << cat
      end
    end
    children_cats += leaf_children_cats

    children_cats.each do |child|
      if child.children.blank?
        html_child = "<li><a href=\"" + category_path(child) + "\">#{child.name}</a></li>"
      else
        html_child =  "<li class=\"dropdown-submenu\">
        <a href=\"" + category_path(child) + "\">#{child.name}</a>
        <ul class=\"dropdown-menu\">
        #{generate_collapse_list_for_navbar(child)}
        </ul>
        </li>"
      end
      html += html_child
    end  
    return html
  end

  def friend_request_notification
    notifications_count = current_user.inverse_friendships.select{|e| e.pending }.length
    if notifications_count > 0
      return "<span class=\"badge badge-info\">#{notifications_count}</span>"
    else
      return ""
    end
  end

  def add_btn_helper(product, size=:small, xtraArgs='', isRemote = true)                       
    if session[:active_recipe] == nil
      link_to "<i class =\"icon-shopping-cart\"></i> Add to cart".html_safe, cart_items_path(:product_id => product), :class => "btn btn-primary btn-#{size} #{xtraArgs}", :method => :post, :remote => true
    else 
      link_to "<i class=\"icon-food\"></i> Add ingredient".html_safe, ingredients_path(product_id: product), :class => "btn btn-primary btn-#{size} #{xtraArgs}", :method => :post, :remote => true         
    end 
  end
end
