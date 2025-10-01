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
    t({"',", "    usage='"}),
    i(2, "%(prog)s target [target ...] --destination path"),
    t({"',", "    description='"}),
    i(3, "What the program does"),
    t({"',", "    epilog='"}),
    i(4, "Text at the bottom of the help"),
    t({"',", ")", "parser.add_argument('--foo', help='foo of the %(prog)s program')", "", "args = parser.parse_args()"}),
  }),
  
  s("addarg", {
        t({
            "parser.add_argument(",
            "    'foo',",
            "    type=bar,",
            "    nargs='',",
            "    help='foo of the %(prog)s program'",
            ")"
        })
    }),

    s("shebang", {
        t({
            "#!/usr/bin/env python3"
        })
    }),

    s("leet-test", {
        t({
            "if __name__ == '__main__':",
            "    sol = Solution()",
        })
    }),

    s("test-timer", {
        t({
            "from timeit import default_timer as timer",
            "start_time = timer()",
            "end_time = timer()",
            "elapsed_time = '{:.2f}'.format((end_time - start_time) * 1000)",
            "print(f'runtime: {elapsed_time}ms')",

        })
    }),

    s("typing-list", {
        t({
            "from typing import List"
        })
    }),

    s("seleniumbtn", {
        t("attach_btn = WebDriverWait(driver, "),
        i(1, "15"),
        t({").until(", "    EC.element_to_be_clickable((By.XPATH, \""}),
        i(2, "//button[@title='Open']"),
        t({"\"))", ")"}),
    }),

    s("seleniumtxt", {
        t("text_box = WebDriverWait(driver, "),
        i(1, "15"),
        t({").until(", "    EC.presence_of_element_located((By.XPATH, \""}),
        i(2, "//input[@type='text']"),
        t({"\"))", ")"}),
    }),
}


local autosnippets = {
}
return snippets, autosnippets
