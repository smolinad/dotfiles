return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  -- We specify the main module to avoid the 'not found' error during lazy loading
  main = 'nvim-treesitter.configs', 
  opts = {
    ensure_installed = {
      'bash', 'c', 'cpp', 'diff', 'html', 'lua', 'luadoc',
      'markdown', 'markdown_inline', 'python', 'latex', 'vim', 'vimdoc'
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
  config = function(_, opts)
    -- This part sets up the installer preference
    require('nvim-treesitter.install').prefer_git = true
    
    -- In v1.0, the configs module is often handled differently.
    -- If the require still fails, this pcall prevents the red screen of death.
    local status, configs = pcall(require, "nvim-treesitter.configs")
    if status then
        configs.setup(opts)
    end
  end,
}
