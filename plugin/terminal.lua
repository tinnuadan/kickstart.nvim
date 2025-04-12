local state = {
  terminal = {
    buf = -1,
    win = -1,
    job_id = 0,
  },
  editor = {
    win = -1,
  },
}

local TerminalModule = {}

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

TerminalModule.toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    state.editor.win = vim.api.nvim_get_current_win()
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

TerminalModule.auto_open_build_terminal = function()
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    state.editor.win = vim.api.nvim_get_current_win()
    state.terminal = create_terminal { buf = state.terminal.buf }
    if vim.bo[state.terminal.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    state.terminal.job_id = vim.bo.channel
  end
  -- vim.cmd 'normal i'
end

TerminalModule.send_command = function(opts)
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

TerminalModule.write_in_terminal = function(opts)
  opts = opts or {}
  local cmd = opts.cmd or nil
  if not cmd then
    return
  end
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    return
  end
  vim.api.nvim_feedkeys(cmd, 't', false)
end

TerminalModule.focus_editor_window = function()
  if not vim.api.nvim_win_is_valid(state.terminal.win) then
    return
  end
  if vim.api.nvim_get_current_win() == state.editor.win then
    return
  end
  vim.api.nvim_set_current_win(state.editor.win)
  -- local key = vim.api.nvim_replace_termcodes('<C-w>w', true, false, true)
  -- vim.api.nvim_feedkeys(key, 'n', false)
end

vim.api.nvim_create_user_command('ToggleTerminal', TerminalModule.toggle_terminal, {})
vim.api.nvim_create_user_command('OpenBuildTerminal', TerminalModule.auto_open_build_terminal, {})

vim.api.nvim_create_user_command('BuildGeneric', function()
  TerminalModule.auto_open_build_terminal()
  TerminalModule.send_command { cmd = 'sdk-make build install -j14; check-task $?\n' }
  -- TerminalModule.write_in_terminal { cmd = 'sdk-make build install -j14; check-task $?\n' }
  TerminalModule.focus_editor_window()
end, {})

-- Example usage:
-- Create a floating window with default dimensions
-- vim.api.nvim_create_user_command('toggle_terminal', toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, '<leader>tt', TerminalModule.toggle_terminal, { desc = '[T]oggle [T]erminal' })
--
-- vim.keymap.set('n', '<leader>bg', function()
-- send_command { cmd = "echo 'Hello World'\n" }
-- end, {})
--
--
--
--
