-- disable line numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
  group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
    vim.opt.statuscolumn = ''

    vim.bo.filetype = 'terminal'
  end,
})

-- local job_id = 0
-- local small_terminal = function()
--   vim.cmd.new()
--   vim.cmd.term()
--   vim.cmd.wincmd 'J'
--   vim.api.nvim_win_set_height(0, 30)
--
--   job_id = vim.bo.channel
-- end
--
-- vim.api.nvim_create_user_command('SmallTerminal', small_terminal, {})
--
-- local build_generic = function()
--   small_terminal()
--   -- vim.fn.chansend(job_id, { 'custom_build.sh\r\n' })
--   vim.fn.chansend(job_id, { 'echo "Hello World"\r\n' })
-- end
--
-- vim.keymap.set('n', '<leader>bg', build_generic, {})
