vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":Ex<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever
vim.keymap.set("x", "<leader>r", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set("n", "<leader>p", [["+p]])
vim.keymap.set("n", "<leader>P", [["+P]])
vim.keymap.set("v", "<leader>p", [["+p]])
vim.keymap.set("v", "<leader>P", [["+P]])

-- make copy
vim.keymap.set("n", "<leader>mc", function()
    local current_file = vim.api.nvim_buf_get_name(0)
    local file_name = vim.fn.input("New file name: ", current_file, "file")
    vim.cmd("write " .. file_name)
    vim.cmd("edit " .. file_name)
end, { noremap = true, silent = true })

-- place prackets
vim.keymap.set("n", "<leader>pb", [[A{<CR>}<Esc>O]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("i", "jj", "<Esc>")

vim.keymap.set("i", "<C-s>", [[<Esc>:w<CR>]])
vim.keymap.set("v", "<C-s>", [[<Esc>:w<CR>]])
vim.keymap.set("n", "<C-s>", [[<Esc>:w<CR>]])
vim.keymap.set("x", "<C-s>", [[<Esc>:w<CR>]])

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<F2>",
    [[:lua os.execute(string.format('GNOME_TERMINAL_SCREEN=""; i3-sensible-terminal -e "cd %s; exec zsh" &', vim.fn.expand('%:h'))) <CR>]])

vim.keymap.set("n", "<leader>j", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>cprev<CR>zz")

vim.keymap.set("n", "<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>n", [[:e %:h/<C-r><C-w>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)


vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

local function toggle_hlsearch()
    vim.o.hlsearch = not vim.o.hlsearch
    if vim.o.hlsearch then
        print("hls: ON")
    else
        print("hls: OFF")
    end
end


vim.keymap.set('n', '<leader>f', function()
    vim.lsp.buf.format()
end, { noremap = true, silent = true })

-- fun animation
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");
vim.keymap.set("n", "<leader>hs", toggle_hlsearch, { desc = "Toggle hlsearch" })
vim.keymap.set("n", "<leader>mm", [[`]], { desc = "Marker" })
