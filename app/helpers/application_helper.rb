module ApplicationHelper
    def render_field(label, field, errors, description='')
        #.label_container
        #   %h3= label
        #.field_container
        #   .field
        #       = field
        #   .error_explanation
        #        %p= resource.errors[:name].join(', ') : ''
        #   .clear
        haml_tag 'div.label_container' do
            haml_tag :h3, label
            haml_tag :p, '(' + description + ')' if !description.blank?
        end
        haml_tag 'div.field_container' do
            haml_tag 'div.field', field
            if !errors.blank?
                haml_tag 'div.error_explanation' do
                    haml_tag :p, errors.join(', ')
                end
            end
            haml_tag 'div.clear'
        end
    end
end
