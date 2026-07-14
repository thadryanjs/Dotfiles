local dartmouth = {
    url = "https://chat.dartmouth.edu/api/chat/completions",
    api_type = "openai",
    fetch_key = function()
        return os.getenv("DARTMOUTH_CHAT_API_KEY")
    end,
    max_tokens = 4096,
    temperature = 0.7,
    top_p = 0.9,
}

local models = {
    {
        name = "Claude Sonnet 4.5",
        model = "anthropic.claude-sonnet-4-5-20250929",
    },
    {
        name = "Claude Opus 4.6",
        model = "anthropic.claude-opus-4-6",
    },
    {
        name = "Claude Haiku 4.5",
        model = "anthropic.claude-haiku-4-5-20251001",
    },
    {
        name = "GPT 5.4",
        model = "openai.gpt-5.4-2026-03-05",
    },
    {
        name = "GPT 4.1",
        model = "openai.gpt-4.1-2025-04-14",
    },
    {
        name = "Gemini 2.5 Flash",
        model = "vertex_ai.gemini-2.5-flash",
    },
    {
        name = "Gemini 2.5 Pro",
        model = "vertex_ai.gemini-2.5-pro",
    },
    {
        name = "Mistral Large 3",
        model = "mistral.mistral-large-2512",
    },
    {
        name = "Llama 3.2 11B Vision",
        model = "meta.llama-3.2-11b-vision-instruct",
    },
    {
        name = "Qwen3-VL 32b",
        model = "qwen.qwen3-vl-32b-instruct-fp8",
    },
}

return {
    config = dartmouth,
    models = models,
}
