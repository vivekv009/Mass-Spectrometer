module SubmissionsHelper

  def error_file_field(parent, field, f)
    html = ""
    html << "<div class='#{['input clearfix', ('error' if (parent.errors[field].length > 0))].join(" ")}'>"
      html << "#{f.label field}"
      html << "#{f.file_field field, :class => 'xlarge'}"
      html << "#{f.error field, :class => 'help-inline'}"
    html << "</div>"
    html.html_safe
  end

  def btn_labelled_radio(post, field, attrs)
    #puts post, field, attrs.to_s
    haml_tag :div, :class=>"hide" do
      attrs.each do |friendly, val|
        inputID = "#{post}_#{field}_#{friendly.split(" ")[0]}"
        inputName = "#{post}[#{field}]"

        isChecked = true if (@pars[field] == val.to_s)
        haml_tag :input, :id=>inputID, :class=>"btn hide", :type=>'radio', :name=>inputName, :value=>val, :checked=>isChecked
        haml_concat "world"
      end
    end
    haml_tag :div, :class=>"btn-group", "data-toggle"=>"buttons-radio" do
      attrs.each do |friendly, val|
        inputID = "#{post}_#{field}_#{friendly.split(" ")[0]}"
        enab_class = "btn active" if @pars[field] == val.to_s
        enab_class = "btn" if not @pars[field] == val.to_s
        #label_tag(inputID, friendly, {:class=>enab_class})
        haml_tag :label, :for=>inputID, :class=>enab_class do
          haml_concat friendly
        end
      end
    end
    
  end

end
