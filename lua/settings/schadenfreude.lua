require("schadenfreude").setup({
	{
		provider = "qwen-3",
		interface = "openai",
		api_key = vim.fn.getenv("GROQ_API_KEY"),
		options = {
			model = "qwen/qwen3-32b",
			url = "https://api.groq.com/openai/v1/chat/completions",
		},
	},
	{
		provider = "gpt-oss-120b",
		interface = "openai",
		api_key = vim.fn.getenv("GROQ_API_KEY"),
		options = {
			model = "openai/gpt-oss-120b",
			url = "https://api.groq.com/openai/v1/chat/completions",
		},
	},
	{
		provider = "qwen3-coder",
		interface = "openai",
		api_key = vim.fn.getenv("OPENROUTER_API_KEY"),
		options = {
			model = "qwen/qwen3-coder",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	{
		provider = "gemma",
		interface = "openai",
		api_key = vim.fn.getenv("GEMINI_API_KEY"),
		options = {
			model = "gemini-2.5-pro",
			url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
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
	selected_provider = "gemma",
})
