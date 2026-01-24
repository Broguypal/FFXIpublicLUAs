--  ____                                          _ _
-- |  _ \                                        | ( )
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |
--                  |___/       |___/|_|
----------------------------------------------------------------------
--                           THF LUA
----------------------------------------------------------------------
-- Summary:
-- This lua relies on using the numberpad to change your mode/state which is tracked on the Job box.
-- To change the keybinds, please edit them in the Keybinds section below
-- To change your default Job box position, please change the "x" and "y" positions in the gearswap_box_config below

local texts = require('texts')

----------------------------------------------------------------------
--                           MODES / UI TEXT BOX
----------------------------------------------------------------------
TP_Mode = "Hybrid"
TP_Modes = { "Hybrid", "DT", "DPS" }

Treasure_Mode = "Off"
Treasure_Modes = { "On", "Off" }


gearswap_box = function()
    local str = '           \\cs(255,245,105)THIEF\\cr\n'
    str = str..' Offense Mode:\\cs(255,150,100)   '..TP_Mode..'\\cr\n'
    str = str..' Treasure Hunter:\\cs(255,150,100)   '..Treasure_Mode..'\\cr\n'
    return str
end

-- Edit the "x" and "y" positions below to change the default position of the job box.
gearswap_box_config = {pos={x=1320,y=550},padding=8, text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},}, bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

----------------------------------------------------------------------
--                           USER SETUP
----------------------------------------------------------------------
function user_setup()
    ----------------------------------------------------------------------
    --                           KEYBINDS
    ----------------------------------------------------------------------
    -- Modes
    send_command('bind numpad9 gs c ToggleHybridDPS')     -- Hybrid ↔ DPS
    send_command('bind numpad8 gs c ToggleDT')           -- DT toggle (back to previous)
    send_command('bind numpad6 gs c ToggleTreasure')     -- TH toggle (back to previous)

    -- Weapons (table cycling)
    send_command('bind numpad4 gs c ToggleMain')         -- Aeneas ↔ Naegling
    send_command('bind numpad5 gs c ToggleOffhand')      -- Gleti\'s Knife ↔ Centovente

    -- Convenience (kept consistent with your other luas)
    send_command('bind f9 input /item "Remedy" <me>')
    send_command('bind f10 input /item "Panacea" <me>')
    send_command('bind f11 input /item "Holy Water" <me>')
    send_command('bind numpad1 input /mount "Noble Chocobo"')
    send_command('bind numpad2 input /dismount')

    ----------------------------------------------------------------------
    --                           INITIALIZATION
    ----------------------------------------------------------------------
    initialize_weapon_tracking()
    gearswap_jobbox:text(gearswap_box())
    gearswap_jobbox:show()
end

----------------------------------------------------------------------
--                           WEAPON TABLES
----------------------------------------------------------------------
Weapons = {
    Main = {
        "Aeneas",
        "Naegling",
		"Tauret",
    },
    Offhand = {
        "Gleti's Knife",
        "Centovente",
    },
}

----------------------------------------------------------------------
--                           SETS / GEAR
----------------------------------------------------------------------
function get_sets()
	sets.idle    = {}
    sets.engaged = {}
    sets.ja      = {}
    sets.precast = {}
    sets.midcast = {}
    sets.ja 	 = {}
	sets.ws      = {}
	sets.special = {}

    ----------------------------------------------------------------------
    --                           IDLE SETS
    ----------------------------------------------------------------------
    -- Put your normal idle/town set here
    sets.idle.Normal = {
		ammo="Staunch Tathlum +1",
		head="Null Masque",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Trotter Boots",
		neck="Bathy Choker +1",
		waist="Engraved Belt",
		left_ear="Genmei Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    -- DT idle set
    sets.idle.DT = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Turms Mittens +1",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Unmoving Collar +1",
		waist="Engraved Belt",
		left_ear="Genmei Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }

    ----------------------------------------------------------------------
    --                           ENGAGED SETS
    ----------------------------------------------------------------------
    sets.engaged.Hybrid = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Null Loop",
		waist="Reiki Yotai",
		left_ear="Sherida Earring",
		right_ear={ name="Skulker's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
		left_ring="Ilabrat Ring",
		right_ring="Moonlight Ring",
		back="Null Shawl",
    }

    sets.engaged.DPS = set_combine(sets.engaged.Hybrid,{
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','"Triple Atk."+4',}},
		neck="Combatant's Torque",
		right_ring="Gere Ring",
    })

    ----------------------------------------------------------------------
    --                           PRECAST / MIDCAST
    ----------------------------------------------------------------------
    sets.precast.FastCast = {
        -- fast cast swaps (optional)
    }

    sets.midcast.Trust = {
		head="Nyame Helm",
		body="Adamantite Armor",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
    }

    ----------------------------------------------------------------------
    --                         Job Ability Sets
    ----------------------------------------------------------------------
		sets.ja.SneakAttack = {
		-- Empy gloves
			back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		}
		
		sets.ja.TrickAttack = {
		--Empy Chest
			back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
		}
		
		--accomplice/collaborator
		sets.ja.Accomplice = {
		--Empy Head
		}
		
		sets.ja.Flee = {
		--AF Feet
		}
		
		sets.ja.Hide = {
		-- AF chest
		}
		
		--steal/mug
		sets.ja.Steal = {
		-- Relic Head
		-- Relic Legs
		-- AF Feet
		}
		
		sets.ja.Despoil = {
		--Empy Legs
		--Empy feet
		}
		
		sets.ja.PerfectDodge = {
		--Relic Hands
		}
		
		sets.ja.Feint = {
		--Relic Legs
		}
		
		sets.ja.Waltz = {
		}
		
	----------------------------------------------------------------------
	--                     Special Sets
	----------------------------------------------------------------------
	
	-- Put your treasurehunter pieces here
	sets.special.TreasureHunter = {
	-- treasurehunter pieces here
	}
	
	-- Holywater
    sets.special.HolyWater = {
        neck="Nicander's Necklace",
        left_ring="Purity Ring",
        right_ring="Blenmot's Ring",
    }

    ----------------------------------------------------------------------
    --                           WEAPONSKILLS (optional skeleton)
    ----------------------------------------------------------------------
    sets.ws.Normal = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
    }
    
	sets.ws.RudrasStorm = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.RuthlessStroke = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.MandalicStab = {
		ammo="Crepuscular Pebble",
		head="Gleti's Mask",
		body="Nyame Mail",
		hands="Gleti's Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.Evisceration = {
		ammo="Coiste Bodhar",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Skulker's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
		left_ring="Begrudging Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.MercyStroke = {
		ammo="Seeth. Bomblet +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear={ name="Skulker's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
		left_ring="Sroda Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.Extenerator = {
		ammo="Coiste Bodhar",
		head="Gleti's Mask",
		body="Gleti's Cuirass",
		hands="Gleti's Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear={ name="Skulker's Earring", augments={'System: 1 ID: 1676 Val: 0','Accuracy+7','Mag. Acc.+7',}},
		left_ring="Ilabrat Ring",
		right_ring="Gere Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.SharkBite = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Ilabrat Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.SavageBlade = {
		ammo="Seeth. Bomblet +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Sailfi Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	sets.ws.AeolianEdge = {
		ammo="Seeth. Bomblet +1",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Moonshade Earring",
		left_ring="Begrudging Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Toutatis's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Phys. dmg. taken-10%',}},
	}
	
end

----------------------------------------------------------------------
--                           GENERAL LOGIC
----------------------------------------------------------------------
function idle()
	if TP_Mode == "DT" then
		equip(sets.idle.DT)
	elseif TP_Mode == "Hybrid" or TP_Mode == "DPS" then
		if player.status == "Engaged" then
			if TP_Mode == "Hybrid" then
				equip(sets.engaged.Hybrid)
			elseif TP_Mode == "DPS" then
				equip(sets.engaged.DPS)
			end
			if Treasure_Mode == "On" then 
				equip(sets.special.TreasureHunter)
			end
			if buffactive["Trick Attack"] then
				equip(sets.ja.TrickAttack)
			end
			if buffactive["Sneak Attack"] then
				equip(sets.ja.SneakAttack)
			end
		else
			equip(sets.idle.Normal)
		end
	end
end

function precast(spell)
    if spell.type == "WeaponSkill" then
        if spell.english == "Rudra's Storm" then
			equip(sets.ws.RudrasStorm)
		elseif spell.english == "Ruthless Stroke" then
			equip(sets.ws.RuthlessStroke)
		elseif spell.english == "Mandalic Stab" then
			equip(sets.ws.MandalicStab)
		elseif spell.english == "Evisceration" then
			equip(sets.ws.Evisceration)
		elseif spell.english == "Mercy Stroke" then
			equip(sets.ws.MercyStroke)
		elseif spell.english == "Extenerator" then
			equip(sets.ws.Extenerator)
		elseif spell.english == "Shark Bite" then
			equip(sets.ws.SharkBite)
		elseif spell.english == "Savage Blade" then
			equip(sets.ws.SavageBlade)
		elseif spell.english == "Aeolian Edge" then
			equip(sets.ws.AeolianEdge)
		else
			equip(sets.ws.Normal)
		end
		if Treasure_Mode == "On" then 
			equip(sets.special.TreasureHunter)
		end
		if buffactive["Trick Attack"] then
			equip(sets.ja.TrickAttack)
		end
		if buffactive["Sneak Attack"] then
			equip(sets.ja.SneakAttack)
		end
    elseif spell.type == "JobAbility" then
		if spell.english == "Sneak Attack" then
			equip(sets.ja.SneakAttack)
		elseif spell.english == "Trick Attack" then
			equip(sets.ja.TrickAttack)
		elseif spell.english == "Accomplice" or spell.english == "Collaborator" then
			equip(sets.ja.Accomplice)
		elseif spell.english == "Flee" then
			equip(sets.ja.Flee)
		elseif spell.english == "Hide" then
			equip(sets.ja.Hide)
		elseif spell.english == "Steal" or spell.english == "Mug" then
			equip(sets.ja.Steal)
		elseif spell.english == "Despoil" then
			equip(sets.ja.Despoil)
		elseif spell.english == "Perfect Dodge" then
			equip(sets.ja.PerfectDodge)
		elseif spell.english == "Feint" then
			equip(sets.ja.Feint)
		end
	elseif spell.type == "Walz" then
		equip(sets.ja.Waltz)
	elseif spell.english == "Holy Water" then
        equip(sets.special.HolyWater)
    elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then
        equip(sets.precast.FastCast)
    else
        idle()
    end
end

function midcast(spell)
    if spell.type == "Trust" then
		equip(sets.midcast.Trust)
    elseif spell.english == "Holy Water" then
        equip(sets.special.HolyWater)
    end
end

function aftercast(spell)
    idle()
end

----------------------------------------------------------------------
--                           KEY EVENTS
----------------------------------------------------------------------
function status_change(new,old)
	if new == "Engaged" then
		idle()
	else
		idle()
	end
end

----------------------------------------------------------------------
--                    WEAPON CYCLING & COMMANDS LOGIC
----------------------------------------------------------------------
function cycle(list, current)
    local index = 1
    if current then
        for i, v in ipairs(list) do
            if v == current then
                index = (i % #list) + 1
                break
            end
        end
    end
    return list[index]
end

function initialize_weapon_tracking()
    current_main = player.equipment.main or Weapons.Main[1]
    current_sub  = player.equipment.sub  or Weapons.Offhand[1]
end

function self_command(command)
    if command == "ToggleHybridDPS" then
        if TP_Mode == "Hybrid" then
            TP_Mode = "DPS"
			idle()
        else
            TP_Mode = "Hybrid"
			idle()
        end
    elseif command == "ToggleDT" then
        TP_Mode = "DT"
		idle()
    elseif command == "ToggleTreasure" then
		if Treasure_Mode == "On" then
			Treasure_Mode = "Off"
		else
			Treasure_Mode = "On"
		end
    elseif command == "ToggleMain" then
        current_main = cycle(Weapons.Main, current_main)
        equip({ main = current_main })
    elseif command == "ToggleOffhand" then
        current_sub = cycle(Weapons.Offhand, current_sub)
        equip({ sub = current_sub })
    end
    idle()
    gearswap_jobbox:text(gearswap_box())
    gearswap_jobbox:show()
end

----------------------------------------------------------------------
--                           UNLOAD & SETUP
----------------------------------------------------------------------
function file_unload()
    send_command('unbind numpad9')
    send_command('unbind numpad8')
    send_command('unbind numpad7')
    send_command('unbind numpad6')
    send_command('unbind numpad5')
    send_command('unbind numpad4')
    send_command('unbind numpad3')
    send_command('unbind numpad2')
    send_command('unbind numpad1')
    send_command('unbind numpad0')
    send_command('unbind ^numpad9')
    send_command('unbind ^numpad8')
    send_command('unbind ^numpad7')
    send_command('unbind ^numpad6')
    send_command('unbind ^numpad5')
    send_command('unbind ^numpad4')
    send_command('unbind ^numpad3')
    send_command('unbind ^numpad2')
    send_command('unbind ^numpad1')
    send_command('unbind ^numpad0')
    send_command('unbind !numpad9')
    send_command('unbind !numpad8')
    send_command('unbind !numpad7')
    send_command('unbind !numpad6')
    send_command('unbind !numpad5')
    send_command('unbind !numpad4')
    send_command('unbind !numpad3')
    send_command('unbind !numpad2')
    send_command('unbind !numpad1')
    send_command('unbind !numpad0')
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f11')
    send_command('unbind f12')
    enable("main","sub","range","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
end

user_setup()
