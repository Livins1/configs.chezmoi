local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local api = vim.api

local lspconfig = require("lspconfig")

local capabilities = require('cmp_nvim_lsp').default_capabilities()

local function create_capabilities()
  return capabilities
end

local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "<space>r", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  buf_set_keymap("n", "<space>a", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  -- buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<A-f>", "<cmd>lua vim.lsp.buf.formatting({async=true})<CR>", opts)
  buf_set_keymap("i", "<A-f>", "<cmd>lua vim.lsp.buf.formatting({async=true})<CR><Esc>", opts)

  -- Get signatures (and _only_ signatures) when in argument lists.
  --[[ require "lsp_signature".on_attach({
doc_lines = 0,
handler_opts = {
border = "none"
},
}) ]]
end

lspconfig.rust_analyzer.setup({
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
    exit_timeout = 0,
  },
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importGranularity = "module",
        importPrefix = "self",
      },
      cargo = {
        loadOutDirsFromCheck = true,
      },
      completion = {
        postfix = {
          enable = false,
        },
      },
      procMarco = {
        enable = false,
      },
    },
  },
})

-- Golang
require("lspconfig").gopls.setup({
  on_attach = on_attach,
  capabilities = create_capabilities(),
})
-- Python
-- require'lspconfig'.pylsp.setup(coq.lsp_ensure_capabilities({on_attach = on_attach}))
require("lspconfig").pylsp.setup({
  on_attach = on_attach,
  capabilities = create_capabilities(),
})
local lspconfig_configs = require 'lspconfig.configs'
local lspconfig_util = require 'lspconfig.util'

local volar_cmd = { 'vue-language-server', '--stdio' }
local volar_root_dir = lspconfig_util.root_pattern 'package.json'

-- Vue
lspconfig_configs.volar_api = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,
    filetypes = { 'vue' },
    -- If you want to use Volar's Take Over Mode (if you know, you know)
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
      typescript = {
        -- serverPath = ''
        serverPath = "/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js",
      },
      languageFeatures = {
        implementation = true, -- new in @volar/vue-language-server v0.33
        references = true,
        definition = true,
        typeDefinition = true,
        callHierarchy = true,
        hover = true,
        rename = true,
        renameFileRefactoring = true,
        signatureHelp = true,
        codeAction = true,
        workspaceSymbol = true,
        completion = {
          defaultTagNameCase = 'both',
          defaultAttrNameCase = 'kebabCase',
          getDocumentNameCasesRequest = false,
          getDocumentSelectionRequest = false,
        },
      }
    },
  }
}
lspconfig.volar_api.setup {}

lspconfig_configs.volar_doc = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,

    filetypes = { 'vue' },
    -- If you want to use Volar's Take Over Mode (if you know, you know):
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json' },
    init_options = {
      typescript = {
        serverPath = "/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js",
      },
      languageFeatures = {
        implementation = true, -- new in @volar/vue-language-server v0.33
        documentHighlight = true,
        documentLink = true,
        codeLens = { showReferencesNotification = true },
        -- not supported - https://github.com/neovim/neovim/pull/15723
        semanticTokens = false,
        diagnostics = true,
        schemaRequestService = true,
      }
    },
  }
}
lspconfig.volar_doc.setup({
  on_attach = on_attach,
  capabilities = create_capabilities(),
})

lspconfig_configs.volar_html = {
  default_config = {
    cmd = volar_cmd,
    root_dir = volar_root_dir,

    filetypes = { 'vue', },
    -- If you want to use Volar's Take Over Mode (if you know, you know), intentionally no 'json':
    --filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    init_options = {
      typescript = {
        serverPath = "/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js",
        -- serverPath = ''
      },
      documentFeatures = {
        selectionRange = true,
        foldingRange = true,
        linkedEditingRange = true,
        documentSymbol = true,
        -- not supported - https://github.com/neovim/neovim/pull/13654
        documentColor = false,
        documentFormatting = {
          defaultPrintWidth = 100,
        },
      }
    },
  }
}
lspconfig.volar_html.setup {}


-- Vue
--[[ require("lspconfig").volar.setup({
  on_attach = on_attach,
  -- filetypes = {'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue', 'json'},
  capabilities = create_capabilities(),
  init_options = {
    typescript = {
      serverPath = "/usr/local/lib/node_modules/typescript/lib/tsserverlibrary.js",
    },
  },
}) ]]
-- Json
-- npm i -g vscode-langservers-extracted
lspconfig.jsonls.setup({
  capabilities = create_capabilities(),
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({}, { 0, 0 }, { vim.fn.line("$"), 0 })
      end,
    },
  },
})

-- React
lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = create_capabilities(),
  settings = {
    documentFormatting = true,
    javascript = {
      format = {
        tabSize = 2,
        indentSize = 2,
        baseIndentSize = 0,
        convertTabsToSpaces = true,
      },
    },
  },
  init_options = {
    javascript = {
      format = {
        baseIndentSize = 2,
      },
    },
  },
})

-- Css
lspconfig.cssls.setup({
  on_attach = on_attach,
  capabilities = create_capabilities(),
  filetypes = { "css", "scss", "less" },
  --[[ commands = {
		Format = {
			function()
				return {
				}
			end,
		},
	}, ]]
})

-- Lua
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = create_capabilities(),
  --[[ commands = {
		Format = {
			function()
				require("stylua-nvim").format_file()
			end,
		},
	}, ]]
  settings = {

    Lua = {
      format = {
        enable = true,
        -- Put format options here
        -- NOTE: the value should be STRING!!
        defaultConfig = {
          indent_style = "space",
          indent_size = "2",
        },
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})

-- C/C++
require("lspconfig").clangd.setup({
  on_attach = on_attach,
  capabilities = create_capabilities(),
})

-- Zig
require'lspconfig'.zls.setup{}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = false,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})


-- Julia
-- julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.add("LanguageServer")'
--
-- julia --project=~/.julia/environments/nvim-lspconfig -e 'using Pkg; Pkg.update()'
-- julia --project=/path/to/my/project -e 'using Pkg; Pkg.instantiate()'
require 'lspconfig'.julials.setup {
  on_attach = on_attach,
  capabilities = create_capabilities(),

}
