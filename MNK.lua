--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
--MNK LUA


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
	send_command('unbind f9')
	send_command('unbind f10')
	send_command('unbind f11')
    enable("main","sub","range","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
end

TP_Mode = "Hybrid"
TP_Modes = {'Hybrid','Counter','Defence'}

gearswap_box = function()
  str = '           \\cs(165,100,40)MONK\\cr\n'
  str = str..' Offense Mode:\\cs(255,150,100)   '..TP_Mode..'\\cr\n'
    return str
end

gearswap_box_config = {pos={x=1320,y=550},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end

function get_sets()
send_command('bind numpad9 gs c ToggleHybrid')
send_command('bind numpad8 gs c ToggleCounter')
send_command('bind numpad7 gs c ToggleDefence')

send_command('bind numpad4 gs c ToggleWeapon')
send_command('bind numpad5 gs c ToggleStaff')

send_command('bind f9 input /item "Remedy" <me>')
send_command('bind f10 input /item "Panacea" <me>')
send_command('bind f11 input /item "Holy Water" <me>')
send_command ('bind numpad1 input /mount "Noble Chocobo"')
send_command ('bind numpad2 input /dismount')
  
    sets.idle = {}                  -- Leave this empty.
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.ja = {}
	sets.items = {}
 
 -------------------------------------DT Sets-----------------------------------------------------------
 -- Normal DT / Town set
    sets.idle.normal = {
	    ammo="Staunch Tathlum +1",
		head={ name="Nyame Helm", augments={'Path: B',}},
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
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
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
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

--Counter set
	sets.idle.counter = {
		ammo="Amar Cluster",
		head="Bhikku Crown +2",
		body="Mpaca's Doublet",
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs="Anch. Hose +2",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Bhikku Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+11','Mag. Acc.+11','"Store TP"+3',}},
		left_ring="Defending Ring",
		right_ring={ name="Gelatinous Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
--------------------------------------TP Sets ----------------------------------------------------------
--Normal TP Set
	sets.idle.tp = {
		ammo="Coiste Bodhar",
		head="Bhikku Crown +2",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Bhikku Hose +2",
		feet="Mpaca's Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.idle.tp.godhands = set_combine(sets.idle.tp,{
		left_ear="Mache Earring +1",
	})

-- TP Set impetus up
	sets.idle.tpimpetus = {
		ammo="Coiste Bodhar",
		head="Bhikku Crown +2",
		body="Bhikku Cyclas +2",
		hands="Mpaca's Gloves",
		legs="Bhikku Hose +2",
		feet="Mpaca's Boots",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	sets.idle.tpimpetus.godhands = set_combine(sets.idle.tpimpetus,{
		left_ear="Mache Earring +1",
	})

-- TP Set footwork up
	sets.idle.tpfootwork = {
		ammo="Coiste Bodhar",
		head="Bhikku Crown +2",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Bhikku Hose +2",
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
	
	sets.idle.tpfootwork.godhands = set_combine(sets.idle.tpfootwork,{
		left_ear="Mache Earring +1",
	})

-- TP Set Impetus + Footwork up
	sets.idle.tpimpetusfootwork = {
		ammo="Coiste Bodhar",
		head="Bhikku Crown +2",
		body="Bhikku Cyclas +2",
		hands="Mpaca's Gloves",
		legs="Bhikku Hose +2",
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

	sets.idle.tpimpetusfootwork.godhands = set_combine(sets.idle.tpimpetusfootwork,{
		left_ear="Mache Earring +1",
	})
	
----------------------------------- Weaponskill sets----------------------------------------------------
--Victory Smite
	sets.ws.victorysmite = {
	    ammo="Knobkierrie",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Ken. Samue +1",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

--Victory Smite (impetus up)
	sets.ws.victorysmiteimpetus = {
	    ammo="Coiste Bodhar",
		head={ name="Adhemar Bonnet +1", augments={'STR+12','DEX+12','Attack+20',}},
		body="Bhikku Cyclas +2",
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}
	
-- Raging Fists
	sets.ws.ragingfists = {
		ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body={ name="Adhemar Jacket +1", augments={'DEX+12','AGI+12','Accuracy+20',}},
		hands={ name="Adhemar Wrist. +1", augments={'STR+12','DEX+12','Attack+20',}},
		legs="Mpaca's Hose",
		feet="Ken. Sune-Ate +1",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

-- Shijin Spiral
	sets.ws.shijinspiral = {
	    ammo="Aurgelmir Orb",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}

-- Howling Fist
	sets.ws.howlingfist = {
	    ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

--Tornado Kick
	sets.ws.tornadokick = {
	    ammo="Coiste Bodhar",
		head="Mpaca's Cap",
		body="Bhikku Cyclas +2",
		hands="Mpaca's Gloves",
		legs="Bhikku Hose +2",
		feet="Anch. Gaiters +3",
		neck={ name="Mnk. Nodowa +2", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

--Final Heaven
	sets.ws.finalheaven = {
	    ammo="Knobkierrie",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Ishvara Earring",
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

--Shell Crusher
	sets.ws.shellcrusher = {
		ammo="Pemphredo Tathlum",
		head="Bhikku Crown +2",
		body="Bhikku Cyclas +2",
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Bhikku Hose +2",
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
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
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
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Friomisi Earring",
		left_ring="Shiva Ring +1",
		right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}

--General Weaponskills
	sets.ws.weaponskill = {
	    ammo="Knobkierrie",
		head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		right_ear="Sherida Earring",
		left_ring="Gere Ring",
		right_ring="Niqmaddu Ring",
		back={ name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10','System: 1 ID: 640 Val: 4',}},
	}


------------------------------------ Job Ability Sets---------------------------------------------------
-- Hundred Fists
	sets.ja.hundredfists = {
	}

-- Boost
	sets.ja.boost = {
		waist="Ask Sash",
	}

-- Dodge
	sets.ja.dodge = {
	}

-- Focus
	sets.ja.focus= {
	}

-- Chakra
	sets.ja.chakra = {
		hands="Hes. Gloves +3",
	}

-- Chi Blast
	sets.ja.chiblast = {
	}

-- Counterstance
	sets.ja.counterstance = {
	}

-- Footwork
	sets.ja.footwork = {
		feet="Shukuyu Sune-Ate",
	}

-- Mantra
	sets.ja.mantra = {
	}

-- Formless Strikes
	sets.ja.formlessstrikes = {
	}

-- Perfect Counter
	sets.ja.perfectcounter = {
	}

------------------------------------ Precast Set -------------------------------------------------------
    sets.precast.fastcast = {

	}

--------------------------------------Midcast set ------------------------------------------------------
    sets.midcast.spell = {
	}

-- Midcast for trusts - want to have 119 gear in head,body,hands,legs,feet.
	sets.midcast.trust = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}

---------------------------	ITEM SETS	---------------------------
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}

end

------------------------------------ Logic ----------------------------------------------------------
function idle()
	if TP_Mode == "Defence" then
		equip(sets.idle.DT)
	elseif TP_Mode == "Counter" then
		if player.status == "Engaged" then
			equip(sets.idle.counter)
		else
			equip(sets.idle.DT)
		end
	elseif TP_Mode == "Hybrid" then
		if player.status == "Engaged" then	
			if player.equipment.main == "Godhands" then
				if buffactive["Impetus"] then
					if buffactive["Footwork"] then
						equip(sets.idle.tpimpetusfootwork.godhands)
					else
						equip(sets.idle.tpimpetus.godhands) 
					end
				elseif buffactive["Footwork"] then
					equip(sets.idle.tpfootwork.godhands)
				else
					equip(sets.idle.tp.godhands) 
				end
			else
				if buffactive["Impetus"] then
					if buffactive["Footwork"] then							
						equip(sets.idle.tpimpetusfootwork)
					else
						equip(sets.idle.tpimpetus) 
					end
				elseif buffactive["Footwork"] then
					equip(sets.idle.tpfootwork)
				else
					equip(sets.idle.tp) 
				end
			end
		else
			equip(sets.idle.normal)
		end
	end
end

function status_change(new,old)
	if new == "Engaged" then
		if player.equipment.main == "Godhands" then
			if buffactive["Impetus"] then
				if buffactive["Footwork"] then
					equip(sets.idle.tpimpetusfootwork.godhands)
				else
					equip(sets.idle.tpimpetus.godhands) 
				end
			elseif buffactive["Footwork"] then
				equip(sets.idle.tpfootwork.godhands)
			else
				equip(sets.idle.tp.godhands) 
			end
		else
			if buffactive["Impetus"] then
				if buffactive["Footwork"] then
					equip(sets.idle.tpimpetusfootwork)
				else
					equip(sets.idle.tpimpetus) 
				end
			elseif buffactive["Footwork"] then
				equip(sets.idle.tpfootwork)
			else
				equip(sets.idle.tp) 
			end
		end
	else
		idle()
	end
end

function precast(spell)
	if spell.type == "WeaponSkill" then
		if spell.english == "Victory Smite" then
			if buffactive["Impetus"] then
				equip(sets.ws.victorysmiteimpetus) 
			else
				equip(sets.ws.victorysmite) 
			end
		elseif spell.english == "Raging Fists" then
			equip(sets.ws.ragingfists)
		elseif spell.english == "Shijin Spiral" then
			equip(sets.ws.shijinspiral)
		elseif spell.english == "Howling Fist" then
			equip(sets.ws.howlingfist)
		elseif spell.english == "Tornado Kick" then
			equip(sets.ws.tornadokick)
		elseif spell.english == "Final Heaven" then
			equip(sets.ws.finalheaven)
		elseif spell.english == "Shell Crusher" or spell.english == "Shattersoul" then
			equip(sets.ws.shellcrusher)
		elseif spell.english == "Cataclysm" then
			equip(sets.ws.cataclysm)
		elseif spell.english == "Rock Crusher" or spell.english == "Earth Crusher" or spell.english == "Starburst" or spell.english == "Sunburst" then
			equip(sets.ws.staffele)
		else
			equip(sets.ws.weaponskill)
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
	 if spell.type == "WeaponSkill" then
		if spell.english == "Victory Smite" then
			if buffactive["Impetus"] then
				equip(sets.ws.victorysmiteimpetus) 
			else
				equip(sets.ws.victorysmite) 
			end
		elseif spell.english == "Raging Fists" then
			equip(sets.ws.ragingfists)
		elseif spell.english == "Shijin Spiral" then
			equip(sets.ws.shijinspiral)
		elseif spell.english == "Howling Fist" then
			equip(sets.ws.howlingfist)
		elseif spell.english == "Tornado Kick" then
			equip(sets.ws.tornadokick)
		elseif spell.english == "Final Heaven" then
			equip(sets.ws.finalheaven)
		elseif spell.english == "Shell Crusher" or spell.english == "Shattersoul" then
			equip(sets.ws.shellcrusher)
		elseif spell.english == "Cataclysm" then
			equip(sets.ws.cataclysm)
		elseif spell.english == "Rock Crusher" or spell.english == "Earth Crusher" or spell.english == "Starburst" or spell.english == "Sunburst" then
			equip(sets.ws.staffele)
		else
			equip(sets.ws.weaponskill)
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
		else 
			idle()
		end
	elseif spell.type == "Trust" then
		equip(sets.midcast.trust)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	else
		equip(sets.midcast.spell)
	end
end

function aftercast(spell)
	if spell.english == "Boost" then
		equip(sets.ja.boost)
	elseif spell.english == "Impetus" then
		if buffactive["Footwork"] then
			if player.equipment.main == "Godhands" then
				equip(sets.idle.tpimpetusfootwork.godhands)
			else
				equip(sets.idle.tpimpetusfootwork)
			end
		else
			if player.equipment.main == "Godhands" then
				equip(sets.idle.tpimpetus.godhands)
			else
				equip(sets.idle.tpimpetus)
			end
		end
	elseif spell.english == "Footwork" then
		if buffactive["Impetus"] then
			if player.equipment.main == "Godhands" then
				equip(sets.idle.tpimpetusfootwork.godhands)
			else
				equip(sets.idle.tpimpetusfootwork)
			end
		else
			if player.equipment.main == "Godhands" then
				equip(sets.idle.tpfootwork.godhands) 
			else
				equip(sets.idle.tpfootwork) 
			end
		end
	else
		idle()
	end
end


function buff_change(name,gain)
	if name == "terror" and gain == "true" then
			equip(sets.idle.normal)
		end
	if name == "stun" and gain == "true" then
			equip(sets.idle.normal)
		end
	if name	== "petrification" and gain == "true" then
			equip(sets.idle.normal)
		end
end

function self_command(command)
	if command == "ToggleHybrid" then
		if TP_Mode == "Counter" or TP_Mode == "Defence" then
			TP_Mode = "Hybrid"
			idle()
		elseif TP_Mode == "Hybrid" then
			idle()
		end
	elseif command == "ToggleCounter" then
		if TP_Mode == "Hybrid" or TP_Mode == "Defence" then
			TP_Mode = "Counter"
			idle()
		elseif TP_Mode == "Counter" then
			idle()
		end
	elseif command == "ToggleDefence" then
		if TP_Mode == "Hybrid" or TP_Mode == "Counter" then
			TP_Mode = "Defence"
			idle()
		elseif TP_Mode == "Defence" then
			idle()
		end
	elseif command == "ToggleWeapon" then
		if player.equipment.main == "Godhands" then
			equip({ main="Verethragna" })
		elseif player.equipment.main == "Verethragna" then
			equip({ main="Godhands" })
		else
			equip({ main="Godhands" })
		end
	elseif command == "ToggleStaff" then
		equip({ main="Xoanon", sub="Niobid Strap" })
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
