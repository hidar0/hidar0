do

local function httpsRequest(url)
  print(url)
  local res,code  = https.request(url)
  if code ~= 200 then return nil end
  return json:decode(res)
end

local function searchYoutubeVideos(text)
  local url = 'https://basher.ml/Apiserch.php?'
  url = url..'search='..URL.escape(text)
  local data = httpsRequest(url)

  if not data then
    print("HTTP Error")
    return nil
  elseif not data.items then
    return nil
  end
  return data.items
end

local function run(msg, matches)
  local text = ''
  local items = searchYoutubeVideos(matches[1])
  if not items then
    return "Error!"
  end
  for k,item in pairs(items) do
    text = text..'http://youtu.be/'..results.url..' '..
      item.snippet.title..'\n\n'
  end
  return text
end

return {
  description = "Search video on youtube and send it.",
  usage = "!youtube [term]: Search for a youtube video and send it.",
  patterns = {
    "^!youtube (.*)"
  },
  run = run
}

end
