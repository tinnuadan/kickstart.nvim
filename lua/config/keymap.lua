-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
vim.keymap.set({ 'n', 'i' }, '<PageUp>', '<cmd>echo "Use Ctrl+U to move!!"<CR>')
vim.keymap.set({ 'n', 'i' }, '<PageDown>', '<cmd>echo "Use Ctrl+D to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set({ 'n', 't' }, '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 'n', 't' }, '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set({ 'n', 't' }, '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 'n', 't' }, '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<leader>xf', '<cmd>source %<CR>', { desc = 'E[x]ecute current [f]ile' })
vim.keymap.set('n', '<leader>xl', ':.lua<CR>', { desc = 'E[x]ecute current [l]ine' })
vim.keymap.set('v', '<leader>xs', ':lua<CR>', { desc = 'E[x]ecute current [s]election' })

vim.keymap.set({ 'n', 'i' }, '<A-]>', '<cmd>BufferNext<CR>', { remap = true })
vim.keymap.set({ 'n', 'i' }, '<A-[>', '<cmd>BufferPrevious<CR>', { remap = true })
vim.keymap.set({ 'n', 't' }, '<A-t>', '<cmd>tabnew<CR>', { remap = true })
vim.keymap.set({ 'n', 't' }, '<A-x>', '<cmd>BufferClose<CR>', { remap = true })

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

vim.keymap.set('i', '', '<cmd>echo "Use u to undo!"<CR>')
-- vim.keymap.set({ 'n', 'i', 'v' }, '', '<cmd>echo "Use :w to save!"<CR>')

vim.keymap.set('i', '<C-CR>', '<cmd>echo "Use Ctrl+Y"<CR>')

-- beginning / end of line
vim.keymap.set('n', 'gh', '_', { desc = 'Beginning of line' })
vim.keymap.set('n', 'gl', '$', { desc = 'End of line' })

-- Remap 'n' so that I don't hit it accidentally
vim.keymap.set('n', 'n', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-n>', 'n', { noremap = true, silent = true })
vim.keymap.set('n', '<C-p>', 'N', { noremap = true, silent = true })

local function getFullPath()
  local filepath = vim.fn.expand '%'
  return filepath
end

-- Copy current filepath to clipboard
local function insertFullPath()
  vim.fn.setreg('+', getFullPath()) -- write to clippoard
end

local function printFullPath()
  local filepath = getFullPath()
  print(filepath)
end

vim.keymap.set('n', '<leader>dpc', insertFullPath, { desc = '[D]ocument: [P]ath: [C]opy', noremap = true })
vim.keymap.set('n', '<leader>dpp', printFullPath, { desc = '[D]ocument: [P]ath: [P]rint', noremap = true })

