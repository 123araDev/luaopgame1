local internet = require("internet")
local event = require("event")

-- Function to fetch and display a webpage
local function browse(url)
    local response = internet.request(url)
    for chunk in response do
        io.write(chunk)
    end
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

        -- Fetch and display the webpage
        local success, err = pcall(browse, input)
        if not success then
            print("Error:", err)
        end
    end
end
