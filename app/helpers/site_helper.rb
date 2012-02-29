module SiteHelper
  
  
  def show_title_not_null(title, value, cell_params)
    returnval = ""
    returnval = returnval +'<td align="right" ><b>' + (value.blank? ? "" : title) + '</b></td>'
    returnval = returnval + '<td '+cell_params+'> ' + value + '</td>'
    return returnval.html_safe
  end
  
  
  def page_edit_div(page)
    returnval=""
    if session[:user_id] then
      user=User.find(session[:user_id])
      if user.roles.detect{|role|((role.name=="Admin") | (role.name=="Site Owner"))} then
        returnval="<div id=\"edit-pages\">"
        returnval=returnval+link_to(image_tag("edit.png",:border=>"0", :class=>"imagebutton"),:controller => 'pages', :id =>page.id ,  :action => 'edit')
        returnval=returnval + "</div>"
      end
    end
    return returnval.html_safe

  end
  
  
end
