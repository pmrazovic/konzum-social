module HtmlHelper
  def get_cached_categories_list(category)
    Rails.cache.fetch('cached_categories') do
      generate_collapse_list(category)      
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
    if category.parent.nil?
      return "<a href=\"" + category_path(category) + "\">#{category.name}</a>"
    else
      return render_category_path(category.parent) + " <i class=\"icon-angle-right\"></i> <a href=\"" + category_path(category) + "\">#{category.name}</a>"
    end    
  end
end