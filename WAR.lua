--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
----------------------------------------------------------------------
--                           WAR LUA
----------------------------------------------------------------------
-- Summary:
-- This lua relies on using the numberpad to change your mode/state which is tracked on the Job box. 
-- To change the keybinds, please edit them in the Keybinds function below
-- To change your default Job box position, please change the "x" and "y" positions in then gearswap_box_config settings below

----------------------------------------------------------------------
--                           MODES / UI TEXT BOX
----------------------------------------------------------------------
TP_Mode  = "Hybrid"
Buff_Mode = "Low"
Weapon_Mode = "2H"
tomahawk_count = 0

TP_Modes = { "Hybrid", "DPS", "Tank" }
Buff_Modes = { "High", "Low" }
Weapon_Modes = { "2H", "1H" }

gearswap_box = function()
  str = '           \\cs(165,100,40)WARRIOR\\cr\n'
  str = str..' Offense Mode:\\cs(255,150,100)   '..TP_Mode..'\\cr\n'
  str = str..' Weapon Mode:\\cs(255,150,100)   '..Weapon_Mode..'\\cr\n'
  str = str..' Buff Level:\\cs(255,150,100)   '..Buff_Mode..'\\cr\n'
  str = str..' Tomahawks: '..tomahawk_count..'\n'
  str = str..' ctrl: \\cs(255,165,0)[BSRK]\\cr \\cs(255,255,0)[CRY]\\cr \\cs(128,255,255)[VOKE]\\cr\n'
  str = str..' alt:  \\cs(0,204,102)[RETAL]\\cr \\cs(204,153,255)[RESTR]\\cr\n'
    return str
end

-- Edit the "x" and "y" positions below to change the default position of the job box.
gearswap_box_config = {pos={x=1320,y=550},padding=8, text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},}, bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function check_tomahawk()
    local count = 0
    local bags = {'inventory','wardrobe','wardrobe2','wardrobe3','wardrobe4','wardrobe5','wardrobe6','wardrobe7','wardrobe8'}
    for _, bag in ipairs(bags) do
        if player[bag] and player[bag]['Thr. Tomahawk'] and player[bag]['Thr. Tomahawk'].count then
            count = count + player[bag]['Thr. Tomahawk'].count
        end
    end

    local color = "\\cs(255,255,255)"
    if count == 0 then
        color = "\\cs(255,0,0)"
    elseif count < 50 then
        color = "\\cs(255,165,0)"
    elseif count < 99 then
        color = "\\cs(255,255,0)"
    else
        color = "\\cs(0,255,0)"
    end
    tomahawk_count = color .. tostring(count) .. "\\cr"
end
----------------------------------------------------------------------
--                           USER SETUP
----------------------------------------------------------------------
function user_setup()
	----------------------------------------------------------------------
	--                           KEYBINDS
	----------------------------------------------------------------------
	send_command('bind numpad9 gs c ToggleHybrid')   -- Hybrid ↔ DPS
	send_command('bind numpad8 gs c ToggleTank')     -- Tank
	
	send_command('bind numpad7 gs c ToggleWeaponMode') -- 2H ↔ 1H
	send_command('bind numpad6 gs c ToggleBuff')     -- High ↔ Low
	

	send_command('bind numpad4 gs c ToggleWeapon')   -- Cycle main weapons
	send_command('bind numpad5 gs c ToggleSub')      -- Cycle sub (grips/shields/offhands)
	
	send_command('bind numpad0 input /ja "Tomahawk" <t>')

	send_command('bind ^numpad1 input /ja "Berserk" <me>')   -- [BSRK]
	send_command('bind ^numpad2 input /ja "Warcry" <me>')    -- [CRY]
	send_command('bind ^numpad3 input /ja "Provoke" <t>')    -- [VOKE]
	send_command('bind !numpad1 input /ja "Retaliation" <me>')  -- [RETAL]
	send_command('bind !numpad2 input /ja "Restraint" <me>')    -- [RESTR]

	send_command('bind f9 input /item "Remedy" <me>')
	send_command('bind f10 input /item "Panacea" <me>')
	send_command('bind f11 input /item "Holy Water" <me>')

	----------------------------------------------------------------------
	--                           INITIALIZATION
	----------------------------------------------------------------------
	initialize_weapon_tracking()
	check_tomahawk()
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end

----------------------------------------------------------------------
--                           WEAPON TABLES
----------------------------------------------------------------------
-- Two-Handed weapons (Great Axe, Great Sword, Polearm)
TwoHanded = {
	"Chango",
	"Laphria",
	"Helheim",
	"Shining One",
	-- add more 2H weapons here
}

-- One-Handed weapons (Sword, Axe, Club)
OneHanded = {
	"Naegling",
	"Dolichenus",
	"Loxotic Mace +1",
	-- add more 1H weapons here
}

-- Grips (for 2H weapons)
Grips = {
	"Utu Grip",
	"Rigorous Grip +1",
	-- add more grips here
}

-- Shields (for 1H weapons without dual wield)
Shields = {
	"Blurred Shield +1",
	"Fernagu",
	-- add more shields here
}

-- Offhand weapons (for 1H weapons with /NIN or /DNC dual wield)
Offhands = {
	"Barbarity +1",
	"Sangarius +1",
	-- add more offhand weapons here
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
    sets.ws      = {}
    sets.items   = {}

	----------------------------------------------------------------------
	--                           IDLE SETS
	----------------------------------------------------------------------
	sets.idle.normal  = {
		-- Fill in your idle/DT set - Put movement speed gear here.
	}
	
	sets.idle.tank    = {
		-- Fill in your full tank set
	}
	
	----------------------------------------------------------------------
	--                           ENGAGED SETS
	----------------------------------------------------------------------
	sets.engaged.hybrid       = {
		-- Fill in your hybrid TP set (balanced DPS + DT)
	}

	sets.engaged.dps          = {
		-- Fill in your full DPS TP set (max damage, minimal DT)
	}

	----------------------------------------------------------------------
	--                           PRECAST SETS
	----------------------------------------------------------------------
	sets.precast.fastcast 	= {
	}
	
	----------------------------------------------------------------------
	--                           MIDCAST SETS
	----------------------------------------------------------------------
	sets.midcast.default 	= {}

	----------------------------------------------------------------------
	--                           JOB ABILITIES
	----------------------------------------------------------------------
	sets.ja.provoke        = {}
	
	sets.ja.berserk        = {--[[AF Body]]}
	sets.ja.defender       = {}
	sets.ja.warcry         = {--[[Relic Head]]}
	sets.ja.aggressor      = {--[[AF Head, Relic Body]]}
	sets.ja.retaliation    = {--[[AF Hands, Empy Feet]]}
	sets.ja.restraint      = {--[[Empy Hands]]}
	sets.ja.bloodrage      = {--[[Empy Body]]}
	
	sets.ja.mighty_strikes  = {--[[Relic Hands]]}
	sets.ja.brazen_rush     = {}
	sets.ja.warriors_charge = {--[[Relic Legs]]}
	sets.ja.tomahawk       = {--[[Relic Feet]]}

	----------------------------------------------------------------------
	--                  GREAT AXE WEAPONSKILLS
	----------------------------------------------------------------------
	-- Disaster / Metatron Torment (STR WSD)
	sets.ws.disaster = {
	}
	sets.ws.disaster_high = set_combine(sets.ws.disaster, {
	})

	-- Upheaval / King's Justice (VIT WSD for Upheaval, STR WSD for KJ)
	sets.ws.upheaval = {
	}
	sets.ws.upheaval_high = set_combine(sets.ws.upheaval, {
	})

	sets.ws.kings_justice = {
	}
	sets.ws.kings_justice_high = set_combine(sets.ws.kings_justice, {
	})

	-- Ukko's Fury / Raging Rush (crit-based)
	sets.ws.ukkos_fury = {
	}
	sets.ws.ukkos_fury_high = set_combine(sets.ws.ukkos_fury, {
	})

	sets.ws.raging_rush = {
	}
	sets.ws.raging_rush_high = set_combine(sets.ws.raging_rush, {
	})

	-- Metatron Torment (shares disaster set logic, STR WSD)
	sets.ws.metatron = {
	}
	sets.ws.metatron_high = set_combine(sets.ws.metatron, {
	})

	----------------------------------------------------------------------
	--                  SWORD WEAPONSKILLS
	----------------------------------------------------------------------
	-- Savage Blade (STR/MND WSD)
	sets.ws.savage_blade = {
	}
	sets.ws.savage_blade_high = set_combine(sets.ws.savage_blade, {
	})

	----------------------------------------------------------------------
	--                  AXE WEAPONSKILLS
	----------------------------------------------------------------------
	-- Decimation / Ruinator (multi-hit DA)
	sets.ws.decimation = {
	}
	sets.ws.decimation_high = set_combine(sets.ws.decimation, {
	})

	-- Mistral Axe / Calamity (STR WSD)
	sets.ws.mistral_axe = {
	}
	sets.ws.mistral_axe_high = set_combine(sets.ws.mistral_axe, {
	})

	-- Cloudsplitter (magic WS, STR/INT)
	sets.ws.cloudsplitter = {
	}
	-- Cloudsplitter does not change much between buff levels
	sets.ws.cloudsplitter_high = set_combine(sets.ws.cloudsplitter, {
	})

	----------------------------------------------------------------------
	--                  CLUB WEAPONSKILLS
	----------------------------------------------------------------------
	-- Judgment / Black Halo (STR/MND WSD - same as Savage Blade logic)
	sets.ws.judgment = {
	}
	sets.ws.judgment_high = set_combine(sets.ws.judgment, {
	})

	----------------------------------------------------------------------
	--                  GREAT SWORD WEAPONSKILLS
	----------------------------------------------------------------------
	-- Fimbulvetr (STR WSD)
	sets.ws.fimbulvetr = {
	}
	sets.ws.fimbulvetr_high = set_combine(sets.ws.fimbulvetr, {
	})

	-- Scourge (STR WSD)
	sets.ws.scourge = {
	}
	sets.ws.scourge_high = set_combine(sets.ws.scourge, {
	})

	-- Resolution (multi-hit DA, STR)
	sets.ws.resolution = {
	}
	sets.ws.resolution_high = set_combine(sets.ws.resolution, {
	})

	----------------------------------------------------------------------
	--                  POLEARM WEAPONSKILLS
	----------------------------------------------------------------------
	-- Impulse Drive (crit-based)
	sets.ws.impulse_drive = {
	}
	sets.ws.impulse_drive_high = set_combine(sets.ws.impulse_drive, {
	})

	-- Stardiver (multi-hit crit-based)
	sets.ws.stardiver = {
	}
	sets.ws.stardiver_high = set_combine(sets.ws.stardiver, {
	})

	----------------------------------------------------------------------
	--                  GENERIC / FALLBACK WS
	----------------------------------------------------------------------
	sets.ws.normal = {
	}
	sets.ws.normal_high = set_combine(sets.ws.normal, {
	})

	----------------------------------------------------------------------
	--                           ITEM SETS
	----------------------------------------------------------------------
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}
end

----------------------------------------------------------------------
--                           GENERAL LOGIC
----------------------------------------------------------------------
function idle()
	if TP_Mode == "Hybrid" then
		if player.status == "Engaged" then
			equip(sets.engaged.hybrid)
		else
			equip(sets.idle.normal)
		end
	elseif TP_Mode == "DPS" then
		if player.status == "Engaged" then
			equip(sets.engaged.dps)
		else
			equip(sets.idle.normal)
		end
	elseif TP_Mode == "Tank" then
		equip(sets.idle.tank)
	end
end

----------------------------------------------------------------------
--               WEAPONSKILL SET PICKER (handles Buff_Mode)
----------------------------------------------------------------------
function get_ws_set(base_name)
	if Buff_Mode == "High" then
		local high_set = sets.ws[base_name.."_high"]
		if high_set then return high_set end
	end
	return sets.ws[base_name] or sets.ws.normal
end

function precast(spell)
	if spell.type == "WeaponSkill" then
		-- Great Axe WS
		if spell.english == "Upheaval" then
			equip(get_ws_set("upheaval"))
		elseif spell.english == "King's Justice" then
			equip(get_ws_set("kings_justice"))
		elseif spell.english == "Ukko's Fury" then
			equip(get_ws_set("ukkos_fury"))
		elseif spell.english == "Raging Rush" then
			equip(get_ws_set("raging_rush"))
		elseif spell.english == "Disaster" then
			equip(get_ws_set("disaster"))
		elseif spell.english == "Metatron Torment" then
			equip(get_ws_set("metatron"))

		-- Sword WS
		elseif spell.english == "Savage Blade" then
			equip(get_ws_set("savage_blade"))

		-- Axe WS
		elseif spell.english == "Decimation" or spell.english == "Ruinator" then
			equip(get_ws_set("decimation"))
		elseif spell.english == "Mistral Axe" or spell.english == "Calamity" then
			equip(get_ws_set("mistral_axe"))
		elseif spell.english == "Cloudsplitter" then
			equip(get_ws_set("cloudsplitter"))

		-- Club WS
		elseif spell.english == "Judgment" or spell.english == "Black Halo" then
			equip(get_ws_set("judgment"))

		-- Great Sword WS
		elseif spell.english == "Fimbulvetr" then
			equip(get_ws_set("fimbulvetr"))
		elseif spell.english == "Scourge" then
			equip(get_ws_set("scourge"))
		elseif spell.english == "Resolution" then
			equip(get_ws_set("resolution"))
		elseif spell.english == "Shockwave" then
			equip(get_ws_set("normal"))

		-- Polearm WS
		elseif spell.english == "Impulse Drive" then
			equip(get_ws_set("impulse_drive"))
		elseif spell.english == "Stardiver" then
			equip(get_ws_set("stardiver"))

		-- Fallback
		else 
			equip(get_ws_set("normal"))
		end

	elseif spell.type == "JobAbility" then
		if spell.english == "Berserk" then 
			equip(sets.ja.berserk)
		elseif spell.english == "Defender" then 
			equip(sets.ja.defender)
		elseif spell.english == "Warcry" then 
			equip(sets.ja.warcry)
		elseif spell.english == "Aggressor" then 
			equip(sets.ja.aggressor)
		elseif spell.english == "Retaliation" then 
			equip(sets.ja.retaliation)
		elseif spell.english == "Restraint" then 
			equip(sets.ja.restraint)
		elseif spell.english == "Blood Rage" then 
			equip(sets.ja.bloodrage)
		elseif spell.english == "Provoke" then 
			equip(sets.ja.provoke)
		elseif spell.english == "Mighty Strikes" then 
			equip(sets.ja.mighty_strikes)
		elseif spell.english == "Brazen Rush" then 
			equip(sets.ja.brazen_rush)
		elseif spell.english == "Warrior's Charge" then 
			equip(sets.ja.warriors_charge)
		elseif spell.english == "Tomahawk" then 
			equip(sets.ja.tomahawk)
		end
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then
		equip(sets.precast.fastcast)
	end
end

function midcast(spell)
	if spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" then
		equip(sets.midcast.default)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	end
end

function aftercast(spell)
	equip({ main = current_main, sub = current_sub })
	idle()
	check_tomahawk()
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end

----------------------------------------------------------------------
--                           KEY EVENTS
----------------------------------------------------------------------
function status_change(new, old)
	idle()
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
	current_main = player.equipment.main or TwoHanded[1]
	current_sub  = Grips[1]
end

function self_command(command)
	if command == "ToggleHybrid" then
		if TP_Mode == "Hybrid" then
			TP_Mode = "DPS"
		else
			TP_Mode = "Hybrid"
		end
		idle()
	elseif command == "ToggleTank" then
		TP_Mode = "Tank"
		idle()
	elseif command == "ToggleBuff" then
		if Buff_Mode == "High" then
			Buff_Mode = "Low"
		else
			Buff_Mode = "High"
		end
	elseif command == "ToggleWeaponMode" then
		if Weapon_Mode == "2H" then
			Weapon_Mode = "1H"
			current_main = OneHanded[1]
			if player.sub_job == "NIN" or player.sub_job == "DNC" then
				current_sub = Offhands[1]
			else
				current_sub = Shields[1]
			end
		else
			Weapon_Mode = "2H"
			current_main = TwoHanded[1]
			current_sub = Grips[1]
		end
		equip({ main = current_main, sub = current_sub })
	elseif command == "ToggleWeapon" then
		if Weapon_Mode == "2H" then
			if #TwoHanded > 0 then
				current_main = cycle(TwoHanded, current_main)
				equip({ main = current_main })
			end
		else
			if #OneHanded > 0 then
				current_main = cycle(OneHanded, current_main)
				equip({ main = current_main })
			end
		end
	elseif command == "ToggleSub" then
		if Weapon_Mode == "2H" then
			current_sub = cycle(Grips, current_sub)
		elseif player.sub_job == "NIN" or player.sub_job == "DNC" then
			current_sub = cycle(Offhands, current_sub)
		else
			current_sub = cycle(Shields, current_sub)
		end
		equip({ sub = current_sub })
	end
	check_tomahawk()
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
