fx_version 'adamant'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

games {'rdr3'}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}

client_script {
	'client/diceRoll.lua'
}

server_script {
	'server/server-dice.lua'
}

dependencies {
    'rsg-core',
    -- 'ox_lib',
	-- 'rNotify',
}

lua54 'yes'