local function funnify(number)
    local funny = tostring(number)
    if number == 69 then
        funny = funny .. "(funny)"
    end

    return funny
end


require("presence"):setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "aka getting bitches.",     -- Text displayed when hovered over the Neovim image
    main_image          = "neovim",                   -- Main image display (either "neovim" or "file")
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    show_time           = true,                       -- Show the timer

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = function(project_name, filename) -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
        if project_name == nil then
            return "Unknown project"
        end

        local greatest_file = "discordpresence.lua"
        local ending = filename:sub(-#greatest_file)
        if ending == "discordpresence.lua" then
            return "Configuring this exact extension"
        end

        if project_name == "nvim" then
            return "Working on the greatest editor"
        end
        return "Working on " .. project_name
    end,
    line_number_text    = function(line_number, line_count)-- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
        return "Line " .. funnify(line_number) .. " out of " .. funnify(line_count)
    end
})
