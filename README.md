# hdrp-dice
System games dice, blackjack, roullete 
- Game DiceRoll with Item one, two dice or five dice
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

# By
- Sadicius / Sadicius#1150 