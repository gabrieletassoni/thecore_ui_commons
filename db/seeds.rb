puts "Loading ThecoreUiCommons seeds"
Settings.ns(:importer).import_from_folder = "tmp/imports"
Settings.ns(:importer).extension = "txt"