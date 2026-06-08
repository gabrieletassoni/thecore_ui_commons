class InfoController < ApplicationController
    layout 'swagger'
    def swagger
        @version = params[:version].to_s.gsub(/[^a-zA-Z0-9]/, '')
        @versions = ThecoreUiCommons.swagger_api_versions
        uri = URI(request.url)
        @base_url = "#{uri.scheme}://#{uri.host}#{":#{uri.port}" if uri.port.present?}#{ENV.fetch("RAILS_RELATIVE_URL_ROOT", "")}"
        @swagger_json_url = "#{@base_url}/api/#{@version}/info/swagger.json"
    end
end
