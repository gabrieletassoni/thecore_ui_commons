Rails.application.config.active_storage.configure(
    :Disk,
    root: Rails.root.join("storage")
)