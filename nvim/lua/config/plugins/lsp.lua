return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
        "j-hui/fidget.nvim",
    },
config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "ruff", "pyright", "clangd", "texlab", "rust_analyzer", "marksman" },
    })

    -- 1. Remove the deprecated require("lspconfig") line
    -- local lspconfig = require("lspconfig") 

    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Keymaps for LSP features
    local function map(buf, keys, func, desc)
        vim.keymap.set("n", keys, func, { buffer = buf, desc = "LSP: " .. desc })
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
            local buf = event.buf
            map(buf, "gd", vim.lsp.buf.definition, "Goto Definition")
            map(buf, "gr", vim.lsp.buf.references, "Goto References")
            map(buf, "gI", vim.lsp.buf.implementation, "Goto Implementation")
            map(buf, "gD", vim.lsp.buf.declaration, "Goto Declaration")
            map(buf, "<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
            map(buf, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        end,
    })

    -- LSP servers definition (keep your existing table as is)
    local servers = {
        lua_ls = {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    workspace = { checkThirdParty = false },
                },
            },
        },
        ocamllsp = {},
        ruff = {},
        pyright = {
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        useLibraryCodeForTypes = true,
                        diagnosticMode = "openFilesOnly",
                    },
                },
            },
        },
        clangd = {},
        texlab = {
            settings = {
                texlab = {
                    build = {
                        executable = "latexmk",
                        args = { "-pdf", "-interaction=nonstopmode", "-synctex=1", "%f" },
                        onSave = true,
                    },
                    forwardSearch = {
                        executable = "zathura",
                        args = { "--synctex-forward", "%l:1:%f", "%p" },
                    },
                },
            },
        },
        rust_analyzer = {},
        marksman = {},
    }

    -- 2. Update the loop to use the new native API
    for name, config in pairs(servers) do
        config.capabilities = capabilities
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
    end
end,
}
