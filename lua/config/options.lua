-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local keymap = vim.api.nvim_set_keymap
local keymap_opts = { noremap = true, silent = true }
local create_autocmd = vim.api.nvim_create_autocmd

-- Don't sync clipboard with system
opt.clipboard = ""
-- Disable relative line number
opt.relativenumber = false
-- Adds "_" as a word ending
opt.iskeyword:remove("_")
-- Sets language to Au English
opt.spelllang = "en_au"

opt.tabstop = 2 -- number of visual spaces per TAB
opt.shiftwidth = 2 -- Autoindent by # spaces when >> << ==
opt.softtabstop = 2 -- number of spaces in tab when editing

-- Uses C-c to copy from visual to clipboard
keymap("v", "<C-c>", 'y:call system("pbcopy", getreg("0"))<CR>', keymap_opts)

-- Uses F5 to turn on spell check
keymap("n", "<F5>", ":set spell!<CR>", keymap_opts)

-- ]s – Jump to the next misspelled word
-- [s – Jump to the previous misspelled word
-- z= – Bring up the suggested replacements
-- zg – Good word: Add the word under the cursor to the dictionary
-- zw – Woops! Undo and remove the word from the dictionary

-- Sets the correct syntax highlights for template files
create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.sh.tpl",
  command = "set filetype=bash",
})

create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.ps1.tpl",
  command = "set filetype=ps1",
})

create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.rb.tpl",
  command = "set filetype=ruby",
})

-- Allows opening 2 files side by side like so:
-- vi file_1 file_2
if #vim.fn.argv() == 2 then
  vim.cmd("vsplit " .. vim.fn.argv(1))
  vim.cmd("syntax enable")
end

-- Adds a cursor column
local cursorcolumn_group = vim.api.nvim_create_augroup("CursorColumn", { clear = true })

vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  group = cursorcolumn_group,
  pattern = "*",
  command = "setlocal cursorcolumn",
})
