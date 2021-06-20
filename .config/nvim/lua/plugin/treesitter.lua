require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  indent = {
    enable = true,
  },
  playground = {
    enable = false,
    disable = {},

    updatetime = 25,
    persist_queries = false
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  ensure_installed = {
    'query', 'javascript', 'jsdoc', 'typescript', 'tsx', 'json',
    'python', 'html', 'lua', 'vue', 'yaml', 'css', 'bash', 'scss',
    'cpp', 'rust', 'go', 'c'
  },
}
