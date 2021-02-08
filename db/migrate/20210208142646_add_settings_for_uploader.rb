class AddSettingsForUploader < ActiveRecord::Migration[6.0]
  def change
    Settings.ns(:importer).import_from_folder = "tmp/imports"
    Settings.ns(:importer).extension = "txt"
  end
end
