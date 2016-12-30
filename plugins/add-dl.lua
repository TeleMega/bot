local function parsed_url(link)
  local parsed_link = URL.parse(link)
  local parsed_path = URL.parse_path(parsed_link.path)
  return parsed_path[2]
end

local function run(msg,matches)
			local ferisystem = "user#id"..266215753 --Put Your Telegram-ID Here
		if msg.service and msg.action.type == "chat_add_user" and msg.action.user.id == tonumber(our_id) then
			local texi_add = 'Now '..string.gsub(msg.from.print_name, '_', ' ')..' ['..msg.from.id..'] #Added Me to '..string.gsub(msg.to.print_name, '_', ' ')..' ['..msg.to.id..']\n#Check_Now☢'
	send_msg(ferisystem, texi_add, ok_cb, false)
	end
		if msg.service and msg.action.type == "chat_del_user" and msg.action.user.id == tonumber(our_id) then
			local texi_del = 'Now '..string.gsub(msg.from.print_name, '_', ' ')..' ['..msg.from.id..'] #Removed Me From '..string.gsub(msg.to.print_name, '_', ' ')..' ['..msg.to.id..']\n#Check_Now☢'
		send_msg(ferisystem, texi_del, ok_cb, false)
	end
		if matches[1] == "import" and is_admin(msg) then --join by group link
			local hash = parsed_url(matches[2])
			local texi = string.gsub(msg.from.print_name, '_', ' ')..' Invited Me By This Link👇\n'..matches[2]
		send_msg(ferisystem, texi, ok_cb, false)
			import_chat_link(hash,ok_cb,false)
		end
	end
	return {
		description = "The Bot Say you when Add/Remove to Group/supergroup  Invite Bot By Link", 
		usage = {
    "Add Bot to a group/supergroup",
    "Remove Bot of a group/supergroup"
	"/import [link]: Join bot to Link group/supergroup"
  },
		patterns = { 
	"^!!tgservice (chat_add_user)$",
	"^!!tgservice (chat_del_user)$",
	"^[#!/](import) (.*)$",
  },
	run = run
  }
  
 --write by : @MutePuker
 --channel : @MuteTeam
  CopyRight© MuteTeam