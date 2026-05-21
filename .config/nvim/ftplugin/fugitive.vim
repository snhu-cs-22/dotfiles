nnoremap <buffer> cb<space> :Git branch<space>
nnoremap <buffer> cbb :Git branch<CR>
nnoremap <buffer> cba <Cmd>Git branch -a<CR>

nnoremap <buffer> g2<space> :Git bisect<space>
nnoremap <buffer> g2s <Cmd>Git bisect start
nnoremap <buffer> g2b <Cmd>Git bisect bad<CR>
nnoremap <buffer> g2g <Cmd>Git bisect good<CR>
nnoremap <buffer> g2o <Cmd>Git bisect old<CR>
nnoremap <buffer> g2n <Cmd>Git bisect new<CR>
nnoremap <buffer> g2r <Cmd>Git bisect reset<CR>

nnoremap <buffer> d<space> :Git diff<space>
nnoremap <buffer> dd <Cmd>Git diff<CR>
nnoremap <buffer> ds <Cmd>Git diff --staged<CR>
nnoremap <buffer> dm <Cmd>Git diff main..HEAD<CR>
nnoremap <buffer> dM <Cmd>Git diff master..HEAD<CR>

nnoremap <buffer> D<space> :Git diff --stat<space>
nnoremap <buffer> DD <Cmd>Git diff --stat<CR>
nnoremap <buffer> Ds <Cmd>Git diff --stat --staged<CR>
nnoremap <buffer> Dm <Cmd>Git diff --stat main..HEAD<CR>
nnoremap <buffer> DM <Cmd>Git diff --stat master..HEAD<CR>

nnoremap <buffer> gl<space> :Git log --decorate --oneline --graph<space>
nnoremap <buffer> glr <Cmd>Git reflog<CR>
nnoremap <buffer> gll <Cmd>Git log --decorate --oneline --graph<CR>
nnoremap <buffer> glm <Cmd>Git log --decorate --oneline --graph main^..HEAD<CR>
nnoremap <buffer> glM <Cmd>Git log --decorate --oneline --graph master^..HEAD<CR>
nnoremap <buffer> gLL <Cmd>Git log --decorate --oneline --graph --stat<CR>
nnoremap <buffer> gLm <Cmd>Git log --decorate --oneline --graph --stat main^..HEAD<CR>
nnoremap <buffer> gLM <Cmd>Git log --decorate --oneline --graph --stat master^..HEAD<CR>

nnoremap <buffer> gr<space> :Git rebase --autostash
nnoremap <buffer> grm <Cmd>Git rebase main --autostash<CR>
nnoremap <buffer> grM <Cmd>Git rebase master --autostash<CR>
nnoremap <buffer> gri<space> :Git rebase -i --autosquash --autostash
nnoremap <buffer> grim <Cmd>Git rebase main -i --autosquash --autostash<CR>
nnoremap <buffer> griM <Cmd>Git rebase master -i --autosquash --autostash<CR>

nnoremap <buffer> a<space> :Git absorb<space>
nnoremap <buffer> am <Cmd>Git absorb -b main -Fn<CR>
nnoremap <buffer> aM <Cmd>Git absorb -b master -Fn<CR>
nnoremap <buffer> Am <Cmd>Git absorb -b main -F<CR>
nnoremap <buffer> AM <Cmd>Git absorb -b master -F<CR>

nnoremap <buffer> gfo <Cmd>Git fetch origin<CR>
nnoremap <buffer> gplo <Cmd>Git pull origin<CR>
nnoremap <buffer> gpso <Cmd>Git push origin<CR>
