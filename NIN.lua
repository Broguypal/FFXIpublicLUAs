--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
-- 						NINJA LUA
-- Requires Gearswap Addon - "Cancel"
-- requires Dressup (to stop blinking "//du blinking self combat on")

TP_Mode = "Hybrid"
Haste_Mode = "Haste2"

TP_Modes = {'Hybrid','HybridHaste1','Malignance','MalignanceHaste1','AoETank','EvasionTank','MagicEvasionTank','DPS','DPSHaste1'}
Haste_Modes = {'Haste1','Haste2'}

shika = 0
inofu = 0
chono = 0
shihei = 0 
utsubuff = "\\cs(255,0,0)0"

gearswap_box = function()
  str = '           \\cs(130,130,130)NINJA\\cr\n'
  str = str..' Offense Mode:\\cs(255,150,100)   '..TP_Mode..'\\cr\n'
  str = str..' Haste Mode:\\cs(255,150,100)   '..Haste_Mode..'\\cr\n'
  str = str..'  Ino(E): '..inofu..'\\cs(255,255,255)   Shika(B): '..shika..'\\cr\n'
  str = str..'Cho(D): '..chono.."\\cs(255,255,255)  Shihei(U): "..shihei.."\\cr\n"
  str = str..'Utsusemi Shadows: '..utsubuff.."\\cr\n"
  return str
end

gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function buff_change(buff, gain)
	if buffactive['Copy Image'] then
		utsubuff = "\\cs(255,127,0)1"	
	elseif buffactive['Copy Image (2)'] then 
		utsubuff = "\\cs(255,255,0)2"
	elseif buffactive['Copy Image (3)'] then
		utsubuff = "\\cs(127,255,0)3"
	elseif buffactive['Copy Image (4+)'] then
		utsubuff = "\\cs(0,255,0)4+"
	else 
		utsubuff = "\\cs(255,0,0)0" 
	end
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end	

function check_tool_count()
	ctool = {'Shikanofuda',
		'Shihei',
		'Chonofuda',
		'Inoshishinofuda'}

	for t =1,4  do

		if not player.inventory[ctool[t]] then
			curCount = 0
		elseif player.inventory[ctool[t]].count then
			curCount = player.inventory[ctool[t]].count
		end
		a = ''

		--defined green = 99
		cMax = 99
		cColorR = 0
		if curCount > cMax then
			cColorR = 0
			cColorG = 255
		else
			percent = (curCount/cMax * 100)
			if percent >=50 then
				cColorG = 255
				cColorR =math.floor(5 * (100-percent))
			else 
				cColorR = 255
				cColorG = 255-math.floor(5 * (50-percent))
			end
		end
		if curCount == 0 then
			a = "\\cs(255,0,0)" .. '0'
		else 
			a = "\\cs("..cColorR..","..cColorG..",0)" .. (curCount) 
		end

		if t == 1 then
			shika = a
		elseif t == 2 then
			shihei = a
		elseif t == 3 then
			chono = a 
		elseif t == 4 then
			inofu = a 
		end
	end
end

function user_setup()
	check_tool_count()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

function get_sets()
	---- Keybinds ----
	send_command('bind numpad9 gs c ToggleHybrid')
	send_command('bind numpad8 gs c ToggleTank')
	send_command('bind numpad7 gs c ToggleDPS')
	send_command('bind numpad6 gs c ToggleHaste')

	send_command('bind numpad5 gs c ToggleSub')
	send_command('bind numpad4 gs c ToggleMain')
	send_command('bind numpad1 gs c ToggleSpecial')

	send_command('bind f9 input /item "Remedy" <me>')
	send_command('bind f10 input /item "Panacea" <me>')
	send_command('bind f11 input /item "Holy Water" <me>')

	---------- Gear Sets --------------
    sets.idle = {}               	-- Leave this empty.   
	sets.engaged = {}				-- Leave this empty.
		sets.engaged.hybrid = {}
		sets.engaged.malignance = {}
		sets.engaged.DPS = {}
		sets.engaged.tank = {}
		sets.engaged.evasion = {}
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.items = {}
	sets.main = {}
	sets.sub = {}
 
	-- Main Weapons
	sets.main["Heishi Shorinken"] = {main = "Heishi Shorinken"}
	sets.main["Fudo Masamune"]    = {main = "Fudo Masamune"}
	sets.main["Naegling"]         = {main = "Naegling"}
	sets.main["Gokotai"]          = {main = "Gokotai"}

	-- Sub Weapons
	sets.sub["Yagyu Darkblade"] = {sub = "Yagyu Darkblade"}
	sets.sub["Kunimitsu"]       = {sub = "Kunimitsu"}
	sets.sub["Gleti's Knife"]   = {sub = "Gleti's Knife"}
	sets.sub["Hitaki"]          = {sub = "Hitaki"}
	sets.sub["Tsuru"]           = {sub = "Tsuru"}
 
	-------------- IDLE SETS ---------------------
    --Hybrid/DPS IDLE--
	sets.idle.normal = {
		ammo="Date Shuriken",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Danzo Sune-Ate",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+15',}},
	}
	--Night Idle set w/ movement speed
	sets.idle.night = set_combine(sets.idle.normal,{
		feet="Hachi. Kyahan +1",
	})
	
	--Malignance IDLE--
	sets.idle.malignance = {
		ammo="Date Shuriken",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Danzo Sune-Ate",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Kasiri Belt",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Ilabrat Ring",
		right_ring="Hizamaru Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+15',}},
	}
	--Night Idle set w/ movement speed
	sets.idle.malignancenight = set_combine(sets.idle.malignance,{
		feet="Hachi. Kyahan +1",
	})
	
	--AoE Tank Idle
	sets.idle.AOEtank = {
		ammo="Date Shuriken",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+15',}},
	}

	--Evasion Tank Idle
	sets.idle.evasion = {
		ammo="Date Shuriken",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Ilabrat Ring",
		right_ring="Hizamaru Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+15',}},
	}
	
	--Magic Evasion Tank Idle
	sets.idle.magicevasion = {
		ammo="Date Shuriken",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Warder's Charm +1",
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+15',}},
	}

	--------------- ENGAGED SETS ------------------
	---- TANK Engaged Sets ----
	sets.engaged.tank.normal = {
		ammo="Date Shuriken",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+15',}},
	}
	-- 0 shadows
	sets.engaged.tank.counter = set_combine(sets.engaged.tank.normal,{
		ammo="Amar Cluster",
		waist="Cornelia's Belt",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	})
	-- 0 Shadows + Yonin Active
	sets.engaged.tank.yonin = set_combine(sets.engaged.tank.counter,{
		legs="Hattori Hakama +2",
	})

	----Evasion Engaged Sets ----
	sets.engaged.evasion.normal = {
		ammo="Date Shuriken",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Null Belt",
		left_ear="Eabani Earring",
		right_ear="Infused Earring",
		left_ring="Ilabrat Ring",
		right_ring="Hizamaru Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','Evasion+15',}},
	}
	-- 0 shadows
	sets.engaged.evasion.counter = set_combine(sets.engaged.evasion.normal,{
		ammo="Amar Cluster",
		body="Mpaca's Doublet",
		legs="Mpaca's Hose",
		waist="Cornelia's Belt",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		right_ring="Defending Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	})
	-- 0 Shadows + Yonin Active
	sets.engaged.evasion.yonin = set_combine(sets.engaged.evasion.counter,{
		legs="Hattori Hakama +2",
	})

	---- Magic Evasion Engaged Set----
	sets.engaged.evasion.magic = {
	    ammo="Date Shuriken",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back="Null Shawl",
	}
	
	----Hybrid / Malignance / DPS engaged sets ----
	---- Capped Haste (need 1 DW - negligible) ----
	sets.engaged.hybrid.hastecap = {
		ammo="Date Shuriken",
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Mpaca's Hose",
		feet="Malignance Boots",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Gere Ring",
		right_ring="Fickblix's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	-- Cap haste 0 shadows
	sets.engaged.hybrid.hastecapdef = set_combine(sets.engaged.hybrid.hastecap,{
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Mpaca's Hose",
		feet="Malignance Boots",
	})
	--yonin swap
	sets.engaged.hybrid.hastecapyonin = set_combine(sets.engaged.hybrid.hastecapdef,{
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		legs="Hattori Hakama +2",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	})
	---- Malignance ----
	sets.engaged.malignance.hastecap = set_combine(sets.engaged.hybrid.hastecap,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.malignance.hastecapdef = set_combine(sets.engaged.malignance.hastecap,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	---- DPS ----
	sets.engaged.DPS.hastecap = {
		ammo="Date Shuriken",
		head="Ken. Jinpachi +1",
		body="Ken. Samue +1",
		hands="Ken. Tekko +1",
		legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate +1",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Brutal Earring",
		left_ring="Gere Ring",
		right_ring="Fickblix's Ring",
		back="Null Shawl",
	}

	---- 35 Haste (need 12 DW) ----
	sets.engaged.hybrid.haste35 = set_combine(sets.engaged.hybrid.hastecap,{
		waist="Reiki Yotai",
		right_ear="Suppanomimi",
	})
	-- 35 haste 0 shadows
	sets.engaged.hybrid.haste35def = set_combine(sets.engaged.hybrid.haste35,{
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Mpaca's Hose",
		feet="Malignance Boots",
	})
	--yonin swap
	sets.engaged.hybrid.haste35yonin = set_combine(sets.engaged.hybrid.haste35def,{
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		legs="Hattori Hakama +2",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	})
	---- Malignance ----
	sets.engaged.malignance.haste35 = set_combine(sets.engaged.hybrid.haste35,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.malignance.haste35def = set_combine(sets.engaged.malignance.haste35,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	----DPS---- 	
	sets.engaged.DPS.haste35 = set_combine(sets.engaged.DPS.hastecap,{
		waist="Reiki Yotai",
		right_ear="Suppanomimi",
	})

	---- 30 Haste (need 21 DW) ----
		sets.engaged.hybrid.haste30 = set_combine(sets.engaged.hybrid.hastecap,{
		waist="Reiki Yotai",
		right_ear="Suppanomimi",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	})
	-- 30 haste 0 shadows
	sets.engaged.hybrid.haste30def = set_combine(sets.engaged.hybrid.haste30,{
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Mpaca's Hose",
		feet="Malignance Boots",
	})
	--yonin swap
	sets.engaged.hybrid.haste30yonin = set_combine(sets.engaged.hybrid.haste30def,{
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		legs="Hattori Hakama +2",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	})
	---- Malignance ----
	sets.engaged.malignance.haste30 = set_combine(sets.engaged.hybrid.haste30,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.malignance.haste30def = set_combine(sets.engaged.malignance.haste30,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	---- DPS ----
	sets.engaged.DPS.haste30 = set_combine(sets.engaged.DPS.hastecap,{
		waist="Reiki Yotai",
		right_ear="Suppanomimi",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	})

	----- 15 Haste (need 32 DW) ----
	sets.engaged.hybrid.haste15 = set_combine(sets.engaged.hybrid.hastecap,{
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		waist="Reiki Yotai",
		right_ear="Suppanomimi",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	})
	-- 15 haste 0 shadows
	sets.engaged.hybrid.haste15def = set_combine(sets.engaged.hybrid.haste15,{
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Mpaca's Hose",
		feet="Malignance Boots",
	})
	--yonin swap
	sets.engaged.hybrid.haste15yonin = set_combine(sets.engaged.hybrid.haste15def,{
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		legs="Hattori Hakama +2",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	})
	---- Malignance ----
	sets.engaged.malignance.haste15 = set_combine(sets.engaged.hybrid.haste15, {
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	sets.engaged.malignance.haste15def = set_combine(sets.engaged.malignance.haste15,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	---- DPS ----
	sets.engaged.DPS.haste15 = set_combine(sets.engaged.DPS.hastecap,{
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	})
	
	------ 0 Haste (need 39 DW) -------------------
	sets.engaged.hybrid.haste0 = set_combine(sets.engaged.hybrid.hastecap,{
		head={ name="Ryuo Somen +1", augments={'HP+65','"Store TP"+5','"Subtle Blow"+8',}},
		feet="Hiza. Sune-Ate +2",
		waist="Reiki Yotai",
		right_ear="Suppanomimi",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	})
	-- 0 haste 0 shadows
	sets.engaged.hybrid.haste0def = set_combine(sets.engaged.hybrid.haste0,{
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Malignance Gloves",
		legs="Mpaca's Hose",
		feet="Malignance Boots",
	})
	--yonin swap
	sets.engaged.hybrid.haste0yonin = set_combine(sets.engaged.hybrid.haste0def,{
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		legs="Hattori Hakama +2",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Evasion+10','"Store TP"+10','System: 1 ID: 640 Val: 4',}},
	})
	---- Malignance ----
	sets.engaged.malignance.haste0 = set_combine(sets.engaged.hybrid.haste0, {
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
	})
	sets.engaged.malignance.haste0def = set_combine(sets.engaged.malignance.haste0,{
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
	})
	---- DPS ----
	sets.engaged.DPS.haste0 = set_combine(sets.engaged.DPS.hastecap,{
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		feet="Hiza. Sune-Ate +2",
		waist="Reiki Yotai",
		left_ear="Eabani Earring",
		right_ear="Suppanomimi",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dual Wield"+10','Damage taken-5%',}},
	})

	--------------- PRECAST SETS ------------------
	--Fastcast
    sets.precast.fastcast = {
		ammo="Sapience Orb",
		head={ name="Herculean Helm", augments={'"Fast Cast"+5','"Mag.Atk.Bns."+14',}},
		body={ name="Adhemar Jacket +1", augments={'HP+105','"Fast Cast"+10','Magic dmg. taken -4',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+8','"Fast Cast"+6','INT+4',}},
		feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+8','"Fast Cast"+6','INT+9',}},
		neck="Voltsurge Torque",
		waist="Audumbla Sash",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Rahab Ring",
		right_ring="Kishar Ring",
		back={ name="Andartia's Mantle", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Fast Cast"+10','Phys. dmg. taken-10%',}},
	}
	--Utsusemi Precast
	sets.precast.utsusemi = set_combine(sets.precast.fastcast,{
		body={ name="Mochi. Chainmail +3", augments={'Enhances "Sange" effect',}},
	})
	--Enmity
	sets.precast.enmity = {
		ammo="Date Shuriken",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		feet="Ahosi Leggings",
		neck="Moonlight Necklace",
		waist="Kasiri Belt",
		left_ear="Friomisi Earring",
		right_ear="Trux Earring",
		left_ring="Begrudging Ring",
		right_ring="Eihwaz Ring",
	}

	--------------- MIDCAST SETS ------------------
	--Utsusemi Midcast
    sets.midcast.utsusemi = set_combine(sets.precast.fastcast,{
		feet="Hattori Kyahan +3",
	})
	
	--Migawari midcast
	sets.midcast.migawari = set_combine(sets.precast.fastcast,{
		feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	})
	
	--Enfeeble Midcast
    sets.midcast.enfeeble = {
		ammo="Pemphredo Tathlum",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Hattori Tekko +3",
		legs="Malignance Tights",
		feet="Hattori Kyahan +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Hermetic Earring",
		right_ear="Digni. Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Null Shawl",
	}

	--Elemental Midcast
    sets.midcast.elemental = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Mochi. Hatsu. +4", augments={'Enhances "Yonin" and "Innin" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Mochi. Kyahan +3", augments={'Enh. Ninj. Mag. Acc/Cast Time Red.',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		right_ring="Shiva Ring +1",
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	--Elemental Midcast + Obi
	sets.midcast.elementalobi = set_combine(sets.midcast.elemental, {
		waist="Hachirin-no-Obi",
	})
	
	-- Midcast elemental - Futae up
	sets.midcast.elementalfutae = set_combine(sets.midcast.elemental, {
		hands="Hattori Tekko +3",
	})
	
	--Midcast elemental - Futae Up + Obi
	sets.midcast.elementalfutaeobi = set_combine(sets.midcast.elementalfutae, {
		waist="Hachirin-no-Obi",
	})
	
	-- Midcast for trusts - want to have 119 gear in head,body,hands,legs,feet.
	sets.midcast.trust = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	--------------- Weaponskill SETS ------------------
	--undefined Weaponskills
	sets.ws.normal = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Hattori Kyahan +3",
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Mache Earring +1",
		left_ring="Gere Ring",
		right_ring="Sroda Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.ws.shun = {
	    ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Malignance Tabard",
		hands="Hattori Tekko +3",
		legs="Mpaca's Hose",
		feet="Hattori Kyahan +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Mache Earring +1",
		left_ring="Gere Ring",
		right_ring="Fickblix's Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}

	sets.ws.metsu = {
	    ammo="Coiste Bodhar",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Hattori Kyahan +3",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Mache Earring +1",
		left_ring="Gere Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.ws.ten = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Hattori Kyahan +3",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Telos Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.ws.ku = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Malignance Gloves",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Hattori Kyahan +3",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Brutal Earring",
		right_ear="Mache Earring +1",
		left_ring="Gere Ring",
		right_ring="Fickblix's Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}

	sets.ws.hi = {
		ammo="C. Palug Stone",
		head="Ken. Jinpachi +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Hattori Kyahan +3",
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Mache Earring +1",
		left_ring="Sroda Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.ws.kamu = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Ninja Nodowa +2", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Gere Ring",
		right_ring="Sroda Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.ws.ei = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Skrymir Cord",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Archon Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	-- Yu Weaponskill
	sets.ws.yu = {
		ammo={ name="Ghastly Tathlum +1", augments={'Path: A',}},
		head={ name="Mochi. Hatsu. +4", augments={'Enhances "Yonin" and "Innin" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Shiva Ring +1",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	--Yu with obi
	sets.ws.yuobi = set_combine(sets.ws.yu,{
		waist="Hachirin-no-Obi",
	})
	
	--chi/teki/to 
	sets.ws.elemental = {
		ammo={ name="Seeth. Bomblet +1", augments={'Path: A',}},
		head={ name="Mochi. Hatsu. +4", augments={'Enhances "Yonin" and "Innin" effect',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Gere Ring",
		right_ring="Epaminondas's Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	--chi/teki/to elemental with Obi
	sets.ws.elementalobi = set_combine(sets.ws.elemental, {
		waist="Hachirin-no-Obi",
	})

	sets.ws.savageblade = {
		ammo="Crepuscular Pebble",
		head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Hattori Kyahan +3",
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Weapon skill damage +10%','Damage taken-5%',}},
	}
	
	sets.ws.ageha = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Digni. Earring",
		right_ear="Crep. Earring",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10','Damage taken-5%',}},
	}
	
	---------------------------	ITEM SETS	---------------------------
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}
end

--------------- LOGIC - DO NOT TOUCH BELOW ------------------

--Automatically switch sets for time
    -- world.time is given in minutes into each day
    -- 7:00 AM would be 420 minutes
    -- 17:00 PM would be 1020 minutes

windower.register_event('time change', function(new, old)
	if new > (7*60) and old <= (7*60) then
		idle()
	end
	if new > (17*60) and old <= (17*60) then
		idle()
	end
end)

-- Recognizing when losing utsusemi or haste related buffs to trigger automatic equipment change
windower.register_event('lose buff', function(buff_id)
	if buff_id == 66 or buff_id == 33 or buff_id == 580 or buff_id == 604 or buff_id == 214 or buff_id == 228 then
		idle()
	end
end)

-- Recognizing when gaining utsusemi or haste related buffs to trigger automatic equipment change
windower.register_event('gain buff', function(buff_id)
	if buff_id == 66 or buff_id == 33 or buff_id == 580 or buff_id == 604 or buff_id == 214 or buff_id == 228 then
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
	if TP_Mode == "Hybrid" or TP_Mode == "Malignance" or TP_Mode == "DPS" then
		if Haste_Mode == "Haste2" then
			if player.status == "Engaged" then 
				if player.equipment.main == "Hachimonji" then
					if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
						equip(sets.engaged.malignance.hastecap)
					else
						equip(sets.engaged.malignance.hastecapdef)
					end
				else
					if ( ( (buffactive[33] or buffactive[580] or buffactive.embrava) and (buffactive.march or buffactive[604]) ) or
					( buffactive[33] and (buffactive[580] or buffactive.embrava) ) or
					( buffactive.march == 2 and buffactive[604] ) ) then
						if TP_Mode == "DPS" then
							equip(sets.engaged.DPS.hastecap)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.hastecap)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.hastecap)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.hastecapdef)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.hastecapyonin)
								else
									equip(sets.engaged.hybrid.hastecapdef)
								end
							end
						end
					elseif ( (buffactive[33] or buffactive.march == 2 or buffactive[580]) and buffactive['haste samba'] ) then
						if TP_Mode == "DPS" then
								equip(sets.engaged.DPS.haste35)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.haste35)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste35)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste35def)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.haste35yonin)
								else
									equip(sets.engaged.hybrid.haste35def)
								end
							end
						end
					elseif ( ( buffactive[580] or buffactive[33] or buffactive.march == 2 ) or
					( buffactive.march == 1 and buffactive[604] ) ) then
						if TP_Mode == "DPS" then
							equip(sets.engaged.DPS.haste30)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.haste30)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste30)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste30)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.haste30yonin)
								else
									equip(sets.engaged.hybrid.haste30def)
								end
							end
						end
					elseif ( buffactive.march == 1 or buffactive[604] ) then
						if TP_Mode == "DPS" then
							equip(sets.engaged.DPS.haste15)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.haste15)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste15)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste15def)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.haste15yonin)
								else
									equip(sets.engaged.hybrid.haste15def)
								end
							end
						end
					else
						if TP_Mode == "DPS" then
							equip(sets.engaged.DPS.haste0)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.haste0)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste0)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste0def)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.haste0yonin)
								else
									equip(sets.engaged.hybrid.haste0def)
								end
							end
						end
					end
				end
			else
				if world.time >= (17*60) or world.time < (7*60) then
					if TP_Mode == "Hybrid" or TP_Mode == "DPS" then
						equip(sets.idle.night)
					elseif TP_Mode == "Malignance" then
						equip(sets.idle.malignancenight)
					end
				else
					if TP_Mode == "Hybrid" or TP_Mode == "DPS" then
						equip(sets.idle.normal)
					elseif TP_Mode == "Malignance" then
						equip(sets.idle.malignance)
					end
				end
			end
		elseif Haste_Mode == "Haste1" then
			if player.status == "Engaged" then 
				if player.equipment.main == "Hachimonji" then
					if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
						equip(sets.engaged.malignance.hastecap)
					else
						equip(sets.engaged.malignance.hastecapdef)
					end
				else
					if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava or buffactive[604]) ) or  -- geo haste + anything
					( buffactive.embrava and (buffactive.march or buffactive[33] or buffactive[604]) ) or  -- embrava + anything
					( buffactive.march == 2 and (buffactive[33] or buffactive[604]) ) or  -- two marches + anything
					( buffactive[33] and buffactive[604] and buffactive.march ) then -- haste + mighty guard + any marches
						if TP_Mode == "DPS" then
							equip(sets.engaged.DPS.hastecap)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.hastecap)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.hastecap)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.hastecapdef)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.hastecapyonin)
								else
									equip(sets.engaged.hybrid.hastecapdef)
								end
							end
						end
					elseif ( (buffactive[604] or buffactive[33]) and buffactive['haste samba'] and buffactive.march == 1) or -- MG or haste + samba with 1 march
					( buffactive.march == 2 and buffactive['haste samba'] ) or
					( buffactive[580] and buffactive['haste samba'] ) then 
						if TP_Mode == "DPS" then
							equip(sets.engaged.DPS.haste35)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.haste35)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste35)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste35def)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.haste35yonin)
								else
									equip(sets.engaged.hybrid.haste35def)
								end
							end
						end
					elseif ( buffactive.march == 2 ) or -- two marches from ghorn
					( (buffactive[33] or buffactive[604]) and buffactive.march == 1 ) or  -- MG or haste + 1 march
					( buffactive[580] ) or  -- geo haste
					( buffactive[33] and buffactive[604] ) then -- haste with MG
						if TP_Mode == "DPS" then
							equip(sets.engaged.DPS.haste30)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.haste30)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste30)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste30)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.haste30yonin)
								else
									equip(sets.engaged.hybrid.haste30def)
								end
							end
						end
					elseif buffactive[33] or buffactive[604] or buffactive.march == 1 then
						if TP_Mode == "DPS" then
							equip(sets.engaged.DPS.haste15)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.haste15)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste15)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste15def)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.haste15yonin)
								else
									equip(sets.engaged.hybrid.haste15def)
								end
							end
						end
					else
						if TP_Mode == "DPS" then
								equip(sets.engaged.DPS.haste0)
						elseif buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
							if TP_Mode == "Hybrid" then
								equip(sets.engaged.hybrid.haste0)
							elseif TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste0)
							end
						else
							if TP_Mode == "Malignance" then
								equip(sets.engaged.malignance.haste0def)
							elseif TP_Mode == "Hybrid" then
								if buffactive['Yonin'] then
									equip(sets.engaged.hybrid.haste0yonin)
								else
									equip(sets.engaged.hybrid.haste0def)
								end
							end
						end
					end
				end
			else
				if world.time >= (17*60) or world.time < (7*60) then
					if TP_Mode == "Hybrid" or TP_Mode == "DPS" then
						equip(sets.idle.night)
					elseif TP_Mode == "Malignance" then
						equip(sets.idle.malignancenight)
					end
				else
					if TP_Mode == "Hybrid" or TP_Mode == "DPS" then
						equip(sets.idle.normal)
					elseif TP_Mode == "Malignance" then
						equip(sets.idle.malignance)
					end
				end
			end
		end
	elseif TP_Mode == "AoETank" or TP_Mode == "EvasionTank" then
		if player.status == "Engaged" then
			if buffactive['Copy Image'] or buffactive['Copy Image (2)'] or buffactive['Copy Image (3)'] or buffactive['Copy Image (4+)'] then
				if TP_Mode == "AoETank" then
					equip(sets.engaged.tank.normal)
				elseif TP_Mode == "EvasionTank" then
					equip(sets.engaged.evasion.normal)
				end
			else
				if buffactive['Yonin'] then	
					if TP_Mode == "AoETank" then
						equip(sets.engaged.tank.yonin)
					elseif TP_Mode == "EvasionTank" then
						equip(sets.engaged.evasion.yonin)
					end
				else
					if TP_Mode == "AoETank" then
						equip(sets.engaged.tank.counter)
					elseif TP_Mode == "EvasionTank" then
						equip(sets.engaged.evasion.counter)
					end
				end	
			end
		else
			if TP_Mode == "AoETank" then
				equip(sets.idle.AOEtank)
			elseif TP_Mode == "EvasionTank" then
				equip(sets.idle.evasion)
			end
		end
	elseif TP_Mode == "MagicEvasionTank" then
		if player.status == "Engaged" then
			equip(sets.engaged.evasion.magic)
		else
			equip(sets.idle.magicevasion)
		end
	end
end

function precast(spell)
	if spell.english == "Provoke" or spell.english == "Issekigan" then
		equip(sets.precast.enmity)
	elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then 
		if spell.name:match('Utsusemi') then
			equip(sets.precast.utsusemi)
		else
			equip(sets.precast.fastcast)
		end
	elseif spell.type == "WeaponSkill" then 
		if spell.english == "Blade: Shun" then
			equip(sets.ws.shun)
		elseif spell.english == "Blade: Metsu" then
			equip(sets.ws.metsu)
		elseif spell.english == "Blade: Ten" then
			equip(sets.ws.ten)
		elseif spell.english == "Blade: Ku" then
			equip(sets.ws.ku)
		elseif spell.english == "Blade: Hi" then
			equip(sets.ws.hi)
		elseif spell.english == "Blade: Kamu" then
			equip(sets.ws.kamu)
		elseif spell.english == "Blade: Ei" then
			equip(sets.ws.ei)
		elseif spell.english == "Blade: Chi" or spell.english == "Blade: Teki" or spell.english == "Blade: To" then
			if spell.element == world.day_element or spell.element == world.weather_element then
				if spell.english == "Blade: Chi" and world.day_element ~= "Wind" and world.weather_element ~= "Wind" then
					equip(sets.ws.elementalobi)
				elseif spell.english == "Blade: Teki" and world.day_element ~= "Lightning" and world.weather_element ~= "Lightning" then
					equip(sets.ws.elementalobi)
				elseif spell.english == "Blade: To" and world.day_element ~= "Fire" and world.weather_element ~= "Fire" then
					equip(sets.ws.elementalobi)
				else
					equip(sets.ws.elemental)
				end
			else
				equip(sets.ws.elemental)
			end
		elseif spell.english == "Blade: Yu" then
			if spell.element == world.day_element or spell.element == world.weather_element then
				if world.day_element ~= "Lightning" and world.weather_element ~= "Lightning" then
					equip(sets.ws.yuobi)
				else
					equip(sets.ws.yu)
				end
			else
				equip(sets.ws.yu)
			end
		elseif spell.english == "Savage Blade" then
			equip(sets.ws.savageblade)
		elseif spell.english == "Tachi: Ageha" then
			equip(sets.ws.ageha)
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
	if spell.name:match('Utsusemi') then
		if spell.english == "Utsusemi: Ichi" or spell.english == "Utsusemi: Ni" then
			if player.equipment.sub ~= "Yagyu Darkblade" then
				if buffactive['Copy Image'] then
					send_command('cancel Copy Image')
					equip(sets.midcast.utsusemi)
				elseif buffactive['Copy Image (2)'] then
					send_command('cancel 444')
					equip(sets.midcast.utsusemi)
				elseif buffactive['Copy Image (3)'] then
					send_command('cancel 445')
					equip(sets.midcast.utsusemi)
				elseif buffactive['Copy Image (4+)'] then
					send_command('cancel 446')
					equip(sets.midcast.utsusemi)
				end
			else
				equip(sets.midcast.utsusemi)
			end
		else
			equip(sets.midcast.utsusemi)
		end
	elseif spell.name:match('Migawari') then
		equip(sets.midcast.migawari)
	elseif spell.name:match('Kurayami') or spell.name:match('Hojo') or spell.name:match('Dokumori') or spell.name:match('Jubaku') or spell.name:match('Yurin') or spell.name:match('Aisha') or spell.skill == "Enfeebling Magic" then
		equip(sets.midcast.enfeeble)
	elseif spell.name:match('Katon') or spell.name:match('Suiton') or spell.name:match('Raiton') or spell.name:match('Doton') or spell.name:match('Huton') or spell.name:match('Hyoton') then
		if buffactive['Futae'] then
			if spell.element == world.day_element or spell.element == world.weather_element then
				if spell.name:match('Katon') and world.day_element ~= "Water" and world.weather_element ~= "Water" then
					equip(sets.midcast.elementalfutaeobi)
				elseif spell.name:match('Suiton') and world.day_element ~= "Lightning" and world.weather_element ~= "Lightning" then
					equip(sets.midcast.elementalfutaeobi)
				elseif spell.name:match('Raiton') and world.day_element ~= "Earth" and world.weather_element ~= "Earth" then
					equip(sets.midcast.elementalfutaeobi)
				elseif spell.name:match('Doton') and world.day_element ~= "Wind" and world.weather_element ~= "Wind" then
					equip(sets.midcast.elementalfutaeobi)
				elseif spell.name:match('Huton') and world.day_element ~= "Ice" and world.weather_element ~= "Ice" then
					equip(sets.midcast.elementalfutaeobi)
				elseif spell.name:match('Hyoton') and world.day_element ~= "Fire" and world.weather_element ~= "Fire" then
					equip(sets.midcast.elementalfutaeobi)
				else
					equip(sets.midcast.elementalfutae)
				end
			else
				equip(sets.midcast.elementalfutae)
			end
		else
			if spell.element == world.day_element or spell.element == world.weather_element then
				if spell.name:match('Katon') and world.day_element ~= "Water" and world.weather_element ~= "Water" then
					equip(sets.midcast.elementalobi)
				elseif spell.name:match('Suiton') and world.day_element ~= "Lightning" and world.weather_element ~= "Lightning" then
					equip(sets.midcast.elementalobi)
				elseif spell.name:match('Raiton') and world.day_element ~= "Earth" and world.weather_element ~= "Earth" then
					equip(sets.midcast.elementalobi)
				elseif spell.name:match('Doton') and world.day_element ~= "Wind" and world.weather_element ~= "Wind" then
					equip(sets.midcast.elementalobi)
				elseif spell.name:match('Huton') and world.day_element ~= "Ice" and world.weather_element ~= "Ice" then
					equip(sets.midcast.elementalobi)
				elseif spell.name:match('Hyoton') and world.day_element ~= "Fire" and world.weather_element ~= "Fire" then
					equip(sets.midcast.elementalobi)
				else
					equip(sets.midcast.elemental)
				end
			else
				equip(sets.midcast.elemental)
			end
		end
	elseif spell.english == "Provoke" or spell.english == "Foil" or spell.english == "Poisonga" or spell.english == "Stun" or spell.english == "Flash" or spell.english == "Jettatura" or spell.english == "Blank Gaze" then
		equip(sets.precast.enmity)
	elseif spell.type == "Trust" then
		equip(sets.midcast.trust)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	end
end

function aftercast(spell)
	if spell.type == "Ninjutsu" then	
		idle()
		check_tool_count()
		gearswap_jobbox:text(gearswap_box())		
		gearswap_jobbox:show()
	else
		idle()
	end
end

function self_command(command)
	if command == "ToggleHybrid" then
		if TP_Mode == "Hybrid" then
			TP_Mode = "Malignance"
			idle()
			gearswap_jobbox:text(gearswap_box())
			gearswap_jobbox:show()
		elseif TP_Mode == "Malignance" or TP_Mode == "AoETank" or TP_Mode == "EvasionTank" or TP_Mode == "MagicEvasionTank" or TP_Mode == "DPS" then
			TP_Mode = "Hybrid"
			idle()
			gearswap_jobbox:text(gearswap_box())
			gearswap_jobbox:show()
		end
	elseif command == "ToggleTank" then
		if TP_Mode == "Hybrid" or TP_Mode == "Malignance" or TP_Mode == "MagicEvasionTank" or TP_Mode == "DPS" then
			TP_Mode = "AoETank"
			idle()
			gearswap_jobbox:text(gearswap_box())
			gearswap_jobbox:show()
		elseif TP_Mode == "AoETank" then
			TP_Mode = "EvasionTank"
			idle()
			gearswap_jobbox:text(gearswap_box())
			gearswap_jobbox:show()
		elseif TP_Mode == "EvasionTank" then
			TP_Mode = "MagicEvasionTank"
			idle()
			gearswap_jobbox:text(gearswap_box())
			gearswap_jobbox:show()
		end
	elseif command == "ToggleHaste" then
		if Haste_Mode == "Haste1" then
			Haste_Mode = "Haste2"
			idle()
			gearswap_jobbox:text(gearswap_box())
			gearswap_jobbox:show()
		elseif Haste_Mode == "Haste2" then
			Haste_Mode = "Haste1"
			idle()
			gearswap_jobbox:text(gearswap_box())
			gearswap_jobbox:show()
		end
	elseif command == "ToggleDPS" then
		if TP_Mode == "Hybrid" or TP_Mode == "Malignance" or TP_Mode == "AoETank" or TP_Mode == "EvasionTank" or TP_Mode == "MagicEvasionTank" then
			TP_Mode = "DPS"
			idle()
			gearswap_jobbox:text(gearswap_box())
			gearswap_jobbox:show()
		end
	elseif command == "ToggleMain" then
		local main_cycle ={"Heishi Shorinken","Fudo Masamune","Naegling","Gokotai"}
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
		local sub_cycle = {"Yagyu Darkblade","Kunimitsu","Gleti's Knife","Hitaki","Tsuru"}
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
	elseif command == "ToggleSpecial" then
		if player.equipment.main == "Hachimonji" then
			send_command ('input /equip Main "Tauret"; wait 1; input /equip Sub "Gleti\'s Knife"')
		else
			send_command ('input /equip Main "Hachimonji"; wait 1; input /equip Sub "Bloodrain strap"')
		end
	end
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
