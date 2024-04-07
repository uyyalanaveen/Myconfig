return {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
    main = "ibl",
    ft = { "yaml" },
    opts = {
        indent = { char = "┊" },
        scope = {
            show_start = false,
            show_end = false,
        },
        exclude = {
            buftypes = { "terminal", "nofile" },
        },
    },
}
