local state = {
  terminal = {
    buf = -1,
    win = -1,
    job_id = 0,
  },
}

local function create_terminal(opts)
  opts = opts or {}
  local width = opts.height or vim.o.columns
  local height = opts.height or math.floor(vim.o.lines * 0.3)

  -- Calculate the position to center the window
  -- local col = math.floor((vim.o.columns - width) / 2)
  -- local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  end

  -- Define window configuration
  local win_config = {
    -- relative = 'editor',
    width = width,
    height = height,
    win = 0,
    split = 'below',
    -- col = col,
    -- row = row,
    -- style = 'minimal', -- No borders or extra UI elements
    -- border = 'rounded',
  }

  -- Create the terminal window
  local win = vim.api.nvim_open_win(buf, true, win_config)
  -- local win = vim.api.nvim_open_win(buf, false, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    state.terminal = create_terminal { buf = state.terminal.buf }
    if vim.bo[state.terminal.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    state.terminal.job_id = vim.bo.channel
    -- if cmd and state.terminal.job_id ~= 0 then
    --   vim.api.nvim_chan_send(state.terminal.job_id, cmd)
    -- end
  else
    vim.api.nvim_win_hide(state.terminal.win)
  end
  vim.cmd 'normal i'
end

local function send_command(opts)
  opts = opts or {}
  local cmd = opts.cmd or nil
  if not cmd then
    return
  end
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    return
  end
  vim.api.nvim_chan_send(state.terminal.job_id, cmd)
end

vim.api.nvim_create_user_command('ToggleTerminal', toggle_terminal, {})

-- Example usage:
-- Create a floating window with default dimensions
-- vim.api.nvim_create_user_command('toggle_terminal', toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, '<leader>tt', toggle_terminal, { desc = '[T]oggle [T]erminal' })
--
-- vim.keymap.set('n', '<leader>bg', function()
-- send_command { cmd = "echo 'Hello World'\n" }
-- end, {})
--
--
--
--
