return {
    "edr3x/lualine.nvim",
    opts = function()
        local harpoon = require("harpoon.mark")

        local lspStatus = {
            function()
                local msg = "No LSP detected"
                local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
                local clients = vim.lsp.get_active_clients()
                if next(clients) == nil then
                    return msg
                end
                for _, client in ipairs(clients) do
                    local filetypes = client.config.filetypes
                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                        return client.name
                    end
                end
                return msg
            end,
            icon = "",
            color = { fg = "#d3d3d3" },
        }

        local lsp_progress = {
            function()
                local lsp = vim.lsp.util.get_progress_messages()[1]
                if lsp then
                    local name = lsp.name or ""
                    local msg = lsp.message or ""
                    local title = lsp.title or ""
                    local percentage = lsp.percentage or 0
                    return string.format("%%<%s: %s %s (%s%%%%)", name, title, msg, percentage)
                end
                return ""
            end,
            color = { fg = "#d3d3d3" },
        }

        local function harpoon_component()
            local total_marks = harpoon.get_length()

            if total_marks == 0 then
                return ""
            end

            local current_mark = "—"

            local mark_idx = harpoon.get_current_index()
            if mark_idx ~= nil then
                current_mark = tostring(mark_idx)
            end

            return string.format("󱡅 %s/%d", current_mark, total_marks)
        end

        local buffer = {
            "buffers",
            mode = 0,
            show_filename_only = true,
            show_modified_status = true,
            hide_filename_extension = false,
            symbols = { alternate_file = "" },
            buffers_color = {
                active = { fg = "#d3d3d3" },
                inactive = { fg = "#414141" },
            },
        }

        local diagnostic = {
            "diagnostics",
            symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = " ",
            },
            icon = "|",
        }

        local diff = {
            "diff",
            symbols = {
                added = " ",
                modified = " ",
                removed = " ",
            },
        }

        return {
            options = {
                icons_enabled = true,
                theme = "custom_transparent",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = { "alpha", "dashboard", "lazy" },
                always_divide_middle = true,
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch" },
                lualine_c = { buffer },
                lualine_x = { "", diff, diagnostic },
                lualine_y = { harpoon_component, "filetype" },
                lualine_z = { "progress" },
            },
        }
    end,
}