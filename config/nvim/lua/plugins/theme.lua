return {
    "rose-pine/neovim", name = "rose-pine",
    config = function ()
        require("rose-pine").setup({
            styles = { transparency = false },
            palette = {
                main = {
                    text = '#e0def4',
                    rose = '#ebbcba',
                }
            }
        })
        vim.cmd("colorscheme rose-pine")
    end
}
