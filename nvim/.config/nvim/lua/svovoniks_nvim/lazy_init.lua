local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- installs lazy if its not installed already
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

-- adds lazy path to nvim search path
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = "svovoniks_nvim.lazy",
    change_detection = { notify = false }
})
