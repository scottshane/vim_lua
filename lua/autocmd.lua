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
