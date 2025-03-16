return {
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                icons = {},
            })

            vim.keymap.set("n", "<leader>tt", function()
                require("trouble").toggle("diagnostics")
                vim.defer_fn(function()
                    vim.cmd.wincmd("j")
                end, 30)
            end, {})

            vim.keymap.set("n", "]t", function()
                require("trouble").next({ skip_groups = true, jump = true });
            end)

            vim.keymap.set("n", "[t", function()
                require("trouble").prev({ skip_groups = true, jump = true });
            end)
        end
    },
}
