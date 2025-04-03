-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup()
  end,
},
  { "olivercederborg/poimandres.nvim" },
}

-- Theme
lvim.colorscheme = "poimandres"

-- Open terminal with a fixed size
function ToggleTermSplit()
  local term_buf = nil
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, "buftype") == "terminal" then
      term_buf = buf
      break
    end
  end

  if term_buf then
    -- If terminal exists, close it
    vim.cmd("bd! " .. term_buf)
  else
    -- If no terminal, open a new split terminal
    vim.cmd("belowright 10split | term")
  end
end

lvim.keys.normal_mode["<leader>t"] = ":lua ToggleTermSplit()<CR>"

-- Make Escape exit terminal mode easily
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Leader + R to compile and run (C++)
lvim.keys.normal_mode["<leader>r"] = ":lua vim.cmd('lcd %:p:h | w! | !g++ % -o %:r && ./%:r')<CR>"

