require("schadenfreude").setup({
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
		provider = "haiku",
		interface = "openai",
		api_key = vim.fn.getenv("OPENROUTER_API_KEY"),
		options = {
			model = "anthropic/claude-haiku-4.5",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	{
		provider = "horizon",
		interface = "openai",
		api_key = vim.fn.getenv("OPENROUTER_API_KEY"),
		options = {
			model = "openrouter/horizon-alpha",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	{
		provider = "grok",
		interface = "openai",
		api_key = vim.fn.getenv("OPENROUTER_API_KEY"),
		options = {
			model = "x-ai/grok-code-fast-1",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	{
		provider = "z",
		interface = "openai",
		api_key = vim.fn.getenv("OPENROUTER_API_KEY"),
		options = {
			model = "z-ai/glm-4.6",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	{
		provider = "gepeto",
		interface = "openai",
		api_key = vim.fn.getenv("OPENROUTER_API_KEY"),
		options = {
			model = "openai/gpt-oss-20b",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	{
		provider = "sonnet",
		interface = "openai",
		api_key = vim.fn.getenv("OPENROUTER_API_KEY"),
		options = {
			model = "anthropic/claude-sonnet-4.5",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	{
		provider = "gemma",
		interface = "openai",
		api_key = vim.fn.getenv("OPENROUTER_API_KEY"),
		options = {
			model = "google/gemini-2.5-pro",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	selected_provider = "z",
})
