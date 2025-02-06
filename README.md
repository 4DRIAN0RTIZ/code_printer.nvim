# Code Printer

A Neovim plugin that generates beautiful code screenshots using the Carbon API.

## Features

- Convert selected code into stylish PNG images
- Automatic file naming based on current buffer
- Configurable save directory
- Error handling and status feedback

## Requirements

- Neovim
- cURL
- Internet connection (to access Carbon API)

## Installation

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):

```lua
use '4DRIAN0RTIZ/code_printer.nvim'
```

## Configuration

```lua
require('code_printer').setup({
    save_dir = "~/Pictures", -- Default save directory
})
```

## Usage

1. Select the code you want to capture in visual mode
2. Run the command `:CodePrinter`

## Keybinding

You can create a keybinding to run the command faster. For example:

```lua
vim.api.nvim_set_keymap('n', '<leader>cp', ':CodePrinter<CR>', { noremap = true, silent = true })
```

The generated image will be saved in your configured directory.

## Output

The plugin generates PNG images with the following naming convention:
`CodePrinter_[filename]_[extension].png`

## License

MIT
