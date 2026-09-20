return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = function()
        local gs = require("gitsigns")
        local notify = require("notify")

        local notify_config = { title = "Git", timeout = 2000, animate = false, icon = "" }
        local blame_enabled = false

        local function toggle_blame()
            gs.toggle_current_line_blame()
            blame_enabled = not blame_enabled
            if blame_enabled then
                notify("Current line blame enabled", "info", notify_config)
            else
                notify("Current line blame disabled", "error", notify_config)
            end
        end

        local function open_diff()
            gs.diffthis()
            vim.cmd.wincmd("h")
        end

        return {
            max_file_length = 10000, -- disable if file is longer than this (in lines)
            signs = {
                add = { text = "▎" },
                change = { text = "▎" },
                delete = { text = "" },
                topdelete = { text = "" },
                changedelete = { text = "▎" },
                untracked = { text = "▎" },
            },
            on_attach = function(bufnr)
                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                map("n", "<leader>gd", open_diff, { silent = true, desc = "Diff this" })
                map("n", "<leader>gb", toggle_blame, { silent = true, desc = "Toggle inline blame" })
            end,
        }
    end,
}
