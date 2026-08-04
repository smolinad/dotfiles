return {
    "tarides/ocaml.nvim", 
    config = function()
      require("ocaml").setup({
      params = {
        client = "ocamllsp",
      },
      -- If you replace this section with {} it will not setup any
      -- keymaps.
      keymaps = {
        jump_next_hole = "<localleader>n",
        jump_prev_hole = "<localleader>p",
        construct = "<localleader>c",
        jump = "<localleader>j",
        phrase_prev = "<localleader>pp",
        phrase_next = "<localleader>pn",
        infer = "<localleader>i",
        switch_ml_mli = "<localleader>s",
        type_enclosing = "<localleader>t",
        type_enclosing_grow = "<Up>",
        type_enclosing_shrink = "<Down>",
        type_enclosing_increase = "<Right>",
        type_enclosing_decrease = "<Left>",
      },
      })
    end
}
