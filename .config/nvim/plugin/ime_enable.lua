-- Source: https://qiita.com/keith_campbell/items/6787dca658a3c9460bca

local ime_commands = nil;
if vim.fn.executable('fcitx5-remote') then
	ime_commands = {
		status = 'fcitx5-remote',
		disable = 'fcitx5-remote -c',
		enable = 'fcitx5-remote -o',
	}
elseif vim.fn.executable('fcitx-remote') then
	ime_commands = {
		status = 'fcitx-remote',
		disable = 'fcitx-remote -c',
		enable = 'fcitx-remote -o',
	}
end

if ime_commands ~= nil then
	local function GetFcitxStatus()
		local handle = io.popen(ime_commands['status'])
		local result = handle:read('*a')
		handle:close()
		return result == '2\n'
	end

	local function Disable()
		-- Save fcitx status when leaving insert mode
		vim.g.fcitx_status = GetFcitxStatus()
		-- Disable (Japanese) input method
		os.execute(ime_commands['disable'])
	end

	local function Enable(status)
		if status then
			os.execute(ime_commands['enable'])
		end
	end

	vim.g.fcitx_status = GetFcitxStatus()

	-- Autocmd for InsertLeave and InsertEnter
	vim.api.nvim_create_autocmd('InsertLeave', {
		callback = Disable
	})
	vim.api.nvim_create_autocmd('InsertEnter', {
		callback = function()
			Enable(vim.g.fcitx_status)
		end
	})

	-- Autocmd for CmdlineLeave and CmdlineEnter
	vim.api.nvim_create_autocmd('CmdlineLeave', {
		pattern = '[/?]',
		callback = Disable
	})

	vim.api.nvim_create_autocmd('CmdlineEnter', {
		pattern = '[/?]',
		callback = function()
			Enable(vim.g.fcitx_status)
		end
	})
end
