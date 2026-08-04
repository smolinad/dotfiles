return {
    "ThePrimeagen/99",
    config = function()
        local _99 = require("99")
        
        local cwd = vim.uv.cwd()
        local basename = vim.fs.basename(cwd)
        
        _99.setup({
            logger = {
                level = _99.DEBUG,
                path = "/tmp/" .. basename .. ".99.debug",
                print_on_error = true,
            },
            tmp_dir = "./tmp",
        })

        -- Monkey-patch the provider to:
        -- 1. Omit the '-m' flag so opencode uses your current default connected model
        -- 2. Add '--auto' so opencode doesn't hang in the background waiting for permission!
        local providers = require("99.providers")
        if providers.OpenCodeProvider then
            providers.OpenCodeProvider._build_command = function(_, query, context)
                return {
                    "opencode",
                    "run",
                    "--agent",
                    "build",
                    "--auto",
                    query,
                }
            end
        end

        vim.keymap.set("n", "<leader>ais", function()
            _99.search()
        end, { desc = "99: Search/Work" })

        vim.keymap.set("v", "<leader>aiv", function()
            _99.visual()
        end, { desc = "99: Send visual selection" })
        
        vim.keymap.set("n", "<leader>aix", function()
            _99.stop_all_requests()
        end, { desc = "99: Cancel running requests" })
    end
}
