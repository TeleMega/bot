function run(msg, matches)
local hash = "with:tag:"..msg.to.id
if is_owner(msg) then
 if matches[1] == "withtag" then
    if matches[2] == "on" then
       if not redis:get(hash) then
          redis:set(hash, "on")
          return "WithTag > on"
       elseif redis:get(hash) == "off" then
          redis:set(hash, "on")
          return "WithTag > on"
       elseif redis:get(hash) == "on" then
          return "WithTag is on now!"
       end
    elseif matches[2] == "off" then
       if not redis:get(hash) then
          redis:set(hash, "off")
          return "WithTag > off"
       elseif redis:get(hash) == "on" then
          redis:set(hash, "off")
          return "WithTag > off"
       elseif redis:get(hash) == "off" then
          return "WithTag is off now!"
       end
    end
 end
end

if not is_momod(msg) or not is_owner(msg) then
if msg.text:match("^(#)(.*)$") then
 if not redis:get("with:tag:"..msg.to.id) or redis:get("with:tag:"..msg.to.id) == "off" or redis:get("with:tag:"..msg.to.id) == "on" then
  return
 end
elseif msg.text:match("^(.*)$") then
 if redis:get("with:tag:"..msg.to.id) == "on" then
delete_msg(msg.id, ok_cb, false)
 elseif not redis:get("with:tag:"..msg.to.id) or redis:get("with:tag:"..msg.to.id) == "off" then
 return
end
end
end
end
return {
patterns = {
"^[!/#](withtag) (on)$",
"^[!/#](withtag) (off)$",
"^(#)(.*)$",
"^(.*)$",
},
run = run
}