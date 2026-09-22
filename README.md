# hdrp-dice
System dice, two dice or five dice
- sent To Discord for logs

# Dependancies
- rsg-core
- ox_lib
- rnotify (optional)

# Starting the resource:
- add the following to your server.cfg file : ensure hdrp-dice

# Installation
- ensure that the dependancies are added and started
- add hdrp-dice to your resources folder
- add images to your "\rsg-inventory\html\images"
- add items to your "\rsg-core\shared\items.lua"
```lua
['dice']		        = {['name'] = 'dice',		    ['label'] = 'Dado',	        ['weight'] = 500, 	['type'] = 'item',	['image'] = 'dice.png',		['unique'] = false,		['useable'] = true,		['shouldClose'] = true,		['combinable'] = nil,		['level'] = 0,		['description'] = 'Campfire'},
['dice2']		        = {['name'] = 'dice2',		    ['label'] = 'Dado doble',	['weight'] = 500, 	['type'] = 'item',	['image'] = 'dice.png',		['unique'] = false,		['useable'] = true,		['shouldClose'] = true,		['combinable'] = nil,		['level'] = 0,		['description'] = 'Campfire'},
['dice5']		        = {['name'] = 'dice5',		    ['label'] = 'Dado de oro',	['weight'] = 500, 	['type'] = 'item',	['image'] = 'dice.png',		['unique'] = false,		['useable'] = true,		['shouldClose'] = true,		['combinable'] = nil,		['level'] = 0,		['description'] = 'Campfire'},
```

# Version oficial thanks
this is a reconverted work from RexShackGaming, by me.
- https://github.com/Rexshack-RedM/rsg-holding
- https://github.com/Rexshack-RedM/rsg-trapper
- qbr-trapper

# By
- Sadicius / Sadicius#1150 