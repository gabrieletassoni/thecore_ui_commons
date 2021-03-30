puts "Loading ThecoreUiCommons seeds"
Settings.ns(:importer).import_from_folder = "tmp/imports" if Settings.ns(:importer).import_from_folder.blank?
Settings.ns(:importer).extension = "txt" if Settings.ns(:importer).extension.blank?