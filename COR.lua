--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    


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
	send_command('unbind f8')
	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
	send_command('unbind f12')
    enable("main","sub","range","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
end

TP_Mode = "Hybrid"
 
TP_Modes = {'Defence','Hybrid'}

trump_card = "\\cs(255,0,0)0"

gearswap_box = function()
  str = '           \\cs(120,0,0)CORSAIR\\cr\n'
  str = str..' Mode:\\cs(255,150,100)   '..TP_Mode..'\\cr\n'
  str = str..' Trump Card: ' .. trump_card .. '\\cr\n'
  str = str..' crl: \\cs(255,255,255)[LGT]\\cr \\cs(255,64,64)[FIR]\\cr \\cs(0,255,0)[WND]\\cr \\cs(180,0,255)[THD]\\cr\n'
  str = str..' alt: \\cs(80,60,100)[DRK]\\cr \\cs(128,255,255)[ICE]\\cr \\cs(165,100,40)[STN]\\cr \\cs(64,128,255)[WTR]\\cr\n'    return str
end

gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	check_trump_card_count()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

function check_trump_card_count()
    local item_name = 'Trump Card'
    local curCount = 0

    if player.inventory[item_name] and player.inventory[item_name].count then
        curCount = player.inventory[item_name].count
    end

    -- max stack count for coloring
    local cMax = 99
    local cColorR, cColorG

    if curCount > cMax then
        cColorR = 0
        cColorG = 255
    else
        local percent = (curCount / cMax) * 100
        if percent >= 50 then
            cColorG = 255
            cColorR = math.floor(5 * (100 - percent))
        else
            cColorR = 255
            cColorG = 255 - math.floor(5 * (50 - percent))
        end
    end

    local a
    if curCount == 0 then
        a = "\\cs(255,0,0)" .. '0'
    else
        a = "\\cs(" .. cColorR .. "," .. cColorG .. ",0)" .. curCount
    end

    trump_card = a
end

------------------------DO NOT TOUCH BELOW----------------------------------------
function get_sets()
	-- Toggle Modes
	send_command('bind numpad9 gs c ToggleMode')

	-- Toggle weapons
	send_command('bind numpad4 gs c ToggleMain')
	send_command('bind numpad5 gs c ToggleSub')
	send_command('bind numpad6 gs c ToggleRanged')

	--Shots keybinds
	send_command ('bind ^numpad1 input /ja "Fire Shot" <t> ')
	send_command ('bind ^numpad2 input /ja "Wind Shot" <t>')
	send_command ('bind ^numpad3 input /ja "Thunder Shot" <t>')
	send_command ('bind ^numpad0 input /ja "Light Shot" <t>') 
	send_command ('bind !numpad1 input /ja "Ice Shot" <t>')
	send_command ('bind !numpad2 input /ja "Earth Shot" <t>')
	send_command ('bind !numpad3 input /ja "Water Shot" <t>')
	send_command ('bind !numpad0 input /ja "Dark Shot" <t>')

	-- Ranged attack
	send_command ('bind numpad0 gs c RangedAttack')

	send_command('bind f9 input /item "Remedy" <me>')
	send_command('bind f10 input /item "Panacea" <me>')
	send_command('bind f11 input /item "Holy Water" <me>')
	send_command ('bind numpad1 input /mount "Noble Chocobo"')
	send_command ('bind numpad2 input /dismount')

 
    sets.idle = {}                  -- Leave this empty
	sets.engaged = {}				-- Leave this empty
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.ja = {}					-- Leave this empty
	sets.items = {}

	last_real_ranged = "Fomalhaut"
 
 ------------------ DO NOT TOUCH ABOVE (BUT TOTALLY TOUCH BELOW THIS POINT) ---------
 
---- IDLE SETS ----
    sets.idle.normal = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Malignance Gloves",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.idle.tank = {
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Plat. Mog. Belt",
		left_ear="Infused Earring",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Warden's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
---- ENGAGED SETS ----

	sets.engaged.normal = {
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear="Eabani Earring",
		left_ring="Defending Ring",
		right_ring="Fickblix's Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}

---- PRESHOT SET ----
    sets.precast.preshot = {
		head="Ikenga's Hat",
		body="Oshosi Vest +1",
		hands="Ikenga's Gloves",
		legs="Oshosi Trousers",
		feet="Ikenga's Clogs",
		neck="Sanctity Necklace",
		waist="Impulse Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Ilabrat Ring",
		right_ring="Petrov Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}

---- MIDCAST SETS ----

    sets.midcast.midshot = {
		head="Malignance Chapeau",
		body="Chasseur's Frac +2",
		hands="Malignance Gloves",
		legs="Chas. Culottes +2",
		feet="Malignance Boots",
		neck="Iskur Gorget",
		waist="Eschan Stone",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}

---- WEAPONSKILL SETS ----
	sets.ws.general = {
		ammo="Chrono Bullet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.ws.laststand = {
		ammo="Chrono Bullet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Ikenga's Vest",
		hands="Chasseur's Gants +2",
		legs="Ikenga's Trousers",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.ws.savageblade = {
		ammo="Chrono Bullet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Chasseur's Gants +2",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Rep. Plat. Medal",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.ws.evisceration = {
		ammo="Chrono Bullet",
		head="Ikenga's Hat",
		body="Ikenga's Vest",
		hands="Malignance Gloves",
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Ikenga's Clogs",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Mache Earring +1",
		left_ring="Apate Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dual Wield"+10','Phys. dmg. taken-10%',}},
	}
	
	sets.ws.hotshot = {
		ammo="Living Bullet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Fotia Gorget",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}
	
	sets.ws.hotshotobi = set_combine(sets.ws.hotshot,{
		waist="Hachirin-no-Obi",
	})

	sets.ws.leadensalute = {
		ammo="Living Bullet",
		head="Pixie Hairpin +1",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Sanctity Necklace",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	sets.ws.leadensaluteobi = set_combine(sets.ws.leadensalute,{
		waist="Hachirin-no-Obi",
	})
	
	sets.ws.wildfire = {
		ammo="Living Bullet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Sanctity Necklace",
		waist="Orpheus's Sash",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	sets.ws.wildfireobi = set_combine(sets.ws.wildfire,{
		waist="Hachirin-no-Obi",
	})

---- **** IMPORTANT ***** ONLY NON-RANGED WEAPONSKILLS SHOULD HAVE HAUKSBOK BULLET EQUIPPED ******
	sets.ws.aeolianedge = {
		ammo="Hauksbok Bullet",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sanctity Necklace",
		waist="Orpheus's Sash",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

---- JOB ABILITY SETS ----
	sets.ja.quickdraw = {
		ammo="Hauksbok Bullet",
		head="Ikenga's Hat",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Sanctity Necklace",
		waist="Orpheus's Sash",
		left_ear="Crematio Earring",
		right_ear="Friomisi Earring",
		left_ring="Fenrir Ring +1",
		right_ring="Dingir Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	sets.ja.quickdrawobi = set_combine(sets.ja.quickdraw,{
		waist="Hachirin-no-Obi",
	})

	sets.ja.quickdrawACC = {
		ammo="Hauksbok Bullet",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
		neck="Sanctity Necklace",
		waist="Orpheus's Sash",
		left_ear="Friomisi Earring",
		right_ear={ name="Chas. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','Crit.hit rate+5',}},
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	sets.ja.quickdrawACCobi = set_combine(sets.ja.quickdrawACC,{
		waist="Hachirin-no-Obi",
	})

	sets.ja.engagedroll = {
		head={ name="Lanun Tricorne +1", augments={'Enhances "Winning Streak" effect',}},
		hands="Chasseur's Gants +2",
		neck="Regal Necklace",
		left_ring="Luzaf's Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%','Mag. Evasion+15',}},
	}

	sets.ja.roll = set_combine(sets.ja.engagedroll,{
		range="Compensator",
	})
	
	sets.ja.wildcard = {
		feet={ name="Lanun Bottes +3", augments={'Enhances "Wild Card" effect',}},
	}
	
	sets.ja.randomdeal = {
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
	}

---------------------------	ITEM SETS	---------------------------
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}
	
end

-------- DO NOT TOUCH BELOW IF COMPLETELY NEW AT GEARSWAP -- Everything above should be all your basic needs.
function idle()
	if TP_Mode == "Defence" then
		equip(sets.idle.tank)
	elseif TP_Mode == "Hybrid" then
		if player.status == "Engaged" then
			equip(sets.engaged.normal)
		else
			equip(sets.idle.normal)
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

function precast(spell,action,spellMap,eventArgs)
	if spell.action_type == 'Ranged Attack' then
		if player.equipment.ammo == "Hauksbok Bullet" then
			cancel_spell()
			add_to_chat(123,'Abort: Don\'t shoot your good ammo!')
			idle()
		else
			equip(sets.precast.preshot)
		end
	elseif spell.type == 'WeaponSkill' then
		if player.equipment.ammo == "Hauksbok Bullet" then
			cancel_spell()
			add_to_chat(123,'Wrong bullet (safety), please recast!')
			idle()
		elseif spell.english == "Last Stand" then
			equip(sets.ws.laststand)
		elseif spell.english == "Savage Blade" then
			equip(sets.ws.savageblade)
		elseif spell.english == "Evisceration" then
			equip(sets.ws.evisceration)
		elseif spell.english == "Hot Shot" then
			if (world.day_element == "Fire" or world.weather_element == "Fire") and world.day_element ~= "Water" and world.weather_element ~= "Water" then
				equip(sets.ws.hotshotobi)
			else
				equip(sets.ws.hotshot)
			end
		elseif spell.english == "Leaden Salute" then
			if (world.day_element == "Dark" or world.weather_element == "Dark") and world.day_element ~= "Light" and world.weather_element ~= "Light" then
				equip(sets.ws.leadensaluteobi)
			else
				equip(sets.ws.leadensalute)
			end
		elseif spell.english == "Wildfire" then
			if (world.day_element == "Fire" or world.weather_element == "Fire") and world.day_element ~= "Water" and world.weather_element ~= "Water" then
				equip(sets.ws.wildfireobi)
			else
				equip(sets.ws.wildfire)
			end
		elseif spell.english == "Aeolian Edge" then
			equip(sets.ws.aeolianedge)
		else
			equip(sets.ws.general)
		end
	elseif spell.type == "JobAbility" then
		if spell.english == "Double-Up" then
			if player.status == "Engaged" then
				equip(sets.ja.engagedroll)
			else
				equip(sets.ja.roll)
			end
		elseif spell.english == "Wild Card" then
			equip(sets.ja.wildcard)
		elseif spell.english == "Random Deal" then
			equip(sets.ja.randomdeal)
		end
	elseif spell.type == "CorsairRoll" then
		if player.status == "Engaged" then
			equip(sets.ja.engagedroll)
		else
			equip(sets.ja.roll)
		end
	elseif spell.type == "CorsairShot" then
		if spell.english == "Dark Shot" or spell.english == "Light Shot" then
			if spell.element == world.day_element or spell.element == world.weather_element then
				if spell.english == "Dark Shot" and world.day_element ~= "Light" and world.weather_element ~= "Light" then
					equip(sets.ja.quickdrawACCobi)
				elseif spell.english == "Light Shot" and world.day_element ~= "Dark" and world.weather_element ~= "Dark" then
					equip(sets.ja.quickdrawACCobi)
				else
					equip(sets.ja.quickdrawACC)
				end
			else
				equip(sets.ja.quickdrawACC)
			end
		else
			if spell.element == world.day_element or spell.element == world.weather_element then
				if spell.english == "Fire Shot" and world.day_element ~= "Water" and world.weather_element ~= "Water" then
					equip(sets.ja.quickdrawobi)
				elseif spell.english == "Water Shot" and world.day_element ~= "Lightning" and world.weather_element ~= "Lightning" then
					equip(sets.ja.quickdrawobi)
				elseif spell.english == "Thunder Shot" and world.day_element ~= "Earth" and world.weather_element ~= "Earth" then
					equip(sets.ja.quickdrawobi)
				elseif spell.english == "Earth Shot" and world.day_element ~= "Wind" and world.weather_element ~= "Wind" then
					equip(sets.ja.quickdrawobi)
				elseif spell.english == "Wind Shot" and world.day_element ~= "Ice" and world.weather_element ~= "Ice" then
					equip(sets.ja.quickdrawobi)
				elseif spell.english == "Ice Shot" and world.day_element ~= "Fire" and world.weather_element ~= "Fire" then
					equip(sets.ja.quickdrawobi)
				else
					equip(sets.ja.quickdraw)
				end
			else
				equip(sets.ja.quickdraw)
			end
		end
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	end
end

function midcast(spell,action,spellMap,eventArgs)
	if spell.action_type == 'Ranged Attack' then
		if player.equipment.ammo == "Hauksbok Bullet" then
			cancel_spell()
			add_to_chat(123,'Abort: Don\'t shoot your good ammo!')
			idle()
		else
			equip(sets.midcast.midshot)
		end
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	end
end

function aftercast(spell)
    if spell.type == "CorsairRoll" and player.status ~= "Engaged" then
        local ammo = (last_real_ranged == "Death Penalty") and "Living Bullet" or "Chrono Bullet"
        equip({ range = last_real_ranged, ammo = ammo })
		idle()
		check_trump_card_count()
		gearswap_jobbox:text(gearswap_box())		
		gearswap_jobbox:show()
	else
        local ammo = (last_real_ranged == "Death Penalty") and "Living Bullet" or "Chrono Bullet"
        equip({ range = last_real_ranged, ammo = ammo })
		idle()
		check_trump_card_count()
		gearswap_jobbox:text(gearswap_box())		
		gearswap_jobbox:show()
    end
end

function self_command(command)
	if command == "RangedAttack" then
		send_command ('input /ra <t>')
	elseif command == "ToggleMode" then
		if TP_Mode == "Hybrid"  then
			TP_Mode = "Defence"
			idle()
		elseif TP_Mode == "Defence" then
			TP_Mode = "Hybrid"
			idle()
		end
	elseif command == "ToggleMain" then
		local main_cycle = { "Naegling", "Tauret" }
		if not main_mode then main_mode = main_cycle[1] end
		local index = 1
		for i, name in ipairs(main_cycle) do
			if main_mode == name then
				index = (i % #main_cycle) + 1
				break
			end
		end
		main_mode = main_cycle[index]
		equip({ main = main_mode })
	elseif command == "ToggleSub" then
		local sub_cycle = { "Gleti's Knife", "Tauret" }
		if not sub_mode then sub_mode = sub_cycle[1] end
		local index = 1
		for i, name in ipairs(sub_cycle) do
			if sub_mode == name then
				index = (i % #sub_cycle) + 1
				break
			end
		end
		sub_mode = sub_cycle[index]
		equip({ sub = sub_mode })
	elseif command == "ToggleRanged" then
		local ranged_cycle = { "Death Penalty", "Anarchy +2", "Fomalhaut" }
		if not ranged_mode then ranged_mode = ranged_cycle[1] end
		local index = 1
		for i, name in ipairs(ranged_cycle) do
			if ranged_mode == name then
				index = (i % #ranged_cycle) + 1
				break
			end
		end
		ranged_mode = ranged_cycle[index]
		
		last_real_ranged = ranged_mode

		local ammo = (ranged_mode == "Death Penalty") and "Living Bullet" or "Chrono Bullet"
		equip({ range = ranged_mode, ammo = ammo })
	end
	check_trump_card_count()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

---- 	Unload settings 		----
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