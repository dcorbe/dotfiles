return {
    "saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        completion = {
            cmp = { enabled = true },
        },
    },
    keys = {
        { "<leader>ct", function() require("crates").toggle() end, desc = "Toggle crates info" },
        { "<leader>cr", function() require("crates").reload() end, desc = "Reload crates" },
        { "<leader>cv", function() require("crates").show_versions_popup() end, desc = "Show versions" },
        { "<leader>cf", function() require("crates").show_features_popup() end, desc = "Show features" },
        { "<leader>cd", function() require("crates").show_dependencies_popup() end, desc = "Show dependencies" },
        { "<leader>cu", function() require("crates").update_crate() end, desc = "Update crate" },
        { "<leader>cU", function() require("crates").upgrade_crate() end, desc = "Upgrade crate" },
        { "<leader>ca", function() require("crates").update_all_crates() end, desc = "Update all crates" },
        { "<leader>cA", function() require("crates").upgrade_all_crates() end, desc = "Upgrade all crates" },
        { "<leader>cH", function() require("crates").open_homepage() end, desc = "Open homepage" },
        { "<leader>cR", function() require("crates").open_repository() end, desc = "Open repository" },
        { "<leader>cD", function() require("crates").open_documentation() end, desc = "Open docs.rs" },
        { "<leader>cC", function() require("crates").open_crates_io() end, desc = "Open crates.io" },
    },
}
