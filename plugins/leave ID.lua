--[[
RRRRR       EEEEEEEEEE     ZZZZZZZZZZ      AAAAA
R    R      E                      Z      A     A
R    R      E                    Z        A     A
R   R       EEEEEEEEEE         Z          AAA-AAA
R RR        E                Z            A     A
R    R      E              Z              A     A
R      R    EEEEEEEEEE    ZZZZZZZZZZ      A     A

@RezaMnk
]]
local function run(msg, matches)
if not is_sudo(msg) then
return false
end
local bot_id = 271787100 --for example 271787100
if matches[1] == "leave" then
chat_del_user("chat#id"..matches[2], 'user#id'..bot_id, ok_cb, false)
leave_channel("channel#id"..matches[2], ok_cb, false)
return "Bot has been leaved "..matches[2]
end
end
return {
  patterns = {
     "^[!#/](leave) (.*)$"
  },
     run = run
  }