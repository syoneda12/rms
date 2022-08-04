module OrganizationsHelper
  def list_trees(items)
    if items.size > 0
      html = "<ul id='tree_0'>\n"
      items.each do |item|
        html << "<li id='item_#{item[:id]}'>"
        if current_user_admin?
          html << "<a href='/organizations/#{item[:id]}/edit'>#{h(item[:name])}</a>\n"
        else
          html << "#{h(item[:name])}\n"
        end
        if item[:subordinate] != nil
          if item[:subordinate].size > 0
            html << list_trees(item[:subordinate])
          end
        end
        html << "</li>\n"
      end
      html << "</ul>\n"
      html.html_safe
    end
  end
end
