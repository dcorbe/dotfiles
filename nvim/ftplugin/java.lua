-- nvim-jdtls configuration
-- This file runs when opening Java files

local jdtls = require('jdtls')
local mason_registry = require('mason-registry')

-- Helper to safely get package install path
local function get_pkg_path(name)
  local ok, path = pcall(function()
    local pkg = mason_registry.get_package(name)
    if pkg:is_installed() then
      return pkg:get_install_path()
    end
    return nil
  end)
  if ok then
    return path
  end
  return nil
end

-- Paths (bail early if jdtls not installed)
local jdtls_path = get_pkg_path('jdtls')
if not jdtls_path then
  vim.notify('jdtls not installed. Run :MasonInstall jdtls', vim.log.levels.WARN)
  return
end

local java_debug_path = get_pkg_path('java-debug-adapter')
local java_test_path = get_pkg_path('java-test')

-- Find project root
local root_markers = { 'gradlew', 'mvnw', '.git', 'pom.xml', 'build.gradle' }
local root_dir = require('jdtls.setup').find_root(root_markers) or vim.fn.getcwd()

-- Workspace directory (unique per project)
local project_name = vim.fn.fnamemodify(root_dir, ':p:h:t')
local workspace_dir = vim.fn.stdpath('data') .. '/jdtls-workspace/' .. project_name

-- Determine OS config
local os_config = 'linux'
if vim.fn.has('mac') == 1 then
  os_config = 'mac'
elseif vim.fn.has('win32') == 1 then
  os_config = 'win'
end

-- Debug bundles (optional - debugging works only if adapters installed)
local bundles = {}
if java_debug_path then
  local debug_jar = vim.fn.glob(java_debug_path .. '/extension/server/com.microsoft.java.debug.plugin-*.jar', true)
  if debug_jar ~= '' then
    table.insert(bundles, debug_jar)
  end
end
if java_test_path then
  local test_jars = vim.fn.glob(java_test_path .. '/extension/server/*.jar', true)
  if test_jars ~= '' then
    vim.list_extend(bundles, vim.split(test_jars, '\n'))
  end
end

-- Capabilities
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- on_attach
local function on_attach(client, bufnr)
  -- Enable inlay hints toggle
  if client.server_capabilities.inlayHintProvider then
    vim.keymap.set('n', '<leader>ih', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, { buffer = bufnr, desc = 'Toggle inlay hints' })
  end

  -- Java-specific keymaps
  local opts = { buffer = bufnr, silent = true }
  vim.keymap.set('n', '<leader>jo', jdtls.organize_imports, vim.tbl_extend('force', opts, { desc = 'Organize imports' }))
  vim.keymap.set('n', '<leader>jv', jdtls.extract_variable, vim.tbl_extend('force', opts, { desc = 'Extract variable' }))
  vim.keymap.set('v', '<leader>jv', function() jdtls.extract_variable(true) end, vim.tbl_extend('force', opts, { desc = 'Extract variable' }))
  vim.keymap.set('n', '<leader>jc', jdtls.extract_constant, vim.tbl_extend('force', opts, { desc = 'Extract constant' }))
  vim.keymap.set('v', '<leader>jc', function() jdtls.extract_constant(true) end, vim.tbl_extend('force', opts, { desc = 'Extract constant' }))
  vim.keymap.set('v', '<leader>jm', function() jdtls.extract_method(true) end, vim.tbl_extend('force', opts, { desc = 'Extract method' }))
  vim.keymap.set('n', '<leader>jt', jdtls.test_nearest_method, vim.tbl_extend('force', opts, { desc = 'Test nearest method' }))
  vim.keymap.set('n', '<leader>jT', jdtls.test_class, vim.tbl_extend('force', opts, { desc = 'Test class' }))

  -- Setup DAP after attach (only if debug adapter installed)
  if java_debug_path then
    jdtls.setup_dap({ hotcodereplace = 'auto' })
    require('jdtls.dap').setup_dap_main_class_configs()
  end
end

-- Configuration
local config = {
  cmd = {
    'java',
    '-Declipse.application=org.eclipse.jdt.ls.core.id1',
    '-Dosgi.bundles.defaultStartLevel=4',
    '-Declipse.product=org.eclipse.jdt.ls.core.product',
    '-Dlog.protocol=true',
    '-Dlog.level=ALL',
    '-Xmx1g',
    '--add-modules=ALL-SYSTEM',
    '--add-opens', 'java.base/java.util=ALL-UNNAMED',
    '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
    '-jar', vim.fn.glob(jdtls_path .. '/plugins/org.eclipse.equinox.launcher_*.jar'),
    '-configuration', jdtls_path .. '/config_' .. os_config,
    '-data', workspace_dir,
  },
  root_dir = root_dir,
  capabilities = capabilities,
  on_attach = on_attach,

  settings = {
    java = {
      signatureHelp = { enabled = true },
      contentProvider = { preferred = 'fernflower' },
      completion = {
        favoriteStaticMembers = {
          'org.junit.Assert.*',
          'org.junit.jupiter.api.Assertions.*',
          'org.mockito.Mockito.*',
          'org.hamcrest.MatcherAssert.assertThat',
          'org.hamcrest.Matchers.*',
        },
        filteredTypes = {
          'com.sun.*',
          'io.micrometer.shaded.*',
          'java.awt.*',
          'jdk.*',
          'sun.*',
        },
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        },
      },
      codeGeneration = {
        toString = {
          template = '${object.className}{${member.name()}=${member.value}, ${otherMembers}}',
        },
        useBlocks = true,
      },
      inlayHints = {
        parameterNames = { enabled = 'all' },
      },
    },
  },

  init_options = {
    bundles = bundles,
  },
}

-- Start jdtls
jdtls.start_or_attach(config)
