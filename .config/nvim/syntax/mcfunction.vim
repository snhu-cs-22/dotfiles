" MCFunction Syntax File
" Language: mcfunction
" Includes automatic syntax highlighting based on Minecraft's highlighting.
" Based on a Notepad++ User Defined Language from reddit. (https://reddit.com/r/Minecraft/comments/7z0lf7/syntax_highlighting_for_113_commands_in_notepad/)

if exists("b:current_syntax")
  finish
endif

syn keyword mcfunctionFunctions advancement ban ban-ip banlist bossbar clear clone data datapack debug defaultgamemode deop difficulty effect enchant execute experience fill function gamemode gamerule give help kick kill locate me msg op pardon pardon-ip particle playsound publish recipe reload replaceitem save-all save-off save-on say scoreboard seed setblock setidletimeout setworldspawn spawnpoint spreadplayers stop stopsound summon tag team teleport tell tellraw time title tp trigger w weather whitelist worldborder xp
syn keyword mcfunctionOperators align anchored as at facing if in positioned rotated store unless&#x000D;&#x000A;merge remove add create get list set disable&#x000D;&#x000A;grant revoke&#x000D;&#x000A;objectives players setdisplay enable operation reset
syn keyword mcfunctionRelativeEntity @e @a @p @r @s
syn keyword mcfunctionRun run
syn keyword mcfunctionRelativePosition ^ ~
syn keyword mcfunctionObject block blocks entity score
syn keyword mcfunctionDefaultNamespace minecraft: #minecraft:
syn region mcfunctionNBT start="{" end="}"

hi mcfunctionNumber guifg=#FFFF00 guibg=NONE gui=NONE
hi mcfunctionFunctions guifg=#A8A8A8 guibg=NONE gui=NONE
hi mcfunctionOperators guifg=#0080FF guibg=NONE gui=NONE
hi mcfunctionRelativeEntity guifg=#54FCFC guibg=NONE gui=NONE
hi mcfunctionRun guifg=#FF3E3E guibg=NONE gui=NONE
hi mcfunctionRelativePosition guifg=#FCFC54 guibg=#2E2E2E gui=NONE
hi mcfunctionObject guifg=#54FCFC guibg=NONE gui=NONE
hi mcfunctionDefaultNamespace guifg=#FFFF80 guibg=NONE gui=NONE
hi mcfunctionNBT guifg=#54FC54 guibg=NONE gui=NONE

hi def link mcfunctionComment Comment
