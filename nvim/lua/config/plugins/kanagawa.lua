return {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa-dragon',
    config = function()
        require('kanagawa').setup {
            compile = false,
            undercurl = false,
            commentStyle = { italic = false },
            functionStyle = {},
            keywordStyle = { italic = false },
            statementStyle = { bold = true },
            typeStyle = {},
            transparent = false,
            dimInactive = false,
            terminalColors = true,
            colors = {
                palette = {},
                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
            },
            overrides = function(colors)
                return {}
            end,
            theme = 'wave',
            background = {
                dark = 'wave',
                light = 'lotus',
            },
        }
    end

}
