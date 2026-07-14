
- I have lots of models through Dartmouth and copilot which are in my config and would like to:
    - general chat (what I am talking to) be reasonably capable for lookup and planning
    - Be somewhat conservative about tokens use as there are limits on the pricey models
    - Open to having the expensive models be manually activated

There should be the following agents:

    - plan (free)   <- default plan
    - build (free)  <- default build
    - plan-burn (balanced model not too expensive, good planner)
    - build-burn (balanced model not too expensive, good builder)
    - build-burn-heavy (full power)

The first two should be free, the next three should be dartmouth models. I am open to suggestions as to the most efficient way to switch to copilot when I have not Dartmouth tokens left.

The names are pretty self-explanatory - planning model, a reasonable build model, a powerful build model. Ones with "dartmouth" are done through my Dartmouth provider, Copilot through my copilot, etc

I notice GPT 5 mini is much slower than other models and it should not be used as a front line planner - only use it if there is a strong reason to do so and not for a model I'm using all the time

  GPT-5 mini                       0x <- Really slow
  GPT-4.1                          0x <- Solid and then suddenly deletes code instead of appending to it

## Perms

- Plan agents should be able to read, ls, webfetch,  things like that, but not edit
- Build agents should be able to do all that and also write and use bash
    - They should ask me the first time each session however

## Dartmouth

I have been given this information on the models I have through Dartmouth:

Free models:
    - GPT OSS 120B
    - Gemma 3 27B (doesn't work with tool calls)
    - Qwen 3.5


['openai.gpt-oss-120b',
 'google.gemma-3-27b-it',
 'meta.llama-3.2-11b-vision-instruct',
 'qwen.qwen3-vl:32b', (getting phased out)
 'qwen.qwen3.5-122b',
 'anthropic.claude-haiku-4-5-20251001',
 'anthropic.claude-opus-4-5-20251101',
 'anthropic.claude-opus-4-6',
 'anthropic.claude-opus-4-7',
 'anthropic.claude-sonnet-4-5-20250929',
 'anthropic.claude-sonnet-4-6',
 'vertex_ai.gemini-3-flash-preview',
 'vertex_ai.gemini-3.1-pro-preview',
 'openai.gpt-5.3-chat-latest',
 'openai.gpt-5.4-2026-03-05',
 'openai.gpt-5.4-mini-2026-03-17',
 'mistral.mistral-large-2512',
 'mistral.mistral-medium-2508',
 'mistral.pixtral-large-2411',
 'meta.llama-3-2-3b-instruct',
 'baai.bge-large-en-v1-5',
 'baai.bge-m3',
 'google_genai.gemini-embedding-001',
 'meta.codellama-13b-instruct-hf',
 'mistral.codestral-embed-2505',
 'mistral.mistral-embed',
 'openai.text-embedding-3-large',
 'openai.text-embedding-3-small',
 'voyage.voyage-3.5',
 'voyage.voyage-code-3',
 'voyage.voyage-finance-2',
 'voyage.voyage-law-2',
 'hop-bo-patron-help-bot',
 'mistral.devstral-2512',
 'curriculum-helper',
 'vertex_ai.gemini-3.1-flash-lite-preview',
 'vertex_ai.gemini-2.5-flash',
 'vertex_ai.gemini-2.5-pro',
 'openai.gpt-5.2-chat-latest']
thadryan@darlene:~/.dotfiles/.config/opencode(dev)
~:)

## Copilot:

Free models - any with a 0x (GPT-5 mini, GPT-4.1)

 Search models...

 Search models...

 Search models...

 Search models...

  GPT-5.3-Codex (default) ✓        1x
  GPT-5.2-Codex                    1x
  GPT-5.2                          1x
  GPT-5.1                          1x
  GPT-5.4 mini                  0.33x
  GPT-5 mini                       0x <- Seems slow, use only if it's the perfect fit
  GPT-4.1                          0x <- Seems to delete shit, avoid unless strongly indicated
❯ Claude Haiku 4.5              0.33x

Note that they work when I use this format

...
    "plan": {
      "description": "Plan with Copilot free model",
      "model": "github-copilot/gpt-5-mini",
      "permission": {
        "bash": "ask"
      }
    },
    "build": {
      "description": "Build with Copilot free model",
      "model": "github-copilot/gpt-4.1",
      "permission": {
        "bash": "ask"
      }
    },
```

## Free though OpenCode
- Big Pickle
- Opencode Free model router
- MiMo V2 Omni Free
- MiniMax M2.5 Free
- Nemotron 3 Super Free
- Qwen3.6 Plus Free
- MiMo V2 Pro Free
- Big Pickle
