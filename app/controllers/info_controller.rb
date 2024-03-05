class InfoController < ApplicationController
    # This is a model-less controller just to render che swagger page using a custom layout
    layout 'swagger'
    def swagger
        uri = URI(request.url)
        @swagger_json_url = "#{uri.scheme}://#{uri.host}#{":#{uri.port}" if uri.port.present?}/api/v2/info/swagger.json"
    end
end