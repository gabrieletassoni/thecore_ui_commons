require 'thecore_background_jobs' # This brings backend commons also.
# Rails
require 'serviceworker-rails'
require "groupdate"
require "apexcharts"
# require "gtk3"
require "cairo"
require "poppler"
require "image_processing"

require 'concerns/thecore_ui_commons_user'

# require 'helpers/thecore_ui_commons_helper'
# require 'helpers/charts_helper'

require "thecore_ui_commons/engine"

module ThecoreUiCommons
  # Your code goes here...

	def self.save_files files
		# Rails.logger.debug "AAAAAAAAAAA: POST?"
		files.each do |pic|
			# Rails.logger.debug "AAAAAAAAAAA: EACH PIC: #{pic.inspect}"
			upload_dir = Rails.root.join(Settings.ns(:importer).import_from_folder, 'uploads')
			FileUtils.mkdir_p upload_dir
			# Rails.logger.debug "AAAAAAAAAAA: Fatto MKDIR di #{upload_dir}"
			file_to_upload = Rails.root.join(upload_dir, "uploaded-#{Time.now.strftime("%Y%m%d%H%M%S%L")}-#{pic.original_filename}")
			# Rails.logger.debug "AAAAAAAAAAA: File da uploadare #{file_to_upload}"
			File.open(file_to_upload, 'wb') do |file|
				# Rails.logger.debug "AAAAAAAAAAAAAAAAAA: Dentro alla scrittura"
				file.write(pic.read)
			end if Regexp.new("\\.#{Settings.ns(:importer).extension.gsub(/ +/, "").split(",").join("|\\.")}$").match? pic.original_filename
		end
	end
end
