return {
    "folke/trouble.nvim",
    opts = {
        modes = {
            all_diagnostics = {
                mode = "diagnostics",
                filter = {
                    any = {
                        buf = 0,
                        {
                            severity = vim.diagnostic.severity.ERROR, -- errors only
                            function(item)
                                return item.filename:find((vim.loop or vim.uv).cwd(), 1, true)
                            end,
                        },
                    },
                },
            }
        },
    },
    cmd = "Trouble",
    keys = {
        {
            "<leader>LE",
            "<cmd>Trouble all_diagnostics toggle focus=true auto_close=true<cr>",
            desc = "Diagnostics (Trouble)",
        },
        {
            "<leader>le",
            "<cmd>Trouble diagnostics toggle filter.buf=0 focus=true auto_close=true<cr>",
            desc = "Buffer Diagnostics (Trouble)",
        },
        {
            "<leader>ls",
            "<cmd>Trouble symbols toggle focus=true win.position=bottom<cr>",
            desc = "Symbols (Trouble)",
        },
        {
            "<leader>ld",
            "<cmd>Trouble lsp_definitions toggle focus=true<cr>",
            desc = "LSP definitions (Trouble)",
        },
        {
            "<leader>lr",
            "<cmd>Trouble lsp_references toggle focus=true<cr>",
            desc = "LSP references (Trouble)",
        },
    },
}
