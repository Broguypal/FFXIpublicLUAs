--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
--WHM LUA

----------------- MODES / UI TEXT BOX -----------------------------
Player_Mode = "Normal"
Casting_Mode = "Normal"
Weapon_Mode = "Unlocked"

Player_Modes = {'Normal','DT'}
Casting_Modes = {'Normal','SIR'}
Weapon_Modes = {'Unlocked','Locked'}

gearswap_box = function()
  str = '           \\cs(255,255,255)WHITE MAGE\\cr\n'
  str = str..' Player Mode:\\cs(255,150,100)   '..Player_Mode..'\\cr\n'
  str = str..' Weapon Lock:\\cs(200,100,100)   '..Weapon_Mode..'\\cr\n'
  str = str..' Casting Mode:\\cs(255,0,100)   '..Casting_Mode..'\\cr\n'
  str = str..' crl: \\cs(255,255,255)[ERASE]\\cr \\cs(80,60,100)[CRSE] \\cr \\cs(255,255,255)[ESUNA]\\cr\n'
  str = str..' crl: \\cs(128,255,255)[PARA]\\cr \\cs(0,255,0)[SLNC]\\cr \\cs(80,60,100)[BLND]\\cr\n'
  str = str..' alt: \\cs(165,100,40)[STON]\\cr \\cs(64,128,255)[PSN]\\cr \\cs(255,64,64)[VIRU]\\cr\n'
    return str
end

gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

function get_sets()
--Mode Commands
	send_command('bind numpad9 gs c ToggleMode')
	send_command('bind numpad3 gs c ToggleSpell')
	send_command('bind numpad6 gs c ToggleWeapons')
	
--Spell Commands
	send_command ('bind numpad1 input /ma "Erase" <stal>')
	send_command ('bind numpad2 input /ma "Cursna" <stal>')
	send_command ('bind numpad3 input /ma "Esuna" <me>')
	send_command ('bind ^numpad1 input /ma "Paralyna" <stal>')
	send_command ('bind ^numpad2 input /ma "Silena" <stal>')
	send_command ('bind ^numpad3 input /ma "Blindna" <stal>')
	send_command ('bind !numpad1 input /ma "Stona" <stal>')
	send_command ('bind !numpad2 input /ma "Poisana" <stal>')
	send_command ('bind !numpad3 input /ma "Viruna" <stal>')
	
-- Gearsets --
    sets.weapons = {}
	sets.idle = {}                  
    sets.precast = {}                  
    sets.midcast = {}                 
    sets.aftercast = {}             
	sets.ws = {}					
	sets.ja = {}					
	sets.misc = {}					
 
 ---- WEAPON SETS ----
	sets.weapons.Idle = {main="Daybreak", sub="Genmei Shield",}
	sets.weapons.Engaged = {main="Maxentius", sub="Genmei Shield",}
	sets.weapons.Dualwield = {main="Maxentius", sub="C. Palug Hammer",}
	sets.weapons.FastCast = {main="C. Palug Hammer", sub="Chanter's Shield",}
	sets.weapons.Curing = {main={ name="Queller Rod", augments={'Healing magic skill +15','"Cure" potency +10%','"Cure" spellcasting time -7%',}}, sub="Sors Shield",}
	sets.weapons.CuringAurorastorm = {main="Chatoyant Staff", sub="Thrace Strap",}
	sets.weapons.StatusRemoval = {main="Yagrush",}
	sets.weapons.Enhancing = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+6','"Mag.Atk.Bns."+15',}}, sub="Ammurapi Shield",}
	sets.weapons.Enfeebling = {main={ name="Gada", augments={'Enh. Mag. eff. dur. +5','Mag. Acc.+6','"Mag.Atk.Bns."+15',}}, sub="Ammurapi Shield",}
	sets.weapons.Nuking = {main="Daybreak", sub="Ammurapi Shield"}
	sets.weapons.SIR = {main="Daybreak", sub="Culminus",}
 
 ---- IDLE SETS ----
    sets.idle.Normal = {
		ammo="Homiliary",
		head="Befouled Crown",
		body="Shamash Robe",
		hands="Ebers Mitts +2",
		legs="Ebers Pant. +2",
		feet="Herald's Gaiters",
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Shadow Ring",
		right_ring="Defending Ring",
		back={ name="Alaunus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Damage taken-5%',}},
	}
	sets.idle.NormalWeapons = set_combine(sets.idle.Normal, sets.weapons.Idle)
	
	sets.idle.Engaged = {
		ammo="Amar Cluster",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Bunzi's Gloves",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Combatant's Torque",
		waist="Cetl Belt",
		left_ear="Telos Earring",
		right_ear="Crep. Earring",
		left_ring="Ilabrat Ring",
		right_ring="Fickblix's Ring",
		back="Null Shawl",
	}
	sets.idle.EngagedWeapons = set_combine(sets.idle.Engaged,sets.weapons.Engaged)
	
	sets.idle.Dualwield = set_combine(sets.idle.Engaged,{
	    left_ear="Eabani Earring",
		right_ear="Suppanomimi",
	})
	sets.idle.DualwieldWeapons = set_combine(sets.idle.Dualwield, sets.weapons.Dualwield)
	
	sets.idle.Tank = {
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets", 
		neck="Sibyl Scarf",
		waist="Carrier's Sash",
		left_ear="Etiolation Earring",
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Shadow Ring",
		right_ring="Defending Ring",
		back={ name="Alaunus's Cape", augments={'AGI+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Enmity-10','Damage taken-5%',}},
	}
	sets.idle.TankWeapons = set_combine(sets.idle.Tank, sets.weapons.Idle)

 ---- PRECAST SETS ----
    sets.precast.FastCast = {
		ammo="Sapience Orb",
		head="Ebers Cap +2",
		body="Inyanga Jubbah +2",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
		legs={ name="Kaykaus Tights +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		feet="Regal Pumps +1",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Etiolation Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	sets.precast.FastCastWeapons = set_combine(sets.precast.FastCast,sets.weapons.FastCast)
	
	sets.precast.Dispelga = set_combine(sets.precast.FastCast, {main="Daybreak",})
	sets.precast.DispelgaWeapons = set_combine(sets.precast.FastCastWeapons, {main="Daybreak",})
	
	sets.precast.Cure = {
		ammo="Sapience Orb",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Inyanga Jubbah +2",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
		legs="Ebers Pant. +2",
		feet="Regal Pumps +1",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Mendi. Earring",
		right_ear="Malignance Earring",
		left_ring="Kishar Ring",
		right_ring="Lebeche Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	sets.precast.CureWeapons = set_combine(sets.precast.Cure, sets.weapons.Curing)
	
 ---- MIDCAST SETS ----	
	--Cure
	sets.midcast.Cure = {
		ammo="Pemphredo Tathlum",
		head={ name="Kaykaus Mitra +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		body="Vrikodara Jupon",
		hands={ name="Kaykaus Cuffs +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		legs="Ebers Pant. +2",
		feet={ name="Kaykaus Boots +1", augments={'MP+80','"Cure" spellcasting time -7%','Enmity-6',}},
		neck="Clr. Torque +1",
		waist="Luminary Sash",
		left_ear="Mendi. Earring",
		right_ear="Glorious Earring",
		left_ring="Sirona's Ring",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	sets.midcast.CureWeapons = set_combine(sets.midcast.Cure, sets.weapons.Curing)
	sets.midcast.CureAurorastorm = set_combine(sets.midcast.cure,{waist="Hachirin-no-Obi",})
	sets.midcast.CureAurorastormWeapons = set_combine(CureAurorastorm, sets.weapons.CuringAurorastorm)
	
	sets.midcast.Curaga = set_combine(sets.midcast.Cure,{
	--twilight cape
	--theo body/gloves
	})
	sets.midcast.CuragaWeapons = set_combine(sets.midcast.Curaga, sets.weapons.Curing)
	sets.midcast.CuragaAurorastorm = set_combine(sets.midcast.Curaga,{waist="Hachirin-no-Obi",})
	sets.midcast.CuragaAurorastormWeapons = set_combine(sets.midcast.CuragaAurorastorm, sets.weapons.Curing)
	
	--Status Removal
	sets.midcast.EraseNA = {
		head="Ebers Cap +2",
		neck="Clr. Torque +1",
		back="Mending Cape",
	}
	sets.midcast.EraseNAWeapons = set_combine(sets.midcast.EraseNA, sets.weapons.StatusRemoval)
	
	sets.midcast.DivineCaress = set_combine(sets.midcast.EraseNA,{
		hands="Ebers Mitts +2", 
		back="Mending Cape",
	})
	sets.midcast.DivineCaressWeapons = set_combine(sets.midcast.DivineCaress, sets.weapons.StatusRemoval)
	
	sets.midcast.Cursna = {
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Ebers Bliaut +2",
		hands={ name="Fanatic Gloves", augments={'MP+50','Healing magic skill +10','"Conserve MP"+7','"Fast Cast"+7',}},
		--theophany pants
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nicander's Necklace",
		--Deblis medalian (neck)
		--Bishops Sash 
		--Meili earring
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Haoma's Ring",
		right_ring="Menelaus's Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	sets.midcast.CursnaWeapons = set_combine(sets.midcast.Cursna, sets.weapons.StatusRemoval)
	
	--Enhancing
	sets.midcast.EnhanceSkill = {
		ammo="Staunch Tathlum +1",
		head="Befouled Crown",
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
		hands="Inyan. Dastanas +2",
		legs={ name="Telchine Braconi", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		--Piety legs
		feet="Ebers Duckbills +2",
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Mimir Earring",
		right_ear="Malignance Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	}
	sets.midcast.EnhanceSkillWeapons = set_combine(sets.midcast.EnhanceSkill, sets.weapons.Enhancing)
	
	sets.midcast.EnhanceDuration = {
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
		hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
		waist="Embla Sash",
	}
	sets.midcast.EnhanceDurationWeapons = set_combine(sets.midcast.EnhanceDuration, sets.weapons.Enhancing)
	
	sets.midcast.Stoneskin = set_combine(sets.midcast.EnhanceSkill,{
		neck="Nodens Gorget",
		waist="Siegel Sash",
	})
	sets.midcast.StoneskinWeapons = set_combine(sets.midcast.Stoneskin, sets.weapons.Enhancing)
	
	sets.midcast.Aquaveil = set_combine(sets.midcast.EnhanceSkill,{
		--chironic hat
		body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back="Mending Cape",
		--Note: Add +6 aquaveil to cape when have a chance
	})
	sets.midcast.AquaveilWeapons = set_combine(sets.midcast.Aquaveil, sets.weapons.Enhancing)
	
	sets.midcast.BarSpells = set_combine(sets.midcast.EnhanceSkill,{
		head="Ebers Cap +2",
		body="Ebers Bliaut +2",
		hands="Ebers Mitts +2",
		legs="Ebers Pant. +2",
		--piety pants
		feet="Ebers Duckbills +2",
		neck="Incanter's Torque",
		--andoaa earring
		left_ear="Mimir Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
	})
	sets.midcast.BarSpellsWeapons = set_combine(sets.midcast.BarSpells, sets.weapons.Enhancing)
	
	sets.midcast.Regen = set_combine(sets.midcast.EnhanceDuration,{
	    head="Inyanga Tiara +2",
		hands="Ebers Mitts +2",
		waist="Embla Sash",
		--[[Need Piety chest badly. Followed by theo pants and duckbills(feet)]]
	})
	sets.midcast.RegenWeapons = set_combine(sets.midcast.Regen, sets.weapons.Enhancing)
	
	--Enfeebling
	sets.midcast.Enfeeble = {
		ammo="Hydrocera",
		head="Befouled Crown",
		body="Ebers Bliaut +2",
		hands="Inyan. Dastanas +2",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','MND+6','Mag. Acc.+13',}},
		feet="Ebers Duckbills +2",
		neck="Null Loop",
		waist="Obstin. Sash",
		left_ear="Malignance Earring",
		right_ear={ name="Ebers Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+12','Mag. Acc.+12','Damage taken-4%',}},
		left_ring="Kishar Ring",
		right_ring="Stikini Ring +1",
		back="Aurist's Cape +1",
	}
	sets.midcast.EnfeebleWeapons = set_combine(sets.midcast.Enfeeble, sets.weapons.Enfeeling)
	
	sets.midcast.Dispelga = set_combine(sets.midcast.Enfeeble, {main="Daybreak",})
	sets.midcast.DispelgaWeapons = set_combine(sets.midcast.EnfeebleWeapons, {main="Daybreak",})
	
	--Nuking
	sets.midcast.Repose = {}
	sets.midcast.ReposeWeapons = set_combine(sets.midcast.Repose, sets.weapons.Nuking)
	
	sets.midcast.Banish = {}
	sets.midcast.BanishWeapons = set_combine(sets.midcast.Banish, sets.weapons.Nuking)
	
	sets.midcast.Holy = {}
	sets.midcast.HolyWeapons = set_combine(sets.midcast.Holy, sets.weapons.Nuking)
	
	sets.midcast.Elemental = {}
	sets.midcast.ElementalWeapons = set_combine(sets.midcast.Elemental, sets.weapons.Nuking)
	
	--SIR
	sets.midcast.SIR = {
		ammo="Staunch Tathlum +1",
		head={ name="Telchine Cap", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		body="Shamash Robe",
		hands="Ebers Mitts +2",
		legs={ name="Telchine Braconi", augments={'Spell interruption rate down -10%','Enh. Mag. eff. dur. +10',}},
		feet="Nyame Sollerets",
		neck="Loricate Torque +1",
		waist="Carrier's Sash",
		left_ear="Halasz Earring",
		right_ear="Magnetic Earring",
		left_ring="Evanescence Ring",
		right_ring="Defending Ring",
		back={ name="Alaunus's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','MND+10','"Fast Cast"+10','Spell interruption rate down-10%',}},
		--Note SIR is currently only 74% with weapons. will need to improve later.
	}
	sets.midcast.SIRWeapons = set_combine(sets.midcast.SIR, sets.weapons.SIR)
	
	
 ---- JOB ABILITY SETS ----
	sets.ja.Solace = {}
	sets.ja.Misery = {}
	sets.ja.Martyr = {}
	sets.ja.Benediction = {}
	sets.ja.Devotion = {}
	
 ---- WEAPONSKILL SETS ----
	sets.ws.Normal = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",
	}
	sets.ws.HexaStrike = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Brutal Earring",
		left_ring="Begrudging Ring",
		right_ring="Fickblix's Ring",
		back="Null Shawl",
	}
	sets.ws.MysticBoon = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",
	}
	sets.ws.BlackHalo = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",
	}
	sets.ws.Realmrazer = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Mache Earring +1",
		right_ear="Malignance Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",
	}
	
	sets.ws.Randgirth = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Telos Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Fickblix's Ring",
		back="Null Shawl",
	}
	sets.ws.FlashNova = {
		ammo="Oshasha's Treatise",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		left_ear="Moonshade Earring",
		right_ear="Friomisi Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Metamor. Ring +1",
		back="Aurist's Cape +1",
	}
 ---- MISC SETS ----
	sets.misc.Trust = {
		head="Nyame Helm",
		body="Shamash Robe",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets", 
	}
	
end


function idle()
	if Player_Mode == "DT" then
		if Weapon_Mode == "Locked" then
			equip(sets.idle.Tank)
		elseif Weapon_Mode == "Unlocked" then
			equip(sets.idle.TankWeapons)
		end
	else
		if player.status == "Engaged" then
			if Weapon_Mode == "Locked" then
				if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
					equip(sets.idle.Dualwield)
				else
					equip(sets.idle.Engaged)
				end
			elseif Weapon_Mode == "Unlocked" then
				if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
					equip(sets.idle.DualwieldWeapons)
				else
					equip(sets.idle.EngagedWeapons)
				end
			end
		else
			if Weapon_Mode == "Locked" then
				equip(sets.idle.Normal)
			elseif Weapon_Mode == "Unlocked" then
				equip(sets.idle.NormalWeapons)
			end
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
	if spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then 
		if Weapon_Mode == "Locked" then
			if spell.name:match('Cure') or spell.name:match('Cura') or spell.name:match('Curaga') or spell.english == "Full Cure" then
				equip(sets.precast.Cure)
			elseif spell.name:match('Dispelga') then
				equip(sets.precast.Dispelga)
			else
				equip(sets.precast.FastCast)
			end
		elseif Weapon_Mode == "Unlocked" then
			if spell.name:match('Cure') or spell.name:match('Cura') or spell.name:match('Curaga') or spell.english == "Full Cure" then
				equip(sets.precast.CureWeapons)
			elseif spell.name:match('Dispelga') then
				equip(sets.precast.DispelgaWeapons)
			else
				equip(sets.precast.FastCastWeapons)
			end
		end
	elseif spell.type == "WeaponSkill" then
		if spell.english == "Hexa Strike" then
			equip(sets.ws.HexaStrike)
		elseif spell.english == "Mystic Boon" then
			equip(sets.ws.MysticBoon)
		elseif spell.english == "Black Halo" then
			equip(sets.ws.BlackHalo)
		elseif spell.english == "Realmrazer" then
			equip(sets.ws.Realmrazer)
		elseif spell.english == "Randgirth" then
			equip(sets.ws.Randgirth)
		elseif spell.english == "Flash Nova" or spell.english == "Seraph Strike" then
			equip(sets.ws.FlashNova)
		else
			equip(sets.ws.Normal)
		end
	else
		idle()
	end
end

function midcast(spell)
	if Casting_Mode == "SIR" then
		if Weapon_Mode == "Locked" then
			equip(sets.midcast.SIR)
		elseif Weapon_Mode == "Unlocked" then
			equip(sets.midcast.SIRWeapons)
		end
	else
		if Weapon_Mode == "Locked" then
			if spell.skill == "Healing Magic" then
				if spell.name:match('Cure') or spell.english == "Full Cure" then
					if buffactive["Aurorastorm"] then
						equip(sets.midcast.CureAurorastorm)
					else
						equip(sets.midcast.Cure)
					end
				elseif spell.name:match('Cura') or spell.name:match('Curaga') then
					if buffactive["Aurorastorm"] then
						equip(sets.midcast.CuragaAurorastorm)
					else
						equip(sets.midcast.Curaga)
					end
				elseif spell.name:match('Raise') or spell.name:match('Reraise') or spell.name:match('Arise') then
					equip(sets.precast.FastCast)
				elseif spell.name:match('Poisona') or spell.name:match('Paralyna') or spell.name:match('Blindna') or
				spell.name:match('Silena') or spell.name:match('Stona') or spell.name:match('Viruna') or spell.name:match('Esuna') then
					if buffactive['Divine Caress'] then
						equip(sets.midcast.DivineCaress)
					else
						equip(sets.midcast.EraseNA)
					end
				end
			elseif spell.skill == "Enhancing Magic" then
				if spell.name:match('Erase') then
					equip(sets.midcast.EraseNA)
				elseif spell.name:match('Protect') or spell.name:match('Protectra') or spell.name:match('Shell') or spell.name:match('Shellra') or 
				spell.name:match('Blink') or spell.name:match('Haste') or spell.name:match('Auspice') or spell.name:match('Sandstorm') or
				spell.name:match('Rainstorm') or spell.name:match('Windstorm') or spell.name:match('Firestorm') or spell.name:match('Hailstorm') or
				spell.name:match('Thunderstorm') or spell.name:match('Voidstorm') or spell.name:match('Aurorastorm') or spell.name:match('Sneak') or 
				spell.name:match('Invisible') or spell.name:match('Deodorize') or spell.name:match('Animus') or spell.name:match('Flurry') then
					equip(sets.midcast.EnhanceDuration)
				elseif spell.english:startswith('En') or spell.name:match('Phalanx') or spell.name:match('Refresh') or spell.english:startswith('Boost') then
					equip(sets.midcast.EnhanceSkill)
				elseif spell.name:match('Stoneskin') then
					equip(sets.midcast.Stoneskin)
				elseif spell.name:match('Aquaveil') then
					equip(sets.midcast.Aquaveil)
				elseif spell.english:startswith('Bar') then
					equip(sets.midcast.BarSpells)
				elseif spell.name:match('Regen') then
					equip(sets.midcast.Regen)
				elseif spell.english:startswith('Recall') or spell.english:startswith('Teleport') or spell.english:startswith('Retrace') or spell.name:match('Warp') or
				spell.name:match('Escape') or spell.name:match('Tractor') then
					equip(sets.precast.FastCast)
				end
			elseif spell.skill == "Enfeebling Magic" or spell.skill == "Dark Magic" then
				if spell.name:match('Dispelga') then
					equip(sets.midcast.Dispelga)
				else
					equip(sets.midcast.Enfeeble)
				end
			elseif spell.skill == "Divine Magic" then
				if spell.name:match('Repose') or spell.name:match('Flash') then
					equip(sets.midcast.Repose)
				elseif spell.name:match('Holy') then
					equip(sets.midcast.Holy)
				elseif spell.name:match('Banish') or spell.name:match('Banishga') then
					equip(sets.midcast.Banish)
				end
			elseif spell.skill == "Elemental Magic" or spell.skill == "Blue Magic" then 
				equip(sets.midcast.Elemental)
			elseif spell.skill == "Ninjutsu" then
				equip(sets.precast.FastCast)
			end	
		elseif Weapon_Mode == "Unlocked" then
			if spell.skill == "Healing Magic" then
				if spell.name:match('Cure') or spell.english == "Full Cure" then
					if buffactive["Aurorastorm"] then
						equip(sets.midcast.CureAurorastormWeapons)
					else
						equip(sets.midcast.CureWeapons)
					end
				elseif spell.name:match('Cura') or spell.name:match('Curaga') then
					if buffactive["Aurorastorm"] then
						equip(sets.midcast.CuragaAurorastormWeapons)
					else
						equip(sets.midcast.CuragaWeapons)
					end
				elseif spell.name:match('Raise') or spell.name:match('Reraise') or spell.name:match('Arise') then
					equip(sets.precast.FastCastWeapons)
				elseif spell.name:match('Poisona') or spell.name:match('Paralyna') or spell.name:match('Blindna') or
				spell.name:match('Silena') or spell.name:match('Stona') or spell.name:match('Viruna') or spell.name:match('Esuna') then
					if buffactive['Divine Caress'] then
						equip(sets.midcast.DivineCaressWeapons)
					else
						equip(sets.midcast.EraseNAWeapons)
					end
				end
			elseif spell.skill == "Enhancing Magic" then
				if spell.name:match('Erase') then
					equip(sets.midcast.EraseNAWeapons)
				elseif spell.name:match('Protect') or spell.name:match('Protectra') or spell.name:match('Shell') or spell.name:match('Shellra') or 
				spell.name:match('Blink') or spell.name:match('Haste') or spell.name:match('Auspice') or spell.name:match('Sandstorm') or
				spell.name:match('Rainstorm') or spell.name:match('Windstorm') or spell.name:match('Firestorm') or spell.name:match('Hailstorm') or
				spell.name:match('Thunderstorm') or spell.name:match('Voidstorm') or spell.name:match('Aurorastorm') or spell.name:match('Sneak') or 
				spell.name:match('Invisible') or spell.name:match('Deodorize') or spell.name:match('Animus') or spell.name:match('Flurry') then
					equip(sets.midcast.EnhanceDurationWeapons)
				elseif spell.english:startswith('En') or spell.name:match('Phalanx') or spell.name:match('Refresh') or spell.english:startswith('Boost') then
					equip(sets.midcast.EnhanceSkillWeapons)
				elseif spell.name:match('Stoneskin') then
					equip(sets.midcast.StoneskinWeapons)
				elseif spell.name:match('Aquaveil') then
					equip(sets.midcast.AquaveilWeapons)
				elseif spell.english:startswith('Bar') then
					equip(sets.midcast.BarSpellsWeapons)
				elseif spell.name:match('Regen') then
					equip(sets.midcast.RegenWeapons)
				elseif spell.english:startswith('Recall') or spell.english:startswith('Teleport') or spell.english:startswith('Retrace') or spell.name:match('Warp') or
				spell.name:match('Escape') or spell.name:match('Tractor') then
					equip(sets.precast.FastCastWeapons)
				end
			elseif spell.skill == "Enfeebling Magic" or spell.skill == "Dark Magic" then
				if spell.name:match('Dispelga') then
					equip(sets.midcast.DispelgaWeapons)
				else
					equip(sets.midcast.EnfeebleWeapons)
				end
			elseif spell.skill == "Divine Magic" then
				if spell.name:match('Repose') or spell.name:match('Flash') then
					equip(sets.midcast.ReposeWeapons)
				elseif spell.name:match('Holy') then
					equip(sets.midcast.HolyWeapons)
				elseif spell.name:match('Banish') or spell.name:match('Banishga') then
					equip(sets.midcast.BanishWeapons)
				end
			elseif spell.skill == "Elemental Magic" or spell.skill == "Blue Magic" then 
				equip(sets.midcast.ElementalWeapons)
			elseif spell.skill == "Ninjutsu" then
				equip(sets.precast.FastCastWeapons)
			end	
		end
	end	
end

function aftercast(spell)
	idle()
end

function self_command(command)
	if command == "ToggleMode" then
		if Player_Mode == "Normal" then
			Player_Mode = "DT"
			idle()
		elseif Player_Mode == "DT" then
			Player_Mode = "Normal"
			idle()
		end
	elseif command == "ToggleSpell" then
		if Casting_Mode == "Normal" then
			Casting_Mode = "SIR"
		elseif Casting_Mode == "SIR" then
			Casting_Mode = "Normal"
		end
	elseif command == "ToggleWeapons" then
		if Weapon_Mode == "Unlocked" then
			Weapon_Mode = "Locked"
		elseif Weapon_Mode == "Locked" then
			Weapon_Mode = "Unlocked"
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