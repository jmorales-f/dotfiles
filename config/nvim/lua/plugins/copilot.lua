return {
    'github/copilot.vim',
    config = function()
        local notify = require("notify")
        local copilot_notify = { title = 'Copilot', timeout = 2000, animate = false, icon = '' }
        _G.copilot_enable = true
        local function toggle_copilot()
            if _G.copilot_enable then
                vim.cmd('Copilot disable')
                notify('Copilot disabled', 'error', copilot_notify)
                _G.copilot_enable = false
            else
                vim.cmd('Copilot enable')
                notify('Copilot enabled', 'info', copilot_notify)
                _G.copilot_enable = true
            end
        end
        vim.keymap.set('n', '<leader>cp', toggle_copilot, { silent = true, desc = 'Toggle Copilot' })
    end
}
