
return {
    "mbbill/undotree",

    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
        
        local os = vim.loop.os_uname().sysname
        if string.find(os, "Windows") then
            vim.g.undotree_DiffCommand = "FC"
        end
    end
}
