puts "Loading ThecoreUiCommons seeds"

Thecore::Seed.save_setting :importer, :import_from_folder, "tmp/imports"
Thecore::Seed.save_setting :importer, :extension, "txt"