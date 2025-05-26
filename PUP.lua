--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
--  
---------------------------	PUPPETMASTER LUA---------------------------
                       

---------------------------	UNLOAD COMMAND	---------------------------		
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

--------------------------- SETTING UP TEXTBOX ------------------------------------------
Mode = "Hybrid"
Pet_Mode = "NA"
Pet_Distance = "Melee"

 
Modes = {'Hybrid','HybridDEF','Master','MasterDEF','Overdrive','OverdriveDEF','Pet','PetDEF','Emergency-DT'}
Pet_Modes = {'NA','Bruiser','Tank','Sharpshot','Ranged','WHM','BLM','RDM','Other'}
Pet_Distances = {'Melee', 'Ranged'}

gearswap_box = function()
  str = '           \\cs(246,102,13)PUPPETMASTER\\cr\n'
  str = str..' Current Mode:\\cs(200,100,200)   '..Mode..'\\cr\n'
  str = str..' Pet Mode:\\cs(54,120,233)   '..Pet_Mode..'\\cr\n'
  str = str..' Pet Distance:\\cs(211,211,211)   '..Pet_Distance..'\\cr\n'
    return str
end

gearswap_box_config = {pos={x=1250,y=525},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
end


function get_sets()
--------------------------- Commands ----------------------------------
--------Required Commands Below ----------

send_command('bind numpad9 gs c ToggleHybrid')
send_command('bind numpad8 gs c ToggleOverdrive')
send_command('bind numpad7 gs c TogglePet')
send_command('bind numpad6 gs c ToggleMaster')
send_command('bind numpad5 gs c ToggleEmergency')
send_command('bind numpad4 gs c ToggleWeapon')
send_command('bind numpad3 gs c ToggleDistance')

--------- Personal Commands ---------------
send_command('bind f9 input /item "Remedy" <me>')
send_command('bind f10 input /item "Panacea" <me>')
send_command('bind f11 input /item "Holy Water" <me>')
send_command('bind f12 input //lua l AutoPUP')

--------- GEAR DEFINED ------------------

    sets.idle = {}	
	sets.engaged = {}
		sets.engaged.hybrid = {}
		sets.engaged.master = {}
		sets.engaged.pet = {}
		sets.engaged.overdrive = {}
    sets.precast = {}
		sets.precast.master = {}
		sets.precast.pet = {}
	sets.ws = {}
		sets.ws.master = {}
		sets.ws.pet = {}
	sets.ja = {}
    sets.midcast = {}    
		sets.midcast.master = {}
		sets.midcast.pet = {} 
	sets.items = {}
 	
---------------------------	GEAR SETS	---------------------------	

---------------------------	DAMAGE TAKEN (for emergencies)	---------------------------	
-- Master Damage taken --
	sets.idle.tank = {
		ammo="Automat. Oil +3",
		head={ name="Nyame Helm", augments={'Path: B',}},
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="C. Palug Ring",
		right_ring="Defending Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

-- Pet Damage Taken / Regen --
	sets.idle.pettank = {
		ammo="Automat. Oil +3",
       	head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Accuracy+3','Pet: Haste+5',}},
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Shepherd's Chain",
		waist="Isa Belt",
		left_ear="Rimeice Earring",
		right_ear="Hypaspist Earring",
		left_ring="C. Palug Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

---------------------------	IDLE / TOWN SET	---------------------------	
	sets.idle.normal = {
		ammo="Automat. Oil +3",
		head="Malignance Chapeau",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Malignance Gloves",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Hermes' Sandals",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="C. Palug Ring",
		right_ring="Defending Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

---------------------------	ENGAGED SETS	---------------------------

---------------------------	HYRBRID ENGAGED SETS	---------------------------
-- Hybrid 
	sets.engaged.hybrid.normal = {
	    range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Heyoka Cap +1",
		body="Mpaca's Doublet",
		hands="Karagoz Guanti +3",
		legs="Heyoka Subligar +1",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Crep. Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Niqmaddu Ring",
		right_ring="Fickblix's Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}
	
	sets.engaged.hybrid.normalranged = set_combine(sets.engaged.hybrid.normal,{
		range="Animator P II +1",
	})

-- Normal - Godhands/Xiucoatl equipped --
	sets.engaged.hybrid.godhands = set_combine(sets.engaged.hybrid.normal,{
		left_ear="Mache Earring +1",
	})
	
	sets.engaged.hybrid.godhandsranged = set_combine(sets.engaged.hybrid.godhands,{
		range="Animator P II +1",
	})

--Hybrid Dual Tank set
	sets.engaged.hybrid.defence = {
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Karagoz Guanti +3",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Crep. Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="C. Palug Ring",
		right_ring="Defending Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','Pet: Phys. dmg. taken-10%',}},
	}

	sets.engaged.hybrid.defenceranged = set_combine(sets.engaged.hybrid.defence,{
		range="Animator P II +1",
	})

	sets.engaged.hybrid.defencegodhands = set_combine(sets.engaged.hybrid.defence,{
		left_ear="Mache Earring +1",
	})

	sets.engaged.hybrid.defencegodhandsranged = set_combine(sets.engaged.hybrid.defencegodhands,{
		range="Animator P II +1",
	})

---------------------------	PET ONLY ENGAGED SETS	---------------------------

-- Normal
	sets.engaged.pet.normal = {
		ammo="Automat. Oil +3",
		head={ name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
		hands={ name="Taeon Gloves", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		legs={ name="Taeon Tights", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Crep. Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="C. Palug Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

--Normal Ohtas equiped
	sets.engaged.pet.normalohtas = set_combine(sets.engaged.pet.normal,{
		waist="Incarnation Sash",
	})

--Bruiser tank 
	sets.engaged.pet.bruiser = {
		ammo="Automat. Oil +3",
		head={ name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		body={ name="Taeon Tabard", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		hands={ name="Taeon Gloves", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		legs={ name="Taeon Tights", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		feet={ name="Taeon Boots", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Rimeice Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="C. Palug Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

-- Bruiser tank Ohtas equipped
	sets.engaged.pet.bruiserohtas = set_combine(sets.engaged.pet.bruiser,{
		waist="Incarnation Sash",
	})

-- ranged dps (use xiucoatl)
	sets.engaged.pet.ranged = {
		ammo="Automat. Oil +3",
		head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
		hands="Mpaca's Gloves",
		legs="Kara. Pantaloni +2",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Crep. Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Fickblix's Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

--Turtle Tank
	sets.engaged.pet.turtle = {
		ammo="Automat. Oil +3",
       	head={ name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Accuracy+3','Pet: Haste+5',}},
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Shepherd's Chain",
		waist="Isa Belt",
		left_ear="Rimeice Earring",
		right_ear="Hypaspist Earring",
		left_ring="C. Palug Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}


---------------------------	OVERDRIVE ENGAGED SETS	---------------------------
--Sharpshot overdrive
	sets.engaged.overdrive.sharpshot = {
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Kara. Cappello +3",
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
		hands="Mpaca's Gloves",
		legs="Heyoka Subligar +1",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Rimeice Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Fickblix's Ring",
		right_ring="Thur. Ring +1",
		back={ name="Dispersal Mantle", augments={'STR+2','DEX+4','Pet: TP Bonus+500',}},
	}

--Sharpshot overdrive Defence
	sets.engaged.overdrive.sharpshotDEF = {
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Kara. Cappello +3",
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Rimeice Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Fickblix's Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

--valoredge overdrive
	sets.engaged.overdrive.valoredge = {
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head={ name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		body={ name="Taeon Tabard", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		hands={ name="Taeon Gloves", augments={'Pet: Accuracy+23 Pet: Rng. Acc.+23','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		legs={ name="Taeon Tights", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Rimeice Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="C. Palug Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

--Valoredge overdrive Defence
	sets.engaged.overdrive.valoredgeDEF = {
		range="Animator P +1",
		ammo="Automat. Oil +3",
		head="Kara. Cappello +3", 
		body={ name="Rao Togi +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		hands={ name="Rao Kote +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		legs={ name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		feet={ name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}},
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Rimeice Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Fickblix's Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

---------------------------	MASTER ONLY ENGAGED SETS	---------------------------
-- Master sets for master mode
	sets.engaged.master.normal = {
        range="Neo Animator",
		ammo="Automat. Oil +3",
		head="Malignance Chapeau",
		body="Mpaca's Doublet",
		hands="Karagoz Guanti +3",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck="Shulmanu Collar",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

--Normal - Godhands/xiucoatl equipped
	sets.engaged.master.godhands = set_combine(sets.engaged.master.normal,{
		left_ear="Mache Earring +1",
	})
	
-- Defence
	sets.engaged.master.defence = {
		range="Neo Animator",
		ammo="Automat. Oil +3",
		head="Malignance Chapeau",
		body="Malignance Tabard",
		hands="Malignance Gloves",
		legs="Malignance Tights",
		feet="Malignance Boots",
		neck={ name="Loricate Torque +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

--Defence - Godhands/xiucoatl equipped
	sets.engaged.master.defencegodhands = set_combine(sets.engaged.master.defence,{
		left_ear="Mache Earring +1",
	})

---- Master Sets for Hybrid Mode (For when pet dies or is not engaged - you shouldn't need to change below) 
--Hybrid Master
	sets.engaged.master.hybrid = set_combine(sets.engaged.master.normal,{
		range="Animator P +1",
	})

	sets.engaged.master.hybridranged = set_combine(sets.engaged.master.normal,{
		range="Animator P II +1",
	})
	
	sets.engaged.master.hybridgodhands = set_combine(sets.engaged.master.godhands,{
		range="Animator P +1",
	})
	
	sets.engaged.master.hybridgodhandsranged = set_combine(sets.engaged.master.godhands,{
		range="Animator P II +1",
	})
	
	
-- Defence Master
	sets.engaged.master.hybriddefence = set_combine(sets.engaged.master.defence,{
		range="Animator P +1",
	})
	
	sets.engaged.master.hybriddefenceranged = set_combine(sets.engaged.master.defence,{
		range="Animator P II +1",
	})

	sets.engaged.master.hybriddefencegodhands = set_combine(sets.engaged.master.defencegodhands,{
		range="Animator P +1",
	})

	sets.engaged.master.hybriddefencegodhandsranged = set_combine(sets.engaged.master.defencegodhands,{
		range="Animator P II +1",
	})
---------------------------	PRECAST SETS	---------------------------

---------------------------	PRECAST / JOB ABILITY MASTER SETS	---------------------------

-- fastcast	
	sets.precast.master.fastcast = {
		ammo="Automat. Oil +3",
		head={ name="Herculean Helm", augments={'"Fast Cast"+5','"Mag.Atk.Bns."+14',}},
		body="Vrikodara Jupon",
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+8','"Fast Cast"+6','INT+4',}},
		feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+8','"Fast Cast"+6','INT+9',}},
		neck="Voltsurge Torque",
		left_ring="Rahab Ring",
		right_ring="Prolix Ring",
		back="Swith Cape",
	}

--Job Abilities--
--  overload
	sets.ja.overload = {
		body="Kara. Farsetto +2",
		hands="Foire Dastanas +1",
		neck="Bfn. Collar +1",
		left_ear="Burana Earring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

-- Provoke (you want an enmity set for your provoke)
	sets.ja.enmity = {
	}

--  individual abilities
    sets.ja.optimization = {
		head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
	}
	sets.ja.overdrive = {
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
	}
	sets.ja.finetuning = {
		hands={ name="Pitre Dastanas +3", augments={'Enhances "Fine-Tuning" effect',}},
	}
	sets.ja.ventriloquy = {
		hands={ name="Pitre Dastanas +3", augments={'Enhances "Fine-Tuning" effect',}},
	}
	sets.ja.rolereversal = {
		feet={ name="Pitre Babouches +3", augments={'Enhances "Role Reversal" effect',}},
	}
	sets.ja.tacticalswitch = {
	    feet="Karagoz Scarpe +2",
	}
	sets.ja.repair = {
	    left_ear="Guignol Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		feet="Foire Bab. +1",
	}

---------------------------	PRECAST PET SETS	---------------------------
---- Precast Pet ----
	sets.precast.pet.fastcast = {
		ammo="Automat. Oil +3",
		head={ name="Naga Somen", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
		body={ name="Naga Samue", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
		hands={ name="Naga Tekko", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
		legs={ name="Pitre Churidars +3", augments={'Enhances "Ventriloquy" effect',}},
		feet={ name="Naga Kyahan", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
		neck="Empath Necklace",
		waist="Ukko Sash",
		right_ear="Burana Earring",
		right_ring="Thur. Ring +1",
	}

---------------------------	MIDCAST MASTER SETS	---------------------------
-- Master Midcast
	sets.midcast.master.spelldamage = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
		neck="Deviant Necklace",
		left_ear="Saviesa Pearl",
		right_ear="Friomisi Earring",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring +1",
	}

-- Midcast for trusts - want to have 119 gear in head,body,hands,legs,feet.
	sets.midcast.master.trust = {
		head="Nyame Helm",
		body="Nyame Mail",
		hands="Nyame Gauntlets",
		legs="Nyame Flanchard",
		feet="Nyame Sollerets",
	}


---------------------------	MIDCAST PET SETS	---------------------------
--pet midcast Enmity gain
	sets.midcast.pet.enmity = {
		head="Heyoka Cap +1",
		body="Heyoka Harness",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar +1",
		feet="Heyoka Leggings",
		left_ear="Rimeice Earring",
	}
	
-- pet midcast BLM
	sets.midcast.pet.nuke = {
		ammo="Automat. Oil +3",
		head="Kara. Cappello +3",
		body="Udug Jacket",
		hands="Karagoz Guanti +3",
		legs={ name="Pitre Churidars +3", augments={'Enhances "Ventriloquy" effect',}},
		feet={ name="Pitre Babouches +3", augments={'Enhances "Role Reversal" effect',}},
		neck="Adad Amulet",
		waist="Ukko Sash",
		left_ear="Burana Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Fickblix's Ring",
		right_ring="C. Palug Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

-- pet midcast WHM
	sets.midcast.pet.cure = {
		ammo="Automat. Oil +3",
		head={ name="Naga Somen", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
		body={ name="Naga Samue", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
		hands={ name="Naga Tekko", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
		legs="Foire Churidars +1",
		feet={ name="Naga Kyahan", augments={'Pet: MP+80','Automaton: "Cure" potency +4%','Automaton: "Fast Cast"+3',}},
		waist="Ukko Sash",
		right_ear="Burana Earring",
		right_ring="Thur. Ring +1",
	}

-- Pet midcast RDM
	sets.midcast.pet.buff = {
		ammo="Automat. Oil +3",
		head="Kara. Cappello +3",
		body="Kara. Farsetto +2",
		hands="Karagoz Guanti +3",
		legs="Kara. Pantaloni +2",
		feet="Mpaca's Boots",
		neck="Adad Amulet",
		waist="Ukko Sash",
		right_ear="Burana Earring",
		left_ring="Fickblix's Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}


---------------------------	WEAPONSKILL SETS	---------------------------

---------------------------	MASTER WS SETS	---------------------------
--  weaponskills
     sets.ws.master.weaponskill = {
	    head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	sets.ws.master.stringingpummel = {
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
		}
	
	sets.ws.master.victorysmite = {
	    head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	sets.ws.master.shijinspiral = {
		head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Mache Earring +1",
		right_ear="Schere Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	sets.ws.master.howlingfist = {
		head="Mpaca's Cap",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs={ name="Nyame Flanchard", augments={'Path: B',}},
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	sets.ws.master.ragingfists = {
	    head="Mpaca's Cap",
		body="Mpaca's Doublet",
		hands="Mpaca's Gloves",
		legs="Mpaca's Hose",
		feet="Mpaca's Boots",
		neck="Fotia Gorget",
		waist="Moonbow Belt +1",
		left_ear="Schere Earring",
		right_ear={ name="Moonshade Earring", augments={'"Mag.Atk.Bns."+4','TP Bonus +250',}},
		left_ring="Niqmaddu Ring",
		right_ring="Gere Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	sets.ws.master.asuranfists = {
	    head="Kara. Cappello +3",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands={ name="Nyame Gauntlets", augments={'Path: B',}},
		legs="Mpaca's Hose",
		feet={ name="Nyame Sollerets", augments={'Path: B',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Schere Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Niqmaddu Ring",
		right_ring="Sroda Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+5','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

---------------------------	PET WEAPONSKILL SETS	---------------------------
-- pet Arcubalista / Daze Weaponskill set
	sets.ws.pet.arcuballista = {
		head="Kara. Cappello +3",
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
		hands="Mpaca's Gloves",
		legs="Kara. Pantaloni +2  ",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Burana Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Fickblix's Ring",
		right_ring="Thur. Ring +1",
		back={ name="Dispersal Mantle", augments={'STR+2','DEX+4','Pet: TP Bonus+500',}},
	}

-- pet Bonecrusher Weaponskill set
	sets.ws.pet.bonecrusher = {
		--head="Kara. Cappello +3",
		head={ name="Taeon Chapeau", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		body={ name="Taeon Tabard", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		hands="Mpaca's Gloves",
		legs={ name="Taeon Tights", augments={'Pet: Accuracy+20 Pet: Rng. Acc.+20','Pet: "Dbl. Atk."+5','Pet: Damage taken -4%',}},
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Incarnation Sash",
		left_ear="Burana Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="C. Palug Ring",
		right_ring="Fickblix's Ring",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

---------------------------	ITEM SETS	---------------------------
	sets.items.holywater = {
		neck="Nicander's Necklace",
		left_ring="Purity Ring",
		right_ring="Blenmot's Ring",
	}

end

---------------------------	LOGIC	---------------------------

-- Registering event for pet changes -- Essentially, this checks the Pet TP every second, and if it reaches 850+ it automatically swaps to the appropriate pet weaponskill set.
windower.register_event('time change', function(new, old)
	if new > old and pet.isvalid and pet.status == "Engaged" then 
		if ( Mode == "Hybrid" or Mode == "HybridDEF" ) and pet.tp >= 850 and player.tp <= 400 then
			if pet.frame == "Sharpshot Frame" then
				equip(sets.ws.pet.arcuballista)
			end
			if pet.frame == "Valoredge Frame" or pet.frame == "Harlequin Frame" then
				equip(sets.ws.pet.bonecrusher)
			end
		end
	end
	if new > old then
		check_pet_status()
	end
end)


-- How swaps are calculated --
function idle()
	if Mode == "Emergency-DT" then
		equip(sets.idle.tank)
	elseif Mode == "Hybrid" or Mode == "HybridDEF" then
		if player.status == "Idle" and pet.status == "Engaged" then
			if pet.frame == "Valoredge Frame" or pet.frame == "Harlequin Frame" then
				if player.equipment.main == "Ohtas" then
					equip(sets.engaged.pet.bruiserohtas)
				else
					equip(sets.engaged.pet.bruiser)
				end
			elseif pet.frame == "Sharpshot Frame" then
				if pet.head == "Sharpshot Head" then
					equip(sets.engaged.pet.ranged)
				elseif pet.head ~= "Sharpshot Head" then
					if player.equipment.main == "Ohtas" then
						equip(sets.engaged.pet.normalohtas)
					else
						equip(sets.engaged.pet.normal)
					end
				end
			elseif pet.frame == "Stormwaker Frame" then
				equip(sets.precast.pet.fastcast)
			end
		elseif player.status == "Engaged" and pet.status == "Engaged" then
			if player.equipment.main == "Godhands" or player.equipment.main == "Xiucoatl" then	
				if Mode == "Hybrid" then
					if Pet_Distance == "Melee" then
						equip(sets.engaged.hybrid.godhands)
					elseif Pet_Distance == "Ranged" then
						equip(sets.engaged.hybrid.godhandsranged)
					end
				elseif Mode == "HybridDEF" then
					if Pet_Distance == "Melee" then
						equip(sets.engaged.hybrid.defencegodhands)
					elseif Pet_Distance == "Ranged" then
						equip(sets.engaged.hybrid.defencegodhandsranged)
					end
				end
			else
				if Mode == "Hybrid" then
					if Pet_Distance == "Melee" then
						equip(sets.engaged.hybrid.normal)
					elseif Pet_Distance == "Ranged" then
						equip(sets.engaged.hybrid.normalranged)
					end
				elseif Mode == "HybridDEF" then
					if Pet_Distance == "Melee" then
						equip(sets.engaged.hybrid.defence)
					elseif Pet_Distance == "Ranged" then
						equip(sets.engaged.hybrid.defenceranged)
					end
				end
			end
		elseif player.status == "Engaged" and (pet.status == "Idle" or pet.isvalid == false) then
			if player.equipment.main == "Godhands" or player.equipment.main == "Xiucoatl" then	
				if Mode == "Hybrid" then
					if Pet_Distance == "Melee" then
						equip(sets.engaged.master.hybridgodhands)
					elseif Pet_Distance == "Ranged" then
						equip(sets.engaged.master.hybridgodhandsranged)
					end
				elseif Mode == "HybridDEF" then
					if Pet_Distance == "Melee" then
						equip(sets.engaged.master.hybriddefencegodhands)
					elseif Pet_Distance == "Ranged" then
						equip(sets.engaged.master.hybriddefencegodhandsranged)
					end
				end
			else
				if Mode == "Hybrid" then
					if Pet_Distance == "Melee" then
						equip(sets.engaged.master.hybrid)
					elseif Pet_Distance == "Ranged" then
						equip(sets.engaged.master.hybridranged)
					end
				elseif Mode == "HybridDEF" then
					if Pet_Distance == "Melee" then
						equip(sets.engaged.master.hybriddefence)
					elseif Pet_Distance == "Ranged" then
						equip(sets.engaged.master.hybriddefenceranged)
					end
				end
			end
		else  
			equip(sets.idle.normal)
		end
	elseif Mode == "Master" or Mode == "MasterDEF" then
		if player.status == "Engaged" then
			if player.equipment.main == "Godhands" or player.equipment.main == "Xiucoatl" then	
				if Mode == "Master" then
					equip(sets.engaged.master.godhands)
				elseif Mode == "MasterDEF" then
					equip(sets.engaged.master.defencegodhands)
				end
			else
				if Mode == "Master" then
					equip(sets.engaged.master.normal)
				elseif Mode == "MasterDEF" then
					equip(sets.engaged.master.godhands)
				end
			end
		else
			equip(sets.idle.normal)
		end
	elseif Mode == "Overdrive" or Mode == "OverdriveDEF" then
		if pet.status == "Engaged" then
			if Mode == "Overdrive" then
				if pet.frame == "Sharpshot Frame" then
					equip(sets.engaged.overdrive.sharpshot)
				elseif pet.frame == "Valoredge Frame" then
					equip(sets.engaged.overdrive.valoredge)
				end
			elseif Mode == "OverdriveDEF" then
				if pet.frame == "Sharpshot Frame" then
					equip(sets.engaged.overdrive.sharpshotDEF)
				elseif pet.frame == "Valoredge Frame" then
					equip(sets.engaged.overdrive.valoredgeDEF)
				end
			end
		else
			equip(sets.idle.normal)
		end
	elseif Mode == "PetDEF" then
		equip(sets.engaged.pet.turtle)
	elseif Mode == "Pet" then
		if pet.status == "Engaged" then
			if pet.frame == "Valoredge Frame" or pet.frame == "Harlequin Frame" then
				if player.equipment.main == "Ohtas" then
					equip(sets.engaged.pet.bruiserohtas)
				else
					equip(sets.engaged.pet.bruiser)
				end
			elseif pet.frame == "Sharpshot Frame" then
				if pet.head == "Sharpshot Head" then
					equip(sets.engaged.pet.ranged)
				elseif pet.head ~= "Sharpshot Head" then
					if player.equipment.main == "Ohtas" then
						equip(sets.engaged.pet.normalohtas)
					else
						equip(sets.engaged.pet.normal)
					end
				end
			elseif pet.frame == "Stormwaker Frame" then
				equip(sets.precast.pet.fastcast)
			end
		else
			equip(sets.engaged.pet.turtle)
		end
	end
end

function status_change(new,old)
	if new == "Engaged" then
		idle()
	elseif new == "Idle" then 
		idle()
	end
end

function pet_status_change(new,old)
	if new == "Engaged" then 
		idle()
	elseif new == "Idle" then 
		idle()
	end
end

function precast(spell)
	if spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "Trust" then 
		equip(sets.precast.master.fastcast)
	elseif spell.type == "WeaponSkill" then 
		if spell.english == "Stringing Pummel" then
			equip(sets.ws.master.stringingpummel)
		elseif spell.english == "Victory Smite" then
			equip(sets.ws.master.victorysmite)
		elseif spell.english == "Shijin Spiral" or spell.english == "Evisceration" then
			equip(sets.ws.master.shijinspiral)
		elseif spell.english == "Howling Fist" then
			equip(sets.ws.master.howlingfist)
		elseif spell.english == "Raging Fists" then
			equip(sets.ws.master.ragingfists)
		elseif spell.english == "Asuran Fists" then
			equip(sets.ws.master.asuranfists)
		else
			equip(sets.ws.master.weaponskill)
		end
	elseif spell.english == "Provoke" then
		equip(sets.ja.enmity)
	elseif spell.english == "Fire Maneuver" or spell.english == "Ice Maneuver" or 
	spell.english == "Wind Maneuver" or spell.english == "Earth Maneuver" or 
	spell.english == "Thunder Maneuver" or spell.english == "Water Maneuver" or 
	spell.english == "Light Maneuver" or spell.english == "Dark Maneuver" then
		if buffactive["Overdrive"] then
			idle()
		else
			equip(sets.ja.overload)
		end
	elseif spell.english == "Tactical Switch" then
		equip(sets.ja.tacticalswitch)
	elseif spell.english == "Overdrive" then
		equip(sets.ja.overdrive)
	elseif spell.english == "Role Reversal" then
		equip(sets.ja.rolereversal)
	elseif spell.english == "Repair" or spell.english == "Maintenance" then
		equip(sets.ja.repair)
	elseif spell.english == "Ventriloquy" then
		equip(sets.ja.ventriloquy)
	elseif spell.english == "Holy Water" then
		equip(sets.items.holywater)
	end
end


function midcast(spell)
	if spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" then 
		equip(sets.midcast.master.spelldamage)
	elseif spell.type == "Trust" then
		equip(sets.midcast.master.trust)
	end
end

function pet_midcast(spell)
	if pet.frame == "Valoredge Frame" then
		equip(sets.midcast.pet.enmity)
	elseif pet.head == "Spiritreaver Head" and pet.frame == "Stormwaker Frame" then
		equip(sets.midcast.pet.nuke)
	elseif pet.head == "Soulsoother Head" and pet.frame == "Stormwaker Frame" then
		equip(sets.midcast.pet.cure)
	elseif pet.head == "Stormwaker Head" and pet.frame == "Stormwaker Frame" then
		equip(sets.midcast.pet.buff)
	else
		idle()
	end
end


function aftercast(spell)
	if spell.english == "Deactivate" then
		check_pet_status()
	else
		idle()
	end
end

function pet_aftercast(spell)
	idle()
end

function self_command(command)
	if command == "ToggleHybrid" then
		if Mode == "HybridDEF" or Mode == "Master" or Mode == "MasterDEF" or Mode == "Overdrive" or Mode == "OverdriveDEF" or Mode == "Pet" or Mode == "PetDEF" or Mode == "Emergency-DT" then
			Mode = "Hybrid"
			idle()
		elseif Mode == "Hybrid" then
			Mode = "HybridDEF"
			idle()
		end
	elseif command == "ToggleMaster" then
		if Mode == "Hybrid" or Mode == "HybridDEF" or Mode == "MasterDEF" or Mode == "Overdrive" or Mode == "OverdriveDEF" or Mode == "Pet" or Mode == "PetDEF" or Mode == "Emergency-DT"then
			Mode = "Master"
			Pet_Distance = "Melee"
			if player.equipment.Range ~= "Neo Animator" then
				send_command ('input /equip Range "Neo Animator"')
			end
			idle()
		elseif Mode == "Master" then
			Mode = "MasterDEF"
			Pet_Distance = "Melee"
			if player.equipment.Range ~= "Neo Animator" then
				send_command ('input /equip Range "Neo Animator"')
			end
			idle()
		end
	elseif command == "ToggleOverdrive" then
		if Mode == "Hybrid" or Mode == "HybridDEF" or Mode == "Master" or Mode == "MasterDEF" or Mode == "OverdriveDEF" or Mode == "Pet" or Mode == "PetDEF" or Mode == "Emergency-DT" then
			Mode = "Overdrive"
			Pet_Distance = "Melee"
			if player.equipment.Range ~= "Animator P +1" then
				send_command ('input /equip Range "Animator P +1"')
			end
			idle()
		elseif Mode == "Overdrive" then
			Mode = "OverdriveDEF"  
			Pet_Distance = "Melee"
			if player.equipment.Range ~= "Animator P +1" then
				send_command ('input /equip Range "Animator P +1"')
			end
			idle()
		end
	elseif command == "TogglePet" then
		if Mode == "Hybrid" or Mode == "HybridDEF" or Mode == "Master" or Mode == "MasterDEF" or Mode == "Overdrive" or Mode == "OverdriveDEF" or Mode == "Pet" or Mode == "Emergency-DT" then
			Mode = "PetDEF"
			idle()
		elseif Mode == "PetDEF" then
			Mode = "Pet"
			idle()
		end
	elseif command == "ToggleEmergency" then
		if Mode == "Hybrid" or Mode == "HybridDEF" or Mode == "Master" or Mode == "MasterDEF" or Mode == "Overdrive" or Mode == "OverdriveDEF" or Mode == "Pet" or Mode == "PetDEF" or Mode == "Emergency-DT" then
			Mode = "Emergency-DT"
			idle()
		end
	elseif command == "ToggleDistance" then
		if Pet_Distance == "Melee" then
			Pet_Distance = "Ranged"
			send_command ('input /equip Range "Animator P II +1"')
			idle()
		elseif Pet_Distance == "Ranged" then
			Pet_Distance = "Melee"
			send_command ('input /equip Range "Animator P +1"')
			idle()
		end
	elseif command == "ToggleWeapon" then
		if Mode == "Hybrid" or Mode == "HybridDEF" then
			if player.equipment.Main == "Kenkonken" then
				send_command ('input /equip Main "Xiucoatl"')
			elseif player.equipment.Main == "Xiucoatl" then
				send_command ('input /equip Main "Godhands"')
			elseif player.equipment.Main == "Godhands" then
				send_command ('input /equip Main "Verethragna"')
			elseif player.equipment.Main == "Verethragna" then
				send_command ('input /equip Main "Ohtas"')
			else
				send_command ('input /equip Main "Kenkonken"')
			end
		elseif Mode == "Master" or Mode == "MasterDEF" or Mode == "Emergency-DT"  then
			if player.equipment.Main == "Godhands" then
				send_command ('input /equip Main "Verethragna"')
			elseif player.equipment.Main == "Verethragna" then
				send_command ('input /equip Main "Kenkonken"')
			else
				send_command ('input /equip Main "Godhands"')
			end
		elseif Mode == "Overdrive" or Mode == "OverdriveDEF" then
			if player.equipment.Main == "Xiucoatl" then
				send_command ('input /equip Main "Kenkonken"')
			else
				send_command ('input /equip Main "Xiucoatl"')
			end
		elseif Mode == "Pet" then
			if player.equipment.Main == "Xiucoatl" then
				send_command ('input /equip Main "Sakpata\'s Fists"')
			elseif player.equipment.Main == "Sakpata's Fists" then
				send_command ('input /equip Main "Ohtas"')
			else
				send_command ('input /equip Main "Xiucoatl"')
			end
		elseif Mode == "PetDEF" then
			if player.equipment.Main == "Gnafron's Adargas" then
				send_command ('input /equip Main "Ohtas"')
			else
				send_command ('input /equip Main "Gnafron\'s Adargas"')
			end
		end
	end
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end

function check_pet_status()
	if pet.isvalid then
		if pet.head == "Soulsoother Head" and pet.frame == "Valoredge Frame" then
			Pet_Mode = "Tank"
		elseif pet.head == "Valoredge Head" and pet.frame == "Valoredge Frame" then
				Pet_Mode = "Bruiser"
		elseif pet.frame == "Harlequin Frame" then
			Pet_Mode = "Bruiser"
		elseif pet.head == "Valoredge Head" and pet.frame == "Sharpshot Frame" then
				Pet_Mode = "Sharpshot"
		elseif pet.head == "Sharpshot Head" and pet.frame == "Sharpshot Frame" then
			Pet_Mode = "Ranged"
		elseif pet.head == "Spiritreaver Head" and pet.frame == "Stormwaker Frame" then
			Pet_Mode = "BLM"
		elseif pet.head == "Soulsoother Head" and pet.frame == "Stormwaker Frame" then
			Pet_Mode = "WHM"
		elseif pet.head == "Stormwaker Head" and pet.frame == "Stormwaker Frame" then
			Pet_Mode = "RDM"
		else
			Pet_Mode = "Other"
		end
	else
		Pet_Mode = "NA"
	end
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end

user_setup()