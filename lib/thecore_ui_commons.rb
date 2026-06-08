require "thecore_backend_commons"
require "haml"
require "haml-rails"
# require "serviceworker-rails"
require "groupdate"
# require "apexcharts"
require "rails_charts"
require "echarts/speedometer"
require "echarts/vector"
require "echarts/multiple_vectors"
require "echarts/binary"
require "echarts/binary_series"
require "echarts/map"
require "omniauth/rails_csrf_protection"

require "thecore_ui_commons/engine"

module ThecoreUiCommons
	mattr_accessor :swagger_api_versions, default: []

	def self.scan_swagger_routes(routes)
		routes
			.map { |r| r.path.spec.to_s }
			.grep(/\/api\/(v\d+)\/info\/swagger/)
			.map { |p| p.match(/\/api\/(v\d+)\/info\/swagger/)[1] }
			.uniq
			.sort_by { |v| v[1..].to_i }
	end

	def self.save_files files
		files.each do |pic|
			upload_dir = Rails.root.join(Settings.ns(:importer).import_from_folder, 'uploads')
			FileUtils.mkdir_p upload_dir
			file_to_upload = Rails.root.join(upload_dir, "uploaded-#{Time.now.strftime("%Y%m%d%H%M%S%L")}-#{pic.original_filename}")
			
			File.open(file_to_upload, 'wb') { |file| file.write(pic.read) } if Regexp.new("\\.#{Settings.ns(:importer).extension.gsub(/ +/, "").split(",").join("|\\.")}$").match? pic.original_filename
		end
	end
end
