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
        name = "Claude Sonnet 5",
        model = "anthropic.claude-sonnet-5",
    },
    {
        name = "Claude Opus 5",
        model = "anthropic.claude-opus-5",
    },
    {
        name = "Claude Haiku 4.5",
        model = "anthropic.claude-haiku-4-5-20251001",
    },
    {
        name = "GPT 5.6 Luna",
        model = "openai.gpt-5.6-luna",
    },
    {
        name = "GPT 5.5",
        model = "openai.gpt-5.5-2026-04-23",
    },
    {
        name = "Gemini 3.8 Flash",
        model = "vertex_ai.gemini-3.8-flash",
    },
    {
        name = "Gemini 3.1 Pro",
        model = "vertex_ai.gemini-3.1-pro-preview",
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
        model = "qwen.qwen3-vl:32b",
    },
}

return {
    config = dartmouth,
    models = models,
}
