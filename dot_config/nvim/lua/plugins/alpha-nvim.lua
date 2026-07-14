return {
    'goolord/alpha-nvim',
    enabled = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
        local alpha = require 'alpha'
        local dashboard = require 'alpha.themes.dashboard'
        -- https://www.patorjk.com/software/taag/#p=display&f=Graceful&t=Neovim
        -- big, Doh, Doom, Epic, Shaded Blocky, Standard, Bolger, Broadway, Collosal,
        -- Cybermedium (Maybe doesn't work, esc chars), Double, Georgia11, Roman
        dashboard.section.header.val = {
            "b.             8 8 8888888888       ,o888888o.  `8.`888b           ,8'  8 8888          ,8.       ,8.          ",
            "888o.          8 8 8888          . 8888     `88. `8.`888b         ,8'   8 8888         ,888.     ,888.         ",
            "Y88888o.       8 8 8888         ,8 8888       `8b `8.`888b       ,8'    8 8888        .`8888.   .`8888.        ",
            ".`Y888888o.    8 8 8888         88 8888        `8b `8.`888b     ,8'     8 8888       ,8.`8888. ,8.`8888.       ",
            "8o. `Y88888o.  8 8 888888888888 88 8888         88  `8.`888b   ,8'      8 8888      ,8'8.`8888,8^8.`8888.      ",
            "8`Y8o. `Y88888o8 8 8888         88 8888         88   `8.`888b ,8'       8 8888     ,8' `8.`8888' `8.`8888.     ",
            "8   `Y8o. `Y8888 8 8888         88 8888        ,8P    `8.`888b8'        8 8888    ,8'   `8.`88'   `8.`8888.    ",
            "8      `Y8o. `Y8 8 8888         `8 8888       ,8P      `8.`888'         8 8888   ,8'     `8.`'     `8.`8888.   ",
            "8         `Y8o.` 8 8888          ` 8888     ,88'        `8.`8'          8 8888  ,8'       `8        `8.`8888.  ",
            "8            `Yo 8 888888888888     `8888888P'           `8.`           8 8888 ,8'         `         `8.`8888. ",
        }

        -- Set men
        dashboard.section.buttons.val = {
            dashboard.button('a', '> Agenda', ':Org agenda <CR>'),
            dashboard.button('v', '> Knowledge', ':cd ~/Vaults/Knowledge/ | edit index.md <CR>'),
            dashboard.button('e', '> New file', ':ene <BAR> startinsert <CR>'),
            dashboard.button('f', '> Find file', ':Telescope find_files<CR>'),
            dashboard.button('r', '> Recent', ':Telescope oldfiles<CR>'),
            dashboard.button('w', '> Workspaces', ':Telescope workspaces<CR>'),
            dashboard.button('b', '> Bookmarks', ":lua require('ezbookmarks').OpenBookmark()<CR>"),
            dashboard.button('m', '> Line marks', ':Telescope marks<CR>'),
            dashboard.button('q', '> Quit', ':qa<CR>'),
        }

        -- Send config to alpha
        alpha.setup(dashboard.opts)
    end,
}
