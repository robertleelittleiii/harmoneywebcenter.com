module ApplicationHelper

  def display_html(data)
  data.html_safe
  end

 def get_page_title
   if @page.blank? then
    return ""
   else
     return  @page.title rescue "Page Title not Found"
   end
 end

def editabletextareacreate (field_name, field_pointer)
    '<div id="field_'+field_name+'" class="myaccountcontentitem">' +
  editabletextarea(field_name,field_pointer)+
  '</div>'
end

def editabletextarea (field_name, field_pointer)
    css_class= 'class="blocklist"'
    field_value=field_pointer[field_name]

  link_to(image_tag("edit.png",:border=>"0", :class=>"imagebutton"),
      :url => {
          :action => "edit_ajax_textarea",
          :id => field_pointer.id,
          :field => field_name,
          :pointer_class=>field_pointer.class },
      :update => "field_"+field_name, :remote=>:true) +
  '<div '+css_class+'>'+h(field_value)+
  '</div>'
end

def editabletextareaedit (field_name, field_pointer)
        return_field=text_area_tag(field_name, field_pointer[field_name], :cols=>"80", :rows=>"20", :onkeyup=>'sz(this);',:class => "mceEditor" )

 #:cols=>"80", :rows=>"20",

 form_remote_tag(:update => 'field_' + field_name,  :url => { :action => 'update_ajax', :method => :post,  :id => field_pointer.id,:pointer_class=>field_pointer.class,  :field => field_name}, :before => "tinyMCE.triggerSave(true,true);"  )do
       return_field+ submit_tag("Save", :class=>"input_button") +
        button_to_remote("Cancel", {:url => { :action => "cancel_ajax", :id => field_pointer.id,  :field => field_name,:pointer_class=>field_pointer.class }, :update => 'field_' + field_name}, :class=>"input_button")+ "<br>"
  end

end

def editablefieldcreate(field_name,field_pointer, opts = {})

  logger.info ("opts")
  logger.info(opts[:class])
  
        if field_pointer[field_name].class == String and field_pointer[field_name].length > 85 then
 ('<div id="field_'+field_name.to_s+'" class="myaccountcontentitem">' +
 best_in_place(field_pointer, field_name, :type => :textarea, :nil => "Click me to add content!", :class=>opts[:class]).html_safe +
  '</div>').html_safe
       else
          
  ('<div id="field_'+field_name.to_s+'" class="myaccountcontentitem">' +
 best_in_place(field_pointer, field_name, :type => :input, :nil => "Click me to add content!", :class=>opts[:class]).html_safe +
  '</div>').html_safe
        end
end 

def editablefieldcreate2(field_name,field_pointer)

  ('<div id="field_'+field_name.to_s+'" class="myaccountcontentitem">' +
  editablefield(field_name,field_pointer)+
  '</div>').html_safe

end

 def best_in_place(object, field, opts = {})
     logger.info ("best_in_place")
    logger.info(opts[:class])
  
      opts[:type] ||= :input
      opts[:collection] ||= []

     field = field.to_s
      value = object.send(field).blank? ? "" : object.send(field)
      collection = nil
      if opts[:type] == :select && !opts[:collection].blank?
        v = object.send(field)
        logger.info(v)
        logger.info (opts[:collection])
        value = Hash[opts[:collection]][!!(v =~ /^[0-9]+$/) ? v.to_i : v] || "Please Select..."
        collection = opts[:collection].to_json
      end
      if opts[:type] == :checkbox
        fieldValue = !!object.send(field)
        if opts[:collection].blank? || opts[:collection].size != 2
          opts[:collection] = ["No", "Yes"]
        end
        value = fieldValue ? opts[:collection][1] : opts[:collection][0]
        collection = opts[:collection].to_json
      end
      extraclass = "'"
      if !opts[:class].blank? 
        extraclass = opts[:class] + "'"
      end
      
      out = "<div class='best_in_place " + extraclass
      out << " id='best_in_place_#{object.class.to_s.gsub("::", "_").underscore}_#{field}'"
      out << " data-url='#{opts[:path].blank? ? url_for(object).to_s : url_for(opts[:path])}'"
      out << " data-object='#{object.class.to_s.gsub("::", "_").underscore}'"
      out << " data-collection='#{collection}'" unless collection.blank?
      out << " data-attribute='#{field}'"
      out << " data-activator='#{opts[:activator]}'" unless opts[:activator].blank?
      out << " data-nil='#{opts[:nil].to_s}'" unless opts[:nil].blank?
      out << " data-type='#{opts[:type].to_s}'"
      if !opts[:sanitize].nil? && !opts[:sanitize]
        out << " data-sanitize='false'>"
        out << sanitize(value.to_s, :tags => %w(b i u s a strong em p h1 h2 h3 h4 h5 ul li ol hr pre span img), :attributes => %w(id class))
      else
        out << ">#{sanitize(value.to_s, :tags => nil, :attributes => nil)}"
      end
      out << "</div>"
      return out
    end


def editablefield(field_name,field_pointer)

  if field_name=="password"
    field_value="***********"
  else
    field_value=field_pointer[field_name]
  end
  if field_value.to_s.empty?
    field_value="(empty)"
  end
  
 if field_pointer[field_name].class == String and field_pointer[field_name].length > 85 then
     css_class= 'class="blocklist"'
   else
     css_class='class="blocklist2"'
   end

  (link_to(image_tag("edit.png",:border=>"0", :class=>"imagebutton"),
      {
          :action => "edit_ajax",
          :id => field_pointer.id,
          :field => field_name,
          :pointer_class=>field_pointer.class }, :remote=>true,
      :update => "field_"+field_name) +
  ('<div '+css_class+'>'+h(field_value)+
  '</div>').html_safe)

end

def editablefieldedit (field_name, field_pointer)
    if field_name=="password" then
        return_field=password_field_tag(field_name, field_pointer[field_name],  :class => 'input_text_field', :size=>'20', :onkeyup=>'sz(this);' ) + password_field_tag(field_name+"_check", field_pointer[field_name+"_check"],  :class => 'input_text_field', :size=>'20', :onkeyup=>'sz(this);' )
    else
      if field_pointer[field_name].class == String and field_pointer[field_name].length > 85 then
        return_field=text_area_tag(field_name, field_pointer[field_name],  :class => 'input_text_area', :onkeyup=>'sz(this);' )
      else
        if field_pointer[field_name].class == String then
          field_size=field_pointer[field_name].length
        else
          field_size=field_pointer[field_name].to_s.length
        end
        return_field=text_field_tag(field_name, field_pointer[field_name],  :class => 'input_text_field', :size=>field_size , :onkeyup=>'sz(this);' )
      end
    end
  return_value = form_tag( {:action => 'update_ajax', :method => :post,  :id => field_pointer.id,:pointer_class=>field_pointer.class,  :field => field_name}, { :remote=>true }) do
       return_field + submit_tag("Save", :class=>"input_button")
     end
     return_value = return_value+ button_to("Cancel", { :action => "cancel_ajax", :id => field_pointer.id,  :field => field_name,:pointer_class=>field_pointer.class },{ :remote=>true, :update => 'field_' + field_name, :class=>"input_button"})+ "<br>".html_safe
  
  return return_value
end

def editablecheckboxedit (field_name, field_pointer,field_title)
  
          check_box_tag( "#{field_name}", field_pointer.id, field_pointer[field_name], {
                  :onchange => "#{remote_function(:url  => {:action => "update_checkbox", :id=>field_pointer.id, :field=>field_name ,:pointer_class=>field_pointer.class},
                                                      :with => "'current_status='+checked")}"})+field_title

end
def ajax_select(field_name, field_object, field_pointer, value_list)
   ('<div id="field_'+field_name.to_s+'" class="myaccountcontentitem">' +
          best_in_place(field_pointer, field_name, :type => :select, :collection => value_list) +
  '</div>').html_safe
      #  <%= best_in_place @user, :country, :type => :select, :collection => @countries %>

end

def ajax_select2(field_name, field_object, field_pointer, value_list)
         select(field_object,"#{field_name}", value_list,{ :prompt => 'Please Select...'}, {"data-id"=>field_pointer.id,
                  :onchange => "#{remote_function(:url  => {:action => "update_ajax", :id=>field_pointer.id, :field=>field_name, :pointer_class=>field_pointer.class},
                                                      :with => "'#{field_name}='+value")}"}
                                                  )

end

#def ajax_select(field_name, field_object, field_pointer, value_list)
#         select(field_object,"#{field_name}", value_list,{ :prompt => 'Please Select...'}, {"data-id"=>field_pointer.id,
#                  :onchange => "#{remote_function(:url  => {:action => "update_ajax", :id=>field_pointer.id, :field=>field_name, :pointer_class=>field_pointer.class},
#                                                      :with => "'#{field_name}='+value")}#"}
#                                                  )
#
#end

def editablecheckboxeditwdisable (field_name, field_pointer,field_title, is_disabled)
          if (not is_disabled)
            spanText="<span class='disabled-text'>"+field_title+"</span>"
          else
            spanText=field_title
          end
          check_box_tag( "#{field_name}]", field_pointer.id, field_pointer[field_name], {:disabled=>(not is_disabled),
                  :onchange => "#{remote_function(:url  => {:action => "update_checkbox", :id=>field_pointer.id, :field=>field_name},
                                                      :with => "'current_status='+checked")}"})+spanText

end



def  ajax_calendar_date_select(field_name, field_pointer)
  calendar_date_select_tag(field_name,field_pointer[field_name],
                {:onchange => "#{remote_function(:url  => {:action => "update_ajax",:pointer_class=>field_pointer.class, :id=>field_pointer.id, :field=>field_name},
                :with => "'#{field_name}='+$F(this)")}",  :year_range => [1901, 2020]})



end

def editablecheckboxtag  (field_name, field_pointer,field_title)
          tag_array= field_pointer.tag_list
          tag_array= tag_array.collect { |item| item.downcase.strip  }
          field_name_d = field_name.downcase.strip
          is_checked = tag_array.include?(field_name_d)

          check_box_tag("#{field_name}]", field_pointer.id, is_checked, {
                  :onchange => "#{remote_function(:url  => {:action => "update_checkbox_tag", :id=>field_pointer.id, :field=>field_name},
                                                     :with => "'current_status='+checked")}"})+field_title
  end

 def hidden_div_if(condition, attributes = {})
    if condition
      attributes["style"] = "display: none"
   end
    attrs = tag_options(attributes.stringify_keys)
    "<div #{attrs}>".html_safe
  end


def controller_stylesheet_link_tag
  stylesheet = "#{params[:controller]}.css"

  if File.exists?(File.join(Rails.public_path, 'stylesheets', stylesheet))
    stylesheet_link_tag stylesheet
  end
end

def controller_javascript_include_tag
  javascript = "#{params[:controller]}/#{params[:action]}.js"

  if File.exists?(File.join(Rails.public_path, 'javascripts', javascript))
    javascript_include_tag javascript
  end
end

def tab_link_to(*args, &block)
        if block_given?
           options      = args.first || {}
           html_options = args.second
           concat(link_to(capture(&block), options, html_options))
         else
           name         = args.first
           options      = args.second || {}
           html_options = args.third
         end

         the_controller_name = options[:controller]
         the_action_name = options[:action]


if session[:user_id] then
  user =  User.find_by_id(session[:user_id])

   if user.roles.detect{|role|
    role.rights.detect{|right|
      ((right.action == the_action_name)|(right.action == "*")|(right.action.include? the_action_name)) && right.controller == the_controller_name
      }
    }

    add_tab do |t|
    t.named name
    t.titled the_controller_name
    t.links_to :controller => the_controller_name, :action =>  the_action_name
    end
      #return_value = the_tab.create(the_controller_name, name) do
      # render :controller => the_controller_name, :action =>  the_action_name
      #  link_to(*args,&block)
    #end
    return
    else
      return ""
    end

         #  url = url_for(options)

         #  if html_options
         #    html_options = html_options.stringify_keys
         #    href = html_options['href']
         #    convert_options_to_javascript!(html_options, url)
         #    tag_options = tag_options(html_options)
         #  else
         #    tag_options = nil
         #  end

         #  href_attr = "href=\"#{url}\"" unless href
         #  "<a #{href_attr}#{tag_options}>#{name || url}</a>"
         # end

       end
end





def app_link_to(*args, &block)
         if block_given?
           options      = args.first || {}
           html_options = args.second
           concat(link_to(capture(&block), options, html_options))
         else
           name         = args.first
           options      = args.second || {}
           html_options = args.third
         end

         the_controller_name = options[:controller]
         the_action_name = options[:action]
puts("#{the_action_name}")
    user =  User.find_by_id(session[:user_id])

    if user.roles.detect{|role|
    role.rights.detect{|right|
      ((right.action == the_action_name)|(right.action == "*")) && right.controller == the_controller_name
      }
    }
    return link_to(*args,&block)
    else
      return ""
    end

         #  url = url_for(options)

         #  if html_options
         #    html_options = html_options.stringify_keys
         #    href = html_options['href']
         #    convert_options_to_javascript!(html_options, url)
         #    tag_options = tag_options(html_options)
         #  else
         #    tag_options = nil
         #  end

         #  href_attr = "href=\"#{url}\"" unless href
         #  "<a #{href_attr}#{tag_options}>#{name || url}</a>"
         # end

       end


  def   buildmenuitem(menuItem, html_options, span_options)
    #    html_options = Menu.create_hash_from_string(menuItem.html_options)
       # html_options = {}
        return_link = ""
            case menuItem.m_type
                when "1"
                  menuText="<span "+ span_options +">"+menuItem.name.titlecase + "</span>"
                  if (menuItem.page_id.blank?)
                     return_link =  link_to(menuText.html_safe, {}, html_options)
                  else
                    class_options = { :action => "show_page", :controller =>"site", :id=>menuItem.page_id}
                    item_link_to = menuText.html_safe
                    return_link =  link_to(item_link_to, class_options, html_options)
                  end
                when "2"
                    return_link = menuItem.rawhtml
                when "3"
                    menuText="<span "+ span_options +">"+menuItem.name.titlecase + "</span>"
                    return_link = link_to(menuText.html_safe, {}, html_options)
#  internal call to controller and action
#                    class_options = { :action => menuItem.action, :controller =>menuItem.controller}.merge(Menu.create_hash_from_string(menuItem.class_options))
#                    item_link_to = menuItem.name.upcase
#                    return_link =  link_to(item_link_to, class_options, html_options)
#                when 3
#                    class_options = menuItem.url
#                    item_link_to = menuItem.name
#                    return_link =  link_to(item_link_to, class_options, html_options)
#                 when 4
#                    class_options = menuItem.url
#                    item_link_to = image_tag(menuItem.picture)
#                    return_link =  link_to(item_link_to, class_options, html_options)
#                when 5
#                   return_link = menuItem.raw_html
                end
        return return_link.html_safe rescue "<none>"
        end

  def buildverticlemenu(params=nil)
    @menu_id= params[:menu_id]
    @prehtml = params[:prehtml]
    @posthtml = params[:posthtml]

    @menu = Menu.find_by_name(@menu_id)

    returnMenu=""


    if @menu.blank? then
      returnMenu = "Can't Find '"+ @menu_id + "'"
    else
          @menus = Menu.find_menu(@menu.id)

      for @menu in @menus
        returnMenu=  returnMenu + @prehtml + self.buildmenuitem(@menu,{},"") + @posthtml
      end
    end
    return returnMenu.html_safe
  end

    def buildhorizontalmenu(params=nil)
        @menu_id= params[:menu_id]
        returnMenu=""

    @menu = Menu.find_by_name(@menu_id)

      if @menu.blank?  then
      returnMenu = "Can't Find '"+ @menu_id + "'"
        else
        @menus = Menu.find_menu(@menu.id)

        breaker = ''
        for @menu in @menus
            returnMenu=  returnMenu + breaker + self.buildmenuitem(@menu,{},"")
            breaker = ' | '
        end
        end
        
        return returnMenu.html_safe
    end

    def buildhorizontalmenuprodrop(params=nil)
      @menu_id= params[:menu_id]
      returnMenu=""

      @menu = Menu.find_by_name(@menu_id)

      if @menu.blank?  then
        returnMenu = "Can't Find '"+ @menu_id + "'"
      else
        @menus = Menu.find_menu(@menu.id)

        breaker = ''
        for @menu in @menus
          if @menus.last == @menu then
            html_link_class="top_link last_link"
          else
            html_link_class="top_link"
          end

          if @menu.menus.count>0 then
            subMenus=self.buildsubmenus(@menu.menus,0)
            returnMenu=  returnMenu + breaker + "<li class='top'>"+ self.buildmenuitem(@menu, {:class=>html_link_class}, "class='down'") +subMenus+ "</li>"
         else
           returnMenu=  returnMenu + breaker  + "<li class='top'>" + self.buildmenuitem(@menu, {:class=>html_link_class}, "") + "</li>"
         end

          breaker = ''.html_safe
        end
      end

      #	<li class="top"><a href="#nogo1" class="top_link"><span>Home</span></a></li>

      return("<ul id='navi'>" + returnMenu + "</ul>").html_safe
      
    end
    
    def buildsubmenus(inputMenus, level)
      returnMenu = ""
      returnSubMenu = ""
      level = level + 1

      for eachmenu in inputMenus
        if eachmenu.menus.size > 0 then
          returnSubMenu = self.buildsubmenus(eachmenu.menus, level)
          returnSubMenu = "<li class='mid'>"+ self.buildmenuitem(eachmenu, {:class=>"fly"}, "")+ returnSubMenu+ "</li>"
        else
          returnSubMenu = "<li>" + self.buildmenuitem(eachmenu, {}, "") + "</li>"
        end
        returnMenu = returnMenu + returnSubMenu
      end

      if level == 1 then
        returnMenu = "<ul class='sub'>" + returnMenu + "</ul>"
      end
      if level == 2 then
        returnMenu =  "<ul>" + returnMenu +"</ul>"
      end
      if level > 2 then
                returnMenu =  "<ul>" + returnMenu +"</ul>"
      end
      return returnMenu   
    end
    
 

end
