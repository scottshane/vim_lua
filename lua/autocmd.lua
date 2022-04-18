--Autocommand reloads nvim whenever plugins.lua is saved
vim.api.nvim_exec(
  [[
augroup Packer_user_config
au!
au BufWritePost plugins.lua source <afile> | PackerSync
augroup END
]],
  false
)

vim.api.nvim_exec(
  [[
augroup Stylua_format_on_save
au!
au BufWritePost *.lua lua require("stylua-nvim").format_file()
augroup end
]],
  false
)
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

-- Stop comments on newline
vim.cmd [[
augroup NoCommentNewLine
  au!
  au BufWinEnter * :set formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
]]

-- Disable lualine on Nvim-tree
-- vim.cmd [[
-- au!
-- au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree_1" | set laststatus=0 | else | set laststatus=2 | endif]]
--
-- realtime update change on disk
vim.api.nvim_exec(
  [[
  set autoread
  augroup UpdateChangeOnDisk
  au!
    au CursorHold * checktime
    call feedkeys('lh')
  augroup END
]],
  false
)

-- change to local directory under active buffer
vim.api.nvim_exec(
  [[
augroup cd_to_buffer_directory
au!
au BufEnter * silent! lcd %:p:h
augroup END
]],
  false
)
