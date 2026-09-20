local mason_opts = {
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
        border = "rounded",
        style = {
            border = "single",
        },
    },
}

local ensure_installed = {
    "cssls",
    "html",
    "lua_ls",
    "vtsls",
    "bashls",
    "pylsp",
    "gopls"
}

local config = function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")

    mason.setup(mason_opts)
    mason_lspconfig.setup({
        ensure_installed = ensure_installed,
        automatic_installation = true,
    })

    local border = {
        { "┏", "FloatBorder" }, -- upper left
        { "━", "FloatBorder" }, -- upper
        { "┓", "FloatBorder" }, -- upper right
        { "┃", "FloatBorder" }, -- right
        { "┛", "FloatBorder" }, -- lower right
        { "━", "FloatBorder" }, -- lower
        { "┗", "FloatBorder" }, -- lower left
        { "┃", "FloatBorder" }, -- left
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts = opts or {}
        opts.border = opts.border or border
        return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    local kind_icons = {
        Text = "",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰇽",
        Variable = "󰂡",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰅲",
    }

    local cmp = require("cmp")
    cmp.setup({
        sources = {
            { name = "nvim_lsp" },
        },
        mapping = cmp.mapping.preset.insert({
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<C-Space>"] = cmp.mapping.complete(),
        }),

        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        window = {
            documentation = cmp.config.window.bordered({
                border = border,
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
            }),
            completion = cmp.config.window.bordered({
                border = border,
                winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder",
            }),
        },
        formatting = {
            format =
                function(entry, vim_item)
                    local lspkind_ok, lspkind = pcall(require, "lspkind")
                    if not lspkind_ok then
                        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
                        return vim_item
                    else
                        return lspkind.cmp_format()(entry, vim_item)
                    end
                end
        },
    })

    -- vim.api.nvim_create_autocmd('LspAttach', {
    --     callback = function(args)
    --         local client = vim.lsp.get_client_by_id(args.data.client_id)
    --         if not client then
    --             return
    --         end
    --         if client.supports_method('textDocument/formatting') then
    --             vim.api.nvim_create_autocmd('BufWritePre', {
    --                 buffer = args.buf,
    --                 callback = function()
    --                     vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
    --                 end,
    --             })
    --         end
    --     end
    -- })

    local function restart_lsp()
        local notify = require("notify")
        vim.cmd('LspRestart<CR>')
        notify('LSP restarted', 'info', { title = "LSP", timeout = 2000, animate = false, icon = "" })
    end

    vim.keymap.set('n', '<leader>rl', restart_lsp, { silent = true }, { description = 'Restart LSP' })
    vim.keymap.set('n', '<leader>ca', ':lua vim.lsp.buf.code_action()<CR>', { silent = true },
        { description = 'Code action' })
    vim.keymap.set('n', '<leader>jd', ':lua vim.lsp.buf.definition()<CR>', { silent = true }, {
        description =
        'Definition'
    })
    vim.keymap.set('n', '<leader>i', ':lua vim.lsp.buf.hover()<CR>', { silent = true }, { description = 'Hover' })
    vim.keymap.set('n', '<leader>rn', ':lua vim.lsp.buf.rename()<CR>', { silent = true }, { description = 'Rename' })
end

return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "L3MON4D3/LuaSnip",
    },
    lazy = false,
    config = config,
}
