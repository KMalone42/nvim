local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local snippets = {
  s("argparse", {
    t({
      "parser = argparse.ArgumentParser(",
      "    prog='",
    }),
    i(1, "ProgramName"),
    t({"',", "    description='"}),
    i(2, "What the program does"),
    t({"',", "    epilog='"}),
    i(3, "Text at the bottom of the help"),
    t({"',", ")", "parser.add_argument('--foo', help='foo of the %(prog)s program')", "", "args = parser.parse_args()"}),
  }),

  s("shebang", {
      t({
          "#!/usr/bin/env python3"
      })
  })
}


local autosnippets = {
}
return snippets, autosnippets
