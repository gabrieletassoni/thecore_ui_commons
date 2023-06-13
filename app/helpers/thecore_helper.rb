module ThecoreHelper
    def bootstrap_class_for(flash_type)
        { success: "alert-success", error: "alert-error", alert: "alert-danger", notice: "alert-info" }[flash_type.to_sym] || flash_type.to_s
    end
    
    def line_break s
        s.gsub("\n", "<br/>")
    end
end