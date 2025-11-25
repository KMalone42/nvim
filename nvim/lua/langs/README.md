### Per-language configuration
there are two areas of this configuration that handle languages.

you'll find in `lua/langs/` that there is a lot of autocmd stuff going on. 
before adding your own lang.lua configuration take a minute to look at `template.lua` which is referenced by all configured languages
such as `cpp.lua`, `nix.lua`, `lua_lang.lua`, and `py.lua`. DO JUST NOT COPY AND PASTE THE TEMPLATE.
