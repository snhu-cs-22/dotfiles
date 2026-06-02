require('blink.cmp').setup {
  completion = {
    -- Disable auto brackets
    -- NOTE: some LSPs may add auto brackets themselves anyway
    accept = { auto_brackets = { enabled = false }, },

    -- Show documentation when selecting a completion item
    documentation = { auto_show = true },

    -- Display a preview of the selected item on the current line
    ghost_text = { enabled = true },

    -- Auto completion menu when typing
    menu = { auto_show = true }
  },

  keymap = {
    ['<C-j>'] = { 'snippet_forward', 'fallback' },
    ['<C-k>'] = { 'snippet_backward', 'fallback' },
  },

  -- Experimental signature help support
  signature = { enabled = true },

  appearance = {
    kind_icons = {
      Text = 'Text',
      Method = 'Method',
      Function = 'Function',
      Constructor = 'Constructor',

      Field = 'Field',
      Variable = 'Variable',
      Property = 'Property',

      Class = 'Class',
      Interface = 'Interface',
      Struct = 'Struct',
      Module = 'Module',

      Unit = 'Unit',
      Value = 'Value',
      Enum = 'Enum',
      EnumMember = 'Enum Member',

      Keyword = 'Keyword',
      Constant = 'Constant',

      Snippet = 'Snippet',
      Color = 'Color',
      File = 'File',
      Reference = 'Reference',
      Folder = 'Folder',
      Event = 'Event',
      Operator = 'Operator',
      TypeParameter = 'Type Parameter',
    },
  },
}

return {}
