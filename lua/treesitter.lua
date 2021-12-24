local status_ok, configs  = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsed w/ maintainers), or list of languages
  sync_installed = false, -- install languages syncronously ( only applied to `ensure_installed` )
  ignore_install = {""}, -- list of parsers to ignore installing
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting= true,
  },
  indent = {
    enabled = true, disable = {"yaml"} 
  }
}
