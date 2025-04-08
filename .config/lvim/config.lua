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

-- Leader + R to run
lvim.keys.normal_mode["<leader>r"] = ":lua run_program()<CR>"
function run_program()
  local filename = vim.fn.expand("%:t")
  local ext = vim.fn.expand("%:e")
  
  if ext == "cpp" then
    -- C++, g++ 
    vim.cmd("lcd %:p:h | w! | belowright split | term g++ -std=c++20 % -o %:r && ./%:r")
  elseif ext == "py" then
    -- Python, uv
    vim.cmd("lcd %:p:h | w! | belowright split | term uv run %")
  else
    -- error message
    print("Unsupported file type")
  end
end

-- Check virtual environment (python)
local venv_python_path = vim.fn.getcwd() .. "/.venv/bin/python" 
-- Set Python interpreter for LSP
vim.g.python3_host_prog = venv_python_path
-- pyright
require'lspconfig'.pyright.setup{
  settings = {
    python = {
      pythonPath = venv_python_path,
    }
  }
}

-- Set default indentation for all files
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
