local config = require('code_printer.config')
local utils = require('code_printer.utils')

-- Función principal que se llamará desde el comando de Neovim
local function generate_carbon_image()
    -- Obtener el código seleccionado
    local code = utils.get_visual_selection()
    local currentBuffer = utils.get_name_and_extension_current_buffer()
    local fileName = currentBuffer[1]
    local extension = currentBuffer[2]
    local outputFileName = string.format("CodePrinter_%s_%s", fileName, extension)
    if code == "" then
        print("? Error: No hay texto seleccionado")
        return
    end

    local escaped_code = utils.escape_json(code)
    
    -- Crear el JSON con el código seleccionado
    local json_payload = string.format([[{"code": "%s", "backgroundColor": "#1F816D"}]], escaped_code)
    
    -- Guardar el JSON en un archivo temporal
    local json_file = os.tmpname()
    local temp_file = io.open(json_file, "w")
    temp_file:write(json_payload)
    temp_file:close()
    
    -- Comando cURL para hacer la solicitud
    -- Modificar el comando cURL para usar el nuevo nombre de archivo
    local curl_command = string.format(
        'curl -s -L -X POST "https://carbonara.solopov.dev/api/cook" ' ..
        '-H "Content-Type: application/json" ' ..
        '-d @%s -o %s/%s -w "HTTP_STATUS:%%{http_code}"', 
        json_file, 
        config.options.save_dir,
        outputFileName .. ".png"
    )
    
    local handle = io.popen(curl_command)
    local result = handle:read("*a")
    handle:close()
    
    -- Eliminar el archivo temporal
    os.remove(json_file)
    
    -- Verificar el código HTTP de la respuesta
    if result:match("HTTP_STATUS:200") then
        print("Imagen guardada como " .. config.options.save_dir .. "/" .. outputFileName .. ".png")
    else
        print("Error en la solicitud. Respuesta de cURL:\n" .. result)
    end
end

return {
    generate_carbon_image = generate_carbon_image,
}
