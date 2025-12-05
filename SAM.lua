--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
----------------------------------------------------------------------
--                           SAM LUA
----------------------------------------------------------------------
-- Summary:
-- This lua relies on using the numberpad to change your mode/state which is tracked on the Job box. 
-- To change the keybinds, please edit them in the Keybinds function below
-- To change your default Job box position, please change the "x" and "y" positions in then gearswap_box_config settings below

----------------------------------------------------------------------
--                           MODES / UI TEXT BOX
----------------------------------------------------------------------
TP_Mode  = "Hybrid"
Haste_Mode = "Haste 2"
Hasso_Mode = "On"

TP_Modes = { "Hybrid", "Tank", "Ranger" }
Haste_Modes = { "Haste 2", "Haste 1" }
Hasso_Modes = { "On", "Off"}

gearswap_box = function()
  str = '           \\cs(165,100,40)SAMURAI\\cr\n'
  str = str..' Offense Mode:\\cs(255,150,100)   '..TP_Mode..'\\cr\n'
  str = str..' Haste Mode:\\cs(255,150,100)   '..Haste_Mode..'\\cr\n'
  str = str..' Auto Hasso:\\cs(255,150,100)   '..Hasso_Mode..'\\cr\n'
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
	send_command('bind numpad9 gs c ToggleHybrid')   -- Hybrid ↔ DPS
	send_command('bind numpad8 gs c ToggleTank')     -- Tank
	send_command('bind numpad7 gs c ToggleRanger')   -- Ranger + equip bow
	
	send_command('bind numpad4 gs c ToggleWeapon')   -- Weapon cycle
	send_command('bind numpad5 gs c ToggleRangedWeapon')
	send_command('bind numpad6 gs c ToggleHaste')
	send_command('bind numpad3 gs c ToggleHasso')
	
	send_command ('bind numpad0 gs c RangedAttack')

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
		"Dojikiri Yasutsuna",
		"Shining One",
    },

    Ranged = {
        "Ullr",
        -- add more bows here
    },

    Ammo = {
        "Eminent Arrow",
        -- add more ammo if needed
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
    sets.ws      = {}
    sets.items   = {}

	----------------------------------------------------------------------
	--                           IDLE SETS
	----------------------------------------------------------------------
	sets.idle.normal  = {
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		head="Kasuga Kabuto +2",
		body="Kasuga Domaru +2",
		hands="Nyame Gauntlets",
		legs="Kasuga Haidate +2",
		feet="Danzo Sune-Ate",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Fortified Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	sets.idle.tank    = {
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Mpaca's Doublet",
		hands="Nyame Gauntlets",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Fortified Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
	
	----------------------------------------------------------------------
	--                           ENGAGED SETS
	----------------------------------------------------------------------
	sets.engaged.hybrid       = {
		sub="Utu Grip",
		ammo="Aurgelmir Orb",
		head="Kasuga Kabuto +2",
		body="Kasuga Domaru +2",
		hands="Tatena. Gote +1",
		legs="Kasuga Haidate +2",
		feet={ name="Ryuo Sune-Ate +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sweordfaetels +1",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
	sets.engaged.hybrid_hasso = set_combine(sets.engaged.hybrid, {
		hands="Wakido Kote +3",
		legs="Kasuga Haidate +2",
	})

	----------------------------------------------------------------------
	--                           PRECAST SETS
	----------------------------------------------------------------------
	sets.precast.fastcast 	= {
		ammo="Sapience Orb",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		neck="Voltsurge Torque",
		left_ear="Etiolation Earring",
		left_ring="Rahab Ring",
		right_ring="Prolix Ring",
	}
	
	sets.precast.preshot  	= {}

	----------------------------------------------------------------------
	--                           MIDCAST SETS
	----------------------------------------------------------------------
	sets.midcast.default 	= {}
	
	sets.midcast.midshot	= set_combine(sets.engaged.hybrid,{})

	----------------------------------------------------------------------
	--                           JOB ABILITIES
	----------------------------------------------------------------------
	sets.ja.hasso        = {
		hands="Wakido Kote +3",
		legs="Kasuga Haidate +2",
		feet="Wakido Sune. +2",
	}
	sets.ja.seigan       = {}
	
	sets.ja.third_eye    = {}
	
	sets.ja.meditate     = {
		head="Wakido Kabuto +3",
		hands="Sakonji Kote +3",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10','Damage taken-5%',}},
	}
	sets.ja.sekkanoki    = {
		hands="Kasuga Kote +2",
	}
	sets.ja.sengikori    = {
		feet="Kas. Sune-Ate +2",
	}
	sets.ja.konzenittai  = {}
	
	sets.ja.meikyo       = {}

	----------------------------------------------------------------------
	--                           WEAPONSKILLS
	----------------------------------------------------------------------
	sets.ws.normal 			= {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	sets.ws.fudo            = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.mumei			= {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.kasha 			= {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.shoha           = {
		ammo="Crepuscular Pebble",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Mpaca's Hose",
		feet="Kas. Sune-Ate +2",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.kaiten          = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	--elemnental WS's - Jinpu / goten / kageru
	sets.ws.elemental           = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear="Schere Earring",
		right_ear="Moonshade Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	sets.ws.koki            = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear="Moonshade Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	sets.ws.rana            = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Kas. Sune-Ate +2",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Schere Earring",
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	sets.ws.impulse_drive        = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Mpaca's Hose",
		feet="Kas. Sune-Ate +2",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Begrudging Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	sets.ws.pentathrust          = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Mpaca's Hose",
		feet="Kas. Sune-Ate +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Begrudging Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	sets.ws.double_thrust        = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Mpaca's Hose",
		feet="Kas. Sune-Ate +2",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Sailfi Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Begrudging Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}

	----------------------------------------------------------------------
	--                           RANGED WEAPONSKILLS
	----------------------------------------------------------------------
	sets.ws.sidewinder  = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.namas_arrow = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	sets.ws.emp_arrow   = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Kasuga Kote +2",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
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
	if TP_Mode == "Hybrid" or TP_Mode == "Ranger"  then
		if player.status == "Engaged" then
			if buffactive["Hasso"] then
				if Haste_Mode == "Haste 2" then
					-- checking to see if haste capped - which do not need the hasso hands equipped if so.
					if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
					( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
					( buffactive.march == 2 and buffactive[604] ) ) then
						equip(sets.engaged.hybrid)
					else
						equip(sets.engaged.hybrid_hasso)
					end
				elseif Haste_Mode == "Haste 1" then
					if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
					( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
					( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
					( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
						equip(sets.engaged.hybrid)
					else
						equip(sets.engaged.hybrid_hasso)
					end
				end
			else
				equip(sets.engaged.hybrid)
			end
		else
			equip(sets.idle.normal)
		end

	elseif TP_Mode == "Tank" then
		equip(sets.idle.tank)
	end
	if TP_Mode == "Ranger" then
		equip({ range = current_ranged, ammo = current_ammo })
	end
end

function precast(spell)
	if spell.type == "WeaponSkill" then
		if spell.english == "Tachi: Fudo" then
			equip(sets.ws.fudo)
		elseif spell.english == "Tachi: Mumei" then
			equip(sets.ws.mumei)
		elseif spell.english == "Tachi: Shoha" then
			equip(sets.ws.shoha)
		elseif spell.english == "Tachi: Kasha" then
			equip(sets.ws.kasha)
		elseif spell.english == "Tachi: Kaiten" then
			equip(sets.ws.kaiten)
		elseif spell.english == "Tachi: Rana" then
			equip(sets.ws.rana)
		elseif spell.english == "Tachi: Jinpu" or spell.english == "Tachi: Goten" or spell.english == "Tachi: Kageru" then
			equip(sets.ws.jinpu)
		elseif spell.english == "Tachi: Koki" then
			equip(sets.ws.koki)
		elseif spell.english == "Impulse Drive" then
			equip(sets.ws.impulse_drive)
		elseif spell.english == "Penta Thrust" then
			equip(sets.ws.pentathrust)
		elseif spell.english == "Double Thrust" then
			equip(sets.ws.double_thrust) 
		elseif spell.english == "Sidewinder" then 
			equip(sets.ws.sidewinder)
		elseif spell.english == "Namas Arrow" then 
			equip(sets.ws.namas_arrow)
		elseif spell.english == "Empyreal Arrow" then 
			equip(sets.ws.emp_arrow)
		else 
			equip(sets.ws.normal)
		end
	elseif spell.type == "JobAbility" then
		if spell.english == "Hasso" then 
			equip(sets.ja.hasso)
		elseif spell.english == "Seigan" then 
			equip(sets.ja.seigan)
		elseif spell.english == "Third Eye" then 
			equip(sets.ja.third_eye)
		elseif spell.english == "Meditate" then 
			equip(sets.ja.meditate)
		elseif spell.english == "Sekkanoki" then 
			equip(sets.ja.sekkanoki)
		elseif spell.english == "Sengikori" then 
			equip(sets.ja.sengikori)
		elseif spell.english == "Konzen-Ittai" then 
			equip(sets.ja.konzenittai)
		elseif spell.english == "Meikyo Shisui" then 
			equip(sets.ja.meikyo)
		end
	elseif spell.type == "Ranged Attack" then
		equip(sets.precast.preshot)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then
		equip(sets.precast.fastcast)
	end

	if TP_Mode == "Ranger" then
		equip({ range = current_ranged, ammo = current_ammo })
	end
end

function midcast(spell)
	if spell.type == "Ranged Attack" then
		equip(sets.ranged.attack)
	elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" then
		equip(sets.midcast.default)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	end
	
	if TP_Mode == "Ranger" then
		equip({ range = current_ranged, ammo = current_ammo })
	end
end

function aftercast(spell)
	idle()
	if TP_Mode == "Ranger" then
		equip({ range = current_ranged, ammo = current_ammo })
	end
end

----------------------------------------------------------------------
--                           KEY EVENTS
----------------------------------------------------------------------
function status_change(new, old)
	idle()
	if TP_Mode == "Ranger" then
		equip({ range = current_ranged, ammo = current_ammo })
	end
end

----------------------------------------------------------------------
--                           AUTO HASSO LOGIC
----------------------------------------------------------------------
windower.register_event('lose buff', function(buff_id)
	if buff_id == 353 then
		if Hasso_Mode == "On" and player.hp > 0 then
			send_command('input /ja "Hasso" <me>')
		end
	end
end)
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
    current_main 	= player.equipment.main or Weapons.Main[1]
    current_ranged 	= Weapons.Ranged[1]
    current_ammo   	= Weapons.Ammo[1]
end

function self_command(command)
	if command == "RangedAttack" then
		if TP_Mode == "Ranger" then
			send_command ('input /ra <t>')
		end
	elseif command == "ToggleHybrid" then
		TP_Mode = "Hybrid"
		idle()
	elseif command == "ToggleTank" then
		TP_Mode = "Tank"
		idle()
	elseif command == "ToggleRanger" then
		TP_Mode = "Ranger"
		equip({ range = current_ranged, ammo = current_ammo })
		idle()
	elseif command == "ToggleHaste" then
		if Haste_Mode == "Haste 2" then
			Haste_Mode = "Haste 1"
		else
			Haste_Mode = "Haste 2"
		end
	elseif command == "ToggleWeapon" then
		if #Weapons.Main > 0 then
			current_main = cycle(Weapons.Main, current_main)
			equip({ main = current_main })
		end
	elseif command == "ToggleRangedWeapon" then
		if #Weapons.Ranged > 0 then
			current_ranged = cycle(Weapons.Ranged, current_ranged)
			current_ammo   = Weapons.Ammo[1]
			equip({ range = current_ranged, ammo = current_ammo })
		end
	elseif command == "ToggleHasso" then
		if Hasso_Mode == "On" then
			Hasso_Mode = "Off"
		else
			Hasso_Mode = "On"
		end
	end
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
