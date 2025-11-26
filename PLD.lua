--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
--PLD LUA


---- 		Mode / Textbox settings 		----
tp_mode = 'Hybrid'
spell_mode = 'Normal'
lock_mode = 'Unlocked'

tp_modes = {'Hybrid','DPS','AoETank','SingleTank','MagicEva','MagicAettir'}
spell_modes = {'Normal','SIR'}
lock_modes = {'Locked','Unlocked'}


gearswap_box = function()
  str = '           \\cs(255,192,203)Paladin\\cr\n'
  str = str..' TP Mode:\\cs(255,150,100)   '..tp_mode..'\\cr\n'
  str = str..' Spell Mode:\\cs(255,150,100)   '..spell_mode..'\\cr\n'
  str = str..' Weapon Lock:\\cs(255,150,100)   '..lock_mode..'\\cr\n'
    return str
end

gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	initialize_weapon_tracking()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

function get_sets()
----				KEYBINDS			----
-- Equipset toggles
send_command('bind numpad9 gs c ToggleHybrid')
send_command('bind numpad8 gs c ToggleTank')
send_command('bind numpad7 gs c ToggleMagic')

-- Weapon/shield togles
send_command('bind numpad5 gs c ToggleShield')
send_command('bind numpad4 gs c ToggleWeapon')
send_command('bind numpad6 gs c ToggleLock')

-- Spell interupt toggle
send_command('bind numpad3 gs c ToggleSIR')

--QOL commands
send_command ('bind numpad1 input /mount "Noble Chocobo"')
send_command ('bind numpad2 input /dismount')
send_command('bind f9 input /item "Remedy" <me>')
send_command('bind f10 input /item "Panacea" <me>')
send_command('bind f11 input /item "Holy Water" <me>')

--- 			EQUIPMENT SETS			----
    sets.idle = {}                  -- Leave this empty
	sets.engaged = {}				-- leave this empty   
    sets.precast = {}               -- leave this empty  
	sets.ja = {}					-- leave this empty
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.items = {}					-- Leave this empty
 
 ---- IDLE SETS ----
 
 --Normal Idle set - Movement speed
    sets.idle.normal = {
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body="Adamantite Armor",
		hands="Sakpata's Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Sakpata's Leggings",
		neck="Unmoving Collar +1",
		waist="Carrier's Sash",
		left_ear="Hearty Earring",
		right_ear="Odnowa Earring +1",
		left_ring="Fortified Ring",
		right_ring="Gelatinous Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
		}

	sets.idle.aoetank = {
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Chev. Cuisses +3",
		feet="Sakpata's Leggings",
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Shadow Ring",
		right_ring="Fortified Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.idle.singletank = {
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Chev. Cuisses +3",
		feet="Sakpata's Leggings",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonbeam Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.idle.block = {
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body="Sakpata's Plate",
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs="Chev. Cuisses +3",
		feet="Rev. Leggings +4",
		neck="Combatant's Torque",
		waist="Plat. Mog. Belt",
		left_ear="Thureous Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonbeam Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.idle.magiceva = {
		ammo="Staunch Tathlum +1",
		head="Chev. Armet +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Chev. Cuisses +3",
		feet="Rev. Leggings +4",
		neck="Warder's Charm +1",
		waist="Plat. Mog. Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Shadow Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.idle.mpabsorb = {
		ammo="Homiliary",
		head="Chev. Armet +3",
		body="Rev. Surcoat +4",
		hands="Sakpata's Gauntlets",
		legs="Chev. Cuisses +3",
		feet="Rev. Leggings +4",
		neck="Sibyl Scarf",
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonbeam Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}

---- ENGAGED SETS ----
	sets.engaged.hybrid = {
		ammo="Coiste Bodhar",
		head="Sakpata's Helm",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Sakpata's Leggings",
		neck="Combatant's Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring +1",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonbeam Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.engaged.DPS = {
		ammo="Coiste Bodhar",
		head="Flam. Zucchetto +2",
		body="Sakpata's Plate",
		hands="Sakpata's Gauntlets",
		legs="Sakpata's Cuisses",
		feet="Flam. Gambieras +2",
		neck="Combatant's Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Fickblix's Ring",
		right_ring="Moonlight Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
---- PRECAST SETS ----
	sets.precast.fastcast = {
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Rev. Surcoat +4",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Chev. Cuisses +3",
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+3','INT+12','Mag. Acc.+11',}},
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ring="Kishar Ring",
		right_ring="Rahab Ring",
		back="Moonbeam Cape",
	}
	
	sets.precast.cure = set_combine(sets.precast.fastcast,{
		left_ear="Mendi. Earring",
		right_ear="Tuisto Earring",
	})

---- JOB ABILITY SETS ----
	sets.ja.sentinel = {
	}
	
	sets.ja.shieldbash = {
		hands={ name="Cab. Gauntlets +2", augments={'Enhances "Chivalry" effect',}},
		left_ear="Knightly Earring",
	}
	
	sets.ja.cover = {
	}
	
	sets.ja.rampart = {
	}
	
	sets.ja.fealty = {
	}
	
	sets.ja.chivalry = {
		hands={ name="Cab. Gauntlets +2", augments={'Enhances "Chivalry" effect',}},
	}
	
	sets.ja.divineemblem = {
	}
	
	sets.ja.invincible = {
	}
	
	sets.ja.holycircle = {
	}

---- MIDCAST SETS ----
	sets.midcast.cure = {
		ammo="Staunch Tathlum +1",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Macabre Gaunt. +1", augments={'Path: A',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+3','INT+12','Mag. Acc.+11',}},
		neck="Sacro Gorget",
		waist="Plat. Mog. Belt",
		left_ear="Tuisto Earring",
		right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.midcast.cureSIR = set_combine(sets.midcast.cure,{
		head={ name="Souv. Schaller +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+7','Breath dmg. taken -3%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+3','INT+12','Mag. Acc.+11',}},
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
	})
	
	sets.midcast.enmity = {
		ammo="Sapience Orb",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Macabre Gaunt. +1", augments={'Path: A',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Sakpata's Leggings",
		neck="Moonlight Necklace",
		waist="Plat. Mog. Belt",
		left_ear="Trux Earring",
		right_ear="Friomisi Earring",
		left_ring="Begrudging Ring",
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.midcast.enmitySIR = set_combine(sets.midcast.enmity,{
		ammo="Staunch Tathlum +1",
		legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+7','Breath dmg. taken -3%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+3','INT+12','Mag. Acc.+11',}},
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear={ name="Nourish. Earring +1", augments={'Path: A',}},
		left_ring="Evanescence Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	})
	
	sets.midcast.phalanx = {
		main="Sakpata's Sword",
		sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
	    ammo="Staunch Tathlum +1",
		head={ name="Yorium Barbuta", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		body={ name="Yorium Cuirass", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+65','Shield skill +15','Phys. dmg. taken -4',}},
		legs="Sakpata's Cuisses",
		feet={ name="Souveran Schuhs +1", augments={'HP+65','Attack+25','Magic dmg. taken -4',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear="Magnetic Earring",
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
	}  
	
	sets.midcast.phalanxSIR = set_combine(sets.midcast.phalanx,{
		legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+7','Breath dmg. taken -3%',}},
		neck="Moonlight Necklace",
	})

-- No weapon/shield swaps
	sets.midcast.phalanxWeapons = set_combine(sets.midcast.phalanx,{
		main="Sakpata's Sword",
		sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
	})

-- No weapon/shield swaps
	sets.midcast.phalanxSIRWeapons = set_combine(sets.midcast.phalanxSIR,{
		main="Sakpata's Sword",
		sub={ name="Priwen", augments={'HP+50','Mag. Evasion+50','Damage Taken -3%',}},
	})
	
	sets.midcast.reprisal = {
		ammo="Staunch Tathlum +1",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands="Sakpata's Gauntlets",
		legs={ name="Founder's Hose", augments={'MND+8','Mag. Acc.+7','Breath dmg. taken -3%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+21','"Fast Cast"+3','INT+12','Mag. Acc.+11',}},
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Knightly Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	

---- ITEM SETS ----
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}

---- WEAPONSKILL SETS ----
	sets.ws.normal = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.ws.savageblade = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.ws.atonement = {
		ammo="Sapience Orb",
		head={ name="Loess Barbuta +1", augments={'Path: A',}},
		body={ name="Souv. Cuirass +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		hands={ name="Macabre Gaunt. +1", augments={'Path: A',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet="Sakpata's Leggings",
		neck="Moonlight Necklace",
		waist="Plat. Mog. Belt",
		left_ear="Trux Earring",
		right_ear="Friomisi Earring",
		left_ring="Begrudging Ring",
		right_ring="Eihwaz Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.ws.requiescat = {
		ammo="Coiste Bodhar",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Sroda Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}

	sets.ws.chantducygne = {
		ammo="Aurgelmir Orb",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Sakpata's Plate",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Sakpata's Cuisses",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear={ name="Lugra Earring +1", augments={'Path: A',}},
		left_ring="Begrudging Ring",
		right_ring="Apate Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
	
	sets.ws.torcleaver = {
		ammo="Oshasha's Treatise",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Thrud Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Rudianos's Mantle", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity+10','Chance of successful block +5',}},
	}
end

----------------------------WEAPONS/SHIELDS-------------------------------
------------------------------------------------------------------------
	Weapons = {
		Main   = { "Burtgang","Malignance Sword","Naegling"},
		Sub    = { "Aegis","Ochain","Duban","Burred Shield +1" },
	}

----------------------------INTERNAL LOGIC-------------------------------
------------------------------------------------------------------------
function idle()
	if tp_mode == "Hybrid" then
		if player.status == "Engaged" then
			equip(sets.engaged.hybrid)
		else
			equip(sets.idle.normal)
		end
	elseif tp_mode == "DPS" then
		if player.status == "Engaged" then
			equip(sets.engaged.DPS)
		else
			equip(sets.idle.normal)
		end
	elseif tp_mode == "AoETank" then
		equip(sets.idle.aoetank)
	elseif tp_mode == "SingleTank" then
		equip(sets.idle.singletank)
	elseif tp_mode == "BlockTank" then
		equip(sets.idle.block)
	elseif tp_mode == "MagicEva" then
		equip(sets.idle.magiceva)
	elseif tp_mode == "MPAbsorb" then
		equip(sets.idle.mpabsorb)
	end
end

function status_change(new,old)
	if new == "Engaged" then
		idle()
	else
		idle()
	end
end

function precast(spell)
	if spell.type == "WhiteMagic" then
		if spell.english:startswith('Cure') then
			equip(sets.precast.cure)
		else
			equip(sets.precast.fastcast)
		end
	elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "Ninjutsu" then 
		equip(sets.precast.fastcast)
	elseif spell.type == "WeaponSkill" then 
		if spell.english == "Savage Blade" then
			equip(sets.ws.savageblade)
		elseif spell.english == "Atonement" then
			equip(sets.ws.atonement)
		elseif spell.english == "Requiescat" then
			equip(sets.ws.requiescat)
		elseif spell.english == "Chant du Cygne" then
			equip(sets.ws.chantducygne)
		elseif spell.english == "Torcleaver" then
			equip(sets.ws.torcleaver)
		else
			equip(sets.ws.normal)
		end
	elseif spell.type == "JobAbility" then
		if spell.english == "Sentinel" then
			equip(sets.ja.sentinel)
		elseif spell.english == "Shield Bash" then
			equip(sets.ja.shieldbash)
		elseif spell.english == "Cover" then
			equip(sets.ja.cover)
		elseif spell.english == "Rampart" then
			equip(sets.ja.rampart)
		elseif spell.english == "Fealty" then
			equip(sets.ja.fealty)
		elseif spell.english == "Chivalry" then
			equip(sets.ja.chivalry)
		elseif spell.english == "Divine Emblem" then
			equip(sets.ja.divineemblem)
		elseif spell.english == "Invincible" then
			equip(sets.ja.invincible)
		elseif spell.english == "Holy Circle" then
			equip(sets.ja.holycircle)
		elseif spell.english == "Provoke" then
			equip(sets.midcast.enmity)
		else
			idle()
		end
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	else
		idle()
	end
end

function midcast(spell)
	if spell.type == "WhiteMagic" then
		if spell.english:startswith('Cure') then
			if tp_mode == "AoETank" then
				equip(sets.midcast.cureSIR)
			elseif tp_mode ~= "AoETank" and (player.hp <= 1200 or spell_mode == "SIR") then
				equip(sets.midcast.cureSIR)
			else
				equip(sets.midcast.cure)
			end
		elseif spell.english == "Flash" then
			equip(sets.midcast.enmity)
		elseif spell.english:startswith('Phalanx') then
			if tp_mode == "AoETank" and player.status == "Engaged" then
				if buffactive["Phalanx"] then
					if lock_mode == 'Unlocked' then
						equip(sets.midcast.phalanxWeapons)
					else
						equip(sets.midcast.phalanx)
					end
				else
					if lock_mode == 'Unlocked' then
						equip(sets.midcast.phalanxSIRWeapons)
					else
						equip(sets.midcast.phalanxSIR)
					end
				end
			else
				if spell_mode == "SIR" then
					if lock_mode == 'Unlocked' then
						equip(sets.midcast.phalanxSIRWeapons)
					else
						equip(sets.midcast.phalanxSIR)
					end
				else
					if lock_mode == 'Unlocked' then
						equip(sets.midcast.phalanxWeapons)
					else
						equip(sets.midcast.phalanx)
					end
				end
			end
		elseif spell.english == "Reprisal" then
			equip(sets.midcast.reprisal)
		else
			if tp_mode == "AoETank" or spell_mode == "SIR" then
				equip(sets.midcast.enmitySIR)
			else
				equip(sets.midcast.enmity)
			end
		end
	elseif spell.type == "BlueMagic" or spell.english == "Foil" or spell.english == "Poisonga" or spell.english == "Stun" then
		if tp_mode == "AoETank" or spell_mode == "SIR" then
			equip(sets.midcast.enmitySIR)
		else
			equip(sets.midcast.enmity)
		end
	elseif spell.type == "BlackMagic" or spell.type == "Ninjutsu" then
		idle()
	end
end

function aftercast(spell)
    if spell.english:startswith('Phalanx') then
		equip({
			main  = last_real_main,
			sub   = last_real_sub,
		})
    end
    idle()
end

----------------------------CYCLING/COMMANDS LOGIC----------------------
------------------------------------------------------------------------
function cycle(list, current)
    local index = nil
    if current then
        for i, v in ipairs(list) do
            if v == current then
                index = (i % #list) + 1
                break
            end
        end
    end
    if not index then
        index = 1
    end
    return list[index]
end

function initialize_weapon_tracking()
	last_real_main   = player.equipment.main   or Weapons.Main[1]
	last_real_sub    = player.equipment.sub    or Weapons.Sub[1]
	
	main_mode   = last_real_main
	sub_mode    = last_real_sub
end

function self_command(command)
	if command == "ToggleHybrid" then
		if tp_mode == "DPS" or tp_mode == "AoETank" or tp_mode == "BlockTank" or tp_mode == "SingleTank" or tp_mode == "MagicEva" or tp_mode == "MPAbsorb" then
			tp_mode = "Hybrid"
			idle()
		elseif tp_mode == "Hybrid" then
			tp_mode = "DPS"
			idle()
		end
	elseif command == "ToggleTank" then
		if tp_mode == "Hybrid" or tp_mode == "DPS" or tp_mode == "SingleTank" or tp_mode == "MagicEva" or tp_mode == "MPAbsorb" then
			tp_mode = "AoETank"
			idle()
		elseif tp_mode == "AoETank" then
			tp_mode = "BlockTank"
			idle()
		elseif tp_mode == "BlockTank" then
			tp_mode = "SingleTank"
			idle()
		end
	elseif command == "ToggleMagic" then
		if tp_mode == "Hybrid" or tp_mode == "DPS" or tp_mode == "AoETank" or tp_mode == "BlockTank" or tp_mode == "SingleTank" or tp_mode == "MagicEva" then
			tp_mode = "MPAbsorb"
			idle()
		elseif tp_mode == "MPAbsorb" then
			tp_mode = "MagicEva"
			idle()
		end
	elseif command == "ToggleShield" then
		sub_mode = cycle(Weapons.Sub, sub_mode)
		last_real_sub = sub_mode
		equip({ sub = sub_mode })
	elseif command == "ToggleWeapon" then
		main_mode = cycle(Weapons.Main, main_mode)
		last_real_main = main_mode
		equip({ main = main_mode })
	elseif command == "ToggleLock" then
		if lock_mode == 'Locked' then
			lock_mode = "Unlocked"
		else
			lock_mode = "Locked"
		end
	elseif command == "ToggleSIR" then
		if spell_mode == "Normal" then
			spell_mode = "SIR"
		else
			spell_mode = "Normal"
		end
	end
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