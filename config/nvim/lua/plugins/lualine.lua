local config = function()
    require("lualine").setup({
        options = {
            theme = "rose-pine",
            globalstatus = true,
        },
        sections = {
            lualine_c = {
                'filename',
            },
            lualine_x = {
                function()
                    if _G.copilot_enable then
                        return ' '
                    else
                        return ' '
                    end
                end,
                "hostname",
                "filetype",
            },
        },
    })
end

return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = config,
}
