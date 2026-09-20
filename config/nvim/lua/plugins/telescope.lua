return {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
        local preview_utils = require("telescope.previewers.utils")

        preview_utils.ts_highlighter = function(bufnr, ft)
            if not ft or ft == "" then
                return false
            end

            local ok, lang = pcall(vim.treesitter.language.get_lang, ft)

            if not ok then
                lang = ft
            end

            if not lang or lang == "" then
                return false
            end

            return pcall(vim.treesitter.start, bufnr, lang)
        end

        local actions = require('telescope.actions')
        local telescope = require('telescope.builtin')
        vim.keymap.set('n', '<leader>ff', telescope.find_files, {}, { description = 'Find files' })
        vim.keymap.set('n', '<leader>fw', telescope.live_grep, {}, { description = 'Find word' })
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    },
                }
            }
        }
    end
}
