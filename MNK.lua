--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
----------------------------------------------------------------------
--                           MNK LUA
----------------------------------------------------------------------
-- Summary:
-- This lua relies on using the numberpad to change your mode/state which is tracked on the Job box. 
-- To change the keybinds, please edit them in the Keybinds function below
-- To change your default Job box position, please change the "x" and "y" positions in then gearswap_box_config settings below

----------------------------------------------------------------------
--                           MODES / UI TEXT BOX
----------------------------------------------------------------------
TP_Mode = "Hybrid"
Buff_Mode = "High"

TP_Modes = {'Hybrid','DPS','SubtleBlow','Counter','Defence'}
Buff_Modes = {'High','Low'}

gearswap_box = function()
  str = '           \\cs(165,100,40)MONK\\cr\n'
  str = str..' Offense Mode:\\cs(255,150,100)   '..TP_Mode..'\\cr\n'
  str = str..' Buff Mode:\\cs(255,150,100)   '..Buff_Mode..'\\cr\n'
    return str
end

-- Edit the "x" and "y" positions below to change the default position of the job box.
gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

----------------------------------------------------------------------
--                           USER SETUP
----------------------------------------------------------------------
function user_setup()
	----------------------------------------------------------------------
	--                           KEYBINDS
	----------------------------------------------------------------------
	send_command('bind numpad9 gs c ToggleHybrid')
	send_command('bind numpad8 gs c ToggleDefence')
	send_command('bind numpad7 gs c ToggleSubtleBlow')
	
	send_command('bind numpad6 gs c ToggleBuff')
	send_command('bind numpad4 gs c ToggleWeapon')
	send_command('bind numpad5 gs c ToggleSpecial')

	send_command('bind f9 input /item "Remedy" <me>')
	send_command('bind f10 input /item "Panacea" <me>')
	send_command('bind f11 input /item "Holy Water" <me>')
	send_command ('bind numpad1 input /mount "Noble Chocobo"')
	send_command ('bind numpad2 input /dismount')
	
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
--Note: Place in order you want to cycle weapons.
	Weapons = {
		Main  	= { "Godhands", "Verethragna" },
	}
	
	Special = {
		{ main = "Xoanon", sub = "Niobid Strap" },
	}

----------------------------------------------------------------------
--                           SETS / GEAR
----------------------------------------------------------------------
function get_sets() 
    sets.idle = {}                  -- Leave this empty.
	sets.engaged = {}
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.ja = {}					-- Leave this empty
	sets.items = {}					-- Leave this empty
 
	----------------------------------------------------------------------
	--                           IDLE SETS
	----------------------------------------------------------------------
	-- Normal DT / Town set
    sets.idle.normal = {
	    ammo="Staunch Tathlum +1",
		head="Null Masque",
		body="Adamantite Armor",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Mpaca's Hose",
		feet="Herald's Gaiters",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	--DT set
	sets.idle.DT = {
	    ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body="Mpaca's Doublet",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Mpaca's Hose",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Defending Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	--Counter set
	sets.idle.counter = {
		ammo="Amar Cluster",
		head="Bhikku Crown +3",
		body="Mpaca's Doublet",
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs="Anch. Hose +2",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+14','Mag. Acc.+14','"Store TP"+5',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	
	----------------------------------------------------------------------
	--                           ENGAGED SETS
	----------------------------------------------------------------------
	--Normal / DPS Set
	sets.engaged.TP = {
		ammo="Coiste Bodhar",
		head="Ryuo Somen +1",
		body="Mpaca's Doublet",
		hands="Tatena. Gote +1",
		legs="Bhikku Hose +3",
		feet="Tatena. Sune. +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Epona's Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Defensive TP Set
	sets.engaged.HYBRID = {
		ammo="Coiste Bodhar",
		head="Ryuo Somen +1",
		body="Mpaca's Doublet",
		hands="Tatena. Gote +1",
		legs="Bhikku Hose +3",
		feet="Tatena. Sune. +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Defending Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}
	
	-- Capped Subtle Blow
	sets.engaged.subtleblow = {
		ammo="Coiste Bodhar",
		head="Bhikku Crown +3",
		body="Ken. Samue +1",
		hands="Malignance Gloves",
		legs="Bhikku Hose +3",
		feet="Malignance Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Store TP"+10','Phys. dmg. taken-10%',}},
	}

	--Specific Equipment swaps you want equipped in your TP sets when you have certain buffs
	sets.engaged.impetus = {
		body="Bhikku Cyclas +3",
	}
	
	sets.engaged.footwork = {
		--feet="Anch. Gaiters +4",
	}

	----------------------------------------------------------------------
	--                           PRECAST SETS
	----------------------------------------------------------------------
    sets.precast.fastcast = {

	}

	----------------------------------------------------------------------
	--                           MIDCAST SETS
	----------------------------------------------------------------------
    sets.midcast.spell = {
	}

	sets.midcast.trust = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

	----------------------------------------------------------------------
	--                           JOB ABILITIES
	----------------------------------------------------------------------
	sets.ja.hundredfists = {
	}

	sets.ja.boost = {
		waist="Ask Sash",
	}

	sets.ja.dodge = {
	}

	sets.ja.focus= {
	}

	sets.ja.chakra = {
		hands="Hes. Gloves +3",
	}

	sets.ja.chiblast = {
	}

	sets.ja.counterstance = {
	}

	sets.ja.footwork = {
		feet="Anch. Gaiters +3",
	}
	
	sets.ja.impetus = {
		body="Bhikku Cyclas +3",
	}

	sets.ja.mantra = {
	}

	sets.ja.formlessstrikes = {
	}

	sets.ja.perfectcounter = {
	}

	----------------------------------------------------------------------
	--                           WEAPONSKILL SETS
	----------------------------------------------------------------------
	--Undefined weaponskills
	sets.ws.weaponskill = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}, -- Note: need to swap this to STR/WSD cape once obtained
	}	
	sets.ws.weaponskillBUFF = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}, -- Note: Need to swap this to STR/WSD cape
	}
	
	--Victory Smite
	sets.ws.victorysmite = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Ken. Tekko +1",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Odr Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}
	sets.ws.victorysmiteBUFF = set_combine(sets.ws.victorysmite, {
		ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Ken. Samue +1",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Ephramad's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})

	--Victory Smite (impetus up)
	sets.ws.victorysmiteimpetus = {
		ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Odr Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}
	sets.ws.victorysmiteimpetusBUFF = set_combine(sets.ws.victorysmiteimpetus,{
		ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Odr Earring",
		left_ring="Ephramad's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	})

	--Ascetic's Fury
	sets.ws.asceticsfury = {
		ammo="Crepuscular Pebble",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.ws.asceticsfuryBUFF = set_combine(sets.ws.asceticsfury, {
		left_ring="Ephramad's Ring",
	})
	
	--Ascetic's Fury (impetus up)
	sets.ws.asceticsfuryimpetus = {
		ammo="Crepuscular Pebble",
		head={ name="Adhemar Bonnet +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Ephramad's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}
	sets.ws.asceticsfuryimpetusBUFF = set_combine(sets.ws.asceticsfuryimpetus,{})
	
	--Maru Kala
	sets.ws.marukala = {
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}, -- Note: need to swap this to STR/WSD cape once obtained
	}
	sets.ws.marukalaBUFF = set_combine(sets.ws.marukala,{
		ammo="Knobkierrie",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Moonshade Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}, -- Note: Need to swap this to STR/WSD cape
	})

	-- Shijin Spiral
	sets.ws.shijinspiral = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+1','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	sets.ws.shijinspiralBUFF = set_combine(sets.ws.shijinspiral,{
		ammo="Coiste Bodhar",
		head="Ken. Jinpachi +1",
		body="Malignance Tabard",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Mache Earring +1",
		left_ring="Ephramad's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+1','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	})

	--Final Heaven
	sets.ws.finalheaven = {
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Bhikku Cyclas +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Null Loop",
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}, -- Note: Need vit/WSD cape
	}
	sets.ws.finalheavenBUFF = set_combine(sets.ws.finalheaven,{
		ammo="Knobkierrie",
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Sroda Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}, -- Note: need vit/WSD cape
	})

	-- Howling Fist
	sets.ws.howlingfist = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck="Rep. Plat. Medal",
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.ws.howlingfistBUFF = set_combine(sets.ws.howlingfist,{
		ammo="Crepuscular Pebble",
		hands="Bhikku Gloves +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		left_ring="Ephramad's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}}, -- Note: needs to be VIT/DA cape
	})
	
	--Asuran Fists
	sets.ws.asuranfists = {
		ammo="Coiste Bodhar",
		head="Nyame Helm",
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Sroda Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}, -- Note: Need str/WSD cape
	}
	sets.ws.asuranfistsBUFF = set_combine(sets.ws.asuranfists,{
		ammo="Crepuscular Pebble",
		head="Nyame Helm",
		body="Malignance Tabard",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Schere Earring",
		left_ring="Sroda Ring",
		right_ring="Ephramad's Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}}, -- Note: need str/WSD cape
	})
	
	--Dragon Kick (+ Footwork)
	sets.ws.dragonkick = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.ws.dragonkickfootwork = set_combine(sets.ws.dragonkick,{
		body="Nyame Mail",
		feet="Anch. Gaiters +4",
	})
	sets.ws.dragonkickBUFF = {
		ammo="Crepuscular Pebble",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Ephramad's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.ws.dragonkickfootworkBUFF = set_combine(sets.ws.dragonkickBUFF,{
		feet="Anch. Gaiters +4",
	})
	
	--Tornado Kick (+footwork)
	sets.ws.tornadokick = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Bhikku Gloves +3",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.ws.tornadokickfootwork = set_combine(sets.ws.tornadokick,{
		hands="Nyame Gauntlets",
		feet="Anch. Gaiters +4",
	})
	sets.ws.tornadokickBUFF = {
		ammo="Crepuscular Pebble",
		head="Mpaca's Cap",
		body="Nyame Mail",
		hands="Bhikku Gloves +3",
		legs="Mpaca's Hose",
		feet="Nyame Sollerets",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Ephramad's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.ws.tornadokickfootworkBUFF = set_combine(sets.ws.tornadokickBUFF,{
		feet="Anch. Gaiters +4",
	})
	
	-- Raging Fists
	sets.ws.ragingfists = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +3",
		hands="Bhikku Gloves +3",
		legs="Nyame Flanchard",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Moonshade Earring",
		right_ear="Schere Earring",
		left_ring="Ephramad's Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	sets.ws.ragingfistsBUFF = set_combine(sets.ws.ragingfists,{
		body="Malignance Tabard",
		hands="Bhikku Gloves +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
	})

	--Shell Crusher
	sets.ws.shellcrusher = {
		ammo="Pemphredo Tathlum",
		head="Bhikku Crown +3",
		body="Bhikku Cyclas +3",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Bhikku Hose +3",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Null Loop",
		waist="Null Belt",
		left_ear="Digni. Earring",
		right_ear="Crep. Earring",
		left_ring="Stikini Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

	--Cataclysm
	sets.ws.cataclysm = {
		ammo="Pemphredo Tathlum",
		head="Pixie Hairpin +1",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ear="Friomisi Earring",
		left_ring="Archon Ring",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

	--elemental staff Weaponskills
	sets.ws.staffele = {
		ammo="Pemphredo Tathlum",
		head={ name="Mpaca's Cap", augments={'Path: A',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Sibyl Scarf",
		waist="Orpheus's Sash",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ear="Friomisi Earring",
		left_ring="Shiva Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
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
	if TP_Mode == "Defence" then
		equip(sets.idle.DT)
	elseif TP_Mode == "Counter" then
		if player.status == "Engaged" then
			equip(sets.idle.counter)
		else
			equip(sets.idle.DT)
		end
	elseif TP_Mode == "Hybrid" or TP_Mode == "DPS" or TP_Mode == "SubtleBlow" then
		if player.status == "Engaged" then
			if TP_Mode == "Hybrid" then
				equip(sets.engaged.HYBRID)
			elseif TP_Mode == "DPS" then
				equip(sets.engaged.TP)
			elseif TP_Mode == "SubtleBlow" then
				equip(sets.engaged.subtleblow)
			end
			if buffactive["Impetus"] then
				equip(sets.engaged.impetus)
			end
			if buffactive["Footwork"] then
				equip(sets.engaged.footwork)
			end
		else
			equip(sets.idle.normal)
		end
	end
end

function precast(spell)
	if spell.type == "WeaponSkill" then
		if spell.english == "Victory Smite" then
			if buffactive["Impetus"] then
				if Buff_Mode == "High" then
					equip(sets.ws.victorysmiteimpetusBUFF)
				else
					equip(sets.ws.victorysmiteimpetus)
				end
			else
				if Buff_Mode == "High" then
					equip(sets.ws.victorysmiteBUFF)
				else
					equip(sets.ws.victorysmite)
				end
			end
		elseif spell.english == "Ascetic's Fury" then
			if buffactive["Impetus"] then
				if Buff_Mode == "High" then
					equip(sets.ws.asceticsfuryimpetusBUFF)
				else
					equip(sets.ws.asceticsfuryimpetus)
				end
			else
				if Buff_Mode == "High" then
					equip(sets.ws.asceticsfuryBUFF)
				else
					equip(sets.ws.asceticsfury)
				end
			end
		elseif spell.english == "Maru Kala" then
			if Buff_Mode == "High" then
				equip(sets.ws.marukalaBUFF)
			else
				equip(sets.ws.marukala)
			end
		elseif spell.english == "Shijin Spiral" then
			if Buff_Mode == "High" then
				equip(sets.ws.shijinspiralBUFF)
			else
				equip(sets.ws.shijinspiral)
			end
		elseif spell.english == "Final Heaven" then
			if Buff_Mode == "High" then
				equip(sets.ws.finalheavenBUFF)
			else
				equip(sets.ws.finalheaven)
			end
		elseif spell.english == "Howling Fist" then
			if Buff_Mode == "High" then
				equip(sets.ws.howlingfistBUFF)
			else
				equip(sets.ws.howlingfist)
			end
		elseif spell.english == "Asuran Fists" then
			if Buff_Mode == "High" then
				equip(sets.ws.asuranfistsBUFF)
			else
				equip(sets.ws.asuranfists)
			end
		elseif spell.english == "Dragon Kick" then
			if buffactive["Footwork"] then
				if Buff_Mode == "High" then
					equip(sets.ws.dragonkickfootworkBUFF)
				else
					equip(sets.ws.dragonkickfootwork)
				end
			else
				if Buff_Mode == "High" then
					equip(sets.ws.dragonkickBUFF)
				else
					equip(sets.ws.dragonkick)
				end
			end
		elseif spell.english == "Tornado Kick" then
			if buffactive["Footwork"] then
				if Buff_Mode == "High" then
					equip(sets.ws.tornadokickfootworkBUFF)
				else
					equip(sets.ws.tornadokickfootwork)
				end
			else
				if Buff_Mode == "High" then
					equip(sets.ws.tornadokickBUFF)
				else
					equip(sets.ws.tornadokick)
				end
			end
		elseif spell.english == "Raging Fists" then
			if Buff_Mode == "High" then
				equip(sets.ws.ragingfistsBUFF)
			else
				equip(sets.ws.ragingfists)
			end
		elseif spell.english == "Shell Crusher" or spell.english == "Shattersoul" then
			equip(sets.ws.shellcrusher)
		elseif spell.english == "Cataclysm" then
			equip(sets.ws.cataclysm)
		elseif spell.english == "Rock Crusher" or spell.english == "Earth Crusher" or spell.english == "Starburst" or spell.english == "Sunburst" then
			equip(sets.ws.staffele)
		else
			if Buff_Mode == "High" then
				equip(sets.ws.weaponskillBUFF)
			else
				equip(sets.ws.weaponskill)
			end	
		end
	elseif spell.type == "JobAbility" then
		if spell.english == "Hundred Fists" then
			equip(sets.ja.hundredfists)
		elseif spell.english == "Boost" then
			equip(sets.ja.boost)
		elseif spell.english == "Dodge" then
			equip(sets.ja.dodge)
		elseif spell.english == "Focus" then
			equip(sets.ja.focus)
		elseif spell.english == "Chakra" then
			equip(sets.ja.chakra)
		elseif spell.english == "Chi Blast" then
			equip(sets.ja.chiblast)
		elseif spell.english == "Counterstance" then
			equip(sets.ja.counterstance)
		elseif spell.english == "Footwork" then
			equip(sets.ja.footwork)
		elseif spell.english == "Mantra" then
			equip(sets.ja.mantra)
		elseif spell.english == "Formless Strikes" then
			equip(sets.ja.formlessstrikes)
		elseif spell.english == "Perfect Counter" then
			equip(sets.ja.perfectcounter)
		elseif spell.english == "Impetus" then
			equip(sets.ja.impetus)
		else 
			idle()
		end
	elseif spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then 
		equip(sets.precast.fastcast)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	else
		idle()
	end
end

function midcast(spell)
	if spell.type == "Trust" then
		equip(sets.midcast.trust)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	end
end

function aftercast(spell)
	if spell.english == "Boost" then
		equip(sets.ja.boost)
	elseif spell.english == "Impetus" then
		idle()
		if player.status == "Engaged" then
			equip(sets.engaged.impetus)
		end
	elseif spell.english == "Footwork" then
		idle()
		if player.status == "Engaged" then
			equip(sets.engaged.footwork)
		end
	else
		idle()
	end
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
	last_real_main   = player.equipment.main   or Weapons.Main[1]
	main_mode   = last_real_main
	
	special_mode = nil
end

function self_command(command)
	if command == "ToggleHybrid" then
		if TP_Mode == "Counter" or TP_Mode == "Defence" or TP_Mode == "SubtleBlow" or TP_Mode == "DPS" then
			TP_Mode = "Hybrid"
			idle()
		elseif TP_Mode == "Hybrid" then
			TP_Mode = "DPS"
			idle()
		end
	elseif command == "ToggleSubtleBlow" then
		TP_Mode = "SubtleBlow"
		idle()
	elseif command == "ToggleDefence" then
		if TP_Mode == "Hybrid" or TP_Mode == "DPS" or TP_Mode == "SubtleBlow" or TP_Mode == "Counter" then
			TP_Mode = "Defence"
			idle()
		elseif TP_Mode == "Defence" then
			TP_Mode = "Counter"
			idle()
		end
	elseif command == "ToggleBuff" then
		if Buff_Mode == "High" then
			Buff_Mode = "Low"
		else
			Buff_Mode = "High"
		end
	elseif command == "ToggleWeapon" then
		main_mode = cycle(Weapons.Main, main_mode)
		last_real_main = main_mode
		equip({ main = main_mode })
		special_mode = nil
	elseif command == "ToggleSpecial" then
		special_mode = cycle(Special, special_mode)
		equip(special_mode)
		main_mode = nil
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
