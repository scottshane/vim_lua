local ok, plenary_reloaded = pcall(require, "plenary.reload")
if not ok then
  reloader = require
else
  reloaded = plenary_reloaded.reload_module
end

P = function(v)
  print(vim.inspect(v))
end

RELOAD = function(...)
  return (...)
end

R = function(name)
  RELOAD(name)
  return require(name)
end
