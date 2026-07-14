return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
        require('orgmode').setup({
            org_default_notes_file = '~/Vaults/Knowledge/Knowledge.org',
            org_startup_folded = "showeverything",
            -- the craziest shit I ever did see
            org_adapt_indentation = false,
            -- vertical, horizontal, auto, float
            win_split_mode = "horizontal",
            -- win_border = "rounded",
            scheduled_reminder = false,
            deadline_reminder = false,
            -- [[ Agenda ]] --
            org_agenda_files = {
                '~/Vaults/Knowledge/refile.org',
                '~/Vaults/Knowledge/to-be-read.org',
                '~/Vaults/Knowledge/Knowledge.org',

                '~/Vaults/Projects/Work/**/*.org',

                '~/Vaults/Knowledge/Areas/Tech/Orgmode/Orgmode.org',
                '~/Vaults/Knowledge/Areas/Tech/Vim/Vim.org',
                '~/Vaults/Knowledge/Areas/Tech/R/R.org',
                '~/Vaults/Knowledge/Areas/Tech/Tmux/Tmux.org',
                '~/Vaults/Knowledge/Areas/Tech/Linux/Linux.org',

                '~/Vaults/Home/to-be-read.org',
                '~/Vaults/Home/Projects/**/*.org',
            },
            org_agenda_skip_scheduled_if_done = false,
            org_agenda_skip_deadline_if_done = false,
            org_agenda_show_future_repeats = false,
            --org_agenda_todo_ignore_scheduled = "future",
            org_deadline_warning_days = 0,
            -- org_agenda_use_time_grid = false,
            org_agenda_sorting_strategy = {
                -- agenda = {'time-up', 'priority-up', 'category-keep'}
                agenda = {'time-up', 'priority-down', 'category-up', 'todo-state-up'}
            },
            org_agenda_custom_commands = {
                -- ignore to-be-read files
                u = {
                    description = "Unscheduled TODO tasks (no home TBR tags)",
                    types = {
                        {
                            type = "tags",
                            match = "TODO=\"TODO\"|TODO=\"NEXT\"|TODO=\"QUEUED\"",
                            -- ignore stuff from tbr - works for now, excluding a particular file from a view would be better
                            org_agenda_todo_ignore_scheduled = "all",
                            org_agenda_tag_filter_preset = "-articles-movies-music-recipes-books-books_related-podcasts-television-vonnegut-videos-saved-food",
                        },
                    }
                },
                U = {
                    description = "Unscheduled TODO tasks (including home TBR tags)",
                    types = {
                        {
                            type = "tags",
                            match = "TODO=\"TODO\"|TODO=\"NEXT\"|TODO=\"QUEUED\"",
                            org_agenda_todo_ignore_scheduled = "all",
                            org_agenda_overriding_header = "Unscheduled TODO tasks",
                        },
                    }
                },
                w = {
                    description = 'Combined view', -- Description shown in the prompt for the shortcut
                    types = {
                        { -- WIP
                            type = 'tags_todo',
                            -- match = "working-memory",
                            org_agenda_overriding_header = "Working Memory",
                            org_agenda_files = {'~/Vaults/Knowledge/Knowledge.org'},
                        },
                        { -- WIP
                            -- filters by TODO states + tags, here tags can be blank
                            type = 'tags_todo',
                            match = 'TODO="ONGOING"',
                            org_agenda_overriding_header = "Ongoing",
                        },
                        {-- Blocked
                            type = 'tags_todo',
                            match = 'TODO="BLOCKED"',
                            org_agenda_overriding_header = "Blocked",
                        },
                        { -- Work queue
                            type = 'tags_todo',
                            match = 'WORK_QUEUE',
                            org_agenda_todo_ignore_scheduled = "all",
                            org_agenda_overriding_header = "Work Queue"
                        },
                        {-- Admin queue
                            type = 'tags_todo',
                            match = "ADMIN_QUEUE-ADMIN_BLOCK-BACK_BURNER",
                            org_agenda_overriding_header = "Admin Queue",

                        },
                        {-- Admin admin block
                            type = 'tags_todo',
                            match = "ADMIN_BLOCK",
                            org_agenda_overriding_header = "Admin Block",

                        },
                        {-- Back burner
                            type = 'tags_todo',
                            match = 'BACK_BURNER',
                            org_agenda_overriding_header = "Back Burner",

                        },
                        {-- Weekly
                            type = 'agenda',
                            match = '-TODO="BLOCKED"',
                            org_agenda_overriding_header = 'The week',
                            org_agenda_start_on_weekday = 1,
                            org_agenda_remove_tags = false,
                            -- doesn't seem to work on view-specific level
                            -- org_agenda_use_time_grid = false
                            -- would be awesome if you could hide it for only some
                            -- org_deadline_warning_days = 0,
                        },
                    }
                },
                h = {
                    description = 'High-level overview', -- Description shown in the prompt for the shortcut
                    types = {
                        { -- WIP
                            -- filters by TODO states + tags, here tags can be blank
                            match = 'HIGH_LEVEL',
                            type = 'tags_todo',
                            org_agenda_overriding_header = "Goals",
                        },
                        { -- WIP
                            -- filters by TODO states + tags, here tags can be blank
                            type = 'tags_todo',
                            match = 'SPRINT',
                            org_agenda_overriding_header = "Sprint",
                        },
                    }
                },
                c = {
                    description = "Completed Tasks",
                    types = {
                        {-- Completed
                            type = 'tags',
                            match = "TODO=\"DONE\"",
                            org_agenda_overriding_header = "Completed Tasks",
                            org_agenda_sorting_strategy = {
                                -- agenda = {'time-up', 'priority-up', 'category-keep'}
                                agenda = {'time-down'}
                            },

                        },
                    }
                },
                d = {
                    description = "Daily plan",
                    types = {
                        {-- Daily
                            type = 'tags_todo',
                            match = '-TODO="BLOCKED"',
                            org_agenda_overriding_header = 'The day',
                            org_agenda_start_on_weekday = 1,
                            org_agenda_remove_tags = false,
                            -- doesn't seem to work on view-specific level
                            -- org_agenda_use_time_grid = true,
                            org_agenda_span = 'day' -- can be any value as org_agenda_span
                            -- would be awesome if you could hide it for only some
                            -- org_deadline_warning_days = 0,
                        },
                        {-- Admin
                            type = 'tags_todo',
                            match = "+ADMIN_BLOCK-TODO=\"DONE\"",
                            org_agenda_overriding_header = "Admin Block",
                        },
                    }
                },
                p = {
                    description = "Project overview",
                    types = {
                        {
                            type = 'tags_todo',
                            org_agenda_tag_filter_preset = "-articles-movies-music-recipes-books-books_related-podcasts-television-vonnegut-videos-saved-food",
                            org_agenda_sorting_strategy = {"category-keep", "priority-down", "todo-state-down"}
                        }
                    }
                }
            },
            -- [[ Tasks ]] --
            org_capture_templates = {
                t = {
                    description = 'Simple TODO',
                    template = '** TODO [#B] %?',
                },
                s = {
                    description = 'TODO with SCHEDULED and Priority',
                    template = {
                        '** TODO [#B] %?',
                        '    SCHEDULED: %t',
                    },
                },
                t = {
                    description = 'TODO with SCHEDULED and time',
                    template = {
                        '** TODO [#B] %?',
                        '    SCHEDULED: %T',
                    },
                },
                d = {
                    description = 'TODO with DEADLINE and Priority',
                    template = {
                        '** TODO [#B] %?',
                        '    DEADLINE: %t',
                    },
                },
                f = {
                    description = 'TODO with DEADLINE, SCHEDULED, and Priority',
                    template = {
                        '** TODO [#B] %?',
                        '    DEADLINE: %t SCHEDULED: %t',
                    },
                },
                -- these get filtered out by one of my agenda views
                b = {
                    description = 'Home to-be-read',
                    template = '** TODO [#B]* %?',
                },
                -- Quick capture with date
                q = {
                    description = 'Quick TODO with date',
                    template = {
                        '** TODO [#B] %?',
                        '    SCHEDULED: <' .. os.date('%Y-%m-%d %a') .. '>',
                    },
                }
            },
            org_todo_keywords = {
                "TODO(t)",
                "ONGOING(o)",
                "BLOCKED(b)",
                "|",
                "DONE(d)"
            },
            org_todo_keyword_faces = {
                TODO = ':foreground darkcyan',
                ONGOING = ':foreground lightblue',
                BLOCKED = ':foreground orange',
            },

        })

        -- [[ Colors ]] --
        vim.api.nvim_set_hl(0, '@org.priority.highest', { link = "DiagnosticHint"})
        vim.api.nvim_set_hl(0, '@org.agenda.deadline', { link = "DiagnosticHint"})
        vim.api.nvim_set_hl(0, '@org.plan', { fg = '#6a9589', bold = true })

        -- [[ Misc ]] --
        -- shortcuts to open key files quickly
        vim.api.nvim_set_keymap('n', '<leader>wi', ':e index.md<CR>', {})
        -- open main orgfile with name of dir
        local function open_orgfile()
            local cwd = vim.fn.getcwd()
            local dirname = vim.fn.fnamemodify(cwd, ':t')
            local orgfile = cwd .. '/' .. dirname .. '.org'
            if vim.fn.filereadable(orgfile) == 1 then
                vim.cmd('edit ' .. orgfile)
            else
                print('Org file not found: ' .. orgfile)
            end
        end

        vim.api.nvim_set_keymap('n', '<leader>wo', '', {
            noremap = true,
            silent = true,
            callback = open_orgfile,
        })

        -- refile hotkey
        vim.api.nvim_set_keymap('n', '<leader>wr', ':e ~/Vaults/Knowledge/refile.org<CR>', {
            noremap = true,
            silent = true
        })

        local env_var = os.getenv("AGENDA")

        if env_var then
            vim.cmd("Org agenda")
        end

    end,
}
