--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
-- 						RED MAGE LUA


----------------- MODES / UI TEXT BOX -----------------------------
Player_Mode = "Melee"
Casting_Mode = "Burst"
Enfeeble_Mode = "Normal"
Lock_Mode = "Locked"

Player_Modes = {'Melee','Enspell','ZeroTPEnspell','Tank','Caster'}
Casting_Modes = {'Burst','Freecast'}
Enfeeble_Modes = {'Normal','Accuracy'}
Lock_Modes = {'Unlocked','Locked'}

shihei = 0

gearswap_box = function()
  str = '           \\cs(204,0,0)RED MAGE\\cr\n'
  str = str..' Offense Mode:\\cs(255,150,100)   '..Player_Mode..'\\cr\n'
  str = str..' Casting Mode:\\cs(255,0,102)   '..Casting_Mode..'\\cr\n'
  str = str..' Enfeeble Mode:\\cs(0,153,51)   '..Enfeeble_Mode..'\\cr\n'
  str = str..' Weapon Lock:\\cs(128,128,128)   '..Lock_Mode..'\\cr\n'
  str = str..' Shihei Amount: '..shihei..'\n'
  str = str..' \\cs(255,64,64)[FIR]\\cr   \\cs(0,255,0)[WND]\\cr   \\cs(180,0,255)[THD]\\cr\n'
  str = str..' \\cs(128,255,255)[ICE]\\cr   \\cs(165,100,40)[STN]\\cr   \\cs(64,128,255)[WTR]\\cr\n'
    return str
end

gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function check_shihei()
    local count = 0
    if player.inventory['Shihei'] and player.inventory['Shihei'].count then
        count = player.inventory['Shihei'].count
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
    shihei = color .. tostring(count) .. "\\cr"
end

function user_setup()
	check_shihei()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

function get_sets()
	---------------- KEYBINDS -----------------------
	send_command('bind numpad9 gs c ToggleMelee')
	send_command('bind numpad8 gs c ToggleTank')
	send_command('bind numpad7 gs c ToggleCaster')
	send_command('bind numpad3 gs c ToggleBurst')
	send_command('bind numpad1 gs c ToggleEnfeeble')
	send_command('bind numpad4 gs c ToggleMain')
	send_command('bind numpad5 gs c ToggleSub')
	send_command('bind numpad6 gs c ToggleLock')

	send_command('bind f9 input /item "Remedy" <me>')
	send_command('bind f10 input /item "Panacea" <me>')
	send_command('bind f11 input /item "Holy Water" <me>')

	-------- Easyspell Keybinds ---------- (Requires easyspell addon)
	send_command ('bind ^numpad1 input //es fire <t>')
	send_command ('bind ^numpad2 input //es aero <t>')
	send_command ('bind ^numpad3 input //es thunder <t>')
	send_command ('bind !numpad1 input //es blizzard <t>')
	send_command ('bind !numpad2 input //es stone <t>')
	send_command ('bind !numpad3 input //es water <t>')

	--------------- EQUIPMENT SETS ------------------

    sets.idle = {}               	-- Leave this empty 
	sets.engaged = {}				-- Leave this empty
		sets.engaged.hybrid = {}	-- Leave this empty
    sets.precast = {}               -- leave this empty 
	sets.ja = {}					-- Leave this empty
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.items = {}
	sets.main = {}
	sets.sub = {}
 
	-- Main weapons
	sets.main["Crocea Mors"] = {main="Crocea Mors"}
	sets.main["Bunzi's Rod"] = {main="Bunzi's Rod"}
	sets.main["Daybreak"]    = {main="Daybreak"}
	sets.main["Naegling"]    = {main="Naegling"}
	sets.main["Tauret"]      = {main="Tauret"}
	sets.main["Maxentius"]   = {main="Maxentius"}

	-- Sub weapons
	sets.sub["Ammurapi Shield"] = {sub="Ammurapi Shield"}
	sets.sub["Culminus"]        = {sub="Culminus"}
	sets.sub["Pukulatmuj +1"]   = {sub="Pukulatmuj +1"}
	sets.sub["Ethereal Dagger"] = {sub="Ethereal Dagger"}
	sets.sub["Genmei Shield"]   = {sub="Genmei Shield"}
	sets.sub["Thibron"]    		= {sub="Thibron"}
	 
	 -------------- IDLE SETS ---------------------
    --Hybrid/DPS IDLE--
	sets.idle.hybrid = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Shamash Robe",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	--Tank Idle
	sets.idle.tank = {
		main="Sakpata's Sword",
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Infused Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	--Caster idle
	sets.idle.caster = {
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Malignance Chapeau",
		body="Shamash Robe",
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Malignance Boots",
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.idle.enspell = set_combine(sets.idle.hybrid,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub={ name="Pukulatmuj +1", augments={'Path: A',}},
	})
	
	sets.idle.ZeroTPEnspell = set_combine(sets.idle.hybrid,{
		main="Qutrub Knife",
		sub="Ethereal Dagger",
	})
		
	--------------- ENGAGED SETS ------------------
	sets.engaged.hybrid.normal = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Crep. Earring",
		left_ring="Fickblix's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

	-- Normal Hybrid set dual wield
	sets.engaged.hybrid.dualwield = {
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Fickblix's Ring",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

	-- Normal Hybrid set dual wield + shadows up
	sets.engaged.hybrid.dualwieldenspellshadows = set_combine(sets.engaged.hybrid.dualwield,{
		head="Umuthi Hat",
		hands="Aya. Manopolas +2",
		waist="Orpheus's Sash",
	})

	-- Enspell mode
	sets.engaged.hybrid.enspell = {
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub={ name="Pukulatmuj +1", augments={'Path: A',}},
		ammo="Coiste Bodhar",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Fickblix's Ring",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

	-- Enspell mode + shadows up
	sets.engaged.hybrid.enspellshadows = set_combine(sets.engaged.hybrid.dualwieldenspellshadows,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub={ name="Pukulatmuj +1", augments={'Path: A',}},
	})

	sets.engaged.hybrid.zeroTPenspell = {
	    main="Qutrub Knife",
		sub="Ethereal Dagger",
		range="Ullr",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Aya. Manopolas +2",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Null loop",
		waist="Orpheus's Sash",
		left_ear="Sherida Earring",
		right_ear="Suppanomimi",
		left_ring="Fickblix's Ring",
		right_ring="Chirich Ring +1",
		back={ name="Sucellos's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

	--------------- PRECAST SETS ------------------
	--Fastcast Set
    sets.precast.fastcast = {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+26','"Fast Cast"+6','MND+6',}},
		legs={ name="Lengo Pants", augments={'INT+8','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','Mag. Acc.+13',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
	}

	--------------- MIDCAST SETS ------------------
	sets.midcast.trust = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	---- ENFEEBLE SETS ----
	-- Max Accuracy
	sets.midcast.enfeebleACCURACY = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Atrophy Tabard +3",
		hands="Leth. Ganth. +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','Mag. Acc.+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Stikini Ring +1",
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}

	sets.midcast.enfeebleACCURACYweapons = set_combine(sets.midcast.enfeebleACCURACY,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		range="Ullr",
	})

	--Frazzle or distract
	sets.midcast.enfeebleFRAZDIST = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','Mag. Acc.+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	} 

	sets.midcast.enfeebleFRAZDISTweapons = set_combine(sets.midcast.enfeebleFRAZDIST,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		range="Ullr",
	})

	--gravity/dispel
	sets.midcast.enfeebleGRAVDISP = {
		head={ name="Viti. Chapeau +3", augments={'Enfeebling Magic duration','Magic Accuracy',}},
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','Mag. Acc.+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.enfeebleGRAVDISPweapons = set_combine(sets.midcast.enfeebleGRAVDISP,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		range="Ullr",
	})

	-- Paralyze/Slow/Addle/poison
	sets.midcast.enfeeblePOTENCY = {
		ammo="Hydrocera",
		head="Leth. Chappel +2",
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','Mag. Acc.+13',}},
		feet="Leth. Houseaux +2",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.enfeeblePOTENCYweapons = set_combine(sets.midcast.enfeeblePOTENCY,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
	})

	-- Silence/Sleep/Break/Bind
	sets.midcast.enfeebleDURATION = {
		head="Leth. Chappel +2",
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +2",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Obstin. Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.enfeebleDURATIONweapons = set_combine(sets.midcast.enfeebleDURATION,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		range="Ullr",
	})

	--Blind (int based)
	sets.midcast.enfeebleBLIND = {
		ammo="Ombre Tathlum +1",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands="Bunzi's Gloves",
		legs="Bunzi's Pants",
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck="Sibyl Scarf",
		waist="Channeler's Stone",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}

	sets.midcast.enfeebleBLINDweapons = set_combine(sets.midcast.enfeebleBLIND,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
	})
		
	--Dia/Inundation
	sets.midcast.enfeebleINUNDIA = {
		head="Leth. Chappel +2",
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +2",
		neck="Sibyl Scarf",
		waist="Obstin. Sash",
		right_ear="Snotra Earring",
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}

	sets.midcast.enfeebleINUNDIAweapons = set_combine(sets.midcast.enfeebleINUNDIA,{
		main="Daybreak",
		sub="Ammurapi Shield",
	})

	---- DARK MAGIC SETS ----
	--Bio
	sets.midcast.darkBIO = {
		head="Leth. Chappel +2",
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','Mag. Acc.+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck="Erra Pendant",
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Evanescence Ring",
		right_ring="Stikini Ring +1",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}

	sets.midcast.darkBIOweapons = set_combine(sets.midcast.darkBIO,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		range="Ullr",
	})

	--Aspir / Drain
	sets.midcast.darkASPIRDRAIN = {
		head="Pixie Hairpin +1",
		body="Lethargy Sayon +2",
		hands="Leth. Ganth. +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','Mag. Acc.+13',}},
		feet={ name="Vitiation Boots +3", augments={'Immunobreak Chance',}},
		neck="Erra Pendant",
		waist="Austerity Belt +1",
		left_ear="Malignance Earring",
		right_ear="Snotra Earring",
		left_ring="Evanescence Ring",
		left_ring="Archon Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}

	sets.midcast.darkASPIRDRAINweapons = set_combine(sets.midcast.darkASPIRDRAIN,{
		main={ name="Crocea Mors", augments={'Path: C',}},
		sub="Ammurapi Shield",
		range="Ullr",
	})

	---- ENHANCING SETS ----
	--Enspells / Temper
	sets.midcast.enhanceSKILL = {
		ammo="Staunch Tathlum +1",
		head="Befouled Crown",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands={ name="Viti. Gloves +3", augments={'Enhancing Magic duration',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Leth. Houseaux +2",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Mimir Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Enha.mag. skill +10','Mag. Acc.+5','Enh. Mag. eff. dur. +17',}},
	}

	sets.midcast.enhanceSKILLweapons = set_combine(sets.midcast.enhanceSKILL,{
		main="Secespita",
		sub={ name="Pukulatmuj +1", augments={'Path: A',}},	
	})

	--Haste/Flurry/Protect/Shell/Blink/Barspells (SELF)
	sets.midcast.enhanceDURATION = {
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands="Atrophy Gloves +2",
		legs={ name="Telchine Braconi", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		feet="Leth. Houseaux +2",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Enha.mag. skill +10','Mag. Acc.+5','Enh. Mag. eff. dur. +17',}},
	}

	sets.midcast.enhanceDURATIONweapons = set_combine(sets.midcast.enhanceDURATION,{
		sub="Ammurapi Shield",
	})

	sets.midcast.enhanceOTHERS = {
		ammo="Staunch Tathlum +1",
		head="Leth. Chappel +2",
		body="Lethargy Sayon +2",
		hands="Atrophy Gloves +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +2",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Enha.mag. skill +10','Mag. Acc.+5','Enh. Mag. eff. dur. +17',}},
	}

	sets.midcast.enhanceOTHERSweapons = set_combine(sets.midcast.enhanceOTHERS,{
		sub="Ammurapi Shield",
	})

	--Gain spells
	sets.midcast.enhanceGAIN = set_combine(sets.midcast.enhanceDURATION,{
		hands={ name="Viti. Gloves +3", augments={'Enhancing Magic duration',}},
	})

	sets.midcast.enhanceGAINweapons = set_combine(sets.midcast.enhanceGAIN,{
		sub="Ammurapi Shield",
	})

	--Aquaveil
	sets.midcast.enhanceAQUAVEIL = {
		ammo="Staunch Tathlum +1",
		head={ name="Amalric Coif +1", augments={'MP+80','INT+12','Enmity-6',}},
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands="Atrophy Gloves +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +2",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Enha.mag. skill +10','Mag. Acc.+5','Enh. Mag. eff. dur. +17',}},
	}
	
	sets.midcast.enhanceAQUAVEILweapons = set_combine(sets.midcast.enhanceAQUAVEIL,{
		sub="Ammurapi Shield",
	})
	
	--Refresh
	sets.midcast.enhanceREFRESH = {
		ammo="Staunch Tathlum +1",
		head={ name="Amalric Coif +1", augments={'MP+80','INT+12','Enmity-6',}},
		body="Atrophy Tabard +3",
		hands="Atrophy Gloves +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +2",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Enha.mag. skill +10','Mag. Acc.+5','Enh. Mag. eff. dur. +17',}},
	}

	sets.midcast.enhanceREFRESHweapons = set_combine(sets.midcast.enhanceREFRESH,{
		main="Daybreak",
		sub="Ammurapi Shield",
	})
	
	--Stoneskin
	sets.midcast.enhanceSTONESKIN = {
		ammo="Staunch Tathlum +1",
		head="Umuthi Hat",
		body={ name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}},
		hands="Atrophy Gloves +2",
		legs={ name="Telchine Braconi", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		feet="Leth. Houseaux +2",
		neck={ name="Dls. Torque +2", augments={'Path: A',}},
		waist="Siegel Sash",
		left_ear="Mimir Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Enha.mag. skill +10','Mag. Acc.+5','Enh. Mag. eff. dur. +17',}},
	}

	sets.midcast.enhanceSTONESKINweapons = set_combine(sets.midcast.enhanceSTONESKIN,{
		sub="Ammurapi Shield",
	})

	--self phalanx enhancements
	sets.midcast.enhancePHALANXSELF = {
		ammo="Staunch Tathlum +1",
		head="Leth. Chappel +2",
		body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		neck="Incanter's Torque",
		waist="Embla Sash",
		left_ear="Mimir Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Ghostfyre Cape", augments={'Enfb.mag. skill +10','Enha.mag. skill +10','Mag. Acc.+5','Enh. Mag. eff. dur. +17',}},
	}

	sets.midcast.enhancePHALANXSELFweapons = set_combine(sets.midcast.enhancePHALANXSELF,{
		main="Sakpata's Sword",
		sub="Egeking",
	})
		
	---- HEALING MAGIC SETS ----
	sets.midcast.healingCURE = {
		ammo="Staunch Tathlum +1",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body="Bunzi's Robe",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		legs={ name="Kaykaus Tights +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Mendi. Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}

	sets.midcast.healingCUREweapons = set_combine(sets.midcast.healingCURE,{
		main="Daybreak",
		sub="Ammurapi Shield",
	})

	sets.midcast.healingCURSNA = {
		body="Atrophy Tabard +3",
	}

	sets.midcast.healingCURSNAweapons = set_combine(sets.midcast.healingCURSNA,{
	})

	----Elemental sets ----
	sets.midcast.elementalFREECAST = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Leth. Chappel +2",
		body="Lethargy Sayon +2",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Leth. Fuseau +2",
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Sibyl Scarf",
		waist="Skrymir Cord",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring="Fenrir Ring +1",
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +8','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

	sets.midcast.elementalFREECASTweapons = set_combine(sets.midcast.elementalFREECAST,{
		main="Bunzi's Rod",
		sub="Culminus",
		--sub="Ammurapi Shield",
	})

	sets.midcast.elementalFREECASTOBI = set_combine(sets.midcast.elementalFREECAST,{
		waist="Hachirin-no-Obi",
	})

	sets.midcast.elementalFREECASTOBIweapons = set_combine(sets.midcast.elementalFREECASTOBI,{
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
	})

	sets.midcast.elementalBURST = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Leth. Fuseau +2",
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Sibyl Scarf",
		waist="Skrymir Cord",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +8','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

	sets.midcast.elementalBURSTweapons = set_combine(sets.midcast.elementalBURST,{
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
	})

	sets.midcast.elementalBURSTOBI = set_combine(sets.midcast.elementalBURST,{
		waist="Hachirin-no-Obi",
	})

	sets.midcast.elementalBURSTOBIweapons = set_combine(sets.midcast.elementalBURSTOBI,{
		main="Bunzi's Rod",
		sub="Ammurapi Shield",
	})

	---- OTHER MIDCAST ----
	--invisible/sneak/deodorize/raise
	sets.midcast.fastcast = {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+26','"Fast Cast"+6','MND+6',}},
		legs={ name="Lengo Pants", augments={'INT+8','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','Mag. Acc.+13',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
	}

	--Utsusemi
	sets.midcast.utsusemi = {
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+26','"Fast Cast"+6','MND+6',}},
		legs={ name="Lengo Pants", augments={'INT+8','Mag. Acc.+14','"Mag.Atk.Bns."+13',}},
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','Mag. Acc.+13',}},
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
	}
	
	--------------- Weaponskill SETS ------------------
		--undefined Weaponskills
	sets.ws.normal = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.SavageBlade = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.ChantDuCygne = {
		ammo="Coiste Bodhar",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ayanmo Corazza +2",
		hands="Malignance Gloves",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Thereoid Greaves",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear="Sherida Earring",
		left_ring="Begrudging Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.DeathBlossom = {
		ammo="Crepuscular Pebble",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear="Malignance Earring",
		left_ring="Sroda Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.Requiscat = {
		ammo="Crepuscular Pebble",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Malignance Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Sroda Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.SanguineBlade = {
		ammo="Sroda Tathlum",
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Jhakri Cuffs +2",
		legs="Leth. Fuseau +2",
		feet="Leth. Houseaux +2",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Archon Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.SeraphBlade = {
		ammo="Sroda Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.RedLotusBlade = {
		ammo="Pemphredo Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.Evisceration = {
		ammo="Coiste Bodhar",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Aya. Gambieras +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Begrudging Ring",
		right_ring="Ilabrat Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.BlackHalo = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Malignance Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}

	sets.ws.AeolianEdge = {
		ammo="Pemphredo Tathlum",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear="Malignance Earring",
		left_ring="Freke Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','MND+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}

	---------------------------	ITEM SETS	---------------------------
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}
end

--------------- LOGIC - DO NOT TOUCH BELOW ------------------
windower.register_event('gain buff', function(buff_id)
	if buff_id == 66 then
		idle()
	end
end)

windower.register_event('lose buff', function(buff_id)
	if buff_id == 66 then
		idle()
	end
end)

function status_change(new,old)
	if new == "Engaged" then
		idle()
	else
		idle()
	end
end

function idle()
	if Player_Mode == "Melee" or Player_Mode == "Enspell" then
		if player.status == "Engaged" then 
			if player.sub_job =='NIN' or player.sub_job =='DNC' then
				if buffactive["Enfire"] or buffactive["Enblizzard"] or buffactive["Enaero"] or buffactive["Enstone"] or buffactive["Enthunder"] or buffactive["Enwater"] or
				buffactive["Enfire II"] or buffactive["Enblizzard II"] or buffactive["Enaero II"] or buffactive["Enstone II"] or buffactive["Enthunder II"] or buffactive["Enwater II"] then
					if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
						if Player_Mode == "Melee" then
							equip(sets.engaged.hybrid.dualwieldenspellshadows)
						elseif Player_Mode == "Enspell" then
							equip(sets.engaged.hybrid.enspellshadows)
						end
					else
						if Player_Mode == "Melee" then
							equip(sets.engaged.hybrid.dualwield)
						elseif Player_Mode == "Enspell" then
							equip(sets.engaged.hybrid.enspell)
						end
					end
				else 
					equip(sets.engaged.hybrid.dualwield)
				end
			else
				equip(sets.engaged.hybrid.normal)
			end
		else
			if Player_Mode == "Melee" then
				equip(sets.idle.hybrid)
			elseif Player_Mode == "Enspell" then
				equip(sets.idle.enspell)
			end
		end
	elseif Player_Mode == "ZeroTPEnspell" then
		if player.status == "Engaged" then
			equip(sets.engaged.hybrid.zeroTPenspell)
		else
			equip(sets.idle.ZeroTPEnspell)
		end
	elseif Player_Mode == "Tank" then
		equip(sets.idle.tank)
	elseif Player_Mode == "Caster" then
		equip(sets.idle.caster)
	end
end

function precast(spell)
	if spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then 
		equip(sets.precast.fastcast)
	elseif spell.type == "WeaponSkill" then 
		if spell.english == "Savage Blade" then
			equip(sets.ws.SavageBlade)
		elseif spell.english == "Chant du Cygne" then
			equip(sets.ws.ChantDuCygne)
		elseif spell.english == "Death Blossom" then
			equip(sets.ws.DeathBlossom)
		elseif spell.english == "Requiscat" then
			equip(sets.ws.Requiscat)
		elseif spell.english == "Sanguine Blade" then
			equip(sets.ws.SanguineBlade)
		elseif spell.english == "Seraph Blade" then
			equip(sets.ws.SeraphBlade)
		elseif spell.english == "Red Lotus Blade" then
			equip(sets.ws.RedLotusBlade)
		elseif spell.english == "Evisceration" then
			equip(sets.ws.Evisceration)
		elseif spell.english == "Black Halo" then
			equip(sets.ws.BlackHalo)
		elseif spell.english == "Aeolian Edge" then
			equip(sets.ws.AeolianEdge)
		else
			equip(sets.ws.normal)
		end
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	else
		idle()
	end
end

function midcast(spell)
	if spell.skill == "Elemental Magic" then
		if spell.name:match('Fire') or spell.name:match('Blizzard') or spell.name:match('Aero') or spell.name:match('Stone') or spell.name:match('Thunder') or spell.name:match('Water') then
			if Casting_Mode == "Burst" then
				if spell.element == world.day_element or spell.element == world.weather_element then
					if spell.name:match('Fire') and world.day_element ~= "Water" and world.weather_element ~= "Water" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalBURSTOBI)
						else
							equip(sets.midcast.elementalBURSTOBIweapons)
						end
					elseif spell.name:match('Water') and world.day_element ~= "Lightning" and world.weather_element ~= "Lightning" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalBURSTOBI)
						else
							equip(sets.midcast.elementalBURSTOBIweapons)
						end
					elseif spell.name:match('Thunder') and world.day_element ~= "Earth" and world.weather_element ~= "Earth" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalBURSTOBI)
						else
							equip(sets.midcast.elementalBURSTOBIweapons)
						end
					elseif spell.name:match('Stone') and world.day_element ~= "Wind" and world.weather_element ~= "Wind" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalBURSTOBI)
						else
							equip(sets.midcast.elementalBURSTOBIweapons)
						end
					elseif spell.name:match('Aero') and world.day_element ~= "Ice" and world.weather_element ~= "Ice" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalBURSTOBI)
						else
							equip(sets.midcast.elementalBURSTOBIweapons)
						end
					elseif spell.name:match('Blizzard') and world.day_element ~= "Fire" and world.weather_element ~= "Fire" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalBURSTOBI)
						else
							equip(sets.midcast.elementalBURSTOBIweapons)
						end
					else
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalBURST)
						else
							equip(sets.midcast.elementalBURSTweapons)
						end
					end
				else
					if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
						equip(sets.midcast.elementalBURST)
					else
						equip(sets.midcast.elementalBURSTweapons)
					end
				end
			elseif Casting_Mode == "Freecast" then
				if spell.element == world.day_element or spell.element == world.weather_element then
					if spell.name:match('Fire') and world.day_element ~= "Water" and world.weather_element ~= "Water" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalFREECASTOBI)
						else
							equip(sets.midcast.elementalFREECASTOBIweapons)
						end
					elseif spell.name:match('Water') and world.day_element ~= "Lightning" and world.weather_element ~= "Lightning" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalFREECASTOBI)
						else
							equip(sets.midcast.elementalFREECASTOBIweapons)
						end
					elseif spell.name:match('Thunder') and world.day_element ~= "Earth" and world.weather_element ~= "Earth" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalFREECASTOBI)
						else
							equip(sets.midcast.elementalFREECASTOBIweapons)
						end
					elseif spell.name:match('Stone') and world.day_element ~= "Wind" and world.weather_element ~= "Wind" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalFREECASTOBI)
						else
							equip(sets.midcast.elementalFREECASTOBIweapons)
						end
					elseif spell.name:match('Aero') and world.day_element ~= "Ice" and world.weather_element ~= "Ice" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalFREECASTOBI)
						else
							equip(sets.midcast.elementalFREECASTOBIweapons)
						end
					elseif spell.name:match('Blizzard') and world.day_element ~= "Fire" and world.weather_element ~= "Fire" then
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalFREECASTOBI)
						else
							equip(sets.midcast.elementalFREECASTOBIweapons)
						end
					else
						if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
							equip(sets.midcast.elementalFREECAST)
						else
							equip(sets.midcast.elementalFREECASTweapons)
						end
					end
				else
					if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
						equip(sets.midcast.elementalFREECAST)
					else
						equip(sets.midcast.elementalFREECASTweapons)
					end
				end
			else
				idle()
			end
		end
	elseif spell.skill == "Enfeebling Magic" then
		if Enfeeble_Mode == "Accuracy" then
			if spell.name:match('Dia') or spell.name:match('Diaga') or spell.name:match('Inundation') then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeebleINUNDIA)
				else
					equip(sets.midcast.enfeebleINUNDIAweapons)
				end
			else
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeebleACCURACY)
				else
					equip(sets.midcast.enfeebleACCURACYweapons)
				end
			end
		elseif Enfeeble_Mode == "Normal" then
			if spell.name:match('Sleep') or spell.name:match('Sleepga') or spell.name:match('Bind') or spell.name:match('Break') or spell.name:match('Silence') then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeebleDURATION)
				else
					equip(sets.midcast.enfeebleDURATIONweapons)
				end
			elseif spell.name:match('Paralyze') or spell.name:match('Addle') or spell.name:match('Slow') or spell.name:match('Poison') then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeeblePOTENCY)
				else
					equip(sets.midcast.enfeeblePOTENCYweapons)
				end
			elseif spell.name:match('Distract') or spell.name:match('Frazzle') then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeebleFRAZDIST)
				else
					equip(sets.midcast.enfeebleFRAZDISTweapons)
				end
			elseif spell.name:match('Gravity') or spell.name:match('Dispel') then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeebleGRAVDISP)
				else
					equip(sets.midcast.enfeebleGRAVDISPweapons)
				end
			elseif spell.name:match('Blind') then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeebleBLIND)
				else
					equip(sets.midcast.enfeebleBLINDweapons)
				end
			elseif spell.name:match('Dia') or spell.name:match('Diaga') or spell.name:match('Inundation') then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeebleINUNDIA)
				else
					equip(sets.midcast.enfeebleINUNDIAweapons)
				end
			end
		end
	elseif spell.skill == "Dark Magic" then
		if spell.name:match('Drain') or spell.name:match('Aspir') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.darkASPIRDRAIN)
			else
				equip(sets.midcast.darkASPIRDRAINweapons)
			end
		elseif spell.name:match('Bio') then
			if Enfeeble_Mode == "Accuracy" then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enfeebleACCURACY)
				else
					equip(sets.midcast.enfeebleACCURACYweapons)
				end
			else
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.darkBIO)
				else
					equip(sets.midcast.darkBIOweapons)
				end
			end
		elseif spell.name:match('Stun') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.enfeebleACCURACY)
			else
				equip(sets.midcast.enfeebleACCURACYweapons)
			end
		end
	elseif spell.skill == "Enhancing Magic" then
		if spell.name:match('Haste') or spell.name:match('Flurry') or spell.name:match('Blink') or spell.name:match('Protect') or spell.name:match('Shell') or spell.english:startswith('Bar') then 
			if spell.target.type == 'SELF' then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enhanceDURATION)
				else
					equip(sets.midcast.enhanceDURATIONweapons)
				end
			else
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enhanceOTHERS)
				else
					equip(sets.midcast.enhanceOTHERSweapons)
				end
			end
		elseif spell.name:match('Temper') or spell.name:match('Enfire') or spell.name:match('Enblizzard') or spell.name:match('Enaero') or spell.name:match('Enstone') or spell.name:match('Enthunder') or spell.name:match('Enwater') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.enhanceSKILL)
			else
				equip(sets.midcast.enhanceSKILLweapons)
			end
		elseif spell.name:match('Blaze Spikes') or spell.name:match('Ice Spikes') or spell.name:match('Shock Spikes') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.enhanceDURATION)
			else
				equip(sets.midcast.enhanceDURATIONweapons)
			end
		elseif spell.english:startswith('Gain') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.enhanceGAIN)
			else
				equip(sets.midcast.enhanceGAINweapons)
			end
		elseif spell.name:match('Aquaveil') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.enhanceAQUAVEIL)
			else
				equip(sets.midcast.enhanceAQUAVEILweapons)
			end
		elseif spell.name:match('Refresh') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.enhanceREFRESH)
			else
				equip(sets.midcast.enhanceREFRESHweapons)
			end
		elseif spell.name:match('Stoneskin') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.enhanceSTONESKIN)
			else
				equip(sets.midcast.enhanceSTONESKINweapons)
			end
		elseif spell.name:match('Phalanx') then
			if spell.target.type == 'SELF' then
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enhancePHALANXSELF)
				else
					equip(sets.midcast.enhancePHALANXSELFweapons)
				end
			else
				if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
					equip(sets.midcast.enhanceOTHERS)
				else
					equip(sets.midcast.enhanceOTHERSweapons)
				end
			end
		elseif spell.name:match('Invisible') or spell.name:match('Sneak') or spell.name:match('Deodorize') then
			equip(sets.midcast.fastcast)
		end
	elseif spell.skill == "Healing Magic" then
		if spell.name:match('Cure') or spell.name:match('Cura') or spell.name:match('Curaga') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.healingCURE)
			else
				equip(sets.midcast.healingCUREweapons)
			end
		elseif spell.name:match('Cursna') then
			if Player_Mode ~= "ZeroTPEnspell" and (player.status == "Engaged" or Lock_Mode == "Locked") then
				equip(sets.midcast.healingCURSNA)
			else
				equip(sets.midcast.healingCURSNAweapons)
			end	
		elseif spell.name:match('Raise') or spell.name:match('Reraise') then
			equip(sets.midcast.fastcast)
		end
	elseif spell.type == "WeaponSkill" then 
		if spell.english == "Savage Blade" then
			equip(sets.ws.SavageBlade)
		elseif spell.english == "Chant du Cygne" then
			equip(sets.ws.ChantDuCygne)
		elseif spell.english == "Death Blossom" then
			equip(sets.ws.DeathBlossom)
		elseif spell.english == "Requiscat" then
			equip(sets.ws.Requiscat)
		elseif spell.english == "Sanguine Blade" then
			equip(sets.ws.SanguineBlade)
		elseif spell.english == "Seraph Blade" then
			equip(sets.ws.SeraphBlade)
		elseif spell.english == "Red Lotus Blade" then
			equip(sets.ws.RedLotusBlade)
		elseif spell.english == "Evisceration" then
			equip(sets.ws.Evisceration)
		elseif spell.english == "Black Halo" then
			equip(sets.ws.BlackHalo)
		elseif spell.english == "Aeolian Edge" then
			equip(sets.ws.AeolianEdge)
		else
			equip(sets.ws.normal)
		end
	elseif spell.name:match('Utsusemi') then
		equip(sets.midcast.utsusemi)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	elseif spell.type == "Trust" then
		equip(sets.midcast.trust)
	else  
		idle()
	end
end

function aftercast(spell)
	if spell.type == "Ninjutsu" then
		check_shihei()
		gearswap_jobbox:text(gearswap_box())		
		gearswap_jobbox:show()
		idle()
	else
		idle()
	end
end

function self_command(command)
	if command == "ToggleMelee" then
		if Player_Mode == "Tank" or Player_Mode == "ZeroTPEnspell" or Player_Mode == "Caster" then
			Player_Mode = "Melee"
			idle()
		elseif Player_Mode == "Melee" then
			Player_Mode = "Enspell"
			idle()
		elseif Player_Mode == "Enspell" then
			Player_Mode = "ZeroTPEnspell"
			idle()
		end
	elseif command == "ToggleTank" then
		if Player_Mode == "Melee" or Player_Mode == "ZeroTPEnspell" or Player_Mode == "Enspell" or Player_Mode == "Caster" then
			Player_Mode = "Tank"
			idle()
		end
	elseif command == "ToggleCaster" then
		if Player_Mode == "Melee" or Player_Mode == "ZeroTPEnspell" or Player_Mode == "Enspell" or Player_Mode == "Tank" then
			Player_Mode = "Caster"
			idle()
		end
	elseif command == "ToggleEnfeeble" then
		if Enfeeble_Mode == "Normal" then
			Enfeeble_Mode = "Accuracy"
		elseif Enfeeble_Mode == "Accuracy" then
			Enfeeble_Mode = "Normal"
		end
	elseif command == "ToggleBurst" then
		if Casting_Mode == "Burst" then
			Casting_Mode = "Freecast"
		elseif Casting_Mode == "Freecast" then
			Casting_Mode = "Burst"
		end
	elseif command == "ToggleLock" then
		if Lock_Mode == "Unlocked" then
			Lock_Mode = "Locked"
		elseif Lock_Mode == "Locked" then
			Lock_Mode = "Unlocked"
		end
	elseif command == "ToggleMain" then
		local main_cycle = {}
		if Player_Mode == "Melee" or Player_Mode == "Tank" then
			main_cycle = {"Crocea Mors","Naegling","Tauret","Maxentius"}
		elseif Player_Mode == "Caster" then
			main_cycle = {"Crocea Mors","Naegling","Tauret","Maxentius"}
		elseif Player_Mode == "Enspell" then
			main_cycle = {"Crocea Mors"}
		end
        local current = player.equipment.main
		local next_index = 1
        for i, main in ipairs(main_cycle) do
            if current == main then
                next_index = (i % #main_cycle) + 1
                break  
            end
        end
		local next_weapon = main_cycle[next_index]
        if next_weapon then
            send_command('input /equip Main "' .. next_weapon .. '"')
        end
	elseif command == "ToggleSub" then
		local sub_cycle = {}
		if Player_Mode == "Melee" or Player_Mode == "Tank" then
			if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
				sub_cycle = {"Daybreak", "Thibron", "Bunzi's Rod"}
			else
				sub_cycle = {"Ammurapi Shield", "Genmei Shield"}
			end
		elseif Player_Mode == "Caster" then
			sub_cycle = {"Culminus", "Ammurapi Shield"}
		elseif Player_Mode == "Enspell" then
			sub_cycle = {"Pukulatmuj +1"}
		end
		local current = player.equipment.sub
		local next_index = 1
		for i, sub in ipairs(sub_cycle) do
			if current == sub then
				next_index = (i % #sub_cycle) + 1
				break
			end
		end
		local next_offhand = sub_cycle[next_index] 
		if next_offhand then
			send_command('input /equip Sub "' .. next_offhand .. '"')
		end
	end
	check_shihei()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

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
	send_command('unbind ^numpad9')
	send_command('unbind ^numpad8')
	send_command('unbind ^numpad7')
	send_command('unbind ^numpad6')
	send_command('unbind ^numpad5')
	send_command('unbind ^numpad4')
	send_command('unbind ^numpad3')
	send_command('unbind ^numpad2')
	send_command('unbind ^numpad1')
	send_command('unbind !numpad9')
	send_command('unbind !numpad8')
	send_command('unbind !numpad7')
	send_command('unbind !numpad6')
	send_command('unbind !numpad5')
	send_command('unbind !numpad4')
	send_command('unbind !numpad3')
	send_command('unbind !numpad2')
	send_command('unbind !numpad1')
	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind f12')
	enable("main","sub","range","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
end

user_setup()