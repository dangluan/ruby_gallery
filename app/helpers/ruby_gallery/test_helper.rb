module RubyGallery::TestHelper
  def upload_factory(model_name, fields={})
    object = model_name.to_s.singularize.classify.constantize.find(params[:id])
    
    content_tag(:div, class: "factory-box") do
      content_tag(:form, action: "/upload_factories/upload_processes") 
      content_tag(:ul, class: "factory-content") do
        content_tag(:li, class: "factory-item") do
          [tag(:label, 'Upload Photo'),
          tag(:input, type: 'file', multiple: "", class: "factory-input")].join.html_safe
        end
      end
    end
    
  end #end def
end