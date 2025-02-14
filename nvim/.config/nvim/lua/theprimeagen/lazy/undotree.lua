return {
    "mbbill/undotree",

    config = function()
        vim.keymap.set("n", "<leader>u", function()
            vim.cmd.UndotreeToggle()
            vim.defer_fn(function() -- Defer the focus switch
                -- vim.cmd('wincmd p') -- Switch focus to the previous (Undotree) window
                vim.cmd.wincmd("p") -- Switch to the undo tree window
            end, 1)
        end, { desc = "Toggle UndoTree and switch to it" })
    end
}
