require("stride").setup({
	api_key = os.getenv("OPENROUTER_API_KEY"),
	endpoint = "https://openrouter.ai/api/v1/chat/completions",
	model = "x-ai/grok-code-fast-1",
	mode = "completion",
})
