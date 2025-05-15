--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
--BLU LUA

----------------- MODES / UI TEXT BOX -----------------------------
Player_Mode = "Hybrid"
Casting_Mode = "Normal"
Weapon_Mode = "Locked"

Player_Modes = {'Hybrid','TreasureHunter','DualWield','DualWieldHaste1','OmenTank'}
Casting_Modes = {'Normal','SIR'}
Weapon_Modes = {'Unlocked','Locked'}

gearswap_box = function()
  str = '           \\cs(0,0,204)BLUE MAGE\\cr\n'
  str = str..' Offense Mode:\\cs(255,150,100)   '..Player_Mode..'\\cr\n'
  str = str..' Casting Mode:\\cs(255,0,102)   '..Casting_Mode..'\\cr\n'
  str = str..' Weapon Mode:\\cs(128,128,128)   '..Weapon_Mode..'\\cr\n'
    return str
end

gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end


-----------------------GEAR SETS------------------------------
function get_sets()
user_setup()

--Mode Commands
send_command('bind numpad9 gs c ToggleHybrid')
send_command('bind numpad8 gs c ToggleTank')
send_command('bind numpad7 gs c ToggleDualWield')
send_command('bind numpad6 gs c ToggleSIR')
send_command('bind numpad3 gs c ToggleWEAPONS')
send_command('bind numpad4 gs c ToggleMAIN')
send_command('bind numpad5 gs c ToggleSUB')

--QOL commands
send_command ('bind numpad1 input /mount "Noble Chocobo"')
send_command ('bind numpad2 input /dismount')
send_command('bind f9 input /item "Remedy" <me>')
send_command('bind f10 input /item "Panacea" <me>')
send_command('bind f11 input /item "Holy Water" <me>')
send_command('bind f12 input //fillmode')


    sets.idle = {}                  -- Leave this empty
	sets.engaged = {}				-- Leave this empty
		sets.engaged.dualwield = {}
		sets.engaged.hybrid = {}
    sets.precast = {}               -- leave this empty   
		sets.precast.tank = {}
    sets.midcast = {}               -- leave this empty
		sets.midcast.tank = {}
		sets.midcast.bluemagic = {}
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.items = {}
 
 
 ---- IDLE SETS ----
    sets.idle.hybrid = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Hashishin Mintan +2",
		hands="Hashi. Bazu. +2",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Shadow Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.idle.tank = {
		ammo="Amar Cluster",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Defending Ring",
		right_ring="Ilabrat Ring",
		back={ name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15',}},
	}
	
	sets.idle.tankweapons = set_combine(sets.idle.tank,{
		main="Tizona",
		sub="Sakpata's Sword",
	})
	
	sets.idle.trust = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Shadow Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
---- ENGAGED SETS ---- (NOTE - DPS Sets assume Dual Wield 3)
--Tank engaged
	sets.engaged.tank = {
		ammo="Amar Cluster",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Defending Ring",
		right_ring="Ilabrat Ring",
		back={ name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15',}},
	}
	
	sets.engaged.tankweapons = set_combine(sets.engaged.tank,{
		main="Tizona",
		sub={ name="Thibron", augments={'TP Bonus +1000',}},
	})
	

--Treasure hunter engaged.
	sets.engaged.treasure = {
		ammo="Per. Lucky Egg",
		head="Malignance Chapeau",
		body={ name="Herculean Vest", augments={'CHR+1','Attack+6','"Treasure Hunter"+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		hands="Malignance Gloves",
		legs={ name="Herculean Trousers", augments={'"Drain" and "Aspir" potency +1','Pet: Accuracy+27 Pet: Rng. Acc.+27','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		feet={ name="Herculean Boots", augments={'Pet: Phys. dmg. taken -1%','STR+4','"Treasure Hunter"+2','Accuracy+18 Attack+18',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Suppanomimi",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
		left_ring="Epona's Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

----HYBRID ENGAGED SETS ----
	sets.engaged.hybrid.normal = {
		ammo="Aurgelmir Orb",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
		left_ring="Epona's Ring",
		right_ring="Defending Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

----DUAL WIELD SETS ----

--[[ Key DW pieces:
-- Suppanomimi - 5 DW
-- Eabani earring - 4 DW
-- Ambu Cape - 10 DW
-- Adhemar Jacket +1 - 6 DW
-- Reiki Yotai - 7 DW
-- Taeon Boots - 9DW
-- Carmine Cuisses +1 - 6DW
-- Max = 48 DW
]]
----NOTE ** all sets asume DW3
-- Capped Haste (11 DW to Cap with DW3)
	sets.engaged.dualwield.hastecap = {
		ammo="Aurgelmir Orb",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Fickblix's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

--35 Magic Haste (22 DW to cap with DW3)
	sets.engaged.dualwield.haste35 = set_combine(sets.engaged.dualwield.hastecap,{
		waist="Reiki Yotai", --7DW
		left_ear="Suppanomimi", -- 5DW
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --10DW
	})

--30 Magic Haste (31DW to cap with DW3)
	sets.engaged.dualwield.haste30 = set_combine(sets.engaged.dualwield.hastecap,{
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, -- 6DW
		waist="Reiki Yotai", --7DW
		left_ear="Suppanomimi", -- 5DW
		right_ear="Eabani Earring", -- 4 DW
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --10DW

	})

-- 15 Magic Haste (42DW to cap with DW 3)
	sets.engaged.dualwield.haste15 = set_combine(sets.engaged.dualwield.hastecap,{
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, -- 6DW
		feet={ name="Taeon Boots", augments={'Accuracy+25','"Dual Wield"+5','DEX+10',}}, --9 DW
		waist="Reiki Yotai", --7DW
		left_ear="Suppanomimi", -- 5DW
		right_ear="Eabani Earring", -- 4 DW
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --10DW
	})

-- 0 Magic Haste (49DW to cap with DW3)
	
	sets.engaged.dualwield.haste0 = set_combine(sets.engaged.dualwield.hastecap,{
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}}, -- 6DW
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}, --6DW
		feet={ name="Taeon Boots", augments={'Accuracy+25','"Dual Wield"+5','DEX+10',}}, --9 DW
		waist="Reiki Yotai", --7DW
		left_ear="Suppanomimi", -- 5DW
		right_ear="Eabani Earring", -- 4 DW
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+5','"Dual Wield"+10','Phys. dmg. taken-10%',}}, --10DW
	})


---- PRECAST SETS ----
    sets.precast.fastcast = {
		ammo="Amar Cluster",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+8','"Fast Cast"+6','INT+4',}},
		feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+8','"Fast Cast"+6','INT+9',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ring="Kishar Ring",
		right_ring="Rahab Ring",
		back={ name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15',}},
	}
	
	sets.precast.bluemagic = set_combine(sets.precast.fastcast,{ 
		body="Hashishin Mintan +2",
	})
	
	sets.precast.diffusion = {
		feet={ name="Luhlaza Charuqs +3", augments={'Enhances "Diffusion" effect',}},
	}

---- TANK PRECAST SETS----
	sets.precast.tank.dreamflower = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Hashishin Mintan +2",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Witful Belt",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Lebeche Ring",
		right_ring="Prolix Ring",
		back={ name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15',}},
	}

----BLUE MAGIC MIDCAST SETS ----

	sets.midcast.bluemagic.Physical = {
		ammo="Aurgelmir Orb",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
		left_ring="Apate Ring",
		right_ring="Ilabrat Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.midcast.bluemagic.PhysicalAcc = set_combine(sets.midcast.bluemagic.Physical,{
		ammo="Falcon Eye",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Mache Earring +1",
		right_ear="Telos Earring",
	})
	
	sets.midcast.bluemagic.PhysicalStr = set_combine(sets.midcast.bluemagic.Physical,{
		ammo="Aurgelmir Orb",
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		right_ring="Sroda Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	})
	
	sets.midcast.bluemagic.PhysicalDex = set_combine(sets.midcast.bluemagic.Physical,{
		ammo="Aurgelmir Orb",
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Mache Earring +1",
		left_ring="Apate Ring",
		right_ring="Ilabrat Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})
	
	sets.midcast.bluemagic.PhysicalVit = set_combine(sets.midcast.bluemagic.Physical,{
		ammo="Aurgelmir Orb",
		neck="Elite Royal Collar",
		left_ring="Petrov Ring",
	})
	
	sets.midcast.bluemagic.PhysicalAgi = set_combine(sets.midcast.bluemagic.Physical,{
		waist="Svelt. Gouriz +1",
		right_ear="Infused Earring",
		right_ring="Ilabrat Ring",
		back={ name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15',}},
	})
	
	sets.midcast.bluemagic.PhysicalInt = set_combine(sets.midcast.bluemagic.Physical,{
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		left_ring="Shiva Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	})
	
	sets.midcast.bluemagic.PhysicalMnd = set_combine(sets.midcast.bluemagic.Physical,{
		ammo="Hydrocera",
		waist="Luminary Sash",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	})
	
	sets.midcast.bluemagic.PhysicalChr = set_combine(sets.midcast.bluemagic.Physical,{
		left_ear="Rimeice Earring",
	})
	
	sets.midcast.bluemagic.PhysicalHP = set_combine(sets.midcast.bluemagic.Physical,{
		ammo="Falcon Eye",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Beeline Ring",
		right_ring="Ilabrat Ring",
		back="Moonbeam Cape",
	})
	
	sets.midcast.bluemagic.Magical = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Hashishin Kavuk +2",
		body="Hashishin Mintan +2",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Hashishin Tayt +2",
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.bluemagic.MagicalDark = set_combine(sets.midcast.bluemagic.Magical,{
		head="Pixie Hairpin +1",
		left_ring="Archon Ring",
	})
	
	sets.midcast.bluemagic.MagicalLight = set_combine(sets.midcast.bluemagic.Magical,{
	})
	
	sets.midcast.bluemagic.MagicalMnd = set_combine(sets.midcast.bluemagic.Magical,{
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	})
	
	sets.midcast.bluemagic.MagicalChr = set_combine(sets.midcast.bluemagic.Magical,{
	})
	
	sets.midcast.bluemagic.MagicalVit = set_combine(sets.midcast.bluemagic.Magical,{
		ammo="Aurgelmir Orb",
	})
	
	sets.midcast.bluemagic.MagicalDex = set_combine(sets.midcast.bluemagic.Magical,{
		ammo="Aurgelmir Orb",
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		left_ear="Mache Earring +1",
		left_ring="Ilabrat Ring",
	})

	sets.midcast.bluemagic.Breath = set_combine(sets.midcast.bluemagic.Magical,{
	-- Luhlaza keffiyeh +3 When obtained
	})
	
	sets.midcast.bluemagic.MagicalAcc = {
		ammo="Pemphredo Tathlum",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Hashishin Mintan +2",
		hands="Hashi. Bazu. +2",
		legs="Hashishin Tayt +2",
		feet="Hashi. Basmak +2",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Crep. Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}
	
	sets.midcast.bluemagic.StunPhysical = set_combine(sets.midcast.bluemagic.MagicalAcc,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Mache Earring +1",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	})
	
	sets.midcast.bluemagic.StunMagical = set_combine(sets.midcast.bluemagic.MagicalAcc,{})
	
	sets.midcast.bluemagic.Healing = {
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body="Vrikodara Jupon",
		hands="Rawhide Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Mendi. Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Lebeche Ring",
		right_ring="Evanescence Ring",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.bluemagic.HealingHP = set_combine(sets.midcast.bluemagic.Healing,{
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		back="Moonbeam Cape",
	})
	
	sets.midcast.bluemagic.Buff = set_combine(sets.midcast.bluemagic.Magical,{
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		legs={ name="Telchine Braconi", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
	})
	
	sets.midcast.bluemagic.BuffSkillBased = set_combine(sets.midcast.bluemagic.Magical,{
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body="Assim. Jubbah +3",
		hands="Rawhide Gloves",
		legs="Hashishin Tayt +2",
		feet={ name="Luhlaza Charuqs +3", augments={'Enhances "Diffusion" effect',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	})
	
	sets.midcast.bluemagic.Refresh = set_combine(sets.midcast.bluemagic.Buff,{
	})


---- MIDCAST NON BLU SETS ----

	sets.midcast.phalanx = {
		ammo="Staunch Tathlum +1",
		head="Malignance Chapeau",
		body={ name="Taeon Tabard", augments={'Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Phalanx +3',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Aswang Sash",
		left_ear="Magnetic Earring",
		right_ear="Halasz Earring",
		left_ring="Defending Ring",
		right_ring="Evanescence Ring",
		back="Moonbeam Cape",
	}
	
	sets.midcast.treasurehunter = {
		ammo="Per. Lucky Egg",
		head="Hashishin Kavuk +2",
		body={ name="Herculean Vest", augments={'CHR+1','Attack+6','"Treasure Hunter"+2','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		hands="Hashi. Bazu. +2",
		legs={ name="Herculean Trousers", augments={'"Drain" and "Aspir" potency +1','Pet: Accuracy+27 Pet: Rng. Acc.+27','"Treasure Hunter"+2','Accuracy+12 Attack+12','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
		feet={ name="Herculean Boots", augments={'Pet: Phys. dmg. taken -1%','STR+4','"Treasure Hunter"+2','Accuracy+18 Attack+18',}},
		neck="Sibyl Scarf",
		waist="Eschan Stone",
		left_ear="Friomisi Earring",
		right_ear="Hecate's Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Shiva Ring +1",
		back="Moonbeam Cape",
	}
	
	sets.midcast.enhancing = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body="Hashishin Mintan +2",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Telchine Braconi", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},

	}
	
	sets.midcast.healing = {
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body="Vrikodara Jupon",
		hands="Rawhide Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Mendi. Earring",
		right_ear="Halasz Earring",
		left_ring="Lebeche Ring",
		right_ring="Evanescence Ring",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.elemental = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head="Hashishin Kavuk +2",
		body="Hashishin Mintan +2",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Hashishin Tayt +2",
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}
	
	sets.midcast.enfeebling = {
		ammo="Pemphredo Tathlum",
		head="Hashishin Kavuk +2",
		body="Hashishin Mintan +2",
		hands="Hashi. Bazu. +2",
		legs="Hashishin Tayt +2",
		feet="Hashi. Basmak +2",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Crep. Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Aurist's Cape +1", augments={'Path: A',}},
	}
	
	sets.midcast.dark = set_combine(sets.midcast.enfeebling,{
		head="Pixie Hairpin +1",
		body={ name="Carm. Sc. Mail +1", augments={'Attack+20','"Mag.Atk.Bns."+12','"Dbl.Atk."+4',}},
		left_ring="Archon Ring",
	})
	
	sets.midcast.SIR = {
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body="Shamash Robe",
		hands="Rawhide Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Magnetic Earring",
		right_ear="Etiolation Earring",
		left_ring="Defending Ring",
		right_ring="Evanescence Ring",
		back={ name="Rosmerta's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Magic Damage +10','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
	}

---- Tank Midcast Sets ----
	sets.midcast.tank.phalanx = {
		ammo="Sapience Orb",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Moonbeam Cape",
	}
		
	sets.midcast.tank.magicaccuracy = {
	    ammo="Ombre Tathlum +1",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Hashishin Tayt +2",
		feet="Malignance Boots",
		neck="Null Loop",
		waist="Austerity Belt +1",
		left_ear="Magnetic Earring",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
		left_ring="Stikini Ring",
		right_ring="Stikini Ring",
		back="Moonbeam Cape",
	}

	sets.midcast.tank.defence = {
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Svelt. Gouriz +1",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Rosmerta's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Fast Cast"+10','Evasion+15',}},
	}

---- WEAPONSKILL SETS ----
	sets.ws.normal = {
		ammo="Oshasha's Treatise",
		head="Hashishin Kavuk +2",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Sroda Ring",
		right_ring="Fickblix's Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.expiacion = {
	    ammo="Coiste Bodhar",
		head="Hashishin Kavuk +2",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.chantducygne = {
	    ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Gleti's Cuirass",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Gleti's Breeches",
		feet="Gleti's Boots",
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear={ name="Hashi. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+13','Mag. Acc.+13','"Dbl.Atk."+4',}},
		left_ring="Begrudging Ring",
		right_ring="Epona's Ring",
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.requiescat = {
	    ammo="Coiste Bodhar",
		head="Hashishin Kavuk +2",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Persis Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.savageblade = {
		ammo="Coiste Bodhar",
		head="Hashishin Kavuk +2",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.sanguineblade = {
	    ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Jhakri Cuffs +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Archon Ring",
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws.blackhalo = {
		ammo="Coiste Bodhar",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mirage Stole +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Rosmerta's Cape", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
---------------------------	ITEM SETS	---------------------------
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}
end


windower.register_event('lose buff', function(buff_id)
	if buff_id == 66 then
		idle()
	end
	if buff_id == 33 then
		idle()
	end
	if buff_id == 580 then
		idle()
	end
	if buff_id == 604 then
		idle()
	end
	if buff_id == 214 then
		idle()
	end
	if buff_id == 228 then
		idle()
	end
end)

windower.register_event('gain buff', function(buff_id)
	if buff_id == 66 then
		idle()
	end
	if buff_id == 33 then
		idle() 
	end
	if buff_id == 580 then
		idle()
	end
	if buff_id == 604 then
		idle()
	end
	if buff_id == 214 then
		idle()
	end
	if buff_id == 228 then
		idle()
	end
end)


function idle()
	if Player_Mode == "OmenTank" then
		if Weapon_Mode == "Locked" then
			if player.status == "Engaged" then 
				equip(sets.engaged.tank) 
			else
				equip(sets.idle.tank)
			end
		else
			if player.status == "Engaged" then 
				equip(sets.engaged.tankweapons) 
			else
				equip(sets.idle.tankweapons)
			end
		end
	elseif Player_Mode == "TreasureHunter" then
		if player.status == "Engaged" then 
			equip(sets.engaged.treasure) 
		else
			equip(sets.idle.hybrid)
		end
	elseif Player_Mode == "Hybrid" then
		if player.status == "Engaged" then 
			equip(sets.engaged.hybrid.normal)
		else
			equip(sets.idle.hybrid)
		end
	elseif Player_Mode == "DualWield" then
		if player.status == "Engaged" then 
			if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
            ( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
            ( buffactive.march == 2 and buffactive[604] ) ) then
				equip(sets.engaged.dualwield.hastecap)
			elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
				equip(sets.engaged.dualwield.haste35)
			elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
            ( buffactive.march == 1 and buffactive[604] ) ) then
				equip(sets.engaged.dualwield.haste30)
			elseif ( buffactive.march == 1 or buffactive[604] ) then
				equip(sets.engaged.dualwield.haste15)
			else
				equip(sets.engaged.dualwield.haste0)
			end
		else
			equip(sets.idle.hybrid)
		end 
	elseif Player_Mode == "DualWieldHaste1" then
		if player.status == "Engaged" then 
			if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
			( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
			( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
			( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
				equip(sets.engaged.dualwield.hastecap)
			elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
            ( buffactive.march == 2 and buffactive['haste samba'] ) or
            ( buffactive[580] and buffactive['haste samba'] ) then 
				equip(sets.engaged.dualwield.haste35)
			elseif ( buffactive.march == 2 ) or -- two marches from ghorn
            ( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
            ( buffactive[580] ) or  -- geo haste
            ( buffactive[33] and buffactive[604] ) then -- haste with MG
				equip(sets.engaged.dualwield.haste30)
			elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
				equip(sets.engaged.dualwield.haste15)
			else
				equip(sets.engaged.dualwield.haste0)
			end
		else
			equip(sets.idle.hybrid)
		end
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
	if spell.name == "Diffusion" then
		equip(sets.precast.diffusion)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	elseif spell.type == "BlueMagic" then
		if spell.english == "Dream Flower" or spell.english == "Sheep Song" then
			if Player_Mode == "OmenTank" then
				equip(sets.precast.tank.dreamflower)
			else
				equip(sets.precast.bluemagic)
			end
		else
			equip(sets.precast.bluemagic)
		end
	elseif spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then 
		equip(sets.precast.fastcast)
	elseif spell.type == "WeaponSkill" then 
		if spell.english == "Expiacion" then
			equip(sets.ws.expiacion)
		elseif spell.english == "Chant du Cygne" then
			equip(sets.ws.chantducygne)
		elseif spell.english == "Requiescat" then
			equip(sets.ws.requiescat)
		elseif spell.english == "Savage Blade" then
			equip(sets.ws.savageblade)
		elseif spell.english == "Sanguine Blade" then
			equip(sets.ws.sanguineblade)
		elseif spell.english == "Black Halo" then
			equip(sets.ws.blackhalo)
		else
			equip(sets.ws.normal)	
		end
	end
end

function midcast(spell)
	if Casting_Mode == "SIR" then
		equip(sets.midcast.SIR)
	else
		if Player_Mode == "OmenTank" then
			if spell.english == "Phalanx" then
				equip(sets.midcast.tank.phalanx)
			elseif spell.english == "Dream Flower" or spell.english == "Sheep Song" then
				equip(sets.midcast.tank.defence)
			elseif spell.english == "Cruel Joke" then
				equip(sets.midcast.tank.magicaccuracy)
			elseif spell.english == "Reaving Wind" or spell.english == "Feather Tickle" then
				equip(sets.midcast.bluemagic.MagicalAcc)
			elseif spell.english == "Holy Water" then
				equip(sets.items.holywater)
			elseif spell.type == "Trust" then
				equip(sets.idle.trust)
			else
				equip(sets.idle.tank)
			end
		elseif Player_Mode == "TreasureHunter" then
			if spell.english == "Holy Water" then
				equip(sets.items.holywater)
			elseif spell.type == "Trust" then
				equip(sets.idle.trust)
			else
				equip(sets.midcast.treasurehunter)
			end
		else
			if spell.english == "Holy Water" then
				equip(sets.items.holywater)
			elseif spell.type == "Trust" then
				equip(sets.idle.trust)
			elseif spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" then
				if spell.skill == "Elemental Magic" then
					equip(sets.midcast.elemental)
				elseif spell.skill == "Enfeebling Magic" then
					equip(sets.midcast.enfeebling)
				elseif spell.skill == "Dark Magic" then
					equip(sets.midcast.dark)
				elseif spell.skill == "Enhancing Magic" then
					equip(sets.midcast.enhancing)
				elseif spell.skill == "Healing Magic" then
					equip(sets.midcast.healing)
				end
			elseif spell.type == "BlueMagic" then
				if spell.english == "Bilgestorm" then
					equip(sets.midcast.bluemagic.Physical)
				elseif spell.english == "Heavy Strike" then
					equip(sets.midcast.bluemagic.PhysicalAcc)
				elseif spell.english == "Battle Dance" or spell.english == "Bloodrake" or spell.english == "Death Scissors" or spell.english == "Dimensional Death"
					or spell.english == "Empty Thrash" or spell.english == "Quadrastrike" or spell.english == "Saurian Slide" or spell.english == "Sinker Drill" 
					or spell.english == "Spinal Cleave" or spell.english == "Sweeping Gouge" or spell.english == "Uppercut" or spell.english == "Vertical Cleave" then
					equip(sets.midcast.bluemagic.PhysicalStr)
				elseif spell.english == "Amorphic Spikes" or spell.english == "Asuran Claws" or spell.english == "Barbed Crescent" or spell.english == "Claw Cyclone"
					or spell.english == "Disseverment" or spell.english == "Foot Kick"  or spell.english == "Frenetic Rip" or spell.english == "Goblin Rush"
					or spell.english == "Hysteric Barrage" or spell.english == "Paralyzing Triad" or spell.english == "Seedspray" or spell.english == "Sickle Slash" 
					or spell.english == "Smite of Rage" or spell.english == "Terror Touch" or spell.english == "Thrashing Assault" or spell.english == "Vanity Dive"  then
					equip(sets.midcast.bluemagic.PhysicalDex)
				elseif spell.english == "Body Slam" or spell.english == "Cannonball" or spell.english == "Delta Thrust" or spell.english == "Glutinous Dart"
					or spell.english == "Grand Slam" or spell.english == "Power Attack"  or spell.english == "Quad. Continuum" or spell.english == "Sprout Smack"
					or spell.english == "Sub-zero Smash" then
					equip(sets.midcast.bluemagic.PhysicalVit)
				elseif spell.english == "Benthic Typhoon" or spell.english == "Feather Storm" or spell.english == "Helldive" or spell.english == "Hydro Shot"
					or spell.english == "Jet Stream" or spell.english == "Pinecone Bomb"  or spell.english == "Spiral Spin" or spell.english == "Wild Oats" then
					equip(sets.midcast.bluemagic.PhysicalAgi)
				elseif spell.english == "Mandibular Bite" or spell.english == "Queasyshroom" then
					equip(sets.midcast.bluemagic.PhysicalInt)
				elseif spell.english == "Ram Charge" or spell.english == "Screwdriver" or spell.english == "Tourbillion" then
					equip(sets.midcast.bluemagic.PhysicalMnd)
				elseif spell.english == "Bludgeon" then
					equip(sets.midcast.bluemagic.PhysicalChr)
				elseif spell.english == "Final Sting" then
					equip(sets.midcast.bluemagic.PhysicalHP)
				elseif spell.english == "Anvil Lightning" or spell.english == "Blastbomb" or spell.english == "Blazing Bound" or spell.english == "Bomb Toss"
					or spell.english == "Cursed Sphere" or spell.english == "Droning Whirlwind"  or spell.english == "Embalming Earth" or spell.english == "Entomb"
					or spell.english == "Firespit" or spell.english == "Foul Waters" or spell.english == "Ice Break" or spell.english == "Leafstorm" 
					or spell.english == "Maelstrom" or spell.english == "Molting Plumage" or spell.english == "Nectarous Deluge" or spell.english == "Regurgitation" 
					or spell.english == "Rending Deluge" or spell.english == "Scouring Spate" or spell.english == "Silent Storm" or spell.english == "Spectral Floe" 
					or spell.english == "Subduction" or spell.english == "Tem. Upheaval" or spell.english == "Water Bomb" or spell.english == "Crashing Thunder"
					or spell.english == "Tearing Gust" or spell.english == "Cesspool" then
					equip(sets.midcast.bluemagic.Magical)
				elseif spell.english == "Dark Orb" or spell.english == "Death Ray" or spell.english == "Eyes On Me" or spell.english == "Evryone. Grudge"
					or spell.english == "Palling Salvo" or spell.english == "Tenebral Crush" or spell.english == "Polar Roar" then
					equip(sets.midcast.bluemagic.MagicalDark)
				elseif spell.english == "Blinding Fulgor" or spell.english == "Diffusion Ray" or spell.english == "Radiant Breath" or spell.english == "Retinal Glare" or spell.english == "Uproot" then
					equip(sets.midcast.bluemagic.MagicalLight)
				elseif spell.english == "Acrid Stream" or spell.english == "Magic Hammer" or spell.english == "Mind Blast" then
					equip(sets.midcast.bluemagic.MagicalMnd)
				elseif spell.english == "Mysterious Light" then
					equip(sets.midcast.bluemagic.MagicalChr)
				elseif spell.english == "Thermal Pulse" then
					equip(sets.midcast.bluemagic.MagicalVit)
				elseif spell.english == "Charged Whisker" or spell.english == "Gates of Hades" then
					equip(sets.midcast.bluemagic.MagicalDex)
				elseif spell.english == "1000 Needles" or spell.english == "Absolute Terror" or spell.english == "Actinic Burst" or spell.english == "Atra. Libations"
					or spell.english == "Auroral Drape" or spell.english == "Awful Eye"  or spell.english == "Blank Gaze" or spell.english == "Blistering Roar"
					or spell.english == "Blood Saber" or spell.english == "Chaotic Eye" or spell.english == "Cimicine Discharge" or spell.english == "Cold Wave" 
					or spell.english == "Corrosive Ooze" or spell.english == "Demoralizing Roar" or spell.english == "Digest" or spell.english == "Dream Flower"  
					or spell.english == "Enervation" or spell.english == "Feather Tickle"  or spell.english == "Filamented Hold" or spell.english == "Frightful Roar"
					or spell.english == "Geist Wall" or spell.english == "Hecatomb Wave" or spell.english == "Infrasonics" or spell.english == "Jettatura" 
					or spell.english == "Light of Penance" or spell.english == "Lowing" or spell.english == "Mind Blast" or spell.english == "Mortal Ray" 
					or spell.english == "MP Drainkiss" or spell.english == "Osmosis"  or spell.english == "Reaving Wind" or spell.english == "Sandspin"
					or spell.english == "Sandspray" or spell.english == "Sheep Song" or spell.english == "Soporific" or spell.english == "Sound Blast" 
					or spell.english == "Stinking Gas" or spell.english == "Sub-zero Smash" or spell.english == "Venom Shell" or spell.english == "Voracious Trunk"
					or spell.english == "Yawn" or spell.english == "Cruel Joke" then
					equip(sets.midcast.bluemagic.MagicalAcc)
				elseif spell.english == "Bad Breath" or spell.english == "Flying Hip Press" or spell.english == "Frost Breath" or spell.english == "Heat Breath"
					or spell.english == "Hecatomb Wave" or spell.english == "Magnetite Cloud"  or spell.english == "Poison Breath" or spell.english == "Self-Destruct"
					or spell.english == "Thunder Breath" or spell.english == "Vapor Spray" or spell.english == "Wind Breath" then
					equip(sets.midcast.bluemagic.Breath)
				elseif spell.english == "Frypan" or spell.english == "Head Butt" or spell.english == "Sudden Lunge" or spell.english == "Tail slap"
					or spell.english == "Whirl of Rage" then
					equip(sets.midcast.bluemagic.StunPhysical)
				elseif spell.english == "Blitzstrahl" or spell.english == "Temporal Shift" or spell.english == "Thunderbolt" then
					equip(sets.midcast.bluemagic.StunMagical)
				elseif spell.english == "Healing Breeze" or spell.english == "Magic Fruit" or spell.english == "Plenilune Embrace" or spell.english == "Pollen"
					or spell.english == "Restoral" or spell.english == "Wild Carrot" then
					equip(sets.midcast.bluemagic.Healing)
				elseif spell.english == "White Wind" then
					equip(sets.midcast.bluemagic.HealingHP)
				elseif spell.english == "Amplification" or spell.english == "Animating Wail" or spell.english == "Carcharian Verve" or spell.english == "Cocoon"
					or spell.english == "Erratic Flutter" or spell.english == "Exuviation"  or spell.english == "Fantod" or spell.english == "Feather Barrier"
					or spell.english == "Harden Shell" or spell.english == "Memento Mori" or spell.english == "Nat. Meditation" or spell.english == "Orcish Counterstance" 
					or spell.english == "Refueling" or spell.english == "Regeneration" or spell.english == "Saline Coat" or spell.english == "Triumphant Roar"
					or spell.english == "Warm-Up" or spell.english == "Winds of Promyvion" or spell.english == "Zephyr Mantle" or spell.english == "Mighty Guard" then
					equip(sets.midcast.bluemagic.Buff)
				elseif spell.english == "Barrier Tusk" or spell.english == "Diamondhide" or spell.english == "Magic Barrier" or spell.english == "Metallic Body"
					or spell.english == "Plasma Charge" or spell.english == "Pyric Bulwark"  or spell.english == "Reactor Cool" or spell.english == "Occultation" then
					equip(sets.midcast.bluemagic.BuffSkillBased)
				elseif spell.english == "Battery Charge" then
					equip(sets.midcast.bluemagic.Refresh)
				end
			end
		end
	end
end


function aftercast(spell)
	idle()
end

function self_command(command)
	if command == "ToggleHybrid" then
		if Player_Mode == "OmenTank" or Player_Mode == "TreasureHunter" or Player_Mode == "DualWield" or Player_Mode == "DualWieldHaste1" then
			Player_Mode = "Hybrid"
			idle()
		elseif Player_Mode == "Hybrid" then
			Player_Mode = "TreasureHunter"
			idle()
		end
	elseif command == "ToggleTank" then
		if Player_Mode == "Hybrid" or Player_Mode == "OmenTank" or Player_Mode == "TreasureHunter" or Player_Mode == "DualWield" or Player_Mode == "DualWieldHaste1" then
			Player_Mode = "OmenTank"
			idle()
		end
	elseif command == "ToggleDualWield" then
		if Player_Mode == "Hybrid" or Player_Mode == "OmenTank" or Player_Mode == "TreasureHunter" or Player_Mode == "DualWieldHaste1" then
			Player_Mode = "DualWield"
			idle()
		elseif Player_Mode == "DualWield" then
			Player_Mode = "DualWieldHaste1"
			idle()
		end
	elseif command == "ToggleSIR" then
		if Casting_Mode == "Normal" then
			Casting_Mode = "SIR"
		elseif Casting_Mode == "SIR" then
			Casting_Mode = "Normal"
		end
	elseif command == "ToggleWEAPONS" then
		if Weapon_Mode == "Locked" then
			Weapon_Mode = "Unlocked"
		elseif Weapon_Mode == "Unlocked" then
			Weapon_Mode = "Locked"
		end
	elseif command == "ToggleMAIN" then
		if player.equipment.main == "Tizona" then
			send_command ('input /equip Main "Maxentius"')
		else
			send_command ('input /equip Main "Tizona"')
		end
	elseif command == "ToggleSUB" then
		if player.equipment.sub == "Zantetsuken" then
			send_command ('input /equip Sub "Thibron"')
		elseif player.equipment.sub == "Thibron" then
			send_command ('input /equip Sub "Bunzi\'s Rod"')
		else
			send_command ('input /equip Sub "Zantetsuken"')
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
