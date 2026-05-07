-- Key mapping for buffer switching
-- Leader mappings (<leader>n, <leader>p, <leader>d)
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete Buffer" })

vim.keymap.set({ "n", "t" }, "<C-t>", function()
    if vim.bo.buftype == "terminal" then
        vim.api.nvim_win_hide(0)
        return
    end
    local cwd = vim.fn.expand("%:p:h")
    if cwd == "" or cwd:match("^%a+://") then
        cwd = vim.fn.getcwd()
    end
    Snacks.terminal.toggle(nil, { id = "file_term", cwd = cwd })
end, { desc = "Terminal (Current File)" })

-- Compile C++ quickly
vim.keymap.set("n", "<leader>r", function()
    vim.cmd("silent! w")

    local ft = vim.bo.filetype
    local file = vim.fn.shellescape(vim.fn.expand("%:p"))
    local file_no_ext = vim.fn.shellescape(vim.fn.expand("%:p:r"))
    local dir = vim.fn.shellescape(vim.fn.expand("%:p:h"))
    local raw_dir = vim.fn.expand("%:p:h")

    local function compile_and_run(compiler, ext)
        if vim.fn.filereadable(raw_dir .. "/Makefile") == 1 then
            return "cd " .. dir .. " && make"
        end
        local choice = vim.fn.confirm("Compile Mode:", "&1. Just this file\n&2. All *." .. ext .. " files", 1)
        if choice == 1 then
            return "cd " .. dir .. " && " .. compiler .. " " .. file .. " -o " .. file_no_ext .. " && " .. file_no_ext
        elseif choice == 2 then
            return "cd " .. dir .. " && " .. compiler .. " *." .. ext .. " -o " .. file_no_ext .. " && " .. file_no_ext
        end
        return nil
    end

    local runners = {
        javascript = "node " .. file,
        python = "python3 " .. file,
        sh = "bash " .. file,
        c = function()
            return compile_and_run("gcc", "c")
        end,
        cpp = function()
            return compile_and_run("g++", "cpp")
        end,
    }

    local runner = runners[ft]
    if not runner then
        vim.notify("No run command configured for filetype: " .. ft, vim.log.levels.WARN)
        return
    end

    local cmd
    if type(runner) == "function" then
        cmd = runner()
    else
        cmd = runner
    end
    if not cmd then
        return
    end

    vim.cmd("botright 15new")
    vim.fn.jobstart(cmd, { term = true })
    vim.cmd("startinsert")
end, { desc = "Run/Compile Current File" })

-- Generate annotation (defaults to function under cursor)
vim.keymap.set("n", "<leader>cn", function()
    require("neogen").generate({ type = "func" })
end, { desc = "Generate JSDoc/Annotation" })

-- Generate class annotation specifically
vim.keymap.set("n", "<leader>cN", function()
    require("neogen").generate({ type = "class" })
end, { desc = "Generate Class Annotation" })
