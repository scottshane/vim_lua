local status_ok, treesitter  = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

treesitter.setup{
  ensure_installed = "maintained", -- one of "all", "maintained" (parsed w/ maintainers), or list of languages
  sync_installed = false, -- install languages syncronously ( only applied to `ensure_installed` )
  ignore_install = {""}, -- list of parsers to ignore installing
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting= true,
  },
  indent = {
    enabled = true, 
    disable = {"yaml"} 
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
    context_commentstring = {
      enable = true,
      config = {
        javascript = {
          __default = "// %s",
          jsx_element = "{/* %s */}",
          jsx_fragment = "{/* %s */}",
          jsx_attribute = "// %s",
          comment = "// %s"
        }
      }
    }
  }
}
