vim.keymap.set('n', '<leader>e', ':Ex<CR>', { silent = true }, { description = 'Explorer' })
vim.keymap.set('n', '<c-h>', ':wincmd h<CR>', { silent = true }, { description = 'Move left' })
vim.keymap.set('n', '<c-l>', ':wincmd l<CR>', { silent = true }, { description = 'Move right' })
vim.keymap.set('n', '<c-k>', ':wincmd k<CR>', { silent = true }, { description = 'Move up' })
vim.keymap.set('n', '<c-j>', ':wincmd j<CR>', { silent = true }, { description = 'Move down' })
vim.keymap.set('n', "<leader>}", ':tabnext<CR>', { silent = true }, { description = 'Next tab' })
vim.keymap.set('n', '<leader>{', ':tabprevious<CR>', { silent = true }, { description = 'Previous tab' })
vim.keymap.set('n', '<Tab>', '>>', { noremap = true, silent = true }, { description = 'Indent' })
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true }, { description = 'Unindent' })
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true }, { description = 'Indent visual mode' })
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true }, { description = 'Unindent visual mode' })
vim.keymap.set('n', '<leader>jb', '<C-o>', { noremap = true, silent = true }, { description = 'Jump back' })
vim.keymap.set('n', '<leader>jf', '<C-i>', { noremap = true, silent = true }, { description = 'Jump forward' })

local notify = require("notify")
local current_tab_width = 2

local function apply_tab_width(width)
    current_tab_width = width
    vim.o.shiftwidth = width
    vim.o.tabstop = width
    vim.o.softtabstop = width

    -- update all loaded buffers
    for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
        if vim.api.nvim_buf_is_loaded(bufnr) then
            vim.bo[bufnr].shiftwidth = width
            vim.bo[bufnr].tabstop = width
            vim.bo[bufnr].softtabstop = width
        end
    end
end

local function toggle_tab_width()
    if current_tab_width == 2 then
        apply_tab_width(4)
        notify("Tab width set to 4 spaces", vim.log.levels.INFO, {
            title = "Neovim",
            timeout = 2000,
            icon = "",
        })
    else
        apply_tab_width(2)
        notify("Tab width set to 2 spaces", vim.log.levels.INFO, {
            title = "Neovim",
            timeout = 2000,
            icon = "",
        })
    end
end

-- ensure every new buffer inherits the current tab width
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        apply_tab_width(current_tab_width)
    end,
})
vim.keymap.set("n", "<leader>tt", toggle_tab_width, { desc = "Toggle tab width 2 <-> 4 (global)" })
