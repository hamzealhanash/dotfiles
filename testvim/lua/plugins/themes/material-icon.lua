return {
    "DaikyXendo/nvim-material-icon",

    config = function()
        local web_devicons_ok, web_devicons = pcall(require, "nvim-web-devicons")
        if not web_devicons_ok then
            return
        end

        local material_icon_ok, material_icon = pcall(require, "nvim-material-icon")
        if not material_icon_ok then
            return
        end

        web_devicons.setup({
            override = material_icon.get_icons(),
        })
        require("nvim-web-devicons").setup({
            override = require("nvim-material-icon").get_icons(),
            color_icons = true,
            default = true,
        })
    end,
}
