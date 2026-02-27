-- CastStill.lua — GearSwap include file
-- Version: 5.1
--
-- SETUP:
--   1. Place in 'addons/GearSwap/libs/'  or 'addons/Gearswap/data/'
--   2. Add to your job lua: include('CastStill.lua')

------------------------------------------------------------
-- Config
------------------------------------------------------------
caststill = caststill or {}
caststill.stop_window     = caststill.stop_window     or 0.35
caststill.server_delay    = caststill.server_delay    or 0.12
caststill.sample_interval = caststill.sample_interval or 0.10
caststill.move_threshold  = caststill.move_threshold  or 0.20
caststill.still_required  = caststill.still_required  or 2
caststill.recent_window   = caststill.recent_window   or 1.25
if caststill.debug == nil then caststill.debug = false end

------------------------------------------------------------
-- Internal state
------------------------------------------------------------
local cs = {
    -- Movement tracker
    last_check_time = 0,
    last_sample_pos = nil,
    last_move_time  = -999,
    still_samples   = 0,
    is_settled      = true,

    -- Gate state
    pending_cmd     = nil,
    pending_time    = 0,
    settle_start    = nil,
    bypass_until    = 0,

    -- Hook state
    hooked          = false,
}

------------------------------------------------------------
-- Helpers
------------------------------------------------------------
local function dbg(msg)
    if caststill.debug then
        windower.add_to_chat(8, 'CastStill: ' .. msg)
    end
end

local function get_pos()
    local info = windower.ffxi.get_info()
    if not info or not info.logged_in or info.loading then return nil end
    local p = windower.ffxi.get_player()
    if not p then return nil end
    local me = windower.ffxi.get_mob_by_index(p.index)
    if me and me.x and me.y then
        return { x = me.x, y = me.y }
    end
    return nil
end

local function dist(p1, p2)
    if not p1 or not p2 then return 999 end
    local dx = p1.x - p2.x
    local dy = p1.y - p2.y
    return math.sqrt(dx * dx + dy * dy)
end

local function recently_moving()
    return (os.clock() - cs.last_move_time) <= caststill.recent_window
end

------------------------------------------------------------
-- Spell prefixes interrupted by movement
------------------------------------------------------------
local gated_prefixes = {
    ['/magic']    = true,
    ['/ninjutsu'] = true,
    ['/song']     = true,
    ['/trust']    = true,
    ['/item']     = true,
}

------------------------------------------------------------
-- The gate check — called from our precast wrapper
------------------------------------------------------------
local function caststill_check(spell)
    dbg('precast check: ' .. spell.name .. ' | moving=' .. tostring(recently_moving()) .. ' settled=' .. tostring(cs.is_settled))

    if os.clock() < cs.bypass_until then
        dbg('Bypass: ' .. spell.name)
        return false
    end

    if not gated_prefixes[spell.prefix] then
        return false
    end

    if not recently_moving() or cs.is_settled then
        return false
    end

    if cs.pending_cmd then
        dbg('Blocked (already gating): ' .. spell.name)
        return true
    end

    dbg('Gate: ' .. spell.name .. ' (moving, checking if you stop...)')
    cs.pending_cmd = spell.prefix .. ' "' .. spell.name .. '" ' .. spell.target.raw
    cs.pending_time = os.clock()
    cs.settle_start = nil
    return true
end

------------------------------------------------------------
-- Prerender: movement tracking + gate timing + hook
------------------------------------------------------------
windower.raw_register_event('prerender', function()
    local t = os.clock()

    ---- hook: wrap precast after job lua defines it ----
    if not cs.hooked and precast then
        cs.hooked = true
        local orig_precast = precast
        precast = function(spell)
            if caststill_check(spell) then
                cancel_spell()
                return
            end
            return orig_precast(spell)
        end
        dbg('precast wrapped.')
    end

    ---- Movement tracker (throttled) ----
    if (t - cs.last_check_time) >= caststill.sample_interval then
        cs.last_check_time = t

        local pos = get_pos()
        if pos and cs.last_sample_pos then
            if dist(cs.last_sample_pos, pos) >= caststill.move_threshold then
                cs.last_move_time = t
                cs.still_samples = 0
                cs.is_settled = false
            else
                cs.still_samples = cs.still_samples + 1
                if cs.still_samples >= caststill.still_required then
                    cs.is_settled = true
                end
            end
        end
        if pos then cs.last_sample_pos = pos end
    end

    ---- Gate: re-send pending cast when ready ----
    if not cs.pending_cmd then return end

    local elapsed = t - cs.pending_time

    if cs.is_settled then
        if not cs.settle_start then
            cs.settle_start = t
            dbg('Client settled. Waiting for server...')
        end
        if (t - cs.settle_start) >= caststill.server_delay then
            dbg('Server delay done. Re-sending: ' .. cs.pending_cmd)
            cs.bypass_until = t + 0.50
            local cmd = cs.pending_cmd
            cs.pending_cmd = nil
            cs.settle_start = nil
            windower.send_command('input ' .. cmd)
        end
    else
        cs.settle_start = nil
        if elapsed >= caststill.stop_window then
            dbg('Still moving after window. Sending anyway.')
            cs.bypass_until = t + 0.50
            local cmd = cs.pending_cmd
            cs.pending_cmd = nil
            cs.settle_start = nil
            windower.send_command('input ' .. cmd)
        end
    end
end)

windower.add_to_chat(8, 'CastStill v5.1 loaded.')
