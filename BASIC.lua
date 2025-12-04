--  ____                                          _ _     
-- |  _ \                                        | ( )    
-- | |_) |_ __ ___   __ _ _   _ _   _ _ __   __ _| |/ ___ 
-- |  _ <| '__/ _ \ / _` | | | | | | | '_ \ / _` | | / __|
-- | |_) | | | (_) | (_| | |_| | |_| | |_) | (_| | | \__ \
-- |____/|_|  \___/ \__, |\__,_|\__, | .__/ \__,_|_| |___/
--                   __/ |       __/ | |                  
--                  |___/       |___/|_|    
-- ===========================================================================
-- BASIC GEARSWAP FOR NEW PLAYERS
-- ===========================================================================

-- HOW TO USE:
-- 1. Go to Windower/addons/GearSwap/data.
-- 2. Create a folder matching your CHARACTER NAME (e.g., Broguypal).
-- 3. Save this file inside that folder as JOBNAME.lua (e.g., PUP.lua, THF.lua). This has the effect of causing this file to load when you're on the specified job.
-- 4. Edit using Notepad++ for best readability.

--------------------------------------------------------------------------------
-- OPTIONAL: MOUNT / DISMOUNT SHORTCUTS
--------------------------------------------------------------------------------
send_command('bind numpad1 input /mount "Crawler"') 	-- To disable this line, put "--" in front of it "Crawler"')
send_command('bind numpad2 input /dismount') 			-- Same thing here: add "--" at the start to turn it off')


--------------------------------------------------------------------------------
-- EQUIPMENT SETS: This is where you're going to be putting your equipment sets.
--------------------------------------------------------------------------------
function get_sets()
  
    sets.idle = {}                  -- Leave this empty
    sets.precast = {}               -- leave this empty    
    sets.midcast = {}               -- leave this empty    
    sets.aftercast = {}             -- leave this empty
	sets.ws = {}					-- Leave this empty
	sets.ja = {}					-- Leave this empty
 
	--------------------------------------------------------------------------
	-- EDIT BELOW THIS LINE
	--------------------------------------------------------------------------
	-- NOTE 1: Type "//gs export" in-game to create a copy/pasteable document of your currently equipped gear which can be pasted into each set below.
	-- NOTE 2: Typing "//gs export" in-game will make a folder named "export" in Windower/addons/GearSwap/data with a new .lua file within it. Open this folder to copy your equipment set and add it to the applicable set in this file.
	
	-- Example of how to export a set into this file:
	--[[----------------------------------------------------------------------
	
	Step 1: Type "//gs export" in-game to create a "timestamped.lua" file in Windower/addons/GearSwap/data/export. 
	
	Step 2: Open this timestamed file. This file looks like this:
				-------------------------------------------------
				sets.exported = {
					main="Dojikiri Yasutsuna",
					sub="Utu Grip",
					ammo="Crepuscular Pebble",
					head="Mpaca's Cap",
					body="Nyame Mail",
					hands="Kasuga Kote +2",
					legs="Mpaca's Hose",
					feet="Kas. Sune-Ate +2",
					neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
					waist="Sailfi Belt +1",
					left_ear="Moonshade Earring",
					right_ear="Thrud Earring",
					left_ring="Niqmaddu Ring",
					right_ring="Sroda Ring",
					back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
				}
				--------------------------------------------------
	
	Step 3: copy everything within the brackets and add it to the sets listed below. For example, your idle set below currently looks like this:
				---------------------
				sets.idle.normal = {
					-- put your set here
				}
				---------------------
	
	With the added set from the export file, it should now look like this"
	
				--------------------
				sets.idle.normal = {
					ammo="Crepuscular Pebble",
					head="Mpaca's Cap",
					body="Nyame Mail",
					hands="Kasuga Kote +2",
					legs="Mpaca's Hose",
					feet="Kas. Sune-Ate +2",
					neck={ name="Sam. Nodowa +2", augments={'Path: A',}},
					waist="Sailfi Belt +1",
					left_ear="Moonshade Earring",
					right_ear="Thrud Earring",
					left_ring="Niqmaddu Ring",
					right_ring="Sroda Ring",
					back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
				}
				--------------------
	
	Step 4: save your file as you now have an idle set defined. 
	--------------------------------------------------------------------------]]

	-- NOTE 3: After editing, save this file and type "//gs reload" while in-game to apply changes.
	-- NOTE 4: Use "//gs showswaps" to verify gear is swapping correctly.
	-- NOTE 5: AVOID PUTTING WEAPONS / SHIELDS IN YOUR EQUIPMENT SETS AS IT MAY CAUSE YOUR WEAPONS TO SWAP. IF THIS HAPPENS, YOUR TP WILL BE RESET TO ZERO.
	
	--------------------------------------------------------------------------
	---- IDLE SETS
	-- This is your idle set. To disable any gear line, put "--" in front of it.
	-- This set equips when you are NOT engaged with an enemy. Great for damage mitigation and movement speed gear. (Remember - movement speed gear doesnt stack with other movement speed gear!)
	--------------------------------------------------------------------------
    sets.idle.normal = {
		-- put your set here
	}

	--------------------------------------------------------------------------
	---- ENGAGED SETS
	-- This set equips when you ARE engaged in combat. Focus is on TP gain and offensive stats.
	--------------------------------------------------------------------------
	sets.idle.engaged = {
		-- put your set here
	}

	--------------------------------------------------------------------------
	---- PRECAST SETS
	-- This set equips BEFORE a spell is cast to reduce casting time.
	-- You should aim for Fast Cast equipment here
	--------------------------------------------------------------------------
    sets.precast.fastcast = {
		-- put your set here
	}

--------------------------------------------------------------------------
	---- MIDCAST SETS
	-- These sets equip while spells are casting. 
	-- These sets equip DURING the spell. Equipment will vary depending on spell purpose:
	-- • Elemental Magic → INT & Magic Attack Bonus
	-- • Enfeebling Magic → MND & Magic Accuracy
	-- • Enhancing Magic → Duration & Skill
	-- • Healing Magic → Cure Potency
	--------------------------------------------------------------------------
    sets.midcast.elemental = {
		-- put your set here
	}
	
	sets.midcast.enfeebling = {
		-- put your set here
	}

	sets.midcast.enhancing = {
		-- put your set here
	}

	sets.midcast.healing = {
		-- put your set here
	}

--------------------------------------------------------------------------
---- WEAPONSKILL SETS
-- These sets equip when you use a weaponskill. Designed for maximum WS damage.
--------------------------------------------------------------------------
	sets.ws.weapons = {
		-- put your set here
	}

--------------------------------------------------------------------------
---- JOB ABILITY SETS
-- Contains gear that enhances your job abilities. Add items here as needed.
-- Lines can be disabled using "--" before the line.
--------------------------------------------------------------------------
	sets.ja.jobability = {
		-- put your set here
	}
end

-------- DO NOT TOUCH BELOW IF COMPLETELY NEW AT GEARSWAP -- Everything above should be all your basic needs for starting.
function idle()
	if player.status == "Engaged" then 
		equip(sets.idle.engaged) 
	else
		equip(sets.idle.normal)
	end
end

function precast(spell)
	if spell.type == "BlueMagic" or spell.type == "BlackMagic" or spell.type == "WhiteMagic" or spell.type == "Ninjutsu" or spell.type == "BardSong" or spell.type == "Trust" then 
		equip(sets.precast.fastcast)
	elseif spell.type == "WeaponSkill" then 
		equip(sets.ws.weapons)
	elseif spell.type == "JobAbility" then
		equip(sets.ja.jobability)
	end
end

function midcast(spell)
	if spell.type == "BlueMagic" or spell.skill == "Elemental Magic" then
		equip(sets.midcast.elemental)
	elseif spell.skill == "Enfeebling Magic" or spell.skill == "Dark Magic" then
		equip(sets.midcast.enfeebling)
	elseif spell.skill == "Enhancing Magic" then
		equip(sets.midcast.enhancing)
	elseif spell.skill == "Healing Magic" then
		equip(sets.midcast.healing)
	end
end

function aftercast(spell)
		idle()
end

function status_change(new,old)
	if new == "Engaged" then
		idle()
	else
		idle()
	end
end