return {
  'kevinhwang91/nvim-ufo',
  event = 'VimEnter',
  dependencies = {
    'kevinhwang91/promise-async',
    {
      'luukvbaal/statuscol.nvim',
      event = 'VeryLazy',
      opts = function()
        local builtin = require 'statuscol.builtin'
        return {
          setopt = true,
          relculright = true,
          segments = {
            { sign = { namespace = { 'gitsigns' }, colwidth = 1, maxwidth = 1 } },
            { sign = { namespace = { 'diagnostic/signs' }, name = { 'Dap*' }, colwidth = 1, maxwidth = 1 } },
            { text = { builtin.foldfunc, ' ' }, click = 'v:lua.ScFa' },
            {
              sign = { name = { '.*' }, maxwidth = 1, colwidth = 1, auto = true },
              click = 'v:lua.ScSa',
            },
            {
              text = { builtin.lnumfunc, ' ' },
              condition = { true, builtin.not_empty },
              click = 'v:lua.ScLa',
            },
          },
        }
      end,
    },
  },
  config = function()
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    vim.keymap.set('n', 'zK', function()
      local winid = require('ufo').peekFoldedLinesUnderCursor()
      if not winid then
        vim.lsp.buf.hover()
      end
    end, { desc = 'Peek Fold' })

    require('ufo').setup {
      open_fold_hl_timeout = 0,
      close_fold_kinds_for_ft = {
        default = { 'imports', 'comment' },
      },
      preview = {
        win_config = {
          border = { '', '─', '', '', '', '─', '', '' },
          winhighlight = '',
          winblend = 0,
        },
        mappings = {
          scrollU = '<C-u>',
          scrollD = '<C-d>',
          jumpTop = '[',
          jumpBot = ']',
        },
      },
      enable_get_fold_virt_text = true,
      fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
        local newVirtText = {}
        local totalLines = vim.api.nvim_buf_line_count(0)
        local foldedLines = endLnum - lnum
        local suffix = (' 󰁂 %d %d%%'):format(foldedLines, foldedLines / totalLines * 100)
        local sufWidth = vim.fn.strdisplaywidth(suffix)
        local targetWidth = width - sufWidth
        local curWidth = 0
        for _, chunk in ipairs(virtText) do
          local chunkText = chunk[1]
          local chunkWidth = vim.fn.strdisplaywidth(chunkText)
          if targetWidth > curWidth + chunkWidth then
            table.insert(newVirtText, chunk)
          else
            chunkText = truncate(chunkText, targetWidth - curWidth)
            local hlGroup = chunk[2]
            table.insert(newVirtText, { chunkText, hlGroup })
            chunkWidth = vim.fn.strdisplaywidth(chunkText)
            -- str width returned from truncate() may less than 2nd argument, need padding
            if curWidth + chunkWidth < targetWidth then
              suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
            end
            break
          end
          curWidth = curWidth + chunkWidth
        end
        local rAlignAppndx = math.max(math.min(vim.opt.textwidth['_value'], width - 1) - curWidth - sufWidth, 0)
        suffix = (' '):rep(rAlignAppndx) .. suffix
        table.insert(newVirtText, { suffix, 'MoreMsg' })
        return newVirtText
      end,
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end,
    }
  end,
}
