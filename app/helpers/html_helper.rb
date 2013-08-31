module HtmlHelper
  def generate_collapse_list(category)
    html = ""
    category.children.each do |child|
      if child.children.blank?
        html_child = "<li><a href=\"#\">#{child.name}</a></li>"
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