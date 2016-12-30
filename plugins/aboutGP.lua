--group settings
local function group_setting(msg, data, target)
    if data[tostring(target)] then
      if data[tostring(target)]['settings']['flood_msg_max'] then
        NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
        print('custom'..NUM_MSG_MAX)
      else 
        NUM_MSG_MAX = 5
      end
    end
	local bots_protection = "Yes"
    if data[tostring(target)]['settings']['lock_bots'] then
    	bots_protection = data[tostring(target)]['settings']['lock_bots']
   	end
    local leave_ban = "no"
    if data[tostring(target)]['settings']['leave_ban'] then
    	leave_ban = data[tostring(target)]['settings']['leave_ban']
   	end
	local public = "no"
	if data[tostring(target)]['settings'] then
		if data[tostring(target)]['settings']['public'] then
			public = data[tostring(target)]['settings']['public']
		end
	end
    local settings = data[tostring(target)]['settings']
    local text = "Group settings:\nLock group name : "..settings.lock_name.."\nLock group photo : "..settings.lock_photo.."\nLock group member : "..settings.lock_member.."\nLock group leave : "..leave_ban.."\nflood sensitivity : "..NUM_MSG_MAX.."\nBot protection : "..bots_protection.."\nPublic: "..public
    return text
end

--SuperGroup settings
local function super_group_settings(msg, data, target)
    if data[tostring(target)] then
      if data[tostring(target)]['settings']['flood_msg_max'] then
        NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max'])
        print('custom'..NUM_MSG_MAX)
      else 
        NUM_MSG_MAX = 5
      end
    end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['public'] then
			data[tostring(target)]['settings']['public'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_rtl'] then
			data[tostring(target)]['settings']['lock_rtl'] = 'no'
		end
	end
	if data[tostring(target)]['settings'] then
		if not data[tostring(target)]['settings']['lock_member'] then
			data[tostring(target)]['settings']['lock_member'] = 'no'
		end
	end
  local data_cat = 'rules'  
	local group_rules = data[tostring(target)][data_cat]
	local group_owner = data[tostring(target)]['set_owner']
	local settings = data[tostring(target)]['settings']
    local text = "Group Name : "..settings.set_name.."\nGroup Owner : "..group_owner.."\nGroup Rules : "..group_rules.."\nGroup Link "..settings.set_link.."\n\n➖➖➖➖➖➖➖➖➖\nGroupSettings : \n#Lock Links > "..settings.lock_link.."\n\n#Lock Flood > "..settings.flood.."\n\n#Flood sensitivity > "..NUM_MSG_MAX.."\n\n#Lock Spam > "..settings.lock_spam.."\n\n#Lock Arabic/Persian > "..settings.lock_arabic.."\n\n#Lock Member > "..settings.lock_member.."\n\n#Lock RTL > "..settings.lock_rtl.."\n\n#Lock TGservice > "..settings.lock_tgservice.."\n\n#Lock Sticker > "..settings.lock_sticker.."\n\n#Public > "..settings.public.."\n\n#Strict Settings > "..settings.strict.."\n\n#OFFLINETEAM"
    return text
end

local function run(msg, matches)
    local chat_id = matches[1]
    local print_name = user_print_name(msg.from):gsub("‮", "")
    local name = print_name:gsub("_", " ")
    local chat_id = matches[1]
    local receiver = get_receiver(msg)
    local data = load_data(_config.moderation.data)
	if matches[1] == 'about' and data[tostring(matches[2])]['settings'] then
	    if not is_sudo(msg) then
          return "Sik Kon :)"
        end
		local target = matches[2]
		local group_type = data[tostring(matches[2])]['group_type']
		if group_type == "Group" or group_type == "Realm" then
			savelog(matches[2], name.." ["..msg.from.id.."] requested group settings ")
			return group_settings(msg, data, target)
		elseif group_type == "SuperGroup" then
			savelog(matches[2], name.." ["..msg.from.id.."] requested SuperGroup settings ")
			return super_group_settings(msg, data, target)
		end
	end
end

return {
  patterns = {
	"^[#!/](about) (%d+)$"
  },
  run = run
}