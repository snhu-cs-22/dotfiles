-- Source: https://qiita.com/keith_campbell/items/6787dca658a3c9460bca

local function GetFcitxStatus()
    local handle = io.popen('fcitx-remote')
    local result = handle:read('*a')
    handle:close()
    return result == '2\n'
end

local function Disable()
    -- Save fcitx status when leaving insert mode
    vim.g.fcitx_status = GetFcitxStatus()
    -- Disable (Japanese) input method
    os.execute('fcitx-remote -c')
end

local function Enable(status)
    if status then
        os.execute('fcitx-remote -o')
    end
end

if vim.fn.executable('fcitx-remote') then
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
