local internet = require("internet")
local event = require("event")

-- Function to fetch the webpage content
local function fetchPage(url)
    local response = internet.request(url)
    local content = ""
    for chunk in response do
        content = content .. chunk
    end
    return content
end

-- Function to extract a preview of the webpage content
local function extractPreview(content)
    -- Remove HTML tags and convert special characters
    local preview = content:gsub("<.-?>", ""):gsub("&.-;", "")

    -- Limit the preview length to 200 characters
    if #preview > 200 then
        preview = preview:sub(1, 200) .. "..."
    end

    return preview
end

-- Main program loop
while true do
    -- Ask the user for a URL
    io.write("Enter a URL (or 'exit' to quit): ")
    local input = io.read()

    if input == "exit" then
        break
    else
        -- Add "http://" to the URL if not present
        if not input:match("^http://") and not input:match("^https://") then
            input = "http://" .. input
        end

        -- Fetch the webpage content
        local success, content = pcall(fetchPage, input)
        if not success then
            print("Error:", content)
        else
            -- Extract and display the preview
            local preview = extractPreview(content)
            print("Preview:\n" .. preview)
        end
    end
end
