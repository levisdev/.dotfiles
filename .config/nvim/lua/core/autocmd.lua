local autocmd = vim.api.nvim_create_autocmd

local function augroup(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Check if we need to reload the file when it changed",
    group = augroup("checktime"),
    command = "checktime",
})

autocmd("BufWritePre", {
    desc = "Automatically create parent directories if they don't exist when saving a file",
    group = augroup("create_dir"),
    callback = function(args)
        if args.match:match("^%w%w+://") then
            return
        end
        vim.fn.mkdir(vim.fn.fnamemodify(vim.loop.fs_realpath(args.match) or args.match, ":p:h"), "p")
    end,
})
