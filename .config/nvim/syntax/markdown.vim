" Vim syntax file
" Language: markdown
" TODO: Install overrides for already-defined syntax groups.

" Conceal formatting marks
setlocal conceallevel=2

" Highlighting for Obsidian internal links
syn region markdownObsidianLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" contains=markdownLink,markdownObsidianLinkAddress keepend concealends
" syn region markdownObsidianLinkAddress matchgroup=markdownLinkTextDelimiter start="\|" end="\]" conceal

" Highlighting for Obsidian highlights and comments
let s:concealends = ''
if has('conceal') && get(g:, 'markdown_syntax_conceal', 1) == 1
  let s:concealends = ' concealends'
endif
exe 'syn region markdownObsidianHighlight matchgroup=markdownObsidianHighlightDelimiter start="==\S\@=" end="\S\@<===\|^$" contains=markdownLineStart,@Spell' . s:concealends
exe 'syn region markdownObsidianComment matchgroup=markdownObsidianCommentDelimiter start="%%\S\@=" end="\S\@<=%%\|^$" contains=markdownLineStart,@Spell' . s:concealends

" Conceal urls in links
exe 'syn region markdownLinkText matchgroup=markdownLinkTextDelimiter start="!\=\[\%(\%(\_[^][]\|\[\_[^][]*\]\)*]\%( \=[[(]\)\)\@=" end="\]\%( \=[[(]\)\@=" nextgroup=markdownLink,markdownId skipwhite contains=@markdownInline,markdownLineStart' . s:concealends
exe 'syn region markdownId matchgroup=markdownIdDelimiter start="\[" end="\]" keepend contained' . s:concealends
exe 'syn region markdownAutomaticLink matchgroup=markdownUrlDelimiter start="<\%(\w\+:\|[[:alnum:]_+-]\+@\)\@=" end=">" keepend oneline' . s:concealends
exe 'syn region markdownLink matchgroup=markdownLinkDelimiter start="(" end=")" contains=markdownUrl keepend contained' . s:concealends

" Conceal "---" as em dash
" exe 'syn region markdownObsidianHighlight matchgroup=markdownObsidianHighlightDelimiter start="==\S\@=" end="\S\@<===\|^$" contains=markdownLineStart,@Spell' . s:concealends

" Highlighting for Obsidian inline footnotes
syn match markdownObsidianInlineFootnote "\^\[.\+\]"

" Syntax linking
hi def link markdownObsidianComment                Comment
hi def link markdownObsidianCommentDelimiter       Comment
