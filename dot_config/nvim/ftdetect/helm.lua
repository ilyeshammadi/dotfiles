local function has_chart_yaml(path)
  local templates_idx = path:find("/templates/", 1, true)
  if not templates_idx then
    return false
  end
  local chart_root = path:sub(1, templates_idx - 1)
  return vim.uv.fs_stat(chart_root .. "/Chart.yaml") ~= nil
end

vim.filetype.add({
  pattern = {
    [".*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = function(path)
      return has_chart_yaml(path) and "helm" or nil
    end,
    [".*/templates/.*%.txt"] = function(path)
      return has_chart_yaml(path) and "helm" or nil
    end,
    [".*/values.-%.yaml"] = "yaml.helm-values",
  },
})
