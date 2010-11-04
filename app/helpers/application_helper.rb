module ApplicationHelper
    # NOTE: Lifted from ActionView::Helpers::AssetTagHelper#collect_asset_files since it's
    #       private to that module
    def collect_asset_files(*path)
        dir = path.first

        Dir[File.join(*path.compact)].collect do |file|
            next if file =~ /\.min\./i
            file[-(file.size - dir.size - 1)..-1].sub(/\.\w+$/, '')
        end.compact.sort
    end

    def collect_javascript_files(javascript_subdir)
        collect_asset_files(config.javascripts_dir, javascript_subdir, '**', '*.js')
    end

    def collect_stylesheet_files(stylesheet_subdir)
        collect_asset_files(config.stylesheets_dir, stylesheet_subdir, '**', '*.css')
    end

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
