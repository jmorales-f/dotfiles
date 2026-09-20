return {
    "jiaoshijie/undotree",
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
        window = {
            winblend = 0,
        },
    },
    keys = {
        { "<leader>u", "<cmd>lua require('undotree').toggle()<CR>" },
    },

}
