local M = {}
local config = require("code_printer.config")
local carbon = require("code_printer.carbon")

function M.setup(opts)
    config.setup(opts)
end

vim.api.nvim_create_user_command('CodePrint', function()
    carbon.generate_carbon_image()
end, {range = true})

return M
