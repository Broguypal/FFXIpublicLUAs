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

--------------------------- SETTING UP TEXTBOX ------------------------------------------
TP_Mode = "Hybrid"
Pet_Mode = "NA"
Animator_Mode = "Melee"
Auto_Mode = "Off"
 
TP_Modes = {'Hybrid','HybridDEF','Master','MasterDEF','Overdrive','OverdriveDEF','Pet','PetDEF','Emergency-DT'}
Pet_Modes = {'NA','Bruiser','Tank','Sharpshot','Ranged','WHM','BLM','RDM','Other'}
Animator_Modes = {'Melee', 'Ranged', 'Master'}
Auto_Modes = {'On','Off'}

gearswap_box = function()
	str = '           \\cs(246,102,13)PUPPETMASTER\\cr\n'
	str = str..' Current Mode:\\cs(200,100,200)   '..TP_Mode..'\\cr\n'
	str = str..' Pet Mode:\\cs(54,120,233)   '..Pet_Mode..'\\cr\n'
	str = str..' Animator:\\cs(211,211,211)   '..Animator_Mode..'\\cr\n'
	str = str..' Auto Maneuver:\\cs(211,211,211)   '..Auto_Mode..'\\cr\n'
	str = str..' crl: \\cs(255,255,255)[LGT]\\cr \\cs(255,64,64)[FIR]\\cr \\cs(0,255,0)[WND]\\cr \\cs(180,0,255)[THD]\\cr\n'
	str = str..' alt: \\cs(80,60,100)[DRK]\\cr \\cs(128,255,255)[ICE]\\cr \\cs(165,100,40)[STN]\\cr \\cs(64,128,255)[WTR]\\cr\n'
	-- Strobe status	
	if (TP_Mode == "Hybrid" or TP_Mode == "Pet") and pet and pet.isvalid and (pet.attachments.strobe or pet.attachments["strobe II"]) then	
		if Strobe_Recast <= 0 then
			str = str..' Strobe: \\cs(0,255,0)Ready\\cr\n'
		else
			str = str..' Strobe: \\cs(255,50,50)' .. string.format("%.1f", Strobe_Recast) .. 's\\cr\n'
		end
	end
	-- Flashbulb status
	if (TP_Mode == "Hybrid" or TP_Mode == "Pet") and pet and pet.isvalid and pet.attachments.flashbulb then
		if Flashbulb_Recast <= 0 then
			str = str..' Flashbulb: \\cs(0,255,0)Ready\\cr\n'
		else
			str = str..' Flashbulb: \\cs(255,50,50)' .. string.format("%.1f", Flashbulb_Recast) .. 's\\cr\n'
		end
	end
  return str
end

gearswap_box_config = {pos={x=1250,y=525},padding=8,text={font='sans-serif',size=10,stroke={width=2,alpha=255},Fonts={'sans-serif'},},bg={alpha=0},flags={}}
gearswap_jobbox = texts.new(gearswap_box_config)

function user_setup()
	initialize_weapon_tracking()
	gearswap_jobbox:text(gearswap_box())		
	gearswap_jobbox:show()
	initialize_enmity_logic()
end

function get_sets()
	--------------------------- Commands ----------------------------------
	--------Required Commands Below ----------
	send_command('bind numpad9 gs c ToggleHybrid')
	send_command('bind numpad8 gs c ToggleOverdrive')
	send_command('bind numpad7 gs c TogglePet')
	send_command('bind numpad6 gs c ToggleMaster')
	send_command('bind numpad3 gs c ToggleEmergency')
	send_command('bind numpad4 gs c ToggleWeapon')
	send_command('bind numpad5 gs c ToggleAnimator')
	send_command('bind numpad0 gs c ToggleAutoMode')
	
	-- Manouver commands
	send_command('bind numpad0 gs c ToggleAutoMode')
	
	send_command ('bind ^numpad1 input /ja "Fire Maneuver" <me>')
	send_command ('bind ^numpad2 input /ja "Wind Maneuver" <me>')
	send_command ('bind ^numpad3 input /ja "Thunder Maneuver" <me>')
	send_command ('bind ^numpad0 input /ja "Light Maneuver" <me>')
	send_command ('bind !numpad1 input /ja "Ice Maneuver" <me>')
	send_command ('bind !numpad2 input /ja "Earth Maneuver" <me>')
	send_command ('bind !numpad3 input /ja "Water Maneuver" <me>')
	send_command ('bind !numpad0 input /ja "Dark Maneuver" <me>')

	--------- Personal Commands ---------------
	send_command('bind f9 input /item "Remedy" <me>')
	send_command('bind f10 input /item "Panacea" <me>')
	send_command('bind f11 input /item "Holy Water" <me>')

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
	sets.animators = {}
 	
	---------------------------	GEAR SETS	---------------------------	
	
	-- Note: Please buy a "left_ear="Mache Earring +1"" to make a lot of the swaps work

	---------------------------	DAMAGE TAKEN (for emergencies)	---------------------------	
	-- Master Damage taken --
	sets.idle.Tank = {
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	-- Pet Damage Taken / Regen --
	sets.idle.PetTank = {
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
	sets.idle.Normal = {
		ammo="Automat. Oil +3",
		head="Malignance Chapeau",
		body={ name="Nyame Mail", augments={'Path: B',}},
		hands="Karagoz Guanti +3",
		legs="Kara. Pantaloni +3",
		feet="Hermes' Sandals",
		neck={ name="Bathy Choker +1", augments={'Path: A',}},
		waist="Moonbow Belt +1",
		left_ear="Genmei Earring",
		right_ear={ name="Odnowa Earring +1", augments={'Path: A',}},
		left_ring="C. Palug Ring",
		right_ring="Defending Ring",
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	---------------------------	ENGAGED SETS	---------------------------
	---------------------------	HYRBRID ENGAGED SETS	---------------------------
	-- Normal Hybrid
	sets.engaged.hybrid.Normal = {
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

	-- Normal - Godhands/Xiucoatl equipped --
	sets.engaged.hybrid.Godhands = set_combine(sets.engaged.hybrid.Normal,{left_ear="Mache Earring +1",})

	--Hybrid Dual Tank set
	sets.engaged.hybrid.Defence = {
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
	

	-- Hybrid - Godhands/Xiucoatl equipped --
	sets.engaged.hybrid.DefenceGodhands = set_combine(sets.engaged.hybrid.Defence,{left_ear="Mache Earring +1",})

	---------------------------	MASTER ONLY ENGAGED SETS	---------------------------
	-- Normal Master Mode
	sets.engaged.master.Normal = {
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	--Normal - Godhands/xiucoatl equipped
	sets.engaged.master.Godhands = set_combine(sets.engaged.master.Normal,{left_ear="Mache Earring +1",})

	-- Defence
	sets.engaged.master.Defence = {
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	--Defence - Godhands/xiucoatl equipped
	sets.engaged.master.DefenceGodhands = set_combine(sets.engaged.master.Defence,{left_ear="Mache Earring +1",})

	---------------------------	PET ONLY ENGAGED SETS	---------------------------
	-- Normal
	sets.engaged.pet.Normal = {
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
	sets.engaged.pet.NormalOhtas = set_combine(sets.engaged.pet.Normal,{
		waist="Incarnation Sash",
	})

	--Bruiser tank 
	sets.engaged.pet.Bruiser = {
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
	sets.engaged.pet.BruiserOhtas = set_combine(sets.engaged.pet.Bruiser,{
		waist="Incarnation Sash",
	})

	-- ranged dps (use xiucoatl)
	sets.engaged.pet.Ranged = {
		ammo="Automat. Oil +3",
		head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
		hands="Mpaca's Gloves",
		legs="Kara. Pantaloni +3",
		feet="Mpaca's Boots",
		neck="Shulmanu Collar",
		waist="Klouskap Sash +1",
		left_ear="Crep. Earring",
		right_ear={ name="Kara. Earring +1", augments={'System: 1 ID: 1676 Val: 0','Accuracy+15','Mag. Acc.+15','"Store TP"+5',}},
		left_ring="Fickblix's Ring",
		right_ring="Thur. Ring +1",
		back={ name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Accuracy+10 Pet: Rng. Acc.+10','Pet: Haste+10','System: 1 ID: 1246 Val: 4',}},
	}

	---------------------------	OVERDRIVE ENGAGED SETS	---------------------------
	--Sharpshot overdrive
	sets.engaged.overdrive.Sharpshot = {
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
	sets.engaged.overdrive.SharpshotDEF = {
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

	--Valoredge overdrive
	sets.engaged.overdrive.Valoredge = {
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
	sets.engaged.overdrive.ValoredgeDEF = {
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
		hands="Kurys Gloves",
		legs="Obatala Subligar",
		feet="Ahosi Leggings",
		neck={ name="Unmoving Collar +1", augments={'Path: A',}},
		left_ear="Friomisi Earring",
		right_ear="Trux Earring",
		left_ring="Begrudging Ring",
		right_ring="Eihwaz Ring",
	}

	--  individual abilities
	sets.ja.optimization = {head={ name="Pitre Taj +3", augments={'Enhances "Optimization" effect',}},}
	
	sets.ja.overdrive = {body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},}
	
	sets.ja.finetuning = {hands={ name="Pitre Dastanas +3", augments={'Enhances "Fine-Tuning" effect',}},}
	
	sets.ja.ventriloquy = {hands={ name="Pitre Dastanas +3", augments={'Enhances "Fine-Tuning" effect',}},}
	
	sets.ja.rolereversal = {feet={ name="Pitre Babouches +3", augments={'Enhances "Role Reversal" effect',}},}
	
	sets.ja.tacticalswitch = {feet="Karagoz Scarpe +2",}
	
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
	
	--pet midcast Enmity gain
	sets.precast.pet.enmity = {
		head="Heyoka Cap +1",
		body="Heyoka Harness",
		hands="Heyoka Mittens",
		legs="Heyoka Subligar +1",
		feet="Heyoka Leggings",
		left_ear="Rimeice Earring",
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
		legs="Kara. Pantaloni +3",
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
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
		back={ name="Visucius's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Crit.hit rate+10','Phys. dmg. taken-10%',}},
	}

	---------------------------	PET WEAPONSKILL SETS	---------------------------
	-- pet Arcubalista / Daze Weaponskill set
	sets.ws.pet.arcuballista = {
		head="Kara. Cappello +3",
		body={ name="Pitre Tobe +3", augments={'Enhances "Overdrive" effect',}},
		hands="Mpaca's Gloves",
		legs="Kara. Pantaloni +3",
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

----------------------------------------------------------------------------------
------------- Animator Swaps - Put in your applicable animators here ---------------
----- Note: Please fill this out even if you don't have a specific animator. Totally fine to have these be all the same animator if you're just starting.

	sets.animators.Ranged = {range="Animator P II +1",}
	
	sets.animators.Melee = {range="Animator P +1",}
	
	sets.animators.Master = {range="Neo Animator",}
end

----------------------------------------------------------------------------------------------------
----------------------- MELEE WEAPON SETS (WHAT YOU WANT TO SWAP TO BASED ON MODE) -----------------
	Weapons = {
		Hybrid 			= {"Kenkonken", "Xiucoatl", "Godhands", "Verethragna", "Ohtas"},
		HybridDEF 		= {"Kenkonken", "Xiucoatl", "Godhands", "Verethragna", "Ohtas"},
		Master     		= {"Godhands", "Verethragna", "Kenkonken"},
		MasterDEF  		= {"Godhands", "Verethragna", "Kenkonken"},
		Emergency  		= {"Godhands", "Verethragna", "Kenkonken"},
		Overdrive  		= {"Xiucoatl", "Kenkonken"},
		OverdriveDEF	= {"Xiucoatl", "Kenkonken"},
		Pet        		= {"Xiucoatl", "Sakpata's Fists", "Ohtas"},
		PetDEF     		= {"Gnafron's Adargas", "Ohtas"}
	}


---------------------------	LOGIC	---------------------------
-- Registering event for pet changes -- Essentially, this checks the Pet TP every second, and if it reaches 850+ it automatically swaps to the appropriate pet weaponskill set.
windower.register_event('time change', function(new, old)
	if new > old and pet and pet.isvalid and pet.status == "Engaged" then 
		if ( TP_Mode == "Hybrid" or TP_Mode == "HybridDEF" or TP_Mode == "Pet" ) and pet.tp >= 850 and player.tp <= 400 then
			if pet.frame == "Sharpshot Frame" then
				equip(sets.ws.pet.arcuballista)
			end
			if pet.frame == "Valoredge Frame" or pet.frame == "Harlequin Frame" then
				equip(sets.ws.pet.bonecrusher)
			end
		end
		--Insert this command if you want your character to automatically cast repair if your pet falls below a certain health percentage while engaged (Delete the "--[[ ... ]]")
		--[[if pet.hpp <= 40 then windower.send_command('input /ja "Repair" <me>') end ]]
	end
	if new > old then
		check_pet_status()
	end
end)

-- How swaps are calculated --
function idle()
	if TP_Mode == "Emergency-DT" then
		equip(sets.idle.Tank)
	elseif TP_Mode == "Hybrid" or TP_Mode == "HybridDEF" then
		if player.status == "Idle" and pet and pet.isvalid and pet.status == "Engaged" then
			if pet.frame == "Valoredge Frame" or pet.frame == "Harlequin Frame" then
				if player.equipment.main == "Ohtas" then
					equip(sets.engaged.pet.BruiserOhtas)
				else
					equip(sets.engaged.pet.Bruiser)
				end
			elseif pet.frame == "Sharpshot Frame" then
				if pet.head == "Sharpshot Head" then
					equip(sets.engaged.pet.Ranged)
				elseif pet.head ~= "Sharpshot Head" then
					if player.equipment.main == "Ohtas" then
						equip(sets.engaged.pet.NormalOhtas)
					else
						equip(sets.engaged.pet.Normal)
					end
				end
			elseif pet.frame == "Stormwaker Frame" then
				equip(sets.precast.pet.fastcast)
			end
		elseif player.status == "Engaged" and pet and pet.isvalid and pet.status == "Engaged" then
			if player.equipment.main == "Godhands" or player.equipment.main == "Xiucoatl" then	
				if TP_Mode == "Hybrid" then
					equip(sets.engaged.hybrid.Godhands)
				elseif TP_Mode == "HybridDEF" then
					equip(sets.engaged.hybrid.DefenceGodhands)
				end
			else
				if TP_Mode == "Hybrid" then
					equip(sets.engaged.hybrid.Normal)
				elseif TP_Mode == "HybridDEF" then
					equip(sets.engaged.hybrid.Defence)
				end
			end
		elseif player.status == "Engaged" and (pet.status == "Idle" or pet.isvalid == false) then
			if player.equipment.main == "Godhands" or player.equipment.main == "Xiucoatl" then	
				if TP_Mode == "Hybrid" then
					equip(sets.engaged.master.Godhands)
				elseif TP_Mode == "HybridDEF" then
					equip(sets.engaged.master.Defence)
				end
			else
				if TP_Mode == "Hybrid" then
					equip(sets.engaged.master.Normal)
				elseif TP_Mode == "HybridDEF" then
					equip(sets.engaged.master.Defence)
				end
			end
		else  
			equip(sets.idle.Normal)
		end
	elseif TP_Mode == "Master" or TP_Mode == "MasterDEF" then
		if player.status == "Engaged" then
			if player.equipment.main == "Godhands" or player.equipment.main == "Xiucoatl" then	
				if TP_Mode == "Master" then
					equip(sets.engaged.master.Godhands)
				elseif TP_Mode == "MasterDEF" then
					equip(sets.engaged.master.DefenceGodhands)
				end
			else
				if TP_Mode == "Master" then
					equip(sets.engaged.master.Normal)
				elseif TP_Mode == "MasterDEF" then
					equip(sets.engaged.master.Defence)
				end
			end
		else
			equip(sets.idle.Normal)
		end
	elseif TP_Mode == "Overdrive" or TP_Mode == "OverdriveDEF" then
		if pet and pet.isvalid and pet.status == "Engaged" then
			if TP_Mode == "Overdrive" then
				if pet.frame == "Sharpshot Frame" then
					equip(sets.engaged.overdrive.Sharpshot)
				elseif pet.frame == "Valoredge Frame" then
					equip(sets.engaged.overdrive.Valoredge)
				end
			elseif TP_Mode == "OverdriveDEF" then
				if pet.frame == "Sharpshot Frame" then
					equip(sets.engaged.overdrive.SharpshotDEF)
				elseif pet.frame == "Valoredge Frame" then
					equip(sets.engaged.overdrive.ValoredgeDEF)
				end
			end
		else
			equip(sets.idle.Normal)
		end
	elseif TP_Mode == "PetDEF" then
		equip(sets.idle.PetTank)
	elseif TP_Mode == "Pet" then
		if pet and pet.isvalid and pet.status == "Engaged" then
			if pet.frame == "Valoredge Frame" or pet.frame == "Harlequin Frame" then
				if player.equipment.main == "Ohtas" then
					equip(sets.engaged.pet.BruiserOhtas)
				else
					equip(sets.engaged.pet.Bruiser)
				end
			elseif pet.frame == "Sharpshot Frame" then
				if pet.head == "Sharpshot Head" then
					equip(sets.engaged.pet.Ranged)
				elseif pet.head ~= "Sharpshot Head" then
					if player.equipment.main == "Ohtas" then
						equip(sets.engaged.pet.NormalOhtas)
					else
						equip(sets.engaged.pet.Normal)
					end
				end
			elseif pet.frame == "Stormwaker Frame" then
				equip(sets.precast.pet.fastcast)
			end
		else
			equip(sets.idle.Normal)
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
	if pet.head == "Spiritreaver Head" and pet.frame == "Stormwaker Frame" then
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
	if Animator_Mode == "Melee" then
		equip(sets.animators.Melee)
	elseif Animator_Mode == "Ranged" then
		equip(sets.animators.Ranged)
	elseif Animator_Mode == "Master" then
		equip(sets.animators.Master)
	end
	
	if spell.english == "Deactivate" then
		check_pet_status()
	else
		idle()
	end
end

function pet_aftercast(spell)
    idle()
end

---- Pet Enmity Timers Logic ----
Strobe_Timer = 30
Flashbulb_Timer = 45
PetEnmityDistanceLimit = 30 -- Maximum distance to equip pet enmity gear

-- Runtime
Strobe_Time = 0.0
Flashbulb_Time = 0.0
Strobe_Recast = 0
Flashbulb_Recast = 0

time_start = os.time()
Enmity_Gear_End_Time = 0

function initialize_enmity_logic()
	windower.register_event("prerender", function()
		local now = os.clock()  -- ⬅ High precision timer

		-- Smooth jobbox updates
		gearswap_jobbox:text(gearswap_box())
		gearswap_jobbox:show()

		-- Enmity idle return timer
		if Enmity_Gear_End_Time > 0 and now >= Enmity_Gear_End_Time then
			Enmity_Gear_End_Time = 0
			idle()
		end

		-- Always update recasts smoothly
		if Strobe_Time > 0 then
			Strobe_Recast = math.max(0, Strobe_Timer - (now - Strobe_Time))
		end

		if Flashbulb_Time > 0 then
			Flashbulb_Recast = math.max(0, Flashbulb_Timer - (now - Flashbulb_Time))
		end

		-- Enmity gear logic
		if (TP_Mode == "Hybrid" or TP_Mode == "Pet")
		and pet and pet.isvalid and pet.status == "Engaged"
		and player.hpp > 0 and pet.distance
		and pet.distance < PetEnmityDistanceLimit then

			if buffactive["Fire Maneuver"]
			and (pet.attachments.strobe or pet.attachments["strobe II"])
			and Strobe_Recast <= 2 then
				equip(sets.precast.pet.enmity)
				Enmity_Gear_End_Time = now + 1  -- 1s delay
			elseif buffactive["Light Maneuver"]
			and pet.attachments.flashbulb
			and Flashbulb_Recast <= 2 then
				equip(sets.precast.pet.enmity)
				Enmity_Gear_End_Time = now + 1
			end
		end
	end)

	windower.register_event("incoming text", function(original)
		local now = os.clock()

		if (TP_Mode == "Hybrid" or TP_Mode == "Pet") and pet and pet.isvalid 
		and pet.distance and pet.distance < PetEnmityDistanceLimit then

			if buffactive["Fire Maneuver"]
			and original:contains(pet.name)
			and original:contains("Provoke") then
				add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Strobe done ] *-*-*-*-*-*-*-*-*")
				Strobe_Time = now
				equip(sets.precast.pet.enmity)
				Enmity_Gear_End_Time = now + 1

			elseif buffactive["Light Maneuver"]
			and original:contains(pet.name)
			and original:contains("Flashbulb") then
				add_to_chat(204, "*-*-*-*-*-*-*-*-* [ Flashbulb done ] *-*-*-*-*-*-*-*-*")
				Flashbulb_Time = now
				equip(sets.precast.pet.enmity)
				Enmity_Gear_End_Time = now + 1
			end
		end
		return original
	end)
end

---- Auto Maneuver Logic ----
windower.register_event('lose buff', function(buff_id)
	if buff_id == 300 then
		if Auto_Mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Fire Maneuver" <me>')
		end
	end
	if buff_id == 301 then
		if Auto_Mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Ice Maneuver" <me>')
		end
	end
	if buff_id == 302 then
		if Auto_Mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Wind Maneuver" <me>')
		end
	end
	if buff_id == 303 then
		if Auto_Mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Earth Maneuver" <me>')
		end
	end
	if buff_id == 304 then
		if Auto_Mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Thunder Maneuver" <me>')
		end
	end
	if buff_id == 305 then
		if Auto_Mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Water Maneuver" <me>')
		end
	end
	if buff_id == 306 then
		if Auto_Mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Light Maneuver" <me>')
		end
	end
	if buff_id == 307 then
		if Auto_Mode == "On" and player.hp > 0 and pet and pet.isvalid then
			send_command('input /ja "Dark Maneuver" <me>')
		end
	end
end)

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
	weapon_mode = nil
	last_real_main = player.equipment.main
end

---- Command List ----
function self_command(command)
	if command == "ToggleHybrid" then
		if TP_Mode == "HybridDEF" or TP_Mode == "Master" or TP_Mode == "MasterDEF" or TP_Mode == "Overdrive" or TP_Mode == "OverdriveDEF" or TP_Mode == "Pet" or TP_Mode == "PetDEF" or TP_Mode == "Emergency-DT" then
			TP_Mode = "Hybrid"
			idle()
		elseif TP_Mode == "Hybrid" then
			TP_Mode = "HybridDEF"
			idle()
		end
	elseif command == "ToggleMaster" then
		if TP_Mode == "Hybrid" or TP_Mode == "HybridDEF" or TP_Mode == "MasterDEF" or TP_Mode == "Overdrive" or TP_Mode == "OverdriveDEF" or TP_Mode == "Pet" or TP_Mode == "PetDEF" or TP_Mode == "Emergency-DT" then
			TP_Mode = "Master"
			idle()
		elseif TP_Mode == "Master" then
			TP_Mode = "MasterDEF"
			Pet_Distance = "Melee"
			idle()
		end
	elseif command == "ToggleOverdrive" then
		if TP_Mode == "Hybrid" or TP_Mode == "HybridDEF" or TP_Mode == "Master" or TP_Mode == "MasterDEF" or TP_Mode == "OverdriveDEF" or TP_Mode == "Pet" or TP_Mode == "PetDEF" or TP_Mode == "Emergency-DT" then
			TP_Mode = "Overdrive"
			idle()
		elseif TP_Mode == "Overdrive" then
			TP_Mode = "OverdriveDEF"  
			Pet_Distance = "Melee"
			idle()
		end
	elseif command == "TogglePet" then
		if TP_Mode == "Hybrid" or TP_Mode == "HybridDEF" or TP_Mode == "Master" or TP_Mode == "MasterDEF" or TP_Mode == "Overdrive" or TP_Mode == "OverdriveDEF" or TP_Mode == "Pet" or TP_Mode == "Emergency-DT" then
			TP_Mode = "PetDEF"
			idle()
		elseif TP_Mode == "PetDEF" then
			TP_Mode = "Pet"
			idle()
		end
	elseif command == "ToggleEmergency" then
		if TP_Mode == "Hybrid" or TP_Mode == "HybridDEF" or TP_Mode == "Master" or TP_Mode == "MasterDEF" or TP_Mode == "Overdrive" or TP_Mode == "OverdriveDEF" or TP_Mode == "Pet" or TP_Mode == "PetDEF" or TP_Mode == "Emergency-DT" then
			TP_Mode = "Emergency-DT"
			idle()
		end
	elseif command == "ToggleAnimator" then
		if Animator_Mode == "Melee" then
			Animator_Mode = "Ranged"
			equip(sets.animators.Ranged)
		elseif Animator_Mode == "Ranged" then
			Animator_Mode = "Master"
			equip(sets.animators.Master)
		elseif Animator_Mode == "Master" then
			Animator_Mode = "Melee"
			equip(sets.animators.Melee)
		end
	elseif command == "ToggleAutoMode" then
		if Auto_Mode == "Off" then
			Auto_Mode = "On"
		else 
			Auto_Mode = "Off"
		end
	elseif command == "ToggleWeapon" then
		local list = Weapons[TP_Mode]
		if not list then
			return
		end

		weapon_mode = cycle(list, weapon_mode)
		last_real_main = weapon_mode
		equip({ main = weapon_mode })
	end
	gearswap_jobbox:text(gearswap_box())
	gearswap_jobbox:show()
end

function check_pet_status()
	if pet and pet.isvalid then
		if pet.head == "Soulsoother Head" and pet.frame == "Valoredge Frame" and ( pet.attachments.flashbulb or pet.attachments.strobe or pet.attachments["strobe II"] ) then
			Pet_Mode = "Tank"
		elseif pet.frame == "Valoredge Frame" then
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