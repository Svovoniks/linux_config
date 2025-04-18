return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/nvim-cmp",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter-context",
        "ranjithshegde/ccls.nvim",
    },

    config = function()
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())

        local util = require "lspconfig.util"
        local server_config = {
            filetypes = { "c", "cpp", "objc", "objcpp", "opencl" },
            root_dir = function(fname)
                return util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
                    or vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
                    or vim.fn.getcwd()
            end,
            clang = {
                extraArgs = { "--gcc-toolchain=/usr", "--driver-mode=g++" }
            }
        }
        require("ccls").setup { lsp = { lspconfig = server_config } }
        require("treesitter-context")
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            automatic_installation = {},
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "gopls",
                "pyright",
            },
            handlers = {
                function(server_name) -- default handler (optional)
                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["sqlls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.sqlls.setup({
                        capabilities = capabilities,
                        filetypes = { 'sql' },
                        root_dir = function()
                            return vim.fn.getcwd()
                        end
                    })
                end,
                ["pyright"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.pyright.setup({
                        settings = {
                            python = {
                                pythonPath = "/usr/bin/python3.12"
                            },
                        },
                        root_dir = function()
                            return vim.fn.getcwd()
                        end
                    })
                end,
                ["bashls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.bashls.setup({
                        capabilities = capabilities,
                        filetypes = { "sh" },
                        root_dir = function()
                            return vim.fn.getcwd()
                        end,
                    })
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        capabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "bit", "vim", "it", "describe", "before_each", "after_each", "require" },
                                }
                            }
                        }
                    }
                end,
            }
        })

        local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                end,
            },

            window = {
                completion = cmp.config.window.bordered({ border = "none" }),
                documentation = cmp.config.window.bordered({ border = "none" }),
            },


            mapping = cmp.mapping.preset.insert({
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'luasnip' }, -- For luasnip users.
            }, {
                { name = 'buffer' },
            }),
            completion = {
                completeopt = 'menu,menuone,noinsert',
            }
        })

        vim.diagnostic.config({
            -- update_in_insert = true,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end
}
