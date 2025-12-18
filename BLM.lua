--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
----------------------------------------------------------------------
--                           BLM LUA
----------------------------------------------------------------------
-- Summary:
-- This lua relies on using the numberpad to change your mode/state which is tracked on the Job box. 
----- The numberpad is also used to:
--------- a)cast the highest tier spell elemental available more easily (ctrl/alt 1-3). This can be modified by changing the selected Spell Tier.
--------- b)cast cumulative magic/ja spells (ctrl/alt 4-6) on your target more easily.
--------- c)cast Myrkr (0), Burn (ctrl 0), or impact (alt 0) more easily
-- To change the keybinds, please edit them in the Keybinds function below
-- To change your default Job box position, please change the "x" and "y" positions in then gearswap_box_config settings below

----------------------------------------------------------------------
--                           MODES / UI TEXT BOX
----------------------------------------------------------------------
Player_Mode		= "Normal"
Casting_Mode	= "Burst"
MP_Mode			= "Off"
Occult_Mode		= "Off"

Player_Modes  = {'Normal','Tank'}
Casting_Modes = {'Burst','Freecast'}
MP_Modes = {'On','Off'}
Occult_Modes = {'On','Off'}

Spell_Tier = 6
Min_Tier   = 1
Max_Tier   = 6

-- Job Box Display
gearswap_box = function()
    local str = ''
    str = str..'           \\cs(102,0,204)BLACK MAGE\\cr\n'
    str = str..' Offense Mode:\\cs(144,238,144)   '..Player_Mode..'\\cr\n'
	str = str..' MP Mode:\\cs(100,150,160)   '..MP_Mode..'\\cr\n'
	str = str..' Occult Mode:\\cs(255,150,100)   '..Occult_Mode..'\\cr\n'
    str = str..' Casting Mode:\\cs(255,0,102)   '..Casting_Mode..'\\cr\n'
    str = str..' Spell Tier:\\cs(128,128,255)   '..Spell_Tier..'\\cr\n'
    str = str..' crl: \\cs(255,64,64)[FIR]\\cr   \\cs(0,255,0)[WND]\\cr   \\cs(180,0,255)[THD]\\cr\n'
    str = str..' alt: \\cs(128,255,255)[ICE]\\cr   \\cs(165,100,40)[STN]\\cr   \\cs(64,128,255)[WTR]\\cr\n'
    return str
end

-- Edit the "x" and "y" positions below to change the default position of the job box.
gearswap_box_config = { pos={x=1320,y=550}, padding=8, text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},}, bg={alpha=0}, flags={} }
gearswap_jobbox = texts.new(gearswap_box_config)

----------------------------------------------------------------------
--                           USER SETUP
----------------------------------------------------------------------
function user_setup()
    ------------------------------------------------------------------
    --                           KEYBINDS
    ------------------------------------------------------------------
    -- Mode switching
    send_command('bind numpad9 gs c ToggleNormal')    -- Normal
	send_command('bind numpad8 gs c ToggleTank')    -- Tank
    send_command('bind numpad3 gs c ToggleBurst')   -- Burst / Freecast
	send_command('bind numpad7 gs c ToggleMP')		-- On / Off 
	send_command('bind numpad6 gs c ToggleOccult')	 -- On / Off 

    -- Tier system
    send_command('bind numpad4 gs c TierDown')      -- Lower tier
    send_command('bind numpad5 gs c TierUp')        -- Raise tier

	--QOL shortcuts
	send_command('bind numpad0 input /ws "Myrkr" <me>')
	send_command('bind ^numpad0 input /ma "Burn" <t>')
	send_command('bind !numpad0 input /ma "Impact" <t>')

    -- Ctrl row (Fire / Wind / Thunder)
    send_command('bind ^numpad1 gs c casttier fire')
    send_command('bind ^numpad2 gs c casttier aero')
    send_command('bind ^numpad3 gs c casttier thunder')

    -- Alt row (Ice / Stone / Water)
    send_command('bind !numpad1 gs c casttier blizzard')
    send_command('bind !numpad2 gs c casttier stone')
    send_command('bind !numpad3 gs c casttier water')

    -- Ctrl row (Firaja / Aeroja / Thundaja)
    send_command('bind ^numpad4 input /ma "Firaja" <t>')
    send_command('bind ^numpad5 input /ma "Aeroja" <t>')
    send_command('bind ^numpad6 input /ma "Thundaja" <t>')

    -- Alt row (Blizzaja / Stoneja / Waterja)
    send_command('bind !numpad4 input /ma "Blizzaja" <t>')
    send_command('bind !numpad5 input /ma "Stoneja" <t>')
    send_command('bind !numpad6 input /ma "Waterja" <t>')

    -- Items (optional)
    send_command('bind f9 input /item "Remedy" <me>')
    send_command('bind f10 input /item "Panacea" <me>')
    send_command('bind f11 input /item "Holy Water" <me>')

    ------------------------------------------------------------------
    --                           INITIALIZATION
    ------------------------------------------------------------------
    gearswap_jobbox:text(gearswap_box())
    gearswap_jobbox:show()
end

----------------------------------------------------------------------
--                           SETS / GEAR
----------------------------------------------------------------------
function get_sets()
	sets.idle = {}    		--leave this empty              
    sets.precast = {}  		--leave this empty                
    sets.midcast = {}    	--leave this empty             
    sets.aftercast = {}		--leave this empty             
	sets.ws = {}			--leave this empty	
	sets.ja = {}			--leave this empty			
	sets.items = {}			--leave this empty	

    --------------------------------------------------------------
    --                      IDLE / TANK (put your weapons/grips in these sets)
    --------------------------------------------------------------
    sets.idle.normal = {
		main="Marin Staff +1",
		sub="Enki Strap",
		ammo="Staunch Tathlum +1",
		head="Wicce Petasos +2",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Herald's Gaiters",
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Shadow Ring",
		right_ring="Defending Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
    }

    sets.idle.tank = {
		main="Kaumodaki",
		sub="Enki Strap",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear="Hearty Earring",
		left_ring="Shadow Ring",
		right_ring="Defending Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
    }
	
    --------------------------------------------------------------
    --                      PRECAST
    --------------------------------------------------------------
    sets.precast.fastcast = {
		ammo="Sapience Orb",
		head={ name="Merlinic Hood", augments={'Accuracy+10','"Fast Cast"+6','"Mag.Atk.Bns."+9',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+26','"Fast Cast"+6','MND+6',}},
		hands="Agwu's Gages",
		legs="Agwu's Slops",
		feet={ name="Merlinic Crackows", augments={'"Mag.Atk.Bns."+6','"Fast Cast"+6','Mag. Acc.+13',}},
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Malignance Earring",
		left_ring="Lebeche Ring",
		right_ring="Kishar Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
    }
	
	sets.precast.impact = set_combine(sets.precast.fastcast,{
		head=empty,
		body="Twilight Cloak",
	})

    --------------------------------------------------------------
    --                      MIDCAST
    --------------------------------------------------------------
	--trust
	sets.midcast.trust = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}
	
	--Occult acumen
		sets.midcast.occult = {
		ammo="Seraphic Ampulla",
		head="Mall. Chapeau +2",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+5','"Occult Acumen"+11','CHR+1',}},
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+29','"Occult Acumen"+11','CHR+3','"Mag.Atk.Bns."+12',}},
		legs="Perdition Slops",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+6 "Mag.Atk.Bns."+6','"Occult Acumen"+11','INT+5','Mag. Acc.+1',}},
		neck="Null Loop",
		waist="Oneiros Rope",
		left_ear="Crep. Earring",
		right_ear="Telos Earring",
		left_ring="Crepuscular Ring",
		right_ring="Chirich Ring +1",
		back="Null Shawl",
	}
	
    -- Elemental Magic sets
    sets.midcast.elementalBurst = {
		ammo="Ghastly Tathlum +1",
		head="Ea Hat +1",
		body="Ea Houppe. +1",
		hands="Spae. Gloves +3",
		legs="Ea Slops +1",
		feet="Ea Pigaches +1",
		neck="Mizu. Kubikazari",
		waist="Skrymir Cord",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Freke Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
    }

	sets.midcast.elementalBurstMana = set_combine(sets.midcast.elementalBurst, {body="Spaekona's Coat +3",})
	sets.midcast.elementalBurstOBI = set_combine(sets.midcast.elementalBurst, {waist="Hachirin-no-Obi",})
	sets.midcast.elementalBurstManaOBI = set_combine(sets.midcast.elementalBurstOBI, {body="Spaekona's Coat +3",})
	
    sets.midcast.elementalFreecast = {
		ammo="Sroda Tathlum",
		head="Wicce Petasos +2",
		body="Spaekona's Coat +3",
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs="Wicce Chausses +2",
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Sibyl Scarf",
		waist="Skrymir Cord",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Freke Ring",
		right_ring="Metamor. Ring +1",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},
    }

	sets.midcast.elementalFreecastMana = set_combine(sets.midcast.elementalFreecast, {body="Spaekona's Coat +3",})
	sets.midcast.elementalFreecastOBI = set_combine(sets.midcast.elementalFreecast, {waist="Hachirin-no-Obi",})
	sets.midcast.elementalFreecastManaOBI = set_combine(sets.midcast.elementalFreecastOBI, {body="Spaekona's Coat +3",})

	-- Elemental Debuffs
	sets.midcast.eleDebuff = {
		ammo="Pemphredo Tathlum",
		head="Wicce Petasos +2",
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		legs="Spae. Tonban +3",
		feet="Spae. Sabots +3",
		-- ########### Need to get Relic legs and feet in here.
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Malignance Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Aurist's Cape +1",
	}
	
	--enfeebling
	sets.midcast.enfeeble = {
		ammo="Pemphredo Tathlum",
		head="Spae. Petasos +3",
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		legs="Wicce Chausses +2",
		feet="Spae. Sabots +3",
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Malignance Earring",
		right_ear={ name="Wicce Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Enmity-1',}},
		left_ring="Stikini Ring +1",
		right_ring="Kishar Ring",
		back="Aurist's Cape +1",
	}
	
	--impact
	sets.midcast.impact = set_combine(sets.midcast.enfeeble,{
		head=empty,
		body="Twilight Cloak",
	})
	
	--death
	sets.midcast.death = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet="Agwu's Pigaches",
		neck="Null Loop",
		waist="Luminary Sash",
		left_ear="Malignance Earring",
		right_ear={ name="Wicce Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Enmity-1',}},
		left_ring="Archon Ring",
		right_ring="Mephitas's Ring +1",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10','Spell interruption rate down-10%',}},		
	}
	
	--aspir/drain
	sets.midcast.aspir = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body="Spaekona's Coat +3",
		hands="Spae. Gloves +3",
		legs="Spae. Tonban +3",
		feet="Agwu's Pigaches",
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Hirudinea Earring",
		right_ear={ name="Wicce Earring +1", augments={'System: 1 ID: 1676 Val: 0','Mag. Acc.+11','Enmity-1',}},
		left_ring="Archon Ring",
		right_ring="Evanescence Ring",
		back="Aurist's Cape +1",
	}
	
	-- Stun enmity based
	sets.midcast.stunEnmity = {
		ammo="Sapience Orb",
		head="Wicce Petasos +2",
		body="Wicce Coat +2",
		hands="Spae. Gloves +3",
		legs="Wicce Chausses +2",
		feet="Spae. Sabots +3",
		neck="Unmoving Collar +1",
		waist="Null Belt",
		left_ear="Trux Earring",
		right_ear="Friomisi Earring",
		left_ring="Petrov Ring",
		right_ring="Eihwaz Ring",
		back="Null Shawl",
	}
	
	--enhancing
	sets.midcast.enhance = {
		main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+6','"Mag.Atk.Bns."+15',}},
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Mimir Earring",
		right_ear="Magnetic Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Aurist's Cape +1",
	}

	-- Healing
		sets.midcast.heal = {
		ammo="Ombre Tathlum +1",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Vrikodara Jupon",
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
		legs="Doyen Pants",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Mendi. Earring",
		right_ear="Regal Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Aurist's Cape +1",
	}
	----------------------------------------------------------------------
	--                           JOB ABILITY SETS
	----------------------------------------------------------------------
	sets.ja.manawall = {
		main="Kaumodaki",
		--empy feet
	}
	
	sets.ja.manafont = {
		--relic body
	}
	
	sets.ja.sublimation = {
		waist="Embla Sash",
	}
	----------------------------------------------------------------------
	--                           WEAPONSKILL SETS
	----------------------------------------------------------------------
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
		back="Aurist's Cape +1",
	}
	
	sets.ws.myrkr = {
		ammo="Ghastly Tathlum +1",
		head={ name="Amalric Coif +1", augments={'MP+80','INT+12','Enmity-6',}},
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands="Spae. Gloves +3",
		legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		feet={ name="Psycloth Boots", augments={'MP+50','INT+7','"Conserve MP"+6',}},
		neck="Dualism Collar +1",
		waist="Luminary Sash",
		left_ear="Etiolation Earring",
		right_ear="Moonshade Earring",
		left_ring="Mephitas's Ring +1",
		right_ring="Mephitas's Ring",
		back={ name="Taranus's Cape", augments={'MP+60','Eva.+20 /Mag. Eva.+20','"Fast Cast"+10','Damage taken-5%',}},
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
    if Player_Mode == "Tank" then
        equip(sets.idle.tank)
    else
		equip(sets.idle.normal)
    end
end

function precast(spell)
    if spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "BardSong" or spell.type == "Trust" then 
		if spell.english == "Impact" then
			equip(sets.precast.impact)
		else
			equip(sets.precast.fastcast)
		end
    elseif spell.type == "WeaponSkill" then
		if spell.english == "Myrkr" then
			equip(sets.ws.myrkr)
		else
			equip(sets.ws.normal)
		end
	elseif spell.type == "JobAbility" then
		if spell.english == "Mana Wall" then
			equip(sets.ja.manawall)
		elseif spell.english == "Manafont" then
			equip(sets.ja.manafont)
		elseif spell.english == "Sublimation" then
			equip(sets.ja.sublimation)
		end
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	else
        idle()
    end
end

function midcast(spell)
    if spell.skill == "Elemental Magic" then
		if spell.name:match('Shock') or spell.name:match('Rasp') or spell.name:match('Choke') or spell.name:match('Frost')
		or spell.name:match('Burn') or spell.name:match('Drown') then
			equip(sets.midcast.eleDebuff)
		elseif spell.english == "Impact" then
			equip(sets.midcast.impact)
		else
			if Occult_Mode == "On" then
				equip(sets.midcast.occult)
			else
				if Casting_Mode == "Burst" then
					if spell.element == world.day_element or spell.element == world.weather_element then
						if MP_Mode == "On" then
							equip(sets.midcast.elementalBurstManaOBI)
						else
							equip(sets.midcast.elementalBurstOBI)
						end
					else
						if MP_Mode == "On" then
							equip(sets.midcast.elementalBurstMana)
						else
							equip(sets.midcast.elementalBurst)
						end
					end
				elseif Casting_Mode == "Freecast" then
					if spell.element == world.day_element or spell.element == world.weather_element then
						if MP_Mode == "On" then
							equip(sets.midcast.elementalFreecastManaOBI)
						else
							equip(sets.midcast.elementalFreecastOBI)
						end
					else
						if MP_Mode == "On" then
							equip(sets.midcast.elementalFreecastMana)
						else
							equip(sets.midcast.elementalFreecast)
						end
					end
				end
			end
		end
	elseif spell.skill == "Dark Magic" then
		if spell.name:match('Drain') or spell.name:match('Aspir') then
			equip(sets.midcast.aspir)
		elseif spell.name:match('Death') then
			equip(sets.midcast.death)
		elseif spell.name:match('Stun') then
			if Player_Mode == "Tank" then
				equip(sets.midcast.stunEnmity)
			else
				equip(sets.midcast.enfeeble)
			end
		else
			equip(sets.midcast.enfeeble)
		end
	elseif spell.skill == "Enfeebling Magic" then
		equip(sets.midcast.enfeeble)
	elseif spell.skill == "Enhancing Magic" then
		equip(sets.midcast.enhance)
	elseif spell.skill == "Healing Magic" then
		equip(sets.midcast.heal)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	elseif spell.type == "Trust" then
		equip(sets.midcast.trust)
	end
end

function aftercast()
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
--                      SPELL TIER CASTING LOGIC
----------------------------------------------------------------------
local res = require('resources')

function cast_element_tier(element)
    local tiers = {
        fire     = {"Fire", "Fire II", "Fire III", "Fire IV", "Fire V", "Fire VI"},
        aero     = {"Aero", "Aero II", "Aero III", "Aero IV", "Aero V", "Aero VI"},
        thunder  = {"Thunder", "Thunder II", "Thunder III", "Thunder IV", "Thunder V", "Thunder VI"},
        blizzard = {"Blizzard", "Blizzard II", "Blizzard III", "Blizzard IV", "Blizzard V", "Blizzard VI"},
        stone    = {"Stone", "Stone II", "Stone III", "Stone IV", "Stone V", "Stone VI"},
        water    = {"Water", "Water II", "Water III", "Water IV", "Water V", "Water VI"},
    }

    element = element:lower()
    local list = tiers[element]
    if not list then return end

    local desired_tier = Spell_Tier

    local recasts = windower.ffxi.get_spell_recasts()

    for tier = desired_tier, 1, -1 do
        local spell_name = list[tier]
        local spell = res.spells:with('name', spell_name)

        if spell then
            local id = spell.id
            if recasts[id] == 0 then
                send_command('input /ma "'..spell_name..'" <t>')
                return
            end
        end
    end

    local fallback = list[1]
    send_command('input /ma "'..fallback..'" <t>')
end

----------------------------------------------------------------------
--                           COMMANDS & TIER LOGIC
----------------------------------------------------------------------
function self_command(cmd)
    if cmd == "ToggleNormal" then
        Player_Mode = "Normal"
		idle()
	elseif cmd == "ToggleTank" then
		Player_Mode = "Tank"
		send_command('input /ja "Mana Wall" <me>') 
    elseif cmd == "ToggleBurst" then
        if Casting_Mode == "Burst" then
            Casting_Mode = "Freecast"
        else
            Casting_Mode = "Burst"
        end
	elseif cmd == "ToggleMP" then
        if MP_Mode == "On" then
            MP_Mode = "Off"
        else
            MP_Mode = "On"
        end
	elseif cmd == "ToggleOccult" then
        if Occult_Mode == "On" then
			Occult_Mode = "Off"
        else
			Occult_Mode = "On"
        end
    elseif cmd == "TierDown" then
        Spell_Tier = math.max(Min_Tier, Spell_Tier - 1)
    elseif cmd == "TierUp" then
        Spell_Tier = math.min(Max_Tier, Spell_Tier + 1)
    elseif cmd:startswith("casttier") then
        local element = cmd:match("casttier (%a+)")
        if element then
            cast_element_tier(element)
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