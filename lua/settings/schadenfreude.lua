require("schadenfreude").setup({
	{
		provider = "llmama",
		interface = "openai",
		api_key = vim.fn.getenv("GROQ_API_KEY"),
		options = {
			model = "llama-3.3-70b-versatile",
			url = "https://api.groq.com/openai/v1/chat/completions",
		},
	},
	{
		provider = "qwen",
		interface = "openai",
		api_key = vim.fn.getenv("GROQ_API_KEY"),
		options = {
			model = "qwen-2.5-coder-32b",
			url = "https://api.groq.com/openai/v1/chat/completions",
		},
	},
	{
		provider = "mixtral",
		interface = "openai",
		api_key = vim.fn.getenv("GROQ_API_KEY"),
		options = {
			model = "mixtral-8x7b-32768",
			url = "https://api.groq.com/openai/v1/chat/completions",
		},
	},
	{
		provider = "xai",
		interface = "openai",
		api_key = vim.fn.getenv("X_GROK_API_KEY"),
		options = {
			model = "grok-3",
			url = "https://api.x.ai/v1/chat/completions",
		},
	},
	{
		provider = "sonnet",
		interface = "anthropic",
		api_key = vim.fn.getenv("ANTHROPIC_KEY"),
		options = {
			model = "claude-3-5-sonnet-20241022",
			url = "https://api.anthropic.com/v1/messages",
		},
	},
	selected_provider = "sonnet",
})
