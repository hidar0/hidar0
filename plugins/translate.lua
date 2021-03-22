function translate(msg,MsgText)
local Text = MsgText[1]

if Text == "تفعيل الترجمة" or Text == "تفعيل الترجمه" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local NameUser   = Hyper_Link_Name(data)
if redis:get(saied.."translate"..msg.chat_id_) then
return sendMsg(msg.chat_id_,msg.id_,"🔒¦ تم بالتأكيد تفعيل الترجمة    \n📮¦ بواسطه ⋙「 "..NameUser.." 」 " )        else
redis:set(saied.."translate"..msg.chat_id_,true)
return sendMsg(msg.chat_id_,msg.id_,"🔒¦ تم تفعيل الترجمة بنجاح   \n📮¦ بواسطه ⋙「 "..NameUser.." 」 " )
end
end,{msg=msg})
end
if Text == "تعطيل الترجمة" or Text == "تعطيل الترجمه" then
if not msg.Admin then return "📪¦ هذا الامر يخص {الادمن,المدير,المنشئ,المطور} فقط  \n" end
GetUserID(msg.sender_user_id_,function(arg,data)
msg = arg.msg 
local NameUser   = Hyper_Link_Name(data)
if not redis:get(saied.."translate"..msg.chat_id_) then
return sendMsg(msg.chat_id_,msg.id_,"🔓¦ تم بالتأكيد تعطيل الترجمة    \n📮¦ بواسطه ⋙「 "..NameUser.." 」 " )        else 
redis:del(saied.."translate"..msg.chat_id_)
return sendMsg(msg.chat_id_,msg.id_,"🔓¦ تم تعطيل الترجمة بنجاح   \n📮¦ بواسطه ⋙「 "..NameUser.." 」 " ) 
end
end,{msg=msg})
end

if (Text == "/ar" or Text == "/fa" or Text == "/en" or Text == "/ru" or Text == "/tr" or Text == "/fr" or Text == "/it" or Text == "/ta" or Text == "/ja" or Text == "/hn" or Text == "/el" or Text == "/de" or Text == "/uk" or Text == "/ko") and msg.reply_to_message_id_ then
if not redis:get(saied.."translate"..msg.chat_id_) then return "📛*¦* الترجمة معطلة من قبل الادراة" end
tdcli_function({ID="GetMessage",chat_id_ = msg.chat_id_,message_id_ = msg.reply_to_message_id_},function(arg,data)
print(data.content_.text_)
local url , res = https.request('https://asddff55.ml/tr.php?lang='..Text:gsub('/','')..'&text='..data.content_.text_:gsub(" ",'+'):gsub('\n','tr0Atr'))
local get = JSON.decode(url)
if get.code == 200 then
return sendMsg(msg.chat_id_,msg.id_,"تمت الترجمة: من "..get.lang:gsub('-',' الى ').."\n["..get.text:gsub(']',""):gsub('[[]',"").."]")
else
return sendMsg(msg.chat_id_,msg.id_,"حدث خطاء غير متوقع وفشلت الترجمة 📛");
end
return false
end,nil)
end
if Text == "ترجمة" or Text == "ترجمه" then
return sendMsg(msg.chat_id_,msg.id_,"🇸🇾 ـ /ar - للترجمة الى العربية\n🇺🇸 ـ /en - للترجمة الى الانجليزية\n🇹🇷 ـ /tr - للترجمة الى التركية\n🇮🇷 ـ /fa - للترجمة الى الفارسية\n🇷🇺 ـ /ru - للترجمة الى الروسية\n🇫🇷 ـ /fr - للترجمة الى الفرنسية\n🇮🇪 ـ /it - للترجمة الى الإطالية\n🇨🇷 ـ /ta - للترجمة الى التايلاندية\n🇳🇮 ـ /ja - للترجمة الى اليابانية\n🇮🇳 ـ /hn - للترجمة الى الهندية\n🇬🇷 ـ /el - للترجمة الى اليونانية\n🇩🇪 ـ /de - للترجمة الى الألمانية\n🇨🇴 ـ /uk - للترجمة الى الأوكرانية\n🇰🇷 ـ /ko - للترجمة الى الكورية\nـ------------------------------\n🚨 جميع اوامر الترجمة \n🔂 تعمل بالرد على الرسالة المراد ترجمتها")
end
end

return {
Mosnter = {
"^(تفعيل الترجمة)$",
"^(تفعيل الترجمه)$",
"^(تعطيل الترجمة)$",
"^(تعطيل الترجمه)$",
"^(ترجمة)$",
"^(ترجمه)$",
"^(/ar)$",
"^(/fa)$",
"^(/en)$",
"^(/ru)$",
"^(/tr)$",
"^(/fr)$",
"^(/it)$",
"^(/ta)$",
"^(/ja)$",
"^(/hn)$",
"^(/el)$",
"^(/de)$",
"^(/uk)$",
"^(/ko)$",
	},
iMonster = translate
}
