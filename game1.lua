-- Word list
local words = {
    "apple",
    "banana",
    "cherry",
    "grape",
    "orange",
    "watermelon"
}

-- Function to select a random word from the list
function selectWord()
    math.randomseed(os.time())
    local index = math.random(1, #words)
    return words[index]
end

-- Function to display the current state of the word
function displayWord(word, guessedLetters)
    local display = ""
    for i = 1, #word do
        local letter = word:sub(i, i)
        if guessedLetters[letter] then
            display = display .. letter .. " "
        else
            display = display .. "_ "
        end
    end
    print(display)
end

-- Game loop
local word = selectWord()
local guessedLetters = {}
local attempts = 6

print("Welcome to Hangman!")
print("Guess the word within " .. attempts .. " attempts.")

while attempts > 0 do
    displayWord(word, guessedLetters)

    -- Ask the player for a letter guess
    io.write("Enter a letter: ")
    local guess = io.read()

    -- Check if the letter is in the word
    guessedLetters[guess] = true

    if not word:find(guess, 1, true) then
        attempts = attempts - 1
        print("Incorrect guess! You have " .. attempts .. " attempts left.")
    end

    -- Check if the word has been completely guessed
    local complete = true
    for i = 1, #word do
        local letter = word:sub(i, i)
        if not guessedLetters[letter] then
            complete = false
            break
        end
    end

    if complete then
        print("Congratulations! You guessed the word.")
        break
    end
end

if attempts == 0 then
    print("Game over! You ran out of attempts. The word was: " .. word)
end

print("Thanks for playing!")
