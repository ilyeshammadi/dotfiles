vim.schedule(function()
  local ok = true
  local function chk(name, fn)
    local good, err = pcall(fn)
    good = good and err ~= false
    if not good then ok = false end
    print(('%-36s %s'):format(name, good and 'ok' or ('FAIL ' .. tostring(err))))
  end
  local km = {}
  for _, m in ipairs(vim.api.nvim_get_keymap('n')) do km[m.lhs] = m end

  chk('folds: native treesitter foldexpr', function() return vim.o.foldexpr == 'v:lua.vim.treesitter.foldexpr()' end)
  chk('folds: foldexpr evaluates', function()
    vim.cmd.edit(vim.fn.stdpath('config') .. '/lua/ilyes/core/options.lua')
    vim.treesitter.start()
    return vim.api.nvim_eval('v:lua.vim.treesitter.foldexpr(1)') ~= nil
  end)
  chk('fillchars intact', function() return vim.o.fillchars:find('foldclose:\239\145\160') ~= nil end)
  chk('mini.icons mocks devicons', function() return require('nvim-web-devicons').get_icon('a.lua') ~= nil end)
  chk('outline icons have icon+hl', function()
    local s = require('outline.config').o.symbols.icons
    return #s.Class.icon > 0 and s.Class.hl:match('^MiniIcons') ~= nil and s.Component ~= nil
  end)
  chk('blink snippets: no luasnip', function()
    return package.loaded['luasnip'] == nil and require('blink.cmp.config').snippets.preset == 'default'
  end)
  chk('gc native, mini.comment gone', function() return km['gcc'] ~= nil and package.loaded['mini.comment'] == nil end)
  chk('grn/gra left as Nvim defaults', function()
    return km['grn'].desc == 'vim.lsp.buf.rename()' and km['gra'].desc == 'vim.lsp.buf.code_action()'
  end)
  chk('K left to LSP default', function() return km['K'] == nil end)
  chk('[<Space> is Nvim default', function() return km['[ '].desc == 'Add empty line above cursor' end)
  chk(']q still advances quickfix', function()
    vim.fn.setqflist { { filename = 'a', lnum = 1, text = '1' }, { filename = 'a', lnum = 2, text = '2' } }
    vim.cmd 'cfirst'
    vim.api.nvim_feedkeys(']q', 'x', false)
    return vim.fn.getqflist({ idx = 0 }).idx == 2
  end)
  chk('qq toggles quickfix', function()
    vim.fn.setqflist { { filename = 'x', lnum = 1, text = 'y' } }
    vim.api.nvim_feedkeys('qq', 'x', false)
    local opened = vim.fn.getqflist({ winid = 0 }).winid ~= 0
    vim.api.nvim_feedkeys('qq', 'x', false)
    return opened and vim.fn.getqflist({ winid = 0 }).winid == 0
  end)
  chk('format on save: lua yes, python no', function()
    vim.system({ 'stylua', '--version' }):wait() -- warm the binary; first spawn is slow here
    local dir = vim.fn.tempname()
    vim.fn.mkdir(dir, 'p')
    local function roundtrip(name, text)
      local f = dir .. '/' .. name
      vim.fn.writefile({ text }, f)
      vim.cmd.edit(f)
      vim.cmd.write()
      return table.concat(vim.fn.readfile(f), '\n')
    end
    local lua = roundtrip('x.lua', 'local   a =  1')
    local py = roundtrip('x.py', 'x  =  1')
    if lua ~= 'local a = 1' then error('lua not formatted: ' .. vim.inspect(lua)) end
    if py ~= 'x  =  1' then error('python WAS formatted: ' .. vim.inspect(py)) end
    return true
  end)
  chk('capabilities set once via "*"', function()
    return vim.lsp.config['*'].capabilities.textDocument.completion ~= nil
      and vim.lsp.config['gopls'].settings.gopls ~= nil
  end)
  chk('all servers enabled', function()
    local want = { 'basedpyright', 'gopls', 'emmylua_ls', 'yamlls', 'helm_ls', 'terraformls', 'nil_ls' }
    for _, n in ipairs(want) do if not vim.lsp.is_enabled(n) then error(n .. ' not enabled') end end
    return true
  end)
  chk('dropped modules absent', function()
    return package.loaded['markview'] == nil and pcall(require, 'ilyes.core.icons') == false
  end)
  chk('tabline + bqf still set up', function()
    return package.loaded['tabline'] ~= nil and package.loaded['bqf'] ~= nil
  end)
  chk('cursor restore autocmd exists', function()
    return #vim.api.nvim_get_autocmds { event = 'BufReadPost', group = 'ilyes-restore-cursor' } == 1
  end)
  chk('gl float wraps long diagnostics', function()
    local buf = vim.api.nvim_create_buf(true, false)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { 'x' })
    vim.api.nvim_set_current_buf(buf)
    vim.diagnostic.set(vim.api.nvim_create_namespace('t'), buf, {
      { lnum = 0, col = 0, message = ('word '):rep(60), severity = vim.diagnostic.severity.ERROR },
    })
    local _, win = vim.diagnostic.open_float()
    if not win then error('no float opened') end
    if not vim.wo[win].wrap then error('float has wrap off') end
    local h = vim.api.nvim_win_get_height(win)
    vim.api.nvim_win_close(win, true)
    if h < 2 then error('float is 1 line tall -> text was truncated, not wrapped') end
    return true
  end)
  print(ok and '\nALL OK' or '\nFAILURES')
  vim.cmd(ok and 'qa!' or 'cq!')
end)

-- Run with:
--   nvim --headless -c 'luafile ~/.config/nvim/check.lua'
-- Exits non-zero on failure. Asserts the Nvim-native/already-installed
-- replacements this config leans on still hold after an upgrade.
