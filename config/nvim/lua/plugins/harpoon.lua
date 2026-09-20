return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    lazy = false,
    opts = {},
    config = function()
        local harpoon = require("harpoon")
        local notify = require("notify")

        harpoon:setup()

        local notify_opts = { title = "Harpoon", timeout = 1500, animate = false }

        for i = 1, 5 do
            vim.keymap.set("n", "<leader>" .. i, function()
                harpoon:list():select(i)
            end, { noremap = true, silent = true, desc = 'Select harpoon file ' .. i })

            vim.keymap.set("n", "<leader>h" .. i, function()
                harpoon:list():replace_at(i)
                notify('Setted as file ' .. i, 'info', notify_opts)
            end, { noremap = true, silent = true, desc = 'Setted as file ' .. i })
        end

        vim.keymap.set("n", "<leader>hr", function()
            harpoon.data = require("harpoon.data").Data:new(harpoon.config)
            harpoon.lists = {}
            notify('Harpoon marks reloaded from disk', 'info', notify_opts)
        end, { noremap = true, silent = true, desc='Reload Harpoon data from disk' })
    end
}

