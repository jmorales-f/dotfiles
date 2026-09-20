return {
    'terrortylor/nvim-comment',
    config = function()
        require('nvim_comment').setup({create_mappings = false})
        vim.keymap.set('v', '<leader>cc', ":'<,'>CommentToggle<CR>", {silent=true}, {description='Toggle comment (Visual mode)'})
        vim.keymap.set('n', '<leader>cc', ":CommentToggle<CR>", {silent=true}, {description='Toggle comment (Visual mode)'})
    end
}
