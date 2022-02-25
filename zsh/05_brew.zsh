# Homebrew configuration for M1
eval "$(/opt/homebrew/bin/brew shellenv)"

# Use Brew cURL instead of macOS's built-in older version
# Run `brew install curl` to install it
export PATH="/opt/homebrew/opt/curl/bin:$PATH"
