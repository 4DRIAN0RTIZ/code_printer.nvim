-- Función para obtener el texto seleccionado en modo visual
local M = {}

function M.get_visual_selection()
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.api.nvim_buf_get_lines(0, start_pos[2]-1, end_pos[2], false)
    
    if #lines == 0 then return "" end
    
    -- Ajustar la primera y última línea según las columnas de selección
    if #lines == 1 then
        lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    else
        lines[1] = string.sub(lines[1], start_pos[3])
        lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
    end
    
    return table.concat(lines, "\n")
end

function M.get_name_and_extension_current_buffer()
    local file_name = vim.fn.expand("%:t:r")
    local extension = vim.fn.expand("%:e")
    return {file_name, extension}
end

-- Escapar caracteres especiales en JSON
function M.escape_json(str)
    return str:gsub("\\", "\\\\")
              :gsub('"', '\\"')
              :gsub("\n", "\\n")
              :gsub("\r", "\\r")
end

return M
