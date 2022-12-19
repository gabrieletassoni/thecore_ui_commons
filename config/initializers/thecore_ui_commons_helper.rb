module Helpers
    module ThecoreUiCommonsHelper
        def get_asset_tags_for(basename)
            out = []

            # Needs to reverse since Paths are traversed in the order they occur in the search path. By default, this means the files in app/assets take precedence, and will mask corresponding paths in lib and vendor.
            Rails.application.config.assets.paths.reverse.each do |basedir|
                base = "#{basedir}/**/#{basename}"
                base_s = Dir["#{base}.{css,scss}"]
                base_j = Dir["#{base}.js"]
                
                (out << stylesheet_link_tag("#{get_folder base_s}/#{basename}", media: 'all', 'data-turbo-track' => true) if base_s.any?) rescue nil
                (out << javascript_include_tag("#{get_folder base_j}/#{basename}", 'data-turbo-track' => true) if base_j.any?) rescue nil
            end

            # Application level assets
            (out << stylesheet_link_tag('application', media: 'all', 'data-turbo-track' => true)) rescue nil
            (out << javascript_include_tag('application', 'data-turbo-track' => true)) rescue nil

            out.join("\n").html_safe
        end
        
        def get_folder(base)
            base.first.split("/")[-2]
        end
    end
end

ActiveSupport.on_load(:action_view) { include Helpers::ThecoreUiCommonsHelper }