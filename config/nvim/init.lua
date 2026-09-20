require('config.lazy')
require('set')
require('vanilla_keymaps')

local function clear_buffers()
    local bufs = vim.api.nvim_list_bufs()
    local current_buf = vim.api.nvim_get_current_buf()
    for _, buf in ipairs(bufs) do
        if buf ~= current_buf and vim.api.nvim_buf_is_valid(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted') then
            vim.api.nvim_buf_delete(buf, {})
        end
    end
    local notify = require('notify')
    local notify_config = { title = 'Neovim', timeout = 2000, animate = false, icon = '' }
    notify('Buffers cleaned', 'info', notify_config)
end

vim.api.nvim_create_user_command("Love", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("!love " .. cwd)
end, {})

vim.keymap.set('n', '<leader>cb', clear_buffers, { silent = true, desc = 'Clear Buffers' })
vim.keymap.set('n', '<leader>l', ':Love<CR>', { silent = true, desc = 'Run Love2D' })
vim.keymap.set("n", "gf", "<cmd>edit <cfile><cr>")
