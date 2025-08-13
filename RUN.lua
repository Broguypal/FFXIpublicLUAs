--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
--RUN LUA



---- 		Mode / Textbox settings 		----
tp_mode = 'Hybrid'
spell_mode = 'Normal'
auto_mode = 'Off'

tp_modes = {'Hybrid','DPS','AoETank','SingleTank','MagicEva','MagicAettir'}
spell_modes = {'Normal','SIR'}
auto_modes = {'On','Off'}

gearswap_box = function()
  str = '           \\cs(120,0,128)RUNE FENCER\\cr\n'
  str = str..' TP Mode:\\cs(255,150,100)   '..tp_mode..'\\cr\n'
  str = str..' Spell Mode:\\cs(255,150,100)   '..spell_mode..'\\cr\n'
  str = str..' Auto Runes:\\cs(255,150,100)   '..auto_mode..'\\cr\n'
str = str..' crl: \\cs(255,255,255)[LGT]\\cr \\cs(255,64,64)[FIR]\\cr \\cs(0,255,0)[WND]\\cr \\cs(180,0,255)[THD]\\cr\n'
str = str..' alt: \\cs(80,60,100)[DRK]\\cr \\cs(128,255,255)[ICE]\\cr \\cs(165,100,40)[STN]\\cr \\cs(64,128,255)[WTR]\\cr\n'    return str
end

gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

function get_sets()
----				KEYBINDS			----
	--Equipset toggles
	send_command('bind numpad9 gs c ToggleHybrid')
	send_command('bind numpad8 gs c ToggleTank')
	send_command('bind numpad7 gs c ToggleMagic')

	-- Spell interupt toggle
	send_command('bind numpad6 gs c ToggleSIR')

	-- Auto Runes toggle
	send_command('bind numpad0 gs c ToggleAUTO')

	send_command ('bind ^numpad1 input /ja "Ignis" <me>')
	send_command ('bind ^numpad2 input /ja "Flabra" <me>')
	send_command ('bind ^numpad3 input /ja "Sulpor" <me>')
	send_command ('bind ^numpad0 input /ja "Lux" <me>')
	send_command ('bind !numpad1 input /ja "Gelus" <me>')
	send_command ('bind !numpad2 input /ja "Tellus" <me>')
	send_command ('bind !numpad3 input /ja "Unda" <me>')
	send_command ('bind !numpad0 input /ja "Tenebrae" <me>')

	--weapon toggles
	send_command('bind numpad4 gs c ToggleWeapon')

	--QOL commands
	send_command ('bind numpad1 input /mount "Noble Chocobo"')
	send_command ('bind numpad2 input /dismount')
	send_command('bind f9 input /item "Remedy" <me>')
	send_command('bind f10 input /item "Panacea" <me>')
	send_command('bind f11 input /item "Holy Water" <me>')

--- 			EQUIPMENT SETS			----

-- Sets defined
    sets.idle = {}                  -- Leave this empty
	sets.engaged = {}
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.items = {}
	sets.main =	{}

---- 		Weapons used 		----
sets.main["Epeolatry"] = {main = "Epeolatry"}
sets.main["Lionheart"] = {main = "Lionheart"}
sets.main["Aettir"]    = {main = "Aettir"}
sets.main["Lycurgos"]  = {main = "Lycurgos"}

 ----			 Idle Sets				----
    sets.idle.normal = {
		sub="Utu Grip",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Runeist Coat +4",
		hands="Nyame Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Erilaz Greaves +3",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Warden's Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}

	sets.idle.aoetank = {
		main={ name="Epeolatry", augments={'Path: A',}},
		sub={ name="Refined Grip +1", augments={'Path: A',}},
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Erilaz Surcoat +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Erilaz Greaves +3",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		 left_ring="Warden's Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.idle.singletank = {
		main={ name="Epeolatry", augments={'Path: A',}},
		sub={ name="Refined Grip +1", augments={'Path: A',}},
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Runeist Coat +4",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Shadow Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},
	}
	
	sets.idle.magic = {
		main={ name="Epeolatry", augments={'Path: A',}},
		sub="Irenic Strap",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Runeist Coat +4",
		hands="Nyame Gauntlets",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Warder's Charm +1",
		waist="Engraved Belt",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Shadow Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
	
	sets.idle.magicaettir = set_combine(sets.idle.magic,{
		main={ name="Aettir", augments={'Accuracy+70','Mag. Evasion+50','Weapon skill damage +10%',}},
		})
	

	sets.idle.dualwield = {
		main="Naegling",
		sub="Reikiko",
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Runeist Coat +4",
		hands="Nyame Gauntlets",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Erilaz Greaves +3",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Warden's Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}

 ----			 Engaged Sets				----	
	sets.engaged.hybrid = {
		sub="Utu Grip",
		ammo="Coiste Bodhar",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Anu Torque",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
	
	sets.engaged.battuta = {
		sub={ name="Refined Grip +1", augments={'Path: A',}},
		ammo="Staunch Tathlum +1",
		head="Nyame Helm",
		body="Runeist Coat +4",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Turms Leggings +1",
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist="Engraved Belt",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},
	}
	
	sets.engaged.parry = {
		sub={ name="Refined Grip +1", augments={'Path: A',}},
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Runeist Coat +4",
		hands="Turms Mittens +1",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Warden's Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Enmity+10','Parrying rate+5%',}},
	}
	
	sets.engaged.dps = {
		sub="Utu Grip",
		ammo="Yamarang",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','"Triple Atk."+4',}},
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Epona's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	sets.engaged.dualwield = {
		main="Naegling",
		sub="Reikiko",
		ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Warder's Charm +1",
		waist="Reiki Yotai",
		left_ear="Suppanomimi",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
	
	sets.engaged.dualwielddps = {
		main="Naegling",
		sub="Reikiko",
		ammo="Yamarang",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Accuracy+18 Attack+18','"Triple Atk."+4',}},
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist="Reiki Yotai",
		left_ear="Sherida Earring",
		right_ear="Brutal Earring",
		left_ring="Epona's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

 ----			 Precast Sets				----	
    sets.precast.fastcast = {
		ammo="Sapience Orb",
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		body="Erilaz Surcoat +3",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Agwu's Slops",
		feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+8','"Fast Cast"+6','INT+9',}},
		neck="Voltsurge Torque",
		waist="Plat. Mog. Belt",
		left_ear="Tuisto Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Kishar Ring",
		right_ring="Rahab Ring",
		back={ name="Ogma's Cape", augments={'HP+60','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',}},
		}
		
	sets.precast.valiance = {
		ammo="Aqreqaq Bomblet",
		head="Nyame Helm",
		body="Runeist Coat +4",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Moonlight Necklace",
		waist="Plat. Mog. Belt",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Eihwaz Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','Enmity+10','Spell interruption rate down-10%',}},
		}	
		
	sets.precast.pulse = {
		head="Erilaz Galea +3",
		}
		
	sets.precast.battuta = {
		head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		}
		
	sets.precast.enmity = {
		ammo="Aqreqaq Bomblet",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Moonlight Necklace",
		waist="Plat. Mog. Belt",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Moonlight Ring",
		right_ring="Eihwaz Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','Enmity+10','Spell interruption rate down-10%',}},
		}
		
----			 Midcast Sets				----	
    sets.midcast.enmity = {
		ammo="Aqreqaq Bomblet",
		head="Halitus Helm",
		body="Emet Harness +1",
		hands="Kurys Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Eihwaz Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','Enmity+10','Spell interruption rate down-10%',}},
		}
		
    sets.midcast.SIR = {
		ammo="Staunch Tathlum +1",
		head="Erilaz Galea +3",
		body="Nyame Mail",
		hands="Rawhide Gloves",
		legs="Eri. Leg Guards +3",
		feet="Erilaz Greaves +3",
		neck="Moonlight Necklace",
		waist="Audumbla Sash",
		left_ear="Magnetic Earring",
		right_ear="Halasz Earring",
		left_ring="Evanescence Ring",
		right_ring="Moonlight Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','Enmity+10','Spell interruption rate down-10%',}},
		}
		
	sets.midcast.temper = set_combine(sets.midcast.SIR,{
		head={ name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		neck="Incanter's Torque",
		waist="Olympus Sash",
		left_ear="Mimir Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	})
		
	sets.midcast.phalanx = {
		ammo="Staunch Tathlum +1",
		head={ name="Fu. Bandeau +2", augments={'Enhances "Battuta" effect',}},
		body={ name="Taeon Tabard", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		hands={ name="Taeon Gloves", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		legs={ name="Taeon Tights", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		feet={ name="Taeon Boots", augments={'Spell interruption rate down -10%','Phalanx +3',}},
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring="Moonlight Ring",
		back="Moonbeam Cape",
		}
----			Item Sets						----
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}

----			 Weaponskill Sets				----	
	sets.ws.dimidiation = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Sherida Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
		}
		
	sets.ws.resolution = {
		ammo={ name="Coiste Bodhar", augments={'Path: A',}},
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Lustra. Leggings +1", augments={'Attack+20','STR+8','"Dbl.Atk."+3',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
		}
		
	sets.ws.savageblade = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Futhark Torque +1", augments={'Path: A',}},
		waist={ name="Sailfi Belt +1", augments={'Path: A',}},
		left_ear="Ishvara Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Epaminondas's Ring",
		right_ring="Sroda Ring",
		back={ name="Ogma's Cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','Weapon skill damage +10%','Spell interruption rate down-10%',}},
	}
	
	sets.ws.ruinator = {
		ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Ishvara Earring",
		left_ring="Sroda Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Ogma's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
end

----			 Internal Logic				----	
-- Idle() - the superhero of the .lua
function idle()
	if tp_mode == "Hybrid" or tp_mode == "DPS" then
		if player.status == "Engaged" then
			if player.sub_job == "NIN" or player.sub_job == "DNC" then 
				if tp_mode == "Hybrid" then
					equip(sets.engaged.dualwield)
				elseif tp_mode == "DPS" then
					equip(sets.engaged.dualwielddps)
				end
			else
				if tp_mode == "Hybrid" then
					equip(sets.engaged.hybrid)
				elseif tp_mode == "DPS" then
					equip(sets.engaged.dps)
				end
			end
		else
			if player.sub_job == "NIN" or player.sub_job == "DNC" then 
				equip(sets.idle.dualwield) 
			else
				equip(sets.idle.normal)
			end
		end
	elseif tp_mode == "AoETank" then
		if player.status == "Engaged" then
			if buffactive["Battuta"] then
				equip(sets.engaged.battuta)
			else
				equip(sets.engaged.parry)
			end
		else
			equip (sets.idle.aoetank)
		end
	elseif tp_mode == "SingleTank" then
		if player.status == "Engaged" then
			if buffactive["Battuta"] then
				equip(sets.engaged.battuta)
			else
				equip(sets.idle.singletank)
			end
		else
			equip (sets.idle.singletank)
		end
	elseif tp_mode == "MagicEva" then
		equip(sets.idle.magic)
	elseif tp_mode == "MagicAettir" then
		equip(sets.idle.magicaettir)
	end
end

--Checks state when becoming engaged
function status_change(new,old)
	if new == "Engaged" then
		idle()
	else
		idle()
	end
end

--Precast rules
function precast(spell)
	if spell.type == "WeaponSkill" then 
		if spell.english == "Resolution" then
			equip (sets.ws.resolution) 
		elseif spell.english == "Dimidiation" then
			equip(sets.ws.dimidiation)	
		elseif spell.english == "Savage Blade" then
			equip(sets.ws.savageblade)
		elseif spell.english == "Ruinator" then
			equip(sets.ws.ruinator)
		else
			equip(sets.ws.dimidiation)
		end
	elseif spell.english == "Battuta" then
		equip(sets.precast.battuta)
	elseif spell.english == "Valiance" or spell.english == "Vallation" then
		equip(sets.precast.valiance)
	elseif spell.english == "Vivacious Pulse" then
		equip(sets.precast.pulse)
	elseif spell.type == "JobAbility" or spell.english == "Pflug" or spell.english == "Liement" or spell.english == "Battuta" then
		equip(sets.precast.enmity)
	elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" then 
		equip(sets.precast.fastcast)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	else
		idle()
	end
end

--midcast rules
function midcast(spell)
	if spell.english == "Foil" or spell.english == "Poisonga" or spell.english == "Stun" or spell.english == "Flash" or spell.english == "Jettatura" or spell.english == "Blank Gaze" then
		if tp_mode == "Hybrid" or tp_mode == "DPS" or MOde == "Single Tank" or tp_mode == "MagicEva" then
			if spell_mode == "Normal" then
				equip(sets.midcast.enmity)
			else
				equip(sets.midcast.SIR)
			end
		elseif tp_mode == "AoETank" then
			equip(sets.midcast.SIR)
		end
	elseif spell.english == "Phalanx" then
		if spell_mode == "Normal" then
			equip(sets.midcast.phalanx)
		else
			equip(sets.midcast.SIR)
		end
	elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" then 
		if spell.english == "Temper" then
			equip(sets.midcast.temper)
		else
			equip(sets.midcast.SIR)
		end
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	end
end

--aftercast rules
function aftercast(spell)
	if spell.english == "Battuta" and player.status == "Engaged" then
		if tp_mode == "AoETank" or tp_mode == "SingleTank" then
			equip(sets.idle.battuta)
		else
			idle()
		end
	else	
		idle()
	end
end

-- Auto RUNE Logic
windower.register_event('lose buff', function(buff_id)
	if buff_id == 523 then
		if auto_mode == "On" and player.hp > 0 then
			send_command('input /ja "Ignis" <me>')
		end
	end
	if buff_id == 524 then
		if auto_mode == "On" and player.hp > 0 then
			send_command('input /ja "Gelus" <me>')
		end
	end
	if buff_id == 525 then
		if auto_mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Flabra" <me>')
		end
	end
	if buff_id == 526 then
		if auto_mode == "On" and player.hp > 0 then
			send_command('input /ja "Tellus" <me>')
		end
	end
	if buff_id == 527 then
		if auto_mode == "On" and player.hp > 0 then
			send_command('input /ja "Sulpor" <me>')
		end
	end
	if buff_id == 528 then
		if auto_mode== "On" and player.hp > 0 then
			send_command('input /ja "Unda" <me>')
		end
	end
	if buff_id == 529 then
		if auto_mode == "On" and player.hp > 0 then
			send_command('input /ja "Lux" <me>')
		end
	end
	if buff_id == 530 then
		if auto_mode == "On" and player.hp > 0 then
			send_command('input /ja "Tenebrae" <me>')
		end
	end
end)

-- rules for setting modes
function self_command(command)
	if command == "ToggleHybrid" then
		if tp_mode == "Hybrid" then
			tp_mode = "DPS"
			idle()
		elseif tp_mode == "DPS" or tp_mode == "AoETank" or tp_mode == "SingleTank" or tp_mode == "MagicEva" or tp_mode == "MagicAettir" then
			tp_mode = "Hybrid"
			idle()
		end
	elseif command == "ToggleTank" then
		if tp_mode == "AoETank" then
			tp_mode = "SingleTank"
			idle()
		elseif tp_mode == "Hybrid" or tp_mode == "DPS" or tp_mode == "SingleTank" or tp_mode == "MagicEva" or tp_mode == "MagicAettir" then
			tp_mode = "AoETank"
			idle()
		end
	elseif command == "ToggleMagic" then
		if tp_mode == "MagicEva" then
			tp_mode = "MagicAettir"
			idle()
		elseif tp_mode == "Hybrid" or tp_mode == "DPS" or tp_mode == "AoETank" or tp_mode == "SingleTank" or tp_mode == "MagicAettir" then
			tp_mode = "MagicEva"
			idle()
		end
	elseif command == "ToggleSIR" then
		if spell_mode == "Normal" then
			spell_mode = "SIR"
			idle()
		else
			spell_mode = "Normal"
			idle()
		end
	elseif command == "ToggleWeapon" then
		local main_cycle	=	{"Epeolatry","Lionheart","Aettir","Lycurgos"}
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
			
            equip({ main = next_weapon })
        end
	elseif command == "ToggleAUTO" then
		if auto_mode == "Off" then
			auto_mode = "On"
		else
			auto_mode = "Off"
		end
	end
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