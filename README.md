<!-- panvimdoc-ignore-start -->

<h2 align="center">High contrast Neovim themes made with components borrowed from all over the place</h2>

<p align="center">
  <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/0a7e13b1-e6ce-4db8-b216-60566874dce7" width="49%"/>
  <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/59c4a91c-b2d4-4bb5-8227-d83c5755d550" width="49%"/>
</p>

# Examples

<details>
  <summary style="font-size: 1.25rem;">Mayu</summary>

  <hr>
  <figure>
    <h4 align="center">Go</h4>
    <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/afd8f5be-fa47-4c00-9bde-9277bfb69407"/>
  </figure>

  <hr>
  <figure>
    <h4 align="center">TypeScript</h4>
    <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/001184f1-125d-45db-945b-1326b21ba464"/>
  </figure>

  <hr>
  <figure>
    <h4 align="center">Rust</h4>
    <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/70370a49-1ab4-401b-ac45-1a917c25d01a"/>
  </figure>

  <hr>
  <figure>
    <h4 align="center">Nix, not a web server (skill issue)</h4>
    <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/34d81f1f-8c87-4452-87a5-670da53aaf5c"/>
  </figure>

  <hr>
</details>

<details>
  <summary style="font-size: 1.25rem;">Shin</summary>
  <hr>

  <figure>
    <h4 align="center">Go</h4>
    <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/fec97edf-e7e6-4f0c-b07a-68725406c616"/>
  </figure>

  <hr>
  <figure>
    <h4 align="center">TypeScript</h4>
    <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/76c2138a-2a90-4502-8ab4-60956a6ef8dc"/>
  </figure>

  <hr>
  <figure>
    <h4 align="center">Rust</h4>
    <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/4c2a24e3-7153-43d3-aa4c-4897dd33cf76"/>
  </figure>

  <hr>
  <figure>
    <h4 align="center">Nix</h4>
    <img src="https://github.com/MyyPo/borrowed.nvim/assets/110892040/0da41fbc-0615-4669-90b8-f7fe474a044f"/>
  </figure>

  <hr>
</details>

<!-- panvimdoc-ignore-end -->

# Installation

### [lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "myypo/borrowed.nvim",
    lazy = false,
    priority = 1000,

    version = '^0', -- Optional: avoid upgrading to breaking versions

    config = function()
        -- require("borrowed").setup({ ... }) -- Optional: only has to be called to change settings

        -- If you are changing the config, colorscheme command has to be called after setup()
        vim.cmd("colorscheme mayu") -- OR vim.cmd("colorscheme shin")
    end,
}
```

# Configuration

Default configuration:

```lua
require("borrowed").setup({
    compile_path = vim.fn.stdpath("cache") .. "/borrowed", -- Where to store compiled colorschemes
    compile_file_suffix = "_compiled", -- Compiled colorscheme file suffix
    transparent = false, -- Disable setting background
    dim_inactive = false, -- Non focused panes set to alternative background

    styles = { -- Styles to be applied to different syntax groups
        comments = "NONE", -- Value is any valid attr-list value `:help attr-list`
        conditionals = "NONE",
        constants = "NONE",
        functions = "NONE",
        keywords = "NONE",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
    },

    inverse = { -- Inverse highlight colors for different types
    	match_paren = false,
        visual = false,
        search = false,
    },

    cursor = { -- WIP: Dynamic cursor settings
        enable = true,
        visual = {
            enable = true,
        },
    },

    module_default = true, -- Default enable value for modules, all modules are enabled by default
    modules = { -- List of various plugin integrations and additional options
        -- ... Optional user settings
    },

    overrides = {
        strategy = "force", -- "force" | "merge" -- How to handle overrides of palettes and highlight groups
        -- ... Optional user settings
    },
})
```

# Overriding colors and highlights

Color palettes of individual or all themes can be overriden e.g. `yell` color,
as well as theme specifications of bundled for ease of change highlights e.g. `syntax`
and individual highlights, such as `Keyword`.

```lua
require("borrowed").setup({
    overrides = {
        strategy = "force", -- "force" | "merge"

        palettes = {
            all = {
                yell     = "#ff0000",
                whisper  = "#4c66e2",

                mynewcolor = "#7da284", -- Adding a new custom color to palette
            },
            mayu = {
                whisper  = "#0000ff", -- Overrides to individual themes will take priority
            },
        },

        specs = {
            all = {
                syntax = {
                    keyword = "speak", -- Using name of a color from palette

                    string = "mynewcolor", -- Make use of the custom color we defined earlier
                },
                diag = {
                    error = "yell",
                },
            },
            shin = {
                syntax = {
                    number = "#0000ff",
                },
            },
        },

        groups = {
            all = {
                IncSearch = { bg = "whisper" },
                String = { link = "Keyword" }, -- Link option has to be used alone, it makes a highlight inherit properties from another highlight
            },
            mayu = {
                Search = { bg = "whisper" },
                Boolean = { style = "italic,underline", bg = "#ffffff" },
            },
            shin = {
                HelloWorld = { fg = "mynewcolor" }, -- Adding a new arbitary highlight, for example, used by another plugin
            },
        },
    },
})
```

> [!Note]
> By default `force` override strategy is used, meaning,
> that when overrides to individual highlights are specified in `groups`
> the previous values of the highlight will be removed.
> Changing the strategy to `merge` will change the behaviour to merging
> the previous values with the provided ones.

### Example "default" overrides

<details>
  <summary>Mayu</summary>

```lua
palettes = {
    mayu = {
        mattress = "#000000",
        sheet    = "#121212",
        blanket  = "#26233a",
        muted    = "#6e6a86",
        subtle   = "#908caa",

        plain    = "#f7c7b5", -- white
        yell     = "#e7517b", -- red
        speak    = "#f78273", -- orange
        whisper  = "#e0879e", -- pink
        shy      = "#a37e6f", -- brown
        extra    = "#949ae7", -- blue
    },
},

specs = {
    mayu = {
        syntax = {
            bracket     = "subtle",
            builtin     = "extra",
            comment     = "muted",
            conditional = "yell",
            const       = "extra",
            dep         = "muted",
            field       = "speak",
            func        = "whisper",
            ident       = "plain",
            keyword     = "yell",
            number      = "extra",
            operator    = "subtle",
            preproc     = "whisper",
            regex       = "shy",
            statement   = "yell",
            string      = "shy",
            type        = "speak",
            variable    = "plain",
        },

        diag = {
            error = "yell",
            warn  = "speak",
            hint  = "extra",
            info  = "shy",
            ok    = "extra",
        },

        diag_bg = {
            error = "blanket",
            warn  = "blanket",
            hint  = "blanket",
            info  = "blanket",
            ok    = "blanket",
        },

        diff = {
            add      = "extra",
            removed  = "yell",
            changed  = "speak",
            conflict = "yell",
            ignored  = "muted",
        },

        cursor = {
            fg = "mattress",
            bg = "#f5dcd8",
        },

        visual = {
            fg        = "mattress",
            bg        = "speak",
            cursor_fg = "mattress",
            cursor_bg = "extra",
        },
    },
},
```

</details>

<details>
  <summary>Shin</summary>

```lua
palettes = {
    shin = {
        mattress = "#000000",
        sheet    = "#121212",
        blanket  = "#26233a",
        muted    = "#6e6a86",
        subtle   = "#908caa",

        plain    = "#f7c7b5", -- white
        yell     = "#e7517b", -- red
        speak    = "#f78273", -- orange
        whisper  = "#e0879e", -- pink
        shy      = "#a37e6f", -- brown
        extra    = "#949ae7", -- blue
    },
},

specs = {
    shin = {
        syntax = {
            bracket     = "subtle",
            builtin     = "extra",
            comment     = "muted",
            conditional = "yell",
            const       = "extra",
            dep         = "muted",
            field       = "speak",
            func        = "whisper",
            ident       = "plain",
            keyword     = "yell",
            number      = "extra",
            operator    = "subtle",
            preproc     = "whisper",
            regex       = "shy",
            statement   = "yell",
            string      = "shy",
            type        = "speak",
            variable    = "plain",
        },

        diag = {
            error = "yell",
            warn  = "speak",
            hint  = "extra",
            info  = "shy",
            ok    = "extra",
        },

        diag_bg = {
            error = "blanket",
            warn  = "blanket",
            hint  = "blanket",
            info  = "blanket",
            ok    = "blanket",
        },

        diff = {
            add      = "extra",
            removed  = "yell",
            changed  = "speak",
            conflict = "yell",
            ignored  = "muted",
        },

        cursor = {
            fg = "mattress",
            bg = "#f5dcd8",
        },

        visual = {
            fg        = "mattress",
            bg        = "speak",
            cursor_fg = "mattress",
            cursor_bg = "extra",
        },
    },
},
```

</details>

# Supported highlight integrations

The plugin provides highlights for certain plugins
and optional (neo)vim features out of the box, they are enabled by default.

Here is the list of such integrations:

<table style="text-align: center;">
<td> <b>Plugin</b> </td> <td> <b>Settings</b> </td>

<!-- nvim-cmp -->
<tr>
<td> <a href="https://github.com/hrsh7th/nvim-cmp">nvim-cmp</a> </td>
<td>

```lua
cmp = { enable = true }
```

</td>
<!-- nvim-cmp -->

<!-- nvim-dap-ui -->
<tr>
<td> <a href="https://github.com/rcarriga/nvim-dap-ui">nvim-dap-ui</a> </td>
<td>

```lua
dap_ui = { enable = true }
```

</td>
<!-- nvim-dap-ui -->

<!-- diagnostic -->
<tr>
<td> <a href="https://neovim.io/doc/user/diagnostic.html#diagnostic-highlights">nvim-diagnostics</a> </td>
<td>

```lua
diagnostic = {
   enable = true,
   background_enable = true,
}
```

</td>
<!-- diagnostic -->

<!-- flash.nvim -->
<tr>
<td> <a href="https://github.com/folke/flash.nvim">flash.nvim</a> </td>
<td>

```lua
flash = { enable = true }
```

</td>
<!-- flash.nvim -->

<!-- gitsigns.nvim -->
<tr>
<td> <a href="https://github.com/lewis6991/gitsigns.nvim">gitsigns.nvim</a> </td>
<td>

```lua
gitsigns = { enable = true }
```

</td>
<!-- gitsigns.nvim -->

<!-- lazy.nvim -->
<tr>
<td> <a href="https://github.com/folke/lazy.nvim">lazy.nvim</a> </td>
<td>

```lua
lazy = { enable = true }
```

</td>
<!-- lazy.nvim -->

<!-- semantic-tokens -->
<tr>
<td> <a href="https://neovim.io/doc/user/lsp.html#lsp-semantic-highlight">nvim-semantic-tokens</a> </td>
<td>

```lua
semantic_tokens = { enable = true }
```

</td>
<!-- semantic-tokens -->

<!-- native-lsp -->
<tr>
<td> <a href="https://github.com/neovim/nvim-lspconfig">nvim-lspconfig</a> </td>
<td>

```lua
native_lsp = {
   enable = true,
   background_enable = true,
}
```

</td>
<!-- native-lsp -->

<!-- telescope.nvim -->
<tr>
<td> <a href="https://github.com/nvim-telescope/telescope.nvim">telescope.nvim</a> </td>
<td>

```lua
telescope = { enable = true }
```

</td>
<!-- telescope.nvim -->

<!-- nvim-treesitter -->
<tr>
<td> <a href="https://github.com/nvim-treesitter/nvim-treesitter">nvim-treesitter</a> </td>
<td>

```lua
treesitter = { enable = true }
```

</td>
<!-- nvim-treesitter -->

</table>

# External integrations

Integrations that have to go beyond setting highlights.

---

**[lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)**

<details> <summary>Instructions for Lazy</summary>

> You are not required to call setup of lualine.
> Calling this plugin's module in question should be enough.

```lua
{
    "nvim-lualine/lualine.nvim",
	-- lazy = false, -- Optional: might slow down the startup time in exchange for shorter lualine "blink"
    dependencies = { "nvim-tree/nvim-web-devicons", "myypo/borrowed.nvim" },
    config = function()
        require("lualine.themes.borrowed-mayu")
        -- require("lualine.themes.borrowed-shin")
    end,
}
```

> Current implementation does not respect overrides to highlight colors.
> So if you want to customize the lualine you will have to
> **[copy it](./lua/lualine/themes)** to your config and override colors yourself.

</details>

---

<!-- panvimdoc-ignore-start -->

# Borrowed from (Acknowledgements)

- [Rosé Pine theme](https://github.com/rose-pine/neovim): Mayu theme colors and dark interface colors

- [Nightfox theme](https://github.com/EdenEast/nightfox.nvim): starting codebase

- [Pinkmare theme](https://github.com/Matsuuu/pinkmare): inspiration and Mayu pink color

- [Touhou Project by ZUN](https://en.wikipedia.org/wiki/Touhou_Project): colors for the Shin theme are based on [Shinmyoumaru](https://en.touhouwiki.net/wiki/Shinmyoumaru_Sukuna)

- **Lualine integration**: is based on [evil lualine](https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua)

- **Images used in the README**:
  [Yuuka with a parasol](https://www.pixiv.net/en/artworks/97429600) and [Shinmyoumaru on a roof](https://www.pixiv.net/en/artworks/94000244)

<!-- panvimdoc-ignore-end -->
