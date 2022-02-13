--Autocommand reloads nvim whenever plugins.lua is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

vim.cmd [[
  augroup stylua_format_on_save
    autocmd!
    autocmd BufWritePost *.lua lua require("stylua-nvim").format_file()
  augroup end
]]

-- Remove all trailing whitespace on save
vim.api.nvim_exec(
  [[
  augroup TrimWhiteSpace
    au!
    autocmd BufWritePre * :%s/\s\+$//e
  augroup END
  ]],
  false
)
-- Prevent new line to also start with a comment
vim.api.nvim_exec(
  [[
  augroup NewLineComment
    au!
    au FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  augroup END
  ]],
  false
)
