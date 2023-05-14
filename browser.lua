local internet = require("internet")
local event = require("event")
local gpu = require("component").gpu
local windows = require("windows")

local width, height = gpu.getResolution()
local previewWindow = windows.create(1, 1, width, height - 1) -- Preview window
local urlTextBox = windows.create(1, height, width - 10, 1) -- URL input textbox
local goButton = windows.create(width - 9, height, 9, 1) -- Go button

-- Function to fetch the webpage content
local function fetchPage(url)
    local response = internet.request(url)
    local content = ""
    for chunk in response do
        content = content .. chunk
    end
    return content
end

-- Function to render the webpage preview
local function renderPreview(content)
    previewWindow:clear()
    previewWindow:setCursorPos(1, 1)
    previewWindow:write(content, nil, 0xFFFFFF)
end

-- Main program loop
while true do
    -- Render the GUI elements
    gpu.fill(1, 1, width, height, " ")
    urlTextBox:render()
    goButton:render()
    gpu.set(1, height, "Enter a URL:")
    gpu.set(width - 8, height, "Go")

    -- Wait for user input
    local _, _, x, y = event.pull("touch")
    if urlTextBox:isClicked(x, y) then
        urlTextBox:focus()
    elseif goButton:isClicked(x, y) then
        -- Fetch the webpage content
        local url = urlTextBox:getText()
        local success, content = pcall(fetchPage, url)
        if not success then
            content = "Error: " .. content
        end

        -- Render the preview
        renderPreview(content)
    end
end
