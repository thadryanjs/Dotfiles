return {
    url = "https://chat.dartmouth.edu/api/chat/completions",
    api_type = "openai",
    fetch_key = function()
        return os.getenv("DARTMOUTH_CHAT_API_KEY")
    end,
    model = "anthropic.claude-sonnet-4-5-20250929",
    max_tokens = 4096,
    temperature = 0.7,
    top_p = 0.9,
}
