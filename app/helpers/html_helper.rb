module HtmlHelper
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
end