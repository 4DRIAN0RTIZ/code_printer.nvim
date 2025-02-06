local config = {}

config.default = {
    save_dir = "~/Pictures",
}

config.options = {}

function config.setup(opts)
    config.options = vim.tbl_deep_extend("force", {}, config.default, opts or {})
end

return config
