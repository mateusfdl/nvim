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
		provider = "deepseek",
		interface = "openai",
		api_key = vim.fn.getenv("GROQ_API_KEY"),
		options = {
			model = "deepseek-r1-distill-qwen-32b",
			url = "https://api.groq.com/openai/v1/chat/completions",
		},
	},
	{
		provider = "llama-specdec",
		interface = "openai",
		api_key = vim.fn.getenv("GROQ_API_KEY"),
		options = {
			model = "llama-3.3-70b-specdec",
			url = "https://api.groq.com/openai/v1/chat/completions",
		},
	},
	{
		provider = "deepseek-v3",
		interface = "openai",
		api_key = vim.fn.getenv("OPEN_ROUTER_KEY"),
		options = {
			model = "deepseek/deepseek-chat-v3-0324:free",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	{
		provider = "gemma",
		interface = "openai",
		api_key = vim.fn.getenv("GEMINI"),
		options = {
			model = "gemini-2.0-flash",
			url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
		},
	},
	{
		provider = "rich gemma",
		interface = "openai",
		api_key = vim.fn.getenv("GEMINI"),
		options = {
			model = "gemini-2.5-pro-preview-03-25",
			url = "https://generativelanguage.googleapis.com/v1beta/openai/chat/completions",
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
	{
		provider = "local-qwen",
		interface = "openai",
		api_key = "fooooo",
		options = {
			model = "qwen2.5-coder-14b-instruct",
			url = "http://desktop:1234/v1/chat/completions",
		},
	},
	{
		provider = "quasar",
		interface = "openai",
		api_key = vim.fn.getenv("OPEN_ROUTER_KEY"),
		options = {
			model = "openrouter/quasar-alpha",
			url = "https://openrouter.ai/api/v1/chat/completions",
		},
	},
	selected_provider = "deepseek-v3",
})
