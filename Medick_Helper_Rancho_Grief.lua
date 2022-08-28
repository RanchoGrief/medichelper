script_name('Medick Helper')
script_version '3.8.7'
local dlstatus = require "moonloader".download_status
script_author('Rancho_Grief')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local a = require 'samp.events'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- çàãðóæàåì áèáëèîòåêó/
local encoding = require 'encoding' -- çàãðóæàåì áèáëèîòåêó
local wm = require 'lib.windows.message'
local gk = require 'game.keys'
local dlstatus = require('moonloader').download_status
local second_window = imgui.ImBool(false)
local third_window = imgui.ImBool(false)
local first_window = imgui.ImBool(false)
local bMainWindow = imgui.ImBool(false)
local sInputEdit = imgui.ImBuffer(128)
local tCarsName = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BFInjection", "Hunter",
"Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo",
"RCBandit", "Romero","Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
"Yankee", "Caddy", "Solair", "Berkley'sRCVan", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RCBaron", "RCRaider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage",
"Dozer", "Maverick", "NewsChopper", "Rancher", "FBIRancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "BlistaCompact", "PoliceMaverick",
"Boxvillde", "Benson", "Mesa", "RCGoblin", "HotringRacerA", "HotringRacerB", "BloodringBanger", "Rancher", "SuperGT", "Elegant", "Journey", "Bike",
"MountainBike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "hydra", "FCR-900", "NRG-500", "HPV1000",
"CementTruck", "TowTruck", "Fortune", "Cadrona", "FBITruck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight",
"Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
"Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RCTiger", "Flash", "Tahoma", "Savanna", "Bandito",
"FreightFlat", "StreakCarriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "NewsVan",
"Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "FreightBox", "Trailer", "Andromada", "Dodo", "RCCam", "Launch", "PoliceCar", "PoliceCar",
"PoliceCar", "PoliceRanger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "GlendaleShit", "SadlerShit", "Luggage A", "Luggage B", "Stairs", "Boxville", "Tiller",
"UtilityTrailer"}
local tCarsTypeName = {"Àâòîìîáèëü", "Ìîòîèöèêë", "Âåðòîë¸ò", "Ñàìîë¸ò", "Ïðèöåï", "Ëîäêà", "Äðóãîå", "Ïîåçä", "Âåëîñèïåä"}
local tCarsSpeed = {43, 40, 51, 30, 36, 45, 30, 41, 27, 43, 36, 61, 46, 30, 29, 53, 42, 30, 32, 41, 40, 42, 38, 27, 37,
54, 48, 45, 43, 55, 51, 36, 26, 30, 46, 0, 41, 43, 39, 46, 37, 21, 38, 35, 30, 45, 60, 35, 30, 52, 0, 53, 43, 16, 33, 43,
29, 26, 43, 37, 48, 43, 30, 29, 14, 13, 40, 39, 40, 34, 43, 30, 34, 29, 41, 48, 69, 51, 32, 38, 51, 20, 43, 34, 18, 27,
17, 47, 40, 38, 43, 41, 39, 49, 59, 49, 45, 48, 29, 34, 39, 8, 58, 59, 48, 38, 49, 46, 29, 21, 27, 40, 36, 45, 33, 39, 43,
43, 45, 75, 75, 43, 48, 41, 36, 44, 43, 41, 48, 41, 16, 19, 30, 46, 46, 43, 47, -1, -1, 27, 41, 56, 45, 41, 41, 40, 41,
39, 37, 42, 40, 43, 33, 64, 39, 43, 30, 30, 43, 49, 46, 42, 49, 39, 24, 45, 44, 49, 40, -1, -1, 25, 22, 30, 30, 43, 43, 75,
36, 43, 42, 42, 37, 23, 0, 42, 38, 45, 29, 45, 0, 0, 75, 52, 17, 32, 48, 48, 48, 44, 41, 30, 47, 47, 40, 41, 0, 0, 0, 29, 0, 0
}
local tCarsType = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1,
3, 1, 1, 1, 1, 6, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 6, 3, 2, 8, 5, 1, 6, 6, 6, 1,
1, 1, 1, 1, 4, 2, 2, 2, 7, 7, 1, 1, 2, 3, 1, 7, 6, 6, 1, 1, 4, 1, 1, 1, 1, 9, 1, 1, 6, 1,
1, 3, 3, 1, 1, 1, 1, 6, 1, 1, 1, 3, 1, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 9, 9, 4, 4, 4, 1, 1, 1,
1, 1, 4, 4, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 1, 1,
1, 3, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 4,
1, 1, 1, 2, 1, 1, 5, 1, 2, 1, 1, 1, 7, 5, 4, 4, 7, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 1, 5, 5
}
local bIsEnterEdit = imgui.ImBool(false)
local ystwindow = imgui.ImBool(false)
local helps = imgui.ImBool(false)
local obnova = imgui.ImBool(false)
local infbar = imgui.ImBool(false)
local updwindows = imgui.ImBool(false)
local tEditData = {
	id = -1,
	inputActive = false
}
encoding.default = 'CP1251' -- óêàçûâàåì êîäèðîâêó ïî óìîë÷àíèþ, îíà äîëæíà ñîâïàäàòü ñ êîäèðîâêîé ôàéëà. CP1251 - ýòî Windows-1251
u8 = encoding.UTF8
local fa = require 'faIcons'
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig() -- to use 'imgui.ImFontConfig.new()' on error
        font_config.MergeMode = true
        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fontawesome-webfont.ttf', 14.0, font_config, fa_glyph_ranges)
    end
end
require 'lib.sampfuncs'
seshsps = 1
ctag = "{9966cc} Medick Helper {ffffff}|"
players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
players2 = {'{ffffff}Äàòà ïðèíÿòèÿ\t{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
frak = nil
rang = nil
ttt = nil
dostavka = false
rabden = false
tload = false
changetextpos = false
tLastKeys = {}
narkoh = 0
health = 0
departament = {}
smslogs = {}
radio = {}
vixodid = {}
local config_keys = {
    fastsms = { v = {}}
}
function apply_custom_style()

	imgui.SwitchContext()
	local style = imgui.GetStyle()
	local colors = style.Colors
	local clr = imgui.Col
	local ImVec4 = imgui.ImVec4
	local ImVec2 = imgui.ImVec2

	style.WindowPadding = ImVec2(15, 15)
	style.WindowRounding = 6.0
	style.FramePadding = ImVec2(5, 5)
	style.FrameRounding = 4.0
	style.ItemSpacing = ImVec2(12, 8)
	style.ItemInnerSpacing = ImVec2(8, 6)
	style.IndentSpacing = 25.0
	style.ScrollbarSize = 15.0
	style.ScrollbarRounding = 9.0
	style.GrabMinSize = 5.0
	style.GrabRounding = 3.0

    colors[clr.WindowBg]              = ImVec4(0.14, 0.12, 0.16, 1.00);
    colors[clr.ChildWindowBg]         = ImVec4(0.30, 0.20, 0.39, 0.00);
	colors[clr.PopupBg]               = ImVec4(0.05, 0.05, 0.10, 0.90);
    colors[clr.Border]                = ImVec4(0.89, 0.85, 0.92, 0.30);
    colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00);
	colors[clr.FrameBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.FrameBgHovered]        = ImVec4(0.41, 0.19, 0.63, 0.68);
	colors[clr.FrameBgActive]         = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TitleBg]               = ImVec4(0.41, 0.19, 0.63, 0.45);
	colors[clr.TitleBgCollapsed]      = ImVec4(0.41, 0.19, 0.63, 0.35);
	colors[clr.TitleBgActive]         = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.MenuBarBg]             = ImVec4(0.30, 0.20, 0.39, 0.57);
	colors[clr.ScrollbarBg]           = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.ScrollbarGrab]         = ImVec4(0.41, 0.19, 0.63, 0.31);
	colors[clr.ScrollbarGrabHovered]  = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ScrollbarGrabActive]   = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ComboBg]               = ImVec4(0.30, 0.20, 0.39, 1.00);
	colors[clr.CheckMark]             = ImVec4(0.56, 0.61, 1.00, 1.00);
	colors[clr.SliderGrab]            = ImVec4(0.41, 0.19, 0.63, 0.24);
	colors[clr.SliderGrabActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.Button]                = ImVec4(0.41, 0.19, 0.63, 0.44);
	colors[clr.ButtonHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.ButtonActive]          = ImVec4(0.64, 0.33, 0.94, 1.00);
	colors[clr.Header]                = ImVec4(0.41, 0.19, 0.63, 0.76);
	colors[clr.HeaderHovered]         = ImVec4(0.41, 0.19, 0.63, 0.86);
	colors[clr.HeaderActive]          = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.ResizeGrip]            = ImVec4(0.41, 0.19, 0.63, 0.20);
	colors[clr.ResizeGripHovered]     = ImVec4(0.41, 0.19, 0.63, 0.78);
	colors[clr.ResizeGripActive]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.CloseButton]           = ImVec4(1.00, 1.00, 1.00, 0.75);
	colors[clr.CloseButtonHovered]    = ImVec4(0.88, 0.74, 1.00, 0.59);
	colors[clr.CloseButtonActive]     = ImVec4(0.88, 0.85, 0.92, 1.00);
	colors[clr.PlotLines]             = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotLinesHovered]      = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.PlotHistogram]         = ImVec4(0.89, 0.85, 0.92, 0.63);
	colors[clr.PlotHistogramHovered]  = ImVec4(0.41, 0.19, 0.63, 1.00);
	colors[clr.TextSelectedBg]        = ImVec4(0.41, 0.19, 0.63, 0.43);
	colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35);
end
apply_custom_style()

local fileb = getWorkingDirectory() .. "\\config\\medick.bind"
local tBindList = {}
if doesFileExist(fileb) then
	local f = io.open(fileb, "r")
	if f then
		tBindList = decodeJson(f:read())
		f:close()
	end
else
	tBindList = {
        [1] = {
            text = "",
            v = {key.VK_No}
        }
	}
end

local medick =
{
  main =
  {
    posX = 1738,
    posY = 974,
    widehud = 320,
    male = true,
    wanted == false,
    clear == false,
    hud = false,
    tar = 'Èíòåðí',
	tarr = 'òýã',
	tarb = false,
	clistb = false,
	clisto = false,
	givra = false,
    clist = 0,
	health = 0,
	narkoh = 0,
  },
  commands =
  {
    ticket = false,
	zaderjka = 5
  },
   keys =
  {
	tload = 113,
	tazer = 113,
	fastmenu = 114,
  }
}
cfg = inicfg.load(nil, 'medick/config.ini')
test = imgui.CreateTextureFromFile(getGameDirectory() .. '\\moonloader\\medick\\images\\arz.png')
local libs = {'sphere.lua', 'rkeys.lua', 'imcustom/hotkey.lua', 'imgui.lua', 'MoonImGui.dll', 'imgui_addons.lua'}
function main()
  while not isSampAvailable() do wait(1000) end
  if seshsps == 1 then
	ftext('Medick Helper çàãðóæåí, äîñòóïåí òîëüêî äëÿ ñåðâåðà Cleveland.',-1)
	ftext('Ãëàâ.Âðà÷: Igor Krylov.',-1)
	ftext('Ñêðèïò ðåäàêòèðîâàë: Rancho Grief.',-1)
	ftext('Ôóíêöèè ñêðèïòà êîìàíäà è êíîïêà: /mh (íàñòðîéêè ñêðèïòà), F3 (ãëàâíîå ìåíþ) èëè ÏÊÌ + Z (îòûãðîâêè).',-1)
	ftext('Ïåðåçàãðóçèòü ñêðèïò åñëè îòêëþ÷èòñÿ, îäíîâðåìåííî çàæàòü CTRL + R.',-1)
        ftext('Åñëè âîçíèêëà êàêàÿ-ëèáî îøèáêà, íàïèøèòå ñþäà: {7e0059}VK - @artyom.morozov2022.{7e0059}',-1)
  end
  if not doesDirectoryExist('moonloader/config/medick/') then createDirectory('moonloader/config/medick/') end
  if cfg == nil then
    sampAddChatMessage("{7e0059}Medick Help {7e0059}| Îòñóòñâóåò ôàéë êîíôèãà, ñîçäàåì.", -1)
    if inicfg.save(medick, 'medick/config.ini') then
      sampAddChatMessage("{7e0059}Medick Help {7e0059}| Ôàéë êîíôèãà óñïåøíî ñîçäàí.", -1)
      cfg = inicfg.load(nil, 'medick/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('Çàãðóæàåòñÿ áèáëèîòåêà'..v)
        end
    end
	if not doesFileExist("moonloader/config/medick/keys.json") then
        local fa = io.open("moonloader/config/medick/keys.json", "w")
        fa:close()
    else
        local fa = io.open("moonloader/config/medick/keys.json", 'r')
        if fa then
            config_keys = decodeJson(fa:read('*a'))
        end
    end
  while not doesFileExist('moonloader\\lib\\rkeys.lua') or not doesFileExist('moonloader\\lib\\imcustom\\hotkey.lua') or not doesFileExist('moonloader\\lib\\imgui.lua') or not doesFileExist('moonloader\\lib\\MoonImGui.dll') or not doesFileExist('moonloader\\lib\\imgui_addons.lua') do wait(0) end
  if not doesDirectoryExist('moonloader/medick') then createDirectory('moonloader/medick') end
  hk = require 'lib.imcustom.hotkey'
  imgui.HotKey = require('imgui_addons').HotKey
  rkeys = require 'rkeys'
  imgui.ToggleButton = require('imgui_addons').ToggleButton
  while not sampIsLocalPlayerSpawned() do wait(0) end
  local _, myid = sampGetPlayerIdByCharHandle(playerPed)
  local name, surname = string.match(sampGetPlayerNickname(myid), '(.+)_(.+)')
  sip, sport = sampGetCurrentServerAddress()
  sampSendChat('/stats')
  while not sampIsDialogActive() do wait(0) end
  proverkk = sampGetDialogText()
  local frakc = proverkk:match('.+Îðãàíèçàöèÿ%s+(.+)%s+Äîëæíîñòü')
  local rang = proverkk:match('.+Äîëæíîñòü%s+%d+ %((.+)%)%s+Ðàáîòà')
  local telephone = proverkk:match('.+Òåëåôîí%s+(.+)%s+Çàêîíîïîñëóøíîñòü')
  rank = rang
  frac = frakc
  tel = telephone
  sampCloseCurrentDialogWithButton(1)
  print(frakc)
  print(rang)
  print(telephone)
  ystf()
  update()
  sampCreate3dTextEx(641, '{ffffff}None', 4294927974, 2346.1362,1666.7819,3040.9387, 3, true, -1, -1)
  sampCreate3dTextEx(642, '{ffffff}None', 4294927974, 2337.5002,1657.4896,3040.9524, 3, true, -1, -1)
  sampCreate3dTextEx(643, '{ffffff}None.{ff0000}óãó!', 4294927974, 2337.8091,1669.0276,3040.9524, 3, true, -1, -1)
  local spawned = sampIsLocalPlayerSpawned()
  for k, v in pairs(tBindList) do
		rkeys.registerHotKey(v.v, true, onHotKey)
  end
  fastsmskey = rkeys.registerHotKey(config_keys.fastsms.v, true, fastsmsk)
  sampRegisterChatCommand('r', r)
  sampRegisterChatCommand('f', f)
  sampRegisterChatCommand('dlog', dlog)
  sampRegisterChatCommand('smslog', slog)
  sampRegisterChatCommand('rlog', rlog)
  sampRegisterChatCommand('dcol', cmd_color)
  sampRegisterChatCommand('dmb', dmb)
  sampRegisterChatCommand('smsjob', smsjob)
  sampRegisterChatCommand('where', where)
  sampRegisterChatCommand('mh', mh)
  sampRegisterChatCommand('vig', vig)
  sampRegisterChatCommand('yvig', yvig)
  sampRegisterChatCommand('ivig',ivig)
  sampRegisterChatCommand('unvig',unvig)
  sampRegisterChatCommand('giverank', giverank)
  sampRegisterChatCommand('cinv', cinv)
  sampRegisterChatCommand('ffixcar', fixcar)
  sampRegisterChatCommand('invite', invite)
  sampRegisterChatCommand('invn', invitenarko)
  sampRegisterChatCommand('blg', blg)
  sampRegisterChatCommand('oinv', oinv)
  sampRegisterChatCommand('fgv', fgiverank)
  sampRegisterChatCommand('zinv', zinv)
  sampRegisterChatCommand('ginv', ginv)
  sampRegisterChatCommand('uninvite', uninvite)
  sampRegisterChatCommand('z', zheal)
    sampRegisterChatCommand('sethud', function()
        if cfg.main.givra then
            if not changetextpos then
                changetextpos = true
                ftext('Ïî çàâåðøåíèþ ââåäèòå êîìàíäó åùå ðàç.')
            else
                changetextpos = false
				inicfg.save(cfg, 'medick/config.ini') -- ñîõðàíÿåì âñå íîâûå çíà÷åíèÿ â êîíôèãå
            end
        else
            ftext('Äëÿ íà÷àëà âêëþ÷èòå èíôî-áàð.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
     datetime = os.date("!*t",os.time()) 
if datetime.min == 00 and datetime.sec == 10 then 
sampAddChatMessage("Íå çàáóäüòå îñòàâèòü îò÷¸ò â òåìå íà ïîëó÷åíèå âûïëàò.", -1) 
wait(1000)
end
    if #departament > 25 then table.remove(departament, 1) end
	if #smslogs > 25 then table.remove(smslogs, 1) end
	if #radio > 25 then table.remove(radio, 1) end
    if cfg == nil then
      sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Îòñóòñâóåò ôàéë êîíôèãà, ñîçäàåì.", -1)
      if inicfg.save(medick, 'medick/config.ini') then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ôàéë êîíôèãà óñïåøíî ñîçäàí.", -1)
        cfg = inicfg.load(nil, 'medick/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Áûñòðîå ìåíþ")
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| Ñèñòåìà ïîâûøåíèé")
	end
          if valid and doesCharExist(ped) then
            local result, id = sampGetPlayerIdByCharHandle(ped)
            if result and wasKeyPressed(key.VK_Z) then
                gmegafhandle = ped
                gmegafid = id
                gmegaflvl = sampGetPlayerScore(id)
                gmegaffrak = getFraktionBySkin(id)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
                --[[ftext(gmegafid)
                ftext(gmegaflvl)
                ftext(gmegaffrak)]]
				megaftimer = os.time() + 300
                submenus_show(pkmmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
            end
        end
	if cfg.main.givra == true then
      infbar.v = true
      imgui.ShowCursor = false
    end
    if cfg.main.givra == false then
      infbar.v = false
      imgui.ShowCursor = false
    end
		if changetextpos then
            sampToggleCursor(true)
            local CPX, CPY = getCursorPos()
            cfg.main.posX = CPX
            cfg.main.posY = CPY
        end
		imgui.Process = second_window.v or third_window.v or bMainWindow.v or ystwindow.v or updwindows.v or infbar.v
  end
  function rkeys.onHotKey(id, keys)
	if sampIsChatInputActive() or sampIsDialogActive() or isSampfuncsConsoleActive() then
		return false
	end
end
end

local fpt = [[
Ãëàâà ¹1. Îáùåå ïîëîæåíèå
1.01 Óñòàâ ÿâëÿåòñÿ îáÿçàòåëüíûì ê èñïîëíåíèþ âñåìè ñîòðóäíèêàìè îðãàíèçàöèè.
1.02 Óñòàâ Ìèíèñòåðñòâà Çäðàâîîõðàíåíèÿ ÿâëÿåòñÿ äîêóìåíòîì, ðåãóëèðóþùåì âçàèìîîòíîøåíèÿ ðóêîâîäñòâà Ministry Of Health ñ ñîòðóäíèêàìè îðãàíèçàöèè, à èìóùåñòâî áîëüíèö ÿâëÿåòñÿ ãîñóäàðñòâåííîé ñîáñòâåííîñòüþ.
1.03 Íåçíàíèå óñòàâà íå îñâîáîæäàåò âàñ îò îòâåòñòâåííîñòè.
1.04 Çà íàðóøåíèå óñòàâà ê ñîòðóäíèêó îðãàíèçàöèè ìîãóò ïðèìåíÿòüñÿ ðàçëè÷íûå ñàíêöèè, íà÷èíàÿ îò óñòíîãî ïðåäóïðåæäåíèÿ è çàêàí÷èâàÿ óâîëüíåíèåì èç ðÿäîâ îðãàíèçàöèè Ministry of Health ñ çàíåñåíèåì â ÷åðíûé ñïèñîê.
1.05 Ðåøåíèå ãëàâíîãî âðà÷à ÿâëÿåòñÿ îêîí÷àòåëüíûì è îáæàëîâàíèþ íå ïîäëåæèò.
1.06 Ðàáîòà ìåäèöèíñêîãî ðàáîòíèêà îñíîâûâàåòñÿ òàê æå íà ïðèíöèïàõ ìèëîñåðäèÿ, äîáðîòû.
1.07 Óñòàâ ìîæåò èñïðàâëÿòüñÿ èëè äîïîëíÿòüñÿ Ãëàâíûì Âðà÷îì.
1.08 Íàðóøèòü óñòàâ èëè ïðèêàçàòü åãî íàðóøèòü â ðàçóìíûõ öåëÿõ ìîæåò òîëüêî Ãëàâ. Âðà÷. à òàê æå ñîòðóäíèêè ïî ïðèêàçó âûøåñòîÿùåãî ðóêîâîäñòâà MOH.
1.09 Îáëàäàíèå íàèâûñøèì äîñòèæèìûì óðîâíåì çäîðîâüÿ ÿâëÿåòñÿ îäíèì èç îñíîâíûõ ïðàâ êàæäîãî ÷åëîâåêà áåç ðàçëè÷èÿ ðàñû, ðåëèãèè, ïîëèòè÷åñêèõ óáåæäåíèé, ýêîíîìè÷åñêîãî èëè ñîöèàëüíîãî ïîëîæåíèÿ.
1.10 Ëþáîé ãðàæäàíèí øòàòà èìååò ïðàâî íà ïîëó÷åíèå óñëóã Ministry Of Health áåç ðàçëè÷èÿ ðàñû, ðåëèãèè, ïîëèòè÷åñêèõ
óáåæäåíèé, ýêîíîìè÷åñêîãî èëè ñîöèàëüíîãî ïîëîæåíèÿ.

Ãëàâà ¹2. Ðåæèì ðàáîòû
2.01 Ðåæèì ðàáîòû â áóäíèå äíè (Ïîíåäåëüíèê  Ïÿòíèöà) íà÷èíàåòñÿ ñ 8:00 è çàêàí÷èâàåòñÿ â 21:00.
2.02 Ðåæèì ðàáîòû â âûõîäíûå äíè (Ñóááîòà  Âîñêðåñåíüå) íà÷èíàåòñÿ ñ 9:00 è çàêàí÷èâàåòñÿ â 20:00.
2.03 Ïî ïðèêàçó Ãëàâíîãî Âðà÷à, ñîòðóäíèê îáÿçàí ÿâèòüñÿ íà ðàáîòó â òå÷åíèè 30 ìèíóò.
2.04 Îáåäåííûé ïåðåðûâ íà÷èíàåòñÿ â 13:00 äî 14:00 åæåäíåâíî.
2.05 Ãëàâíûé Âðà÷ âïðàâå èçìåíèòü ãðàôèê ðåæèìà ðàáîòû ïî ñâîåìó óñìîòðåíèþ.
2.06 ÐÏ ñîí ðàçðåøàåòñÿ òîëüêî âî âðåìÿ îáåäåííîãî ïåðåðûâà, ñ 13:00 äî 14:00.
2.07 Âûåçä â çàêóñî÷íûå âíå îáåäåííîãî ïåðåðûâà âîçìîæíû òîëüêî ñ ðàçðåøåíèÿ ðóêîâîäñòâà MOH.

Ãëàâà ¹3. Îáÿçàííîñòè ñîòðóäíèêîâ
3.01 Ìåäèöèíñêèé ðàáîòíèê îáÿçàí îêàçàòü ìåäèöèíñêóþ ïîìîùü íóæäàþùåìóñÿ, áåç ðàçëè÷èÿ ðàñû, ðåëèãèè, ïîëèòè÷åñêèõ óáåæäåíèé, ýêîíîìè÷åñêîãî èëè ñîöèàëüíîãî ïîëîæåíèÿ.
3.02 Ñîòðóäíèêè MOH îáÿçàòåëüíî äîëæíû áûòü âåæëèâûìè è îáðàùàòüñÿ ê ëþäÿì è ê êîëëåãàì, ñòðîãî íà 'Âû'. (çà íåöåíçóðíóþ ëåêñèêó â /b òàêæå ïîñëåäóåò íàêàçàíèå âïëîòü äî óâîëüíåíèÿ)
3.03 Ñîòðóäíèê MOH îáÿçàí äîñòàâèòü ïîñòðàäàâøåãî äî ïðèåìíîãî ïîêîÿ áîëüíèöû, åñëè åñòü òàêàÿ íåîáõîäèìîñòü.
3.04 Ñîòðóäíèê îáÿçàí îêàçûâàòü ìåäèöèíñêóþ ïîìîùü, ïðèëàãàÿ âñå óñèëèÿ è íàâûêè (RP-îòûãðîâêà), Íàðóøåíèå âëå÷åò çà ñîáîé ( Ïîíèæåíèå, Óâîëüíåíèå)
3.05 Ñîòðóäíèê MOH îáÿçàí ïàðêîâàòü ëè÷íûé òðàíñïîðò èñêëþ÷èòåëüíî íà ñòîÿíêå ðàçðåøåííîé äåïàðòàìåíòîì ãîðîäà.
3.06 Îòäûõàòü, (AFK) ðàçðåøàåòñÿ òîëüêî â îðäèíàòîðñêîé áîëüíèöû.
3.07 Çà ñîí ( AFK ) íà ïîñòó áîëåå 100 ñåêóíä êàðàåòñÿ (Âûãîâîðîì, ïîíèæåíèåì, óâîëüíåíèåì.)
3.07 Â ðàáî÷åå âðåìÿ, ñîòðóäíèê MOH îáÿçàí íàõîäèòüñÿ íà íàçíà÷åííîì åìó ïîñòó è èñïîëíÿòü ñâîè äîëæíîñòíûå îáÿçàííîñòè.
3.08 Ïî ïðèíÿòèþ âûçîâà, ìåäèöèíñêèé ñîòðóäíèê îáÿçàí äåëàòü äîêëàä â ðàöèþ î ïðèíÿòèè âûçîâà îò äèñïåò÷åðà.
3.09 Ðóêîâîäèòåëü à òàê æå Çàìåñòèòåëü Ðóêîâîäèòåëÿ îòäåëà, îáÿçàí íàó÷èòü ñîòðóäíèêîâ ñâîåãî îòäåëà âñåìó, ÷òî çíàåò ñàì  â ïîëíîé ìåðå.
3.10 Âîçäóøíûé ïàòðóëü øòàòà ðàçðåø¸í ñ äîëæíîñòè 'Äîêòîð'.
3.11 Íàçåìíûé ïàòðóëü ãîðîäà ðàçðåøåí ñ äîëæíîñòè 'Ìåä.Áðàòà' îò äâóõ ÷åëîâåê, â òîì ñëó÷àå, åñëè âñå ïîñòû çàíÿòû.
3.12 Íîøåíèå è ïðèìåíåíèå îãíåñòðåëüíîãî îðóæèÿ ðàçðåøåíî ñ äîëæíîñòè 'Ïñèõîëîã' è âûøå, èñêëþ÷åíèå ïðè âûåçäîâ íà ×Ñ. Â ñëó÷àå íàðóøåíèå (Âûãîâîð)
3.13 Ïåðåâîä ìåæäó îòäåëàìè îñóùåñòâëÿåòñÿ ñ äîëæíîñòè 'Íàðêîëîã' ñ ðàçðåøåíèÿ âàøåãî Íà÷àëüíèêà îòäåëà.


Ãëàâà ¹4. Çàïðåòû ñîòðóäíèêà
4.01 Îòêàç îò âûõîäà íà ðàáîòó, à òàê æå ñàìîâîëüíîå çàâåðøåíèå ðàáî÷åãî äíÿ. (Âûãîâîð)
4.02 Íàõîæäåíèå â êàçèíî â ðàáî÷åå èëè íå ðàáî÷åå âðåìÿ â ôîðìå (Âûãîâîð, Ïîíèæåíèå, Óâîëüíåíèå)
4.03 Âõîäèòü â ÐÏ ñîí âî âðåìÿ ðàáî÷åãî äíÿ è âíå ðàáî÷åãî âðåìåíè â ôîðìå (Ñîòðóäíèê îáÿçàí ñíÿòü ðàáî÷óþ ôîðìó ïîñëå çàâåðøåíèÿ ðàáî÷åãî äíÿ, äëÿ ÐÏ ñíà).
4.04 Çà íåïîä÷èíåíèå ðóêîâîäÿùåìó ñîñòàâó (Ïñèõîëîã è âûøå, â íåêîòîðûõ ñëó÷àÿõ Ãëàâû èëè Çàìåñòèòåëè îòäåëîâ) êàðàåòñÿ (Ïîíèæåíèåì, Óâîëüíåíèåì)
4.05 Ââåäåíèå â çàáëóæäåíèå ðóêîâîäñòâî è èõ îáìàí, à òàê æå Ãëàâ.îòäåëîâ è èõ çàìåñòèòåëåé, êàðàåòñÿ (óâîëüíåíèåì ñ äàëüíåéøèì çàíåñåíèåì â ×åðíûé Ñïèñîê MOH.)
4.06 Çà ëå÷åíèå âèòàìèíàìè, àñêîðáèíêàìè è ïðî÷èì, ñîòðóäíèê áóäåò êàðàòüñÿ (Âûãîâîðîì, Ïîíèæåíèåì.)
4.07 Íå âûïîëíåíèå ñëóæåáíûõ îáÿçàííîñòåé äëÿ ðóêîâîäñòâà êàðàåòñÿ (Ñíÿòèåì ñ äîëæíîñòè)
4.08 Ëþáîé ïðèçíàê íåóâàæåíèÿ, ïîïûòêà óíèçèòü äîñòîèíñòâî ÷åëîâåêà êàðàåòñÿ (âûãîâîðîì, ïîíèæåíèåì, óâîëüíåíèåì ñ äàëüíåéøèì çàíåñåíèåì â ×åðíûé Ñïèñîê.)
4.09 Êóðåíèå âíóòðè çäàíèÿ çàïðåùåíî (Âûãîâîð, Ïîíèæåíèå)
4.10 Ëå÷åíèå ëþáûõ áîëåçíåé ïðîèçâîäèòñÿ èñêëþ÷èòåëüíî â ïàëàòå, îïåðàöèîííîé èëè â êàðòå ñêîðîé ïîìîùè. Çà íàðóøåíèå äàííîãî ïóíêòà (Âûãîâîð, Ïîíèæåíèå)
4.11 Èñïîëüçîâàòü ñëóæåáíûå àâòîìîáèëè è âåðòîë¸òû â ëè÷íûõ öåëÿõ êàðàåòñÿ (Âûãîâîðîì)
4.12 Èñïîëüçîâàíèå ñïåö.ñèãíàëîâ â ëè÷íûõ öåëÿõ çàïðåùåíî, êàðàåòñÿ (Âûãîâîðîì)
4.13 Íåêîððåêòíîå èñïîëüçîâàíèå âîëíû äåïàðòàìåíòà êàðàåòñÿ (Âûãîâîðîì, Óâîëüíåíèåì)
4.14 Èñïîëüçîâàíèå âîëíû äåïàðòàìåíòà ñîòðóäíèêàì íèæå äîëæíîñòè 'Ìåä.Áðàò' [3 ðàíã] êàðàåòñÿ (Âûãîâîðîì, Óâîëüíåíèåì)
4.15 Ñîòðóäíèêàì çàïðåùåíî ïðåðåêàòüñÿ ñ íà÷àëüñòâîì ïî ðàöèè êàðàåòñÿ (Âûãîâîðîì)
4.16 Âûÿñíÿòü îòíîøåíèÿ, îñêîðáëåíèÿ íà ëþáîé âîëíå êàðàåòñÿ (Âûãîâîðîì, Ïîíèæåíèåì)
4.17 Ëþáàÿ ðåêëàìà â ðàöèè îðãàíèçàöèè èëè äåïàðòàìåíòà êàðàåòñÿ (Ïîíèæåíèåì, Óâîëüíåíèåì)
4.18 Ïîëüçîâàòüñÿ ðàöèåé äåïàðòàìåíòà åñëè îíà çàêðûòà íà ×Ñ. (Âûãîâîð)
4.19 Çàïðåùåíî âûïðàøèâàòü ïîâûøåíèå, êàðàåòñÿ (Âûãîâîðîì, Ïîíèæåíèåì)
4.20 Çà íîøåíèå ôîðìû íå ïî äîëæíîñòè, êàðàåòñÿ (Âûãîâîðîì, Ïîíèæåíèåì)
4.21 Çàïðåùàåòñÿ íîøåíèå ëèøíèõ àêñåññóàðîâ, ïåðåèçáûòîê èõ, êàðàåòñÿ (Âûãîâîðîì, Ïîíèæåíèåì)

Ãëàâà ¹5. Èñïîëüçîâàíèå ðàöèè
5.01 Àáñîëþòíî âñå ñîòðóäíèêè îáÿçàíû ñòðîãî ñîáëþäàòü ïðàâèëà ïîëüçîâàíèÿ ðàöèåé.
5.02 Ïðè âûçîâå êàðåòû ïî âîëíå äåïàðòàìåíòà, ñîòðóäíèê, êîòîðûé âûåçæàåò íà âûçîâ, îáÿçàí ñîîáùèòü ïî âîëíå Ìèíçäðàâà î ñâîåì âûåçäå íà âûçîâ. À ðóêîâîäèòåëè â äàííîì ñëó÷àå îáÿçàíû ñîîáùèòü ïî âîëíå äåïàðòàìåíòà î âûåçäå êàðåòû.
5.03 Ñîòðóäíèê îáÿçàí ñîîáùàòü â ðàöèþ äîêëàäû î çàñòóïëåíèè íà ïîñò èëè ïàòðóëü, î ñîñòîÿíèè ïîñòà èëè ïàòðóëÿ, îá óåçäå ñ ïîñòà ñ óêàçàíèåì ïðè÷èíû.
5.04 Ñîòðóäíèê îáÿçàí íàõîäÿñü íà ïîñòó, äîêëàäûâàòü â ðàöèþ êàæäûå 5 ìèíóò ÷àñà. (Ïðèìåð: 12:05, 12:10 è ò.ä)
5.05 Ïðè çàïðîñå îò ñòàðøåãî ñîñòàâà èëè Ãëàâ îòäåëîâ è èõ çàìåñòèòåëåé, ñ ïðîñüáîé ñîîáùåíèè ñòàòóñà ïîñòîâ, ñîòðóäíèê - îáÿçàí íåçàìåäëèòåëüíî ñîîáùèòü.

Ãëàâà ¹6. Ïîâûøåíèÿ / ïîíèæåíèÿ / âûãîâîðû / óâîëüíåíèÿ
6.01 Ñèñòåìà ïîâûøåíèÿ åäèíà äëÿ âñåõ ñîòðóäíèêîâ MOH.
6.02 Âñå ïîâûøåíèÿ, ïîíèæåíèÿ, âûãîâîðû è óâîëüíåíèÿ ôèêñèðóþòñÿ â ñîîòâåòñòâóþùèõ ðååñòðàõ.
6.03 Âûãîâîð ÿâëÿåòñÿ ïðåäóïðåæäåíèåì. Äâà âûãîâîðà  ïîíèæåíèåì â äîëæíîñòè. Òðè âûãîâîðà  óâîëüíåíèå.
6.04 Â ñëó÷àå íåñîãëàñèÿ ñ ðåøåíèåì ñòàðøåãî ñîñòàâà êàñàòåëüíî âûãîâîðà, ïîíèæåíèÿ èëè óâîëüíåíèÿ ñîòðóäíèê âïðàâå ïîäàòü æàëîáó Ãëàâíîìó Âðà÷ó â ñîîòâåòñòâóþùåì ðàçäåëå.
6.05 Ñîòðóäíèêó ìîæåò áûòü îòêàçàíî â ïîâûøåíèè â ñâÿçè ñ ìàëîé àêòèâíîñòüþ.

Ãëàâà ¹7. Ïðàâèëà îòïóñêà è íåàêòèâà.
7.01 Ñîòðóäíèê èìååò ïðàâî âçÿòü îòïóñê ñ äîëæíîñòè 'Äîêòîð' [6 ðàíã]
7.02 Äëèòåëüíîñòü îòïóñêà ñîñòàâëÿåò íå áîëåå 14 äíåé ðàç â äâà ìåñÿöà.
7.03 Íåàêòèâ áåð¸òñÿ ñðîêîì äî 14 äíåé, ïðè íàëè÷èè óâàæèòåëüíîé ïðè÷èíû.
7.04 Â ñëó÷àå, åñëè ðàáîòíèê âîçâðàùàåòñÿ â óêàçàííûé ñðîê, åãî âîññòàíàâëèâàþò â äîëæíîñòè.
7.05 Â ñëó÷àå, åñëè ñîòðóäíèê íå âîçâðàùàåòñÿ â óêàçàííûé ñðîê, îí (Óâîëüíÿåòñÿ)
7.06 Ïðè ñëóæåáíîé íåîáõîäèìîñòè, ñîòðóäíèê ìîæåò áûòü âûçâàí ñ îòïóñêà.
7.07 Âî âðåìÿ îòïóñêà èëè íåàêòèâà ñòðîãî çàïðåùàåòñÿ íàõîäèòñÿ â êðèìèíàëüíûõ ãðóïïèðîâêàõ, êàðàåòñÿ (Óâîëüíåíèåì)
7.08 Âî âðåìÿ íàõîæäåíèÿ â îòïóñêå èëè íåàêòèâå, çàïðåùåíî íàðóøàòü çàêîíû Øòàòà, ÅÊÃÑ. (Ïîíèæåíèå, Óâîëüíåíèå)
]]

function dmb()
	lua_thread.create(function()
		status = true
		players2 = {'{ffffff}Äàòà ïðèíÿòèÿ\t{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}Â ñåòè: "..gcount.." | {ae433d}Îðãàíèçàöèÿ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}Â ñåòè: "..gcount.." | {ae433d}Îðãàíèçàöèÿ | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		status = false
		gcount = nil
	end)
end
function blg(pam)
    local id, frack, pric = pam:match('(%d+) (%a+) (.+)')
    if id and frack and pric and sampIsPlayerConnected(id) then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/d %s, áëàãîäàðþ %s çà %s. Öåíèòå!", frack, rpname, pric))
    else
        ftext("Ââåäèòå: /blg [id] [Ôðàêöèÿ] [Ïðè÷èíà]", -1)
		ftext("Ïðèìåð: òðàíñïîðòèðîâêó, ñïàñåíèå æèçíè, è ò.ä. ", -1)
    end
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{9966cc}Medick Helper {ffffff}| {ae433d}Âíå îôèñà {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- Ïîêàçûâàåì èíôîðìàöèþ.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | Ëîã ñîîáùåíèé äåïàðòàìåíòà', table.concat(departament, '\n'), '»', 'x', 0)
end
function slog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | Ëîã SMS', table.concat(smslogs, '\n'), '»', 'x', 0)
end

function rlog()
    sampShowDialog(97988, '{9966cc}Medick Help{ffffff} | Ëîã Ðàöèè', table.concat(radio, '\n'), '»', 'x', 0)
end

function yvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' or  rank == 'Äîêòîð' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /yvig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /yvig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - ïîëó÷àåò óñòíûé âûãîâîð ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - ïîëó÷àåò óñòíûé âûãîâîð ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /vig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /vig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - ïîëó÷àåò âûãîâîð ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - ïîëó÷àåò âûãîâîð ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end
function ivig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Äîêòîð' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /ivig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /ivig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Ïîëó÷àåò ñòðîãèé âûãîâîð ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Ïîëó÷àåò ñòðîãèé âûãîâîð ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end

function unvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /unvig [ID] [Ïðè÷èíà]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Èãðîê ñ ID: "..id.." íå ïîäêëþ÷åí ê ñåðâåðó.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
  
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| Ââåäèòå: /unvig [ID] [ÏÐÈ×ÈÍÀ]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - Ïîëó÷àåò cíÿòèå âûãîâîðà ïî ïðè÷èíå: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - Ïîëó÷àåò cíÿòèå âûãîâîðà ïî ïðè÷èíå: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- çàïðîñ ìåñòîïîëîæåíèÿ
   if rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, äîëîæèòå ñâîå ìåñòîïîëîæåíèå. Íà îòâåò 20 ñåêóíä.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, äîëîæèòå ñâîå ìåñòîïîëîæåíèå. Íà îòâåò 20 ñåêóíä.", name))
			end
			else
			ftext('{FFFFFF} Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} Èñïîëüçóéòå: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}Äàííàÿ êîìàíäà äîñòóïíà ñ 6 ðàíãà.', 0x046D63)
	end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = 'Èíòåðí',
		['2'] = 'Ñàíèòàð',
		['3'] = 'Ìåä.áðàò',
		['4'] = 'Ñïàñàòåëü',
		['5'] = 'Íàðêîëîã',
		['6'] = 'Äîêòîð',
		['7'] = 'Ïñèõîëîã',
		['8'] = 'Õèðóðã',
		['9'] = 'Çàì.Ãëàâ.Âðà÷à',
		['10'] = 'Ãëàâ.Âðà÷'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 5 then
				if cfg.main.male == true then
				sampSendChat('/me ñíÿë ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(3000)
				sampSendChat('/me óáðàë ñòàðûé áåéäæèê â êàðìàí')
				wait(3000)
                sampSendChat(string.format('/me äîñòàë íîâûé áåéäæèê %s', ranks))
				wait(3000)
				sampSendChat('/me çàêðåïèë íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(3000)
				else
				sampSendChat('/me ñíÿëà ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(3000)
				sampSendChat('/me óáðàëà ñòàðûé áåéäæèê â êàðìàí')
				wait(3000)
                sampSendChat(string.format('/me äîñòàëà íîâûé áåéäæèê %s', ranks))
				wait(3000)
				sampSendChat('/me çàêðåïèëà íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(3000)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(3000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s â äîëæíîñòè äî %s%s.', cfg.main.tarr, plus == '+' and 'Ïîâûøåí' or 'Ïîíèæåí(à)', ranks, plus == '+' and ', Ïîçäðàâëÿåì!' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s â äîëæíîñòè äî %s%s.', plus == '+' and 'Ïîâûøåí' or 'Ïîíèæåí', ranks, plus == '+' and ', Ïîçäðàâëÿåì!' or ''))
				wait(3000)
				sampSendChat('/b /time 1 + F8, îáÿçàòåëüíî.')
            end
			else
			ftext('Âû ââåëè íåâåðíûé òèï [+/-]')
		end
		else
			ftext('Ââåäèòå: /giverank [id] [ðàíã] [+/-]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Ïñèõîëîã.')
	  end
	  else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
	  end
   end)
 end
function fgiverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
        if id and rangg then
		if plus == '-' or plus == '+' then
		ranks = getrang(rangg)
		        local _, handle = sampGetCharHandleBySampPlayerId(id)
				if doesCharExist(handle) then
				local x, y, z = getCharCoordinates(handle)
				local mx, my, mz = getCharCoordinates(PLAYER_PED)
				local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
				if dist <= 5 then
				if cfg.main.male == true then
				sampSendChat('/me ñíÿë ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(3000)
				sampSendChat('/me óáðàë ñòàðûé áåéäæèê â êàðìàí')
				wait(3000)
                sampSendChat(string.format('/me äîñòàë íîâûé áåéäæèê %s', ranks))
				wait(3000)
				sampSendChat('/me çàêðåïèë íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(3000)
				else
				sampSendChat('/me ñíÿëà ñòàðûé áåéäæèê ñ ÷åëîâåêà íàïðîòèâ ñòîÿùåãî')
				wait(3000)
				sampSendChat('/me óáðàëà ñòàðûé áåéäæèê â êàðìàí')
				wait(3000)
                sampSendChat(string.format('/me äîñòàëà íîâûé áåéäæèê %s', ranks))
				wait(3000)
				sampSendChat('/me çàêðåïèëà íà ðóáàøêó ÷åëîâåêó íàïðîòèâ íîâûé áåéäæèê')
				wait(3000)
				end
				end
				end
			else
			ftext('Âû ââåëè íåâåðíûé òèï [+/-].')
		end
		else
			ftext('Ââåäèòå: /giverank [id] [ðàíã] [+/-]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Äîêòîð.')
	  end
	  else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
	  end
   end)
 end
function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Õèðóðã' or  rank == 'Ïñèõîëîã' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me äîñòàë(à) áåéäæèê è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
		end
		else
			ftext('Ââåäèòå: /invite [id]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Ïñèõîëîã.')
	  end
   end)
 end
 function fixcar()
    lua_thread.create(function()
	  if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Õèðóðã' or  rank == 'Ïñèõîëîã' then
        sampSendChat('/rb Ñïàâí îðãàíèçàöèîííîãî òðàíñïîðòà ÷åðåç 15 ñåêóíä')
		wait(5000)
		sampSendChat('/rb  Ñïàâí îðãàíèçàöèîííîãî òðàíñïîðòà ÷åðåç 10 ñåêóíä.')
		wait(5000)
		sampSendChat('/rb  Ñïàâí îðãàíèçàöèîííîãî òðàíñïîðòà ÷åðåç 5 ñåêóíä.')
		wait(5000)
		sampSendChat('/rb  Ñïàâí îðãàíèçàöèîííîãî òðàíñïîðòà.')
		wait(1000)
		sampSendChat('/ffixcar')
	  end
   end)
 end
 function invitenarko(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Õèðóðã' or rank == 'Ïñèõîëîã' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me äîñòàë(à) áåéäæèê íàðêîëîãà è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
				wait(6000)
				sampSendChat(string.format('/giverank %s 5', id))
				wait(2000)
				sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - Áûë ïðèíÿò íà íàðêîëîãà, Ïîçäðàâëÿåì', cfg.main.tarr))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
		end
		else
			ftext('Ââåäèòå: /invn [id]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Ïñèõîëîã.')
	  end
   end)
 end
function zheal(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
				wait(3000)
				sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
				wait(3000)
				sampSendChat('/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(1100)
				sampSendChat(string.format('/heal %s', id))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
		end
		else
			ftext('Ââåäèòå: /z [id]')
		end
   end)
end
 function ginv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(ginvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ.')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	end
	  else
			ftext('Ââåäèòå: /ginv [id]')
	end
	  end)
   end
   
   function cinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(crpinv(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ.')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	end
	  else
			ftext('Ââåäèòå: /cinv [id]')
	end
	  end)
   end

 function zinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(zinvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ.')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	end
	  else
			ftext('Ââåäèòå: /zinv [id]')
	end
	  end)
   end
 function oinv(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
		local _, handle = sampGetCharHandleBySampPlayerId(id)
	if id then
	if doesCharExist(handle) then
		local x, y, z = getCharCoordinates(handle)
		local mx, my, mz = getCharCoordinates(PLAYER_PED)
		local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)
	  if dist <= 5 then
	  if cfg.main.tarb then
		if sampIsPlayerConnected(id) then
                submenus_show(oinvite(id), "{9966cc}Medick Helpers {ffffff}| Âûáîð îòäåëà")
				else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
            end
		else
			ftext('Âêëþ÷èòå àâòîòåã â íàñòðîéêàõ.')
		end
		else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	  end
	  else
			ftext('Ðÿäîì ñ âàìè íåò äàííîãî èãðîêà.')
	end
	  else
			ftext('Ââåäèòå: /oinv [id]')
	end
	  end)
   end

 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me çàáðàë(à) ôîðìó è áåéäæèê ó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
			else
			ftext('Èãðîê ñ äàííûì ID íå ïîäêëþ÷åí ê ñåðâåðó èëè óêàçàí âàø ID.')
		end
		else
			ftext('Ââåäèòå: /uninvite [id] [ïðè÷èíà]')
		end
		else
			ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Õèðóðã.')
	  end
   end)
 end
 function zinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë SES",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Çàìåñòèòåëÿ Ãëàâû Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêîé-Ñòàíöèè è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 12.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Çàì.Ãëàâû.SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Çàìåñòèòåëü Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêîé-Ñòàíöèè.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë ÏÑÁ",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Çàìåñòèòåëÿ Ãëàâû Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(4000)
	sampSendChat('/b /clist 29.')
	wait(4000)
	sampSendChat('/b Òåã â /r [Çàì.Ãëàâû ÏÑÁ]:')
	wait(4000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Çàìåñòèòåëü Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû.', cfg.main.tarr))
	end
   },
 }
end
function crpinv(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Íà÷àëüíèê",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Íà÷àëüíèêà Control Room è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 15.')
	wait(7000)
	sampSendChat('/b Òåã â /r [Chief CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Íà÷àëüíèê Control Room.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}» {FFFFFF}Ñò.Äèñïåò÷åð",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñòàðøåãî Äèñïåò÷åðà Control Room è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 10.')
	wait(7000)
	sampSendChat('/b Òåã â /r [Senior Dispatcher]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ñò.Äèñïåò÷åð Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Äèñïåò÷åð",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Äèñïåò÷åðà Control Room è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 11.')
	wait(7000)
	sampSendChat('/b Òåã â /r [Dispatcher CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Äèñïåò÷åð Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Ñîòðóäíèê",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñîòðóäíèêà Control Room è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 16.')
	wait(7000)
	sampSendChat('/b Òåã â /r [Employee CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ñîòðóäíèê Control Room.', cfg.main.tarr))
	end
   },
 }
end
function oinvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë SES [Èíñïåêòîð SES]",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Èíñïåêòîðà Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñîé-Ñòàíöèè è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10.')
	wait(5000)
	sampSendChat('/b òåã â /r [SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ïîâûøàåòñÿ â äîëíîñòè íà Èíñïåêòîðà Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñîé-Ñòàíöèè.', cfg.main.tarr))
	end
   },
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë SES",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñòàæåðà Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñîé-Ñòàíöèè è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 19.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Còàæåð SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé  ñîòðóäíèê  Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñîé-Ñòàíöèè.', cfg.main.tarr))
	end
   },

   -- {
   -- title = "{80a4bf}» {FFFFFF}Îòäåë ÓÒÓ",
    -- onclick = function()
	-- sampSendChat('/me äîñòàë(à) áåéäæèê Ñîòðóäíèêà(öû) Ó÷åáíî-Òðåíèíãîâî îòäåëåíèÿ è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	-- wait(5000)
	-- sampSendChat('/b /clist 15.')
	-- wait(5000)
	-- sampSendChat('/b Òåã â /r [ÓÒÓ]:')
	-- wait(5000)
	-- sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé  Ñîòðóäíèê Îòäåëà MA.', cfg.main.tarr))
	-- end
   -- },
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë ÏÑÁ [Èíñïåêòîð ÏÑÁ]",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Èíñïåêòîðà Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10.')
	wait(5000)
	sampSendChat('/b Òåã â /r [ÏÑÁ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ïîâûøàåòñÿ â äîëíîñòè íà Èíñïåêòîðà Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë ÏÑÁ",
    onclick = function()
	sampSendChat('/me äîñòàë(à) áåéäæèê Ñòàæåðà Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû è ïåðåäàë åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 2.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Còàæåð ÏÑÁ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé  ñîòðóäíèê  Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû.', cfg.main.tarr))
	end
   },
 }
end
function ginvite(id)
 return
{
  {
   title = "{80a4bf}» {FFFFFF}Îòäåë ÏÑÁ Ãëàâà.",
    onclick = function()
	if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' or  rank == 'Õèðóðã' or  rank == 'Äîêòîð' or  rank == 'Ïñèõîëîã' then
	sampSendChat('/me äîñòàë(à) áåéäæèê Ãëàâû  Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 21.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Ãëàâà ÏÑÁ]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ãëàâà Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû ', cfg.main.tarr))
	else
	ftext('Âû íå ìîæåòå íàçíà÷èòü Ãëàâó äàííîãî îòäåëà.')
	end
	end
   },
   {
   title = "{80a4bf}» {FFFFFF}Îòäåë SES Ãëàâà.",
    onclick = function()
	if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâíûé Âðà÷' or  rank == 'Õèðóðã' then
	sampSendChat('/me äîñòàë(à) áåéäæèê Ãëàâû  Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêîé-Ñòàíöèè è ïåðåäàë(à) åãî '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 8.')
	wait(5000)
	sampSendChat('/b Òåã â /r [Ãëàâà SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - íîâûé Ãëàâà Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêîé-Ñòàíöèè ', cfg.main.tarr))
	else
	ftext('Âû íå ìîæåòå íàçíà÷èòü Ãëàâó äàííîãî îòäåëà.')
	end
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{80a4bf}»{FFFFFF} Ìåíþ {ffffff}ëåêöèé",
    onclick = function()
	submenus_show(fthmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ ëåêöèé")
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Cîáåñåäîâàíèå",
    onclick = function()
	submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ ñîáåñåäîâàíèÿ")
	end
   },
   -- {
   -- title = "{80a4bf}»{FFFFFF} Îñíîâíîå ìåíþ",
    -- onclick = function()
	-- submenus_show(osmrmenu(id), "{9966cc}Medick Helper {0033cc}| Îñíîâíîå ìåíþ")
	-- end
   -- },
   -- {
   -- title = "{80a4bf}»{FFFFFF} Äîïîëíèòåëüíî",
    -- onclick = function()
	-- submenus_show(osmrmenu1(id), "{9966cc}Medick Helper {0033cc}| Ìåäèöèíñêèé îñìîòð")
	-- end
   -- },
   {
	title = '{80a4bf}»{FFFFFF} Ìåíþ {ffffff}Ìåíþ àãèòàöèè {ff0000}(Ñò.Ñîñòàâ)',
    onclick = function()
	  if rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' or  rank == 'Õèðóðã' or  rank == 'Ïñèõîëîã' then
	submenus_show(agitmenu(id), '{9966cc} Medick Helper {0033cc}| Ìåíþ àãèòàöèè')
	else
	ftext('Âû íå íàõîäèòåñü â ñòàðøåì ñîñòàâå.')
	end
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Ìåíþ {ffffff}ãîñ.íîâîñòåé {ff0000}(Ñò.Ñîñòàâ)",
    onclick = function()
	if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
	submenus_show(govmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ ãîñ.íîâîñòåé")
	else
	ftext('Âû íå íàõîäèòåñü â ñòàðøåì ñîñòàâå.')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Ìåíþ {ffffff}îòäåëîâ",
    onclick = function()
	if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' or rank == 'Äîêòîð' or rank == 'Íàðêîëîã' then
	submenus_show(otmenu(id), "{9966cc}Medick Helper {0033cc}| Ìåíþ îòäåëîâ")
	else
	ftext('Äàííîå ìåíþ äîñòóïíî ñ äîëæíîñòè Íàðêîëîã.')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Âûçâàòü ñîòðóäíèêà ÏÎ â áîëüíèöó (/d).",
    onclick = function()
	if rank == 'Ìåä.áðàò' or rank =='Ñïàñàòåëü' or rank =='Íàðêîëîã' or rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
	sampSendChat(string.format('/d SAPD, âûøëèòå ñîòðóäíèêà â áîëüíèöó. Çàðàíåå ñïàñèáî.'))
	else
	ftext('Äàííàÿ ôóíêöèÿ äîñòóïíà ñ äîëæíîñòè Ìåä.áðàò.')
	end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Ïðîâåðêà áèçíåñîâ/îðãàíèçàöèé",
    onclick = function()
	submenus_show(proverkabizorg(id), "{9966cc}Medick Helper {0033cc}| Ïðîâåðêà áèçíåñîâ/îðãàíèçàöèé")
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Ìåíþ îïåðàöèé",
    onclick = function()
	submenus_show(operacia(id), "{9966cc}Medick Helper {0033cc}| Îïåðàöèè")
	end
   },
}
end

function otmenu(id)
 return
{
  {
   title = "{80a4bf}»{FFFFFF} Ïèàð îòäåëà â ðàöèþ {ff00ff}ÑÝÑ{ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Â Ñàíèòàðíî-Ýïèäåìèîëîãè÷åñêóþ-Ñòàíöèþ ïðîèçâîäèòñÿ ïîïîëíåíèå ñîòðóäíèêîâ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Âñòóïèòü â îòäåë ìîæíî ñ äîëæíîñòè "Ìåä.Áðàò".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Äëÿ ïîäðîáíîé èíôîðìàöèè ïèøèòå íà ï.'..myid..'.', cfg.main.tarr))
	wait(5000)
    sampSendChat(string.format('/rb [%s]: Îò âàñ òðåáóåòñÿ õîðîøåå îòûãðûâàíèå ÐÏ ñèòóàöèé.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Ïèàð îòäåëà â ðàöèþ {0000ff}FI{ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Â Fire Inspection îòäåëåíèå ïðîèçâîäèòñÿ ïîïîëíåíèå ñîòðóäíèêîâ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Âñòóïèòü â îòäåë ìîæíî ñ äîëæíîñòè "Íàðêîëîã".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Äëÿ ïîäðîáíîé èíôîðìàöèè ïèøèòå íà ï.'..myid..'.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Ïèàð îòäåëà â ðàöèþ {0000ff}ÏÑÁ{ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Â Ïîèñêîâî-Ñïàñàòåëüíîé Áðèãàäû îòäåëåíèå ïðîèçâîäèòñÿ ïîïîëíåíèå ñîòðóäíèêîâ.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Âñòóïèòü â îòäåë ìîæíî ñ äîëæíîñòè "Ìåä.Áðàò".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: Äëÿ ïîäðîáíîé èíôîðìàöèè ïèøèòå íà ï.'..myid..'.', cfg.main.tarr))
	end
   },
   -- {
   -- title = "{80a4bf}»{FFFFFF} Ïèàð îòäåëà â ðàöèþ {0000ff}CR{ff0000}(Äëÿ ãëàâ/çàìîâ îòäåëà)",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- sampSendChat(string.format('/r [%s]: Óâàæàåìûå ñîòðóäíèêè, ìèíóòî÷êó âíèìàíèÿ.', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: Â Control Room ïðîèçâîäèòñÿ ïîïîëíåíèå ñîòðóäíèêîâ.', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: Âñòóïèòü â îòäåë ìîæíî ñ äîëæíîñòè "Ìåä.Áðàò".', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: Äëÿ ïîäðîáíîé èíôîðìàöèè ïèøèòå íà ï.'..myid..'.', cfg.main.tarr))
	-- end
   -- },
}
end

function operacia(id)
    return
    {
      {
        title = '{ffffff}» Ïåðåëîì ðóêè/íîãè ¹1.',
        onclick = function()
        sampSendChat("/me ïîìîãàåò ïàöèåíòó äîéòè äî îïåðàöèîííîãî ñòîëà")
        wait(3000) 
        sampSendChat("/me íàäåë ïåð÷àòêè íà ñâîè ðóêè è çàêðûë øêàô")
        wait(3000) 
        sampSendChat("/me âêëþ÷èâ ðåíòãåí-àïïàðàò â ñåòü, íàâ¸ë èçëó÷àòåëè íà ïàöèåíòà")
		wait(3000) 
        sampSendChat("/do Ñíèìîê áûë ãîòîâ.")
		wait(3000) 
        sampSendChat("/me âçÿë â ñâîè ðóêè ñíèìîê è íà÷àë åãî ðàññìàòðèâàòü")
		wait(3000) 
        sampSendChat("/todo Ýòî çàêðûòûé ïåðåëîì*ïîêàçàâ ïàöèåíòó ïàëüöåì íà ó÷àñòîê êîñòè íà ðåíòãåíå.")
		wait(3000) 
        sampSendChat("/me óëîæèë ïàöèåíòà íà îïåðàöèîííûé ñòîë")
		wait(3000) 
        sampSendChat("/me äîñòàë èç øêàôà ýëàñòè÷íûé áèíò è ïîëîæèë åãî ðÿäîì")
		wait(3000) 
        sampSendChat("/me çàôèêñèðîâàë ðóêó â íåïîäâèæíîì ñîñòîÿíèè")
		wait(3000) 
        sampSendChat("/do Â ðóêå ìåäèöèíñêàÿ øèíà.")
		wait(3000) 
        sampSendChat("/me íàëîæèë øèíó íà ìåñòî ïåðåëîìà áåç äàâëåíèÿ íà ñîñóäû")
		wait(3000) 
        sampSendChat("/try ïåðåâÿçàë âîêðóã øèíû ýëàñòè÷íûé áèíò ïðèêëàäûâàÿ ñðåäíþþ ñèëó")
		end
      },
	  {
        title = '{5b83c2}« Åñëè íåóäà÷íî, òî ïåðåõîäèì ê ¹2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Ïåðåëîì ðóêè/íîãè ¹2.',
        onclick = function()
        sampSendChat("/do Ó ïàöèåíòà áûëè ýìîöèè íà ëèöå, ïîêàçûâàþùèå åãî áîëü.")
        wait(3000) 
        sampSendChat("/me îñëàáèë íåìíîãî áèíò, ñáàâëÿÿ ñâîþ ñèëó")
        wait(3000) 
        sampSendChat("/try âçãëÿíóë íà ëèöî ïàöèåíòà è ñèëà ïåðåâÿçêè íå äîñòàâëÿëà åìó áîëè")
		end
      },
	  {
        title = '{ffffff}» Ïóëåâîå ðàíåíèå ¹1.',
        onclick = function()
        sampSendChat("/me ïîäîø¸ë ê øêàôó, äîñòàë èç íåãî ïåð÷àòêè")
        wait(3000) 
        sampSendChat("/me ïîìûâ ðóêè ïîä êðàíîì, îäåë ïåð÷àòêè è çàêðûë øêàô")
        wait(3000) 
        sampSendChat("/todo Ëîæèòåñü, ÿ âàì îêàæó ïîìîùü*ïîêàçàâ ðóêîé íà ñòîë.")
		wait(3000) 
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
		wait(3000) 
        sampSendChat("/me ïðîêðóòèë âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
		wait(3000) 
        sampSendChat("/do Ïîñëå ïîäà÷è íàðêîçà ïàöèåíò óñíóë.")
		wait(3000) 
        sampSendChat("/me âçÿë ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
		wait(3000) 
        sampSendChat("/me ïîñòàâèë ïîäíîñ íà òàáóðåò ðÿäîì ñ îïåðàöèîííûì ñòîëîì")
		wait(3000) 
        sampSendChat("/me âêîëîë øïðèö ñ 2 ïðîöåíòàìè Äèáàçîëà è ââ¸ë îáåçáîëèâàþùåå")
		wait(3000) 
        sampSendChat("/me âçÿë ñ ïîäíîñà ïèíöåò è ïðîëåç èì â ðàíó")
		wait(3000) 
        sampSendChat("/me ñòàðàåòñÿ îñòîðîæíî çàöåïèòü ïóëþ ïèíöåòîì")
		wait(3000) 
        sampSendChat("/try èçúÿë ïóëþ, íàùóïàâ å¸")
		end
      },
	  {
        title = '{5b83c2}« Åñëè íåóäà÷íî, òî ïåðåõîäèì ê ¹2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Ïóëåâîå ðàíåíèå ¹2.',
        onclick = function()
        sampSendChat("/me öåïëÿåò ïóëþ, äåëàÿ ýòî îñòîðîæíî")
        wait(3000) 
        sampSendChat("/try èçúÿë ïóëþ, íàùóïàâ å¸")
		end
      },
	  {
        title = '{5b83c2}« Åñëè óäà÷íî, òî ïåðåõîäèì ê ¹3. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Ïóëåâîå ðàíåíèå ¹3.',
        onclick = function()
        sampSendChat("/me èçâë¸ê ïóëþ èç ÷åëîâåêà è ïîëîæèë å¸ íà ïîäíîñ")
        wait(3000) 
        sampSendChat("/me âçÿë ø¸ëêîâóþ èãëó è ïðîäåë íèòêó â óøêî èãðû")
		wait(3000) 
        sampSendChat("/me íà÷àë íàêëàäûâàòü øâû, ñòÿãèâàÿ êîæó ó ðàíû")
		wait(3000) 
        sampSendChat("/do Ïîñëå íàëîæåíèÿ øâîâ, îíè áûëè çàôèêñèðîâàíû.")
		wait(3000) 
        sampSendChat("/me âçÿë íîæíèöû è îáðåçàë ëèøíþþ íèòî÷êó")
		wait(3000) 
        sampSendChat("/me îáðàáîòàë ìåñòî ðàíåíèÿ àíòèñåïòèêîì è ñëîæèë âñ¸ íà ïîäíîñ")
		end
      },
	  {
        title = '{ffffff}» Íîæåâîå ðàíåíèå.',
        onclick = function()
        sampSendChat("/me ïîäîø¸ë ê øêàôó, äîñòàë èç íåãî ïåð÷àòêè")
        wait(3000) 
        sampSendChat("/me ïîìûâ ðóêè ïîä êðàíîì, îäåë ïåð÷àòêè è çàêðûë øêàô")
        wait(3000) 
        sampSendChat("/todo Ðàçäåâàéòåñü, âåùè ïîëîæèòå ñþäà*ïîêàçàâ ðóêîé íà ñòóë.")
		wait(3000) 
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
		wait(3000) 
        sampSendChat("/me ïðîêðóòèë âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
		wait(3000) 
        sampSendChat("/me âçÿë ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
		wait(3000) 
        sampSendChat("/me íåñ¸ò ïîäíîñ â ðóêàõ è ïîñòàâèë ïîäíîñ íà òàáóðåò")
		wait(3000) 
        sampSendChat("/me âçÿë ñ ïîäíîñà øïðèö ñ ðàñòâîðîì Äèáàçîëà")
		wait(3000) 
        sampSendChat("/me âêîëîë øïðèö ðÿäîì ñ ìåñòîì ðàíåíèÿ")
		wait(3000) 
        sampSendChat("/do Îáåçáîëèâàþùåå ïîäåéñòâîâàëî.")
		wait(3000) 
        sampSendChat("/me íà÷àë íàêëàäûâàòü øâû, ñòÿíóâ êîæó ó ðàíû")
		wait(3000) 
        sampSendChat("/me çàêîí÷èâ íàëîæåíèå øâîâ, çàòåì çàôèêñèðîâàë èõ")
		wait(3000) 
        sampSendChat("/me îáðåçàë ëèøíþþ íèòü íîæíèöàìè è âçÿë àíòèñåïòèê")
		wait(3000) 
        sampSendChat("/me îáðàáîòàë øâû àíòèñåïòèêîì è ñëîæèë âñ¸ íà ïîäíîñ")
		end
      },
	  {
        title = '{ffffff}» Óäàëåíèå àïïåíäèöèòà.',
        onclick = function()
        sampSendChat("/me ïîäîø¸ë ê øêàôó, äîñòàë èç íåãî ïåð÷àòêè")
        wait(3000) 
        sampSendChat("/me ïîìûâ ðóêè ïîä êðàíîì, îäåë ïåð÷àòêè è çàêðûë øêàô")
        wait(3000) 
        sampSendChat("/do Êèñëîðîäíàÿ ìàñêà âèñåëà ïåðåä ëèöîì.")
		wait(3000) 
        sampSendChat("/me ïðîêðóòèë âåíòèëü, ïîäàâ òåì ñàìûì íàðêîç")
		wait(3000) 
        sampSendChat("/do Ïîñëå ïîäà÷è íàðêîçà ïàöèåíò óñíóë.")
		wait(3000) 
        sampSendChat("/me âçÿë ñî ñòîëà ïîäíîñ ñ õèðóðãè÷åñêèìè èíñòðóìåíòàìè")
		wait(3000) 
        sampSendChat("/me âçÿë ñ ïîäíîñà äûõàòåëüíóþ òðóáêó è ââ¸ë â òðàõåþ ïàöèåíòà")
		wait(3000) 
        sampSendChat("/me íàìåòèâ ìàðêåðîì ìåñòî íàäðåçà, çàòåì ñäåëàë íàäðåç")
		wait(3000) 
        sampSendChat("/me âçÿë â ðóêè ïèíöåò è ïðîëåç â íàäðåç")
		wait(3000) 
        sampSendChat("/me çàöåïèë ïèíöåòîì àïïåíäèêñ è îáðåçàë âîñïàë¸ííûé îðãàí")
		wait(3000) 
        sampSendChat("/me èçâë¸ê àïïåíäèêñ ïèíöåòîì èç ðàíû, óáðàë íà ïîäíîñ ñêàëüïåëü")
		wait(3000) 
        sampSendChat("/me âçÿë ñî ñòîëà íèòü è èãëó, ïîòîì ïðîäåë íèòü â óøêî")
		wait(3000) 
        sampSendChat("/me ñòÿíóë òêàíè â ñëåïîé êèøêå è íàëîæèë øâû")
		wait(3000) 
        sampSendChat("/me çàôèêñèðîâàâ øâû è îòðåçàë íèòü íîæíèöàìè")
		wait(3000) 
        sampSendChat("/do Ïðîöåññ íàëîæåíèÿ øâîâ íà òåëî ïàöèåíòà.")
		wait(3000) 
        sampSendChat("/me ñëîæèë âñ¸ íà ïîäíîñ è îáðàáîòàë")
		wait(3000) 
        sampSendChat("/me ïîëîæèë âñ¸ íà ïîäíîñ, ñíÿë ïåð÷àòêèñ")
		wait(3000) 
        sampSendChat("/me îáðàáîòàë ìåñòî øâîâ àíòèñåïòèêîì")
		end
      },
    }
end

function proverkabizorg(id)
    return
    {
      {
        title = '{5b83c2}« Ïðîâåðêà çàâåäåíèÿ. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Îñìîòðåíèå â ïîìåùåíèè.',
        onclick = function()
        sampSendChat("/me ïîñìîòðåë ïî ñòîðîíàì, ïðîâåðÿÿ ìåñòà äëÿ óïîòðåáëåíèÿ ïèùè")
        wait(3000) 
        sampSendChat("/try îïðåäåëèë íà âçãëÿä, ÷òî ìåñòà äëÿ óïîòðåáëåíèÿ ïèùè ÷èñòû")
        wait(3000) 
        sampSendChat("/me ñäåëàë çàïèñü â áëîêíîòå")
		end
      },
	  {
        title = '{ffffff}» 2) Ïðîâåðêà ñòîëà íà êóõíå.',
        onclick = function()
        sampSendChat("/me äîñòàë ÷èñòûå ïåð÷àòêè èç ñóìêè")
        wait(3000) 
        sampSendChat("/me íàòÿíóë ïåð÷àòêè íà ðóêè è ïðîâåë ðóêîé ïî ñòîëó íà êóõíå")
        wait(3000) 
        sampSendChat("/try ïîñìîòðåë íà ðóêó â ïåð÷àòêå è îáíàðóæèë ãðÿçü íà ïåð÷àòêå")
		wait(3000) 
        sampSendChat("/me ñòÿíóë ïåð÷àòêè ñ ðóê è âûáðîñèë â ìóñîðêó")
		wait(3000) 
        sampSendChat("/me ñäåëàë çàïèñü â áëîêíîòå")
		end
      },
	  {
        title = '{ffffff}» 3) Îñìîòðåíèå ïîìåùåíèÿ (íà íàëè÷èå íàñåêîìûõ).',
        onclick = function()
        sampSendChat("/me ïîñìîòðåë ïî ñòîðîíàì ïîìåùåíèÿ â ïîèñêàõ ìóõ")
        wait(3000) 
        sampSendChat("/me íà÷àë îñìàòðèâàòü âñå ÿùèêè â ïîèñêàõ íàñåêîìûõ")
        wait(3000) 
        sampSendChat("/try îáíàðóæèë ìóõ (íàñåêîìûõ) â íåêîòîðûõ ÿùèêàõ")
		wait(3000) 
        sampSendChat("/me ñäåëàë çàïèñü â áëîêíîòå")
		end
      },
	  {
        title = '{ffffff}» 4) Ïðîâåðêà ïðèáîðîâ ïðèãîòîâëåíèÿ ïèùè.',
        onclick = function()
        sampSendChat("/me äîñòàë ÷èñòûå ïåð÷àòêè èç ñóìêè è íàäåë èõ íà ðóêè")
        wait(3000) 
        sampSendChat("/me ïðîâåðÿåò ÷èñòîòó ïðèñïîñîáëåíèé äëÿ ïðèãîòîâëåíèÿ ïèùè")
        wait(3000) 
        sampSendChat("/try ïîñìîòðåë íà ðóêó â ïåð÷àòêå è îáíàðóæèë ãðÿçü íà ïåð÷àòêå")
		wait(3000) 
        sampSendChat("/me ñòÿíóë ïåð÷àòêè ñ ðóê è âûêèíóë â ìóñîðêó")
		wait(3000) 
        sampSendChat("/me ñäåëàë çàïèñü â áëîêíîòå")
		end
      },
	  {
        title = '{ffffff}» 5) Ïðîâåðêà ïðîäóêòîâ íà ñðîêè ãîäíîñòè.',
        onclick = function()
        sampSendChat("/me îòêðûë øêàô è íà÷àë ïðîâåðÿòü ïðîäóêòû â í¸ì")
        wait(3000) 
        sampSendChat("/try îáíàðóæèë íåñîîòâåòñòâèÿ ñ íîðìàìè õðàíåíèÿ ïðîäóêòîâ")
        wait(3000) 
        sampSendChat("/me çàïèñàë â áëîêíîò è çàêðûë åãî")
		end
      },
	  {
        title = '{5b83c2}« /do "Äîëæíîñòü" ïîâåñèë íà ñòåíêó îò÷¸ò: Ñàíèòàðèÿ è ïðèãîäíîñòü: [?/5] »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}«  »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðîâåðêà îðãàíèçàöèè. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Ïðîâåðêà êðîâè.',
        onclick = function()
        sampSendChat("Äîáðûé äåíü. Ïðèñàæèâàéòåñü ïîæàëóéñòà íà äèâàí÷èê, ñåé÷àñ âîçüìó àíàëèç êðîâè")
        wait(3000) 
        sampSendChat("/me îòêðûë òàáëî ñ àíàëèçîì êðîâè")
        wait(3000) 
        sampSendChat("/do Òàáëî îòêðûòî.")
		wait(3000) 
        sampSendChat("/me çàëèë òóäà êðîâü ïðîâåðÿþùåãî")
		wait(3000) 
        sampSendChat("/do Âêëþ÷èë àíàëèç-àïïàðàò.")
		end
      },
	  {
        title = '{5b83c2}« Ïðîâåðÿåì êîìàíäîé /checkheal [id] »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Ïðîâåðêà àíàëèçà, åñëè óäà÷íî - òî ïîëîæèòåëüíûé, íåóäà÷íî - òî îòðèöàòåëüíûé.',
        onclick = function()
        sampSendChat("/try àíàëèç-àïïàðàò ïîêàçàë îòðèöàòåëüíûé/ïîëîæèòåëüíûé àíàëèç")
		wait(3000) 
        sampSendChat("/me çàïèñàë âñå áëîêíîò")
		end
      },
	  {
        title = '{5b83c2}« Äîêëàä â ðàöèþ ïî ïîâîäó ïàöèåíòà çàâèñèì èëè íå çàâèñèì îò íàðêîòèêîâ. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« /r [ÒÝÃ] "Nick_Name ãîñ.ñëóæàùåãî" - íå ÿâëÿåòñÿ íàðêîçàâèñèìûì. Çäîðîâ. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« /r [ÒÝÃ] "Nick_Name ãîñ.ñëóæàùåãî" - èìååò 1000% íàðêîçàâèñèìîñòè. »',
        onclick = function()
        end
      },
    }
end

function sobesedmenu(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë ñîáåñåäîâàíèÿ. »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat('Çäðàâñòâóéòå. ß ñîòðóäíèê áîëüíèöû '..myname:gsub('_', ' ')..', âû íà ñîáåñåäîâàíèå?')
		wait(4000)
		sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ '..rank..' | '..myname:gsub('_', ' ')..'.')
		end
      },
      {
        title = '{80a4bf}» {ffffff}Äîêóìåíòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Âàø ïàñïîðò è äèïëîì,ïîæàëóéñòà.')
		wait(3000)
		sampSendChat('/b /showpass '..myid..'')
		wait(3000)
		sampSendChat('/b Äèïëîì ïî ÐÏ.')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Çàÿâëåíèå íà îô.ïîðòàë íà Íàðêîëîãà{ff0000} ñ 6 ëåò â øòàòå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Âû ìîæåòå îñòàâèòü çàÿâëåíèå íà îô.ïîðòàëå, íà äîëæíîñòü Íàðêîëîãà, à ìîæåòå ñåé÷àñ íà Èíòåðíà.')
		wait(5000)
		sampSendChat('/b evolve-rp.su -> Cleveland -> Ãîñ.Ñòðóêòóðû -> Ìèíèñòåðñòâî Çäðàâîõðàíåíèÿ -> Çàÿâëåíèå íà äîëæíîñòü Íàðêîëîãà.')
		wait(3000)
		sampSendChat('Îñòàâèòå çàÿâëåíèå èëè ñåé÷àñ íà èíòåðíà?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff} Èçó÷åíèå äîêóìåíòîâ.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('/me âçÿë äîêóìåíòû ó ÷åëîâåêà íàïðîòèâ, ïîñëå íà÷àë èõ èçó÷àòü')
		wait(4000)
        sampSendChat('/me îçíàêîìèâøèñü ñ äîêóìåíòàìè, âåðíóë èõ îáðàòíî')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Ðàññêàæèòå íåìíîãî î ñåáå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('Õîðîøî, ðàññêàæèòå íåìíîãî î ñåáå.')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàðüåðà.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Êàê áû âû õîòåëè, ÷òîáû ðàçâèâàëàñü âàøà êàðüåðà?')
        end
      },
	  {
	     title = '{80a4bf}» {ffffff}Îïûò â äàííîé ñôåðå.',
        onclick = function()
        sampSendChat('Èìåëè ðàíüøå îïûò â äàííîé ñôåðå?')
		wait(4000)
        end
      },
	  {
	   title = '{80a4bf}» {ffffff}Ïðîáëåìû ñ çàêîíîì.',
	   onclick = function()
	   sampSendChat('Èìåëè ðàíüøå ïðîáëåìû ñ çàêîíîì?')
	   wait(4000)
	   end
      },
	  {
        title = '{80a4bf}» {ffffff}Còðåññ íà ðàáîòå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Êàê âû ñïðàâëÿåòåñü ñî ñòðåññîì íà ðàáîòå?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîøëàÿ ðàáîòà.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('×òî âàñ íå óñòðàèâàëî íà ïðîøëîé ðàáîòå?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Çàðïëàòà.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Íà êàêóþ çàðïëàòó âû ðàñ÷èòûâàåòå?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}ÐÏ òåðìèíû.',
        onclick = function()
        sampSendChat('×òî ïî âàøåìó îçíà÷àþò ïîíÿòèÿ êàê ÐÏ è ÄÌ?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}×òî íàä ãîëîâîé.',
        onclick = function()
        sampSendChat('×òî ó ìåíÿ íàä ãîëîâîé?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðèêàçû ðóêîâîäñòâà.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Êàê âû ïåðåíîñèòå ïðèêàçû ðóêîâîäñòâà?')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}ÐÏ òåðìèíû â /b.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('/b ÐÏ è ÒÊ â /sms '..myid..'')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Âû ïðèíÿòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Ïîçäðàâëÿþ, âû íàì ïîäõîäèòå.')
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Âû íå ïðèíÿòû.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('Ïðîøó ïðîùåíèÿ, íî âû íàì íå ïîäõîäèòå. Ïîêèíüòå ñîáåñåäîâàíèÿ.')
        end
	  },
    }
end

function govmenu(id)
 return
{
   {
   title = "{80a4bf}»{FFFFFF} Íà÷àëî ñîáåñåäîâàíèÿ è åãî ïðîäîëæåíèå.",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		wait(1300)
		sampSendChat("/gov [MOH]: Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ìèíóòî÷êó âíèìàíèÿ.")
        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Õîòèì ñîîáùèòü, ÷òî ïðÿìî ñåé÷àñ ïðîõîäèò ñîáåñåäîâàíèå â èíòåðíàòóðó.')
        wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: Êðèòåðèè: Èìåòü ïðîïèñêó îò 3-õ ëåò â øòàòå è áûòü çàêîíîïîñëóøíûì.')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Ïîñëå òðóäîóñòðîéñòâà âàñ îæèäàåò ñòàáèëüíàÿ çàðàáîòíàÿ ïëàòà è ïðåìèè.')
		wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [MOH]: Ñ óâàæåíèåì, ðóêîâîäñòâî öåíòðàëüíîé áîëüíèöû øòàòà.')
		wait(750)
        sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		wait(1200)
		sampAddChatMessage("{F80505}Â îáÿçàòåëüíîì ïîðÿäêå {F80505}äîáàâüòå {0CF513} /addvacancy.", -1)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
	},
	{
   title = "{80a4bf}»{FFFFFF} Êîíåö ñîáåñåäîâàíèÿ.",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        wait(1300)
        sampSendChat("/gov [MOH]: Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ìèíóòî÷êó âíèìàíèÿ.")
                wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Ñîáåñåäîâàíèå â èíòåðíàòóðó ïîäîøëî ê êîíöó.')
                wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [MOH]: Õîòèì íàïîìíèòü, ÷òî íà îôèöèàëüíîì ïîðòàëå îòêðûòû çàÿâëåíèÿ íà äîëæíîñòü Íàðêîëîãà.')
	        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Ïîñëå òðóäîóñòðîéñòâà âàñ îæèäàåò ñòàáèëüíàÿ çàðàáîòíàÿ ïëàòà è ïðåìèè.')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Ñ óâàæåíèåì, ðóêîâîäñòâî öåíòðàëüíîé áîëüíèöû øòàòà.')
		wait(750)
        sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé..")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
    {
   title = "{80a4bf}»{FFFFFF} Çàÿâëåíèÿ íà äîëæíîñòü Íàðêîëîãà.",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        wait(1300)
        sampSendChat("/gov [MOH]: Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ìèíóòî÷êó âíèìàíèÿ.")
        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Íà îôèöèàëüíîì ïîðòàëå øòàòà îòêðûòû çàÿâëåíèÿ íà äîëæíîñòü Íàðêîëîãà.')
        wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [MOH]: Â ñëó÷àå óñïåøíîãî ïðîõîæäåíèÿ íàðêîëîãèè, âû ïîëó÷èòå 500.000$.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Èñïûòàòåëüíûé ñðîê 7 äíåé.')
        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Ñ óâàæåíèåì, ðóêîâîäñòâî öåíòðàëüíîé áîëüíèöû øòàòà.')
		wait(750)
        sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
    {
   title = '{80a4bf}»{FFFFFF} Ðåôåðàëüíàÿ ñèñòåìà.',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.')
                wait(1300)
        sampSendChat('/gov [MOH]: Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ìèíóòî÷êó âíèìàíèÿ.')
        wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [MOH]: Â öåíòðàëüíîé áîëüíèöå äåéñòâóåò ðåôåðàëüíàÿ ñèñòåìà.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Çà êàæäîãî ïðèãëàø¸ííîãî äðóãà ê íàì, âû ìîæåòå ïîëó÷èòü äî 400.000$.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Áîëåå ïîäðîáíî âû ìîæåòå îçíàêîìèòñÿ íà îôèöèàëüíîì ïîðòàëå.')
	wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [MOH]: Ñ óâàæåíèåì, ðóêîâîäñòâî öåíòðàëüíîé áîëüíèöû øòàòà.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
   {
   title = "{80a4bf}»{FFFFFF} Àìíèñòèÿ ÷¸ðíîãî ñïèñêà ÌÎÍ.",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
                wait(1300)
        sampSendChat("/gov [MOH]: Óâàæàåìûå æèòåëè è ãîñòè øòàòà, ìèíóòî÷êó âíèìàíèÿ.")
        wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [MOH]: Ðóêîâîäñòâî ïðèíÿëî ðåøåíèå î àìíèñòèè ÷¸ðíîãî ñïèñêà.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Êàæäûé êòî â í¸ì áûë, òåïåðü èìååò ïðàâî âåðíóòñÿ ñíîâà â íàø äðóæíûé êîëëåêòèâ.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [MOH]: Ýòî âàø øàíñ èçìåíèòü ñâîþ æèçíü ê ëó÷øåìó.')
	wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [MOH]: Ñ óâàæåíèåì, ðóêîâîäñòâî öåíòðàëüíîé áîëüíèöû øòàòà.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		wait(1200)
		if cfg.main.hud then
        sampSendChat("/time 1")
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   },
   -- {
   -- title = "{80a4bf}»{FFFFFF} COVID-19.",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- local myname = sampGetPlayerNickname(myid)
	-- sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat("/me äîñòàë ÊÏÊ, ïîñëå ÷åãî ïîäêëþ÷èëñÿ ê ãîñ. âîëíå íîâîñòåé")
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/gov [ÌÎÍ]: Óâàæàåìûå æèòåëè øòàòà, ìèíóòî÷êó âíèìàíèÿ!")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [ÌÎÍ]: Â äàííûé ìîìåíò, ïîñòóïèëà èíôîðìàöèÿ ïðî âèðóñ.')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [ÌÎÍ]: Áóäüòå îñòîðîæíû, íîñèòå ìàñêè è äåðæèòå äèñòàíöèþ, òàêæå íå çàáûâàéòå ìûòü ðóêè ñ ìûëîì.')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [ÌÎÍ]: Ïðî âèðóñ âû ñìîæåòå óçíàòü íà îô.ïîðòàëå øòàòà.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH]: Ñ óâàæåíèåì, '..rank..' áîëüíèöû ãîðîäà Los-Santos - '..myname:gsub('_', ' ')..'.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [ÌÎÍ] Áóäüòå çäîðîâû, íå áîëåéòå!')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		-- wait(1200)
		-- if cfg.main.hud then
        -- sampSendChat("/time")
        -- wait(500)
        -- setVirtualKeyDown(key.VK_F8, true)
        -- wait(150)
        -- setVirtualKeyDown(key.VK_F8, false)
		-- end
	-- end
   -- },
    -- {
   -- title = "{80a4bf}»{FFFFFF} Ñèñòåìà {fb05d6}ðåôåðàëîâ.",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- local myname = sampGetPlayerNickname(myid)
	-- sampSendChat("/d OG, çàíÿë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat("/me äîñòàë ÊÏÊ, ïîñëå ÷åãî ïîäêëþ÷èëñÿ ê ãîñ. âîëíå íîâîñòåé")
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/gov [ÌÎÍ]: Óâàæàåìûå æèòåëè øòàòà, ìèíóòî÷êó âíèìàíèÿ!")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH]: Â öåíòðàëüíîé áîëüíèöå ãîðîäà Los-Santos`a äåéñòâóåò ðåôåðàëüíàÿ ñèñòåìà.')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [MOH]: Ñ äàííîé ñèñòåìîé âû ìîæåòå îçíàêîìèòüñÿ íà îô.ïîðòàëå áîëüíèöû.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH]: Ñ Óâàæåíèåì, '..rank..' Áîëüíèöû ãîðîäà Los-Santos - '..myname:gsub('_', ' ')..'.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [ÌÎÍ]: Áóäüòå çäîðîâû, íå áîëåéòå!')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/d OG, îñâîáîäèë âîëíó ãîñóäàðñòâåííûõ íîâîñòåé.")
		-- wait(1200)
		-- if cfg.main.hud then
        -- sampSendChat("/time")
        -- wait(500)
        -- setVirtualKeyDown(key.VK_F8, true)
        -- wait(150)
        -- setVirtualKeyDown(key.VK_F8, false)
		-- end
	-- end
   -- },
}
end

function fastsmsk()
	if lastnumber ~= nil then
		sampSetChatInputEnabled(true)
		sampSetChatInputText("/t "..lastnumber.." ")
	else
		ftext("Âû ðàíåå íå ïîëó÷àëè âõîäÿùèõ ñîîáùåíèé.", 0x046D63)
	end
end

function osmrmenu(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ëå÷åíèå ïàöèåíòà.",
    onclick = function()
	    sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
        wait(3000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
        wait(3000)
        sampSendChat("/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû ïàöèåíòó")
        wait(3000)
        sampSendChat("/heal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñåàíñ.",
    onclick = function()
	    sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(4000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ïðåïàðàò")
        wait(4000)
		sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
		wait(4000)
		sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
		wait(4000)
		sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
		wait(4000)
		sampSendChat("/do Øïðèö è ïðåïàðàò â ïðàâîé ðóêå.")
                wait(4000)
		sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò ïðåïàðàò â âåíó ïàöèåíòà")
                wait(4000)
		sampSendChat("/todo Íó âîò è âñ¸*âûòàùèâ øïðèö èç âåíû è ïðèëîæèâ âàòó ê ìåñòó óêîëà.")
                wait(4000)
		sampSendChat("/healaddict")





    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñïðàâêà ¹1.",
    onclick = function()
	    sampSendChat("/do Íà ñòîëå ñòîèò ÿùèê ñ ìåä.êàðòàìè è íåâðîëîãè÷åñêèì ìîëîòî÷êîì.")
        wait(5000)
        sampSendChat(" Èìååòå ëè âû æàëîáû íà çäîðîâüå?")
        wait(5000)
        sampSendChat("/do Â ëåâîé ðóêå ÷¸ðíàÿ ðó÷êà.")
        wait(5000)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(5000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(5000)
        sampSendChat("Ïðèñàæèâàéòåñü, íà÷íåì îáñëåäîâàíèå.")
        wait(5000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(5000)
        sampSendChat("/me âîäèò ìîëîòî÷êîì ïåðåä ãëàçàìè ïàöèåíòà")
        wait(5000)
        sampSendChat("/me óáåäèëñÿ, ÷òî çðà÷êè äâèæóòñÿ ñîäðóæåñòâåííî è ðåôëåêñ â íîðìå")
        wait(5000)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(5000)
        sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ëåâîìó êîëåíó ïàöèåíòà")
        wait(5000)
        sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ïðàâîìó êîëåíó ïàöèåíòà")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñïðàâêà ¹2",
    onclick = function()
	    sampSendChat("Çäåñü òîæå âñå â ïîðÿäêå. Òåïåðü ïðîâåðèì âàøó êðîâü.")
        wait(5000)
        sampSendChat("/do Íà ïîëó ñòîèò ìèíè-ëàáîðàòîðèÿ.")
        wait(5000)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(5000)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(5000)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(5000)
        sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
        wait(5000)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(5000)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(5000)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(5000)
        sampSendChat("/checkheal")
    end
  },  
  {
    title = "{80a4bf}»{FFFFFF} Ëå÷åíèå ïàöèåíòà.",
    onclick = function()
		sampSendChat(" Çäðàâñòâóéòå, ÷òî âàñ áåñïîêîèò?")
		wait(5000)
		sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
		wait(5000)
		sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
		wait(5000)
		sampSendChat("/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû ïàöèåíòó")
		wait(5000)
		sampSendChat("/heal")
    end
  },
}
end

function osmrmenu2(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ñåàíñ.",
    onclick = function()
	    sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(5000)
		sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ïðåïàðàò")
		wait(5000)
		sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
		wait(5000)
		sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
		wait(5000)
		sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
		wait(5000)
		sampSendChat("/do Øïðèö è ïðåïàðàò â ïðàâîé ðóêå.")
		wait(5000)
		sampSendChat("/me íàáðàë â øïðèö ïðåïàðàò")
		wait(5000)
		sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò ïðåïàðàò â âåíó ïàöèåíòà")
		wait(5000)
		sampSendChat("/healaddict")
    end
  },
}
end

function osmrmenu(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ëå÷åíèå ïàöèåíòà.",
    onclick = function()
	    sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
            wait(3000)
            sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
            wait(3000)
           sampSendChat("/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû ïàöèåíòó")
           wait(3000)
           sampSendChat("/heal") 
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñïðàâêà ¹1",
    onclick = function()
	     sampSendChat("/do Íà ñòîëå ñòîèò ÿùèê ñ ìåä.êàðòàìè è íåâðîëîãè÷åñêèì ìîëîòî÷êîì.")
        wait(5000)
        sampSendChat(" Èìååòå ëè âû æàëîáû íà çäîðîâüå?")
        wait(5000)
        sampSendChat("/do Â ëåâîé ðóêå ÷¸ðíàÿ ðó÷êà.")
        wait(5000)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(5000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(5000)
        sampSendChat("Ïðèñàæèâàéòåñü, íà÷íåì îáñëåäîâàíèå.")
        wait(5000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(5000)
        sampSendChat("/me âîäèò ìîëîòî÷êîì ïåðåä ãëàçàìè ïàöèåíòà")
        wait(5000)
        sampSendChat("/me óáåäèëñÿ, ÷òî çðà÷êè äâèæóòñÿ ñîäðóæåñòâåííî è ðåôëåêñ â íîðìå")
        wait(5000)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(5000)
        sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ëåâîìó êîëåíó ïàöèåíòà")
        wait(5000)
        sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ïðàâîìó êîëåíó ïàöèåíòà")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ñïðàâêà ¹2",
    onclick = function()
	    sampSendChat("Çäåñü òîæå âñå â ïîðÿäêå. Òåïåðü ïðîâåðèì âàøó êðîâü.")
        wait(5000)
        sampSendChat("/do Íà ïîëó ñòîèò ìèíè-ëàáîðàòîðèÿ.")
        wait(5000)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(5000)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(5000)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(5000)
        sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
        wait(5000)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(5000)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(5000)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(5000)
        sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Çàïîëíåíèå ñïðàâêè.",
    onclick = function()
	    sampSendChat("/do Øêàô÷èê îòêðûò.")
        wait(5000)
        sampSendChat("/do Â øêàô÷èêå ñòîÿò áëàíêè ñïðàâîê.")
        wait(5000)
        sampSendChat("/me äîñòàë èç øêàô÷èêà áëàíê ñïðàâêè")
        wait(5000)
        sampSendChat("/me âûïèñàë ñïðàâêó î òîì, ÷òî ïàöèåíò íå èìååò íàðêîçàâèñèìîñòè è ãîäåí ê ñëóæáå")
        wait(5000)
        sampSendChat("/me ïåðåäàë ñïðàâêó ïàöèåíòó â ðóêè")
        wait(5000)
        sampSendChat("/do Ïðîòÿíóòà ïðàâàÿ ðóêà ñî ñïðàâêîé.")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },  
  {
    title = "{80a4bf}»{FFFFFF} Äåëàåì ñåàíñ, åñëè ïàöèåíò çàâèñèì.",
    onclick = function()
		sampSendChat("/do Íà ýêðàíå ïîêàçàí ïîëîæèòåëüíûé ðåçóëüòàò òåñòà êðîâè ïàöèåíòà.")
		wait(5000)
		sampSendChat("/me äîñòàë èç øêàô÷èêà áëàíê ñïðàâêè.")
		wait(5000)
		sampSendChat("/me âûïèñàë ñïðàâêó î òîì, ÷òî ïàöèåíò çäîðîâ è ãîäåí ê ñëóæáå.")
		wait(5000)
		sampSendChat("/healaddict")
    end
  },
}
end

function remont(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Îòêðûâàåì ìåøîê ñ ïåñêîì.",
    onclick = function()
	    sampSendChat("/do Íà ïîëó ìåøîê ñ ïåñêîì.")
        wait(5000)
        sampSendChat("/me îòêðûë ìåøîê ñ ïåñêîì")
		wait(5000)
		sampSendChat("/do Ìåøîê ñ ïåñêîì îòêðûò.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Áåðåì ëîïàòó.",
    onclick = function()
	    sampSendChat("/do Îêîëî ìåøêà ëåæèò ëîïàòà, ìàñòåðîê è âåäðî. ")
        wait(5000)
        sampSendChat("/me âçÿë ëîïàòó, ìàñòåðîê è âåäðî")
		wait(5000)
		sampSendChat("/me ïîñòàâèë âåäðî ïåðåä ìåøêîì")
		wait(5000)
		sampSendChat("/do Âåäðî ïåðåä ìåøêîì.")
		wait(5000)
		sampSendChat("/do Ïðîöåññ.")
		wait(5000)
		sampSendChat("/me çàêîí÷èë íàêëàäûâàòü ïåñîê â âåäðî")
		wait(5000)
		sampSendChat("/do Âåäðî ïîëíîå.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Èä¸ì ê ÿìå.",
    onclick = function()
	    sampSendChat("/me ïîäíÿë âåäðî è ïîøåë ê ÿìå")
        wait(5000)
        sampSendChat("/do Â àñôàëüòå ãëóáîêàÿ ÿìà.")
		wait(5000)
		sampSendChat("/me âûñûïàë ïåñîê â ÿìó")
		wait(5000)
		sampSendChat("/do Ïåñîê â ÿìå.")
		wait(5000)
		sampSendChat("/me óáðàë âåäðî è äîñòàë ìàñòåðîê")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Ìàñòåðîê â ðóêå.",
    onclick = function()
	    sampSendChat("/do Ìàñòåðîê â ðóêå.")
        wait(5000)
        sampSendChat("/me ðàçðàâíèâàåò ïåñîê ìàñòåðêîì")
		wait(5000)
		sampSendChat("/do Ïðîöåññ.")
		wait(5000)
		sampSendChat("/me çàêîí÷èë ðàâíÿòü ïåñîê")
		wait(5000)
		sampSendChat("/do Ïåñîê ëåæèò ðîâíî.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Âîçâðàùàåòåñü â ìåñòî ãäå áðàëè ïåñîê è ïðîäîëæàåòå îòûãðûâàòü ÐÏ.",
    onclick = function()
	    sampSendChat("/do Íà ïîëó ëåæèò àñôàëüò.")
        wait(5000)
        sampSendChat("/me ëîïàòîé íàêëàäûâàåò àñôàëüò â âåäðî")
		wait(5000)
		sampSendChat("/do Ïðîöåññ.")
		wait(5000)
		sampSendChat("/me çàêîí÷èë íàêëàäûâàòü àñôàëüò â âåäðî")
		wait(5000)
		sampSendChat("/do Âåäðî ïîëíîñòüþ çàáèòî àñôàëüòîì.")
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Âîçâðàùàåòåñü ê ìåñòó êóäà âûñûïàëè ïåñîê è ïðîäîëæàåòå îòûãðûâàòü ÐÏ.",
    onclick = function()
	    sampSendChat("/me ïîñòàâèë âåäðî îêîëî ÿìû")
        wait(5000)
        sampSendChat("/do Âåäðî îêîëî ÿìû")
		wait(5000)
		sampSendChat("/me ëîïàòîé âûêëàäûâàåò àñôàëüò íà ïåñîê")
		wait(5000)
		sampSendChat("/do Ïðîöåññ.")
		wait(5000)
		sampSendChat("/me âûëîæèë àñôàëüò íà ïåñîê")
		wait(5000)
		sampSendChat("/do Àñôàëüò ëåæèò íà ïåñêå.")
		wait(5000)
		sampSendChat("/me äîñòàë ìàñòåðîê è íà÷àë ðàçðàâíèâàòü àñôàëüò")
		wait(5000)
		sampSendChat("/me ðàçðàâíÿë ìàñòåðêîì àñôàëüò")
		wait(5000)
		sampSendChat("/do Çàëàòàë ÿìó.")
    end
  },
}
end

function osmrmenu1(id)
 return
{
  {
    title = "{80a4bf}»{FFFFFF} Ìåäèöèíñêèé îñìîòð íà ïðèçûâå.",
    onclick = function()
	    sampSendChat("- Õîðîøî. Ñåé÷àñ ìû ïðîâåðèì âàñ íà íàëè÷èå íàðêîçàâèñèìîñòè.")
        wait(5000)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(5000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ñïåöèàëüíóþ êîëáî÷êó")
        wait(5000)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(5000)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(5000)
         sampSendChat("/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà")
        wait(5000)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(5000)
        sampSendChat("/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó ïàöèåíòà")
        wait(5000)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà")
        wait(5000)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(5000)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà")
        wait(5000)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(5000)
    end
  },
  {
    title = "{80a4bf}»{FFFFFF} Èññëåäîâàíèå óðîâíÿ ãëþêîçû â êðîâè.",
    onclick = function()
		sampSendChat("/do Íà ñòîëå ñòîèò ÿùèê ñ ìåä.êàðòàìè è íåâðîëîãè÷åñêèì ìîëîòî÷êîì.")
		wait(5000)
		sampSendChat("/me äîñòàë èç ÿùèêà ìåä.êàðòó íà èìÿ ïàöèåíòà")
		wait(5000)
		sampSendChat(" Èìååòå ëè âû æàëîáû íà çäîðîâüå?")
		wait(5000)
		sampSendChat("/do Â ëåâîé ðóêå ÷¸ðíàÿ ðó÷êà.")
		wait(5000)
		sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
		wait(5000)
		sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
		wait(5000)
		sampSendChat(" Ïðèñàæèâàéòåñü, íà÷íåì îáñëåäîâàíèå.")
		wait(5000)
		sampSendChat("/me âîäèò ìîëîòî÷êîì ïåðåä ãëàçàìè ïàöèåíòà")
		wait(5000)
		sampSendChat("/me óáåäèëñÿ, ÷òî çðà÷êè äâèæóòñÿ ñîäðóæåñòâåííî è ðåôëåêñ â íîðìå")
		wait(5000)
		sampSendChat(" Õîðîøî. Ðåôëåêñû çðåíèÿ â íîðìå.")
		wait(5000)
		sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
		wait(5000)
		sampSendChat("/me óäàðèë ìîëîòî÷êîì ïî ëåâîìó êîëåíó ïàöèåíòà")
		wait(5000)
		sampSendChat(" Çäåñü òîæå âñå â ïîðÿäêå. Ïðîâåðèì âàøó êðîâü.")
		wait(5000)
		sampSendChat("Èññëåäóåì âàø óðîâåíü ãëþêîçû â êðîâè.")
		wait(5000)
		sampSendChat("/me äîñòàë èç ìåä. ñóìêè è íàäåë ñòåðèëüíûå ïåð÷àòêè")
		wait(5000)
		sampSendChat("/do Ïåð÷àòêè íàäåòû.")
        wait(5000)
        sampSendChat("/me âçÿë ñêàðèôèêàòîð ñî ñòîëà è ïðîêîëîë ïàëåö ïàöèåíòà")
		wait(5000)
		sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(5000)
		sampSendChat("/me âçÿë ïðîáèðêó ñî ñòîëà è íàáðàë â íå¸ êðîâü èç ïàëüöà, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
		wait(5000)
		sampSendChat("/do Íà ýêðàíå ïîêàçàí ðåçóëüòàò òåñòà êðîâè: 4,5 ììîëü/ë.")
		wait(5000)
		sampSendChat("/checkheal")
    end
  },
}
end
function fthmenu(id)
 return
{
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ äëÿ {139BEC}Èíòåðíà.',
    onclick = function()
	    sampSendChat('Çäðàñòâóéòå, Èíòåðíû.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ìû ðàäû ïðèâåòñòâîâàòü âàñ â ñòåíàõ íàøåé áîëüíèöû. Ïîìíèòå, âû ïîêà òîëüêî ó÷åíèêè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñóùåñòâóåò ðÿä ïðàâèë, îíè çàêðåïëåíû â óñòàâå áîëüíèöû.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íàïðèìåð, âàì êàòåãîðè÷åñêè çàïðåùåíî ïðîãóëèâàòü ëåêöèè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Çàïðåùåíî áðàòü ìåäèêàìåíòû, à òàêæå ïðèñòóïàòü ê ëå÷åíèþ ïàöèåíòîâ, ýòî îïàñíî äëÿ èõ æèçíè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('È òàê, ÷òîáû îêîí÷èòü èíòåðíàòóðó è ïîëó÷èòü äîëãîæäàííîå ïîâûøåíèå, âàì íåîáõîäèìî:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Îçíàêîìèòüñÿ ñ ïîðòàëîì øòàòà, ïðîñëóøàòü âñå ëåêöèè, çàòåì ïîéòè ê ñòàðøåìó ñîñòàâó.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Îíè ó âàñ ïðîâåðÿþò çíàíèÿ óñòàâà, íàçâàíèé ïðåïàðàòîâ. È ïîëó÷àåòå ñâî¸ ïîâûøåíèå â äîëæíîñòè.')
         wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Òàêæå, íå çàáûâàéòå íîñèòü ñâîè áýéäæèêè ¹13. Íà ýòîì ëåêöèÿ îêîí÷åíà. Âîïðîñû åñòü?')
		wait(5000)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
   title = '{80a4bf}»{FFFFFF} Ïåðâàÿ ïîìîùü ïðè {139BEC}êðîâîòå÷åíèÿõ.',
    onclick = function()
       sampSendChat('Ïðèâåòñòâóþ, êîëëåãè. Ñåãîäíÿ ÿ ïðî÷òó âàì ëåêöèþ íà òåìó «Ïåðâàÿ ïîìîùü ïðè êðîâîòå÷åíèè».')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Íóæíî ÷åòêî ïîíèìàòü, ÷òî àðòåðèàëüíîå êðîâîòå÷åíèå ïðåäñòàâëÿåò ñìåðòåëüíóþ îïàñíîñòü äëÿ æèçíè.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ïåðâîå, ÷òî òðåáóåòñÿ  ïåðåêðûòü ñîñóä âûøå ïîâðåæäåííîãî ìåñòà.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Äëÿ ýòîãî ïðèæìèòå àðòåðèþ ïàëüöàìè è ñðî÷íî ãîòîâüòå æãóò.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Èñïîëüçóéòå â òàêîì ñëó÷àå ëþáûå ïîäõîäÿùèå ñðåäñòâà:')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Øàðô, ïëàòîê, ðåìåíü, îòîðâèòå äëèííûé êóñîê îäåæäû.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ñòÿãèâàéòå æãóò äî òåõ ïîð, ïîêà êðîâü íå ïåðåñòàíåò ñî÷èòüñÿ èç ðàíû.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Â ñëó÷àå âåíîçíîãî êðîâîòå÷åíèÿ äåéñòâèÿ ïîâòîðÿþòñÿ, çà èñêëþ÷åíèåì òîãî, ÷òî..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..æãóò íàêëàäûâàåòñÿ ÷óòü íèæå ïîâðåæä¸ííîãî ìåñòà.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ñëåäóåò ïîìíèòü, ÷òî ïðè îáîèõ âèäàõ êðîâîòå÷åíèÿ æãóò íàêëàäûâàåòñÿ íå áîëåå äâóõ ÷àñîâ..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..â æàðêóþ ïîãîäó è íå áîëåå ÷àñà â õîëîäíóþ.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ïðè êàïèëëÿðíîì êðîâîòå÷åíèè ñëåäóåò îáðàáîòàòü ïîâðåæäåííîå ìåñòî ïåðåêèñüþ âîäîðîäà..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..è íàëîæèòü ïëàñòûðü, ëèáî ïåðåáèíòîâàòü ðàíó. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ñïàñèáî çà âíèìàíèå.')
       wait(1200)
       if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
  title = '{80a4bf}»{FFFFFF} Ïåðâàÿ ïîìîùü ïðè {139BEC}îáìîðîêàõ.',
    onclick = function()
      sampSendChat('Ïðèâåòñòâóþ, êîëëåãè. Ñåãîäíÿ ÿ ïðî÷òó âàì ëåêöèþ íà òåìó «Ïåðâàÿ ïîìîùü ïðè îáìîðîêàõ».')
      wait(cfg.commands.zaderjka * 5000)
      sampSendChat('Îáìîðîêè ñîïðîâîæäàþòñÿ êðàòêîâðåìåííîé ïîòåðåé ñîçíàíèÿ, âûçâàííîé..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..íåäîñòàòî÷íûì êðîâîñíàáæåíèåì ìîçãà. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Îáìîðîê ìîãóò âûçâàòü: ðåçêàÿ áîëü, ýìîöèîíàëüíûé ñòðåññ, ÑÑÁ è òàê äàëåå.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Áåññîçíàòåëüíîìó ñîñòîÿíèþ îáû÷íî ïðåäøåñòâóåò ðåçêîå óõóäøåíèå ñàìî÷óâñòâèÿ..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..íàðàñòàåò ñëàáîñòü, ïîÿâëÿåòñÿ òîøíîòà, ãîëîâîêðóæåíèå, øóì èëè çâîí â óøàõ.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Çàòåì ÷åëîâåê áëåäíååò, ïîêðûâàåòñÿ õîëîäíûì ïîòîì è âíåçàïíî òåðÿåò ñîçíàíèå.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Ïåðâàÿ ïîìîùü äîëæíà áûòü íàïðàâëåíà íà óëó÷øåíèå êðîâîñíàáæåíèÿ ìîçãà..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..è îáåñïå÷åíèå ñâîáîäíîãî äûõàíèÿ.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Åñëè ïîñòðàäàâøèé íàõîäèòñÿ â äóøíîì, ïëîõî ïðîâåòðåííîì ïîìåùåíèè, òî..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..îòêðîéòå îêíî, âêëþ÷èòå âåíòèëÿòîð èëè âûíåñèòå ïîòåðÿâøåãî ñîçíàíèå íà âîçäóõ.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Ïðîòðèòå åãî ëèöî è øåþ õîëîäíîé âîäîé, ïîõëîïàéòå ïî ùåêàì è..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..äàéòå ïîñòðàäàâøåìó ïîíþõàòü âàòêó, ñìî÷åííóþ íàøàòûðíûì ñïèðòîì.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('Ñïàñèáî çà âíèìàíèå.')
       wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ïåðâàÿ ïîìîùü ïðè {139BEC}ÄÒÏ.',
    onclick = function()
       sampSendChat('Ïðèâåòñòâóþ, êîëëåãè. Ñåãîäíÿ ÿ ïðî÷òó âàì ëåêöèþ íà òåìó «Ïåðâàÿ ïîìîùü ïðè ÄÒÏ».')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Îêàçûâàÿ ïåðâóþ ïîìîùü, íåîáõîäèìî äåéñòâîâàòü ïî ïðàâèëàì.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Íåìåäëåííî îïðåäåëèòå õàðàêòåð è èñòî÷íèê òðàâìû.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Íàèáîëåå ÷àñòûå òðàâìû â ñëó÷àå ÄÒÏ - ñî÷åòàíèå ïîâðåæäåíèé ÷åðåïà..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..è íèæíèõ êîíå÷íîñòåé è ãðóäíîé êëåòêè.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Íåîáõîäèìî èçâëå÷ü ïîñòðàäàâøåãî èç àâòîìîáèëÿ, îñìîòðåòü åãî.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Äàëåå ñëåäóåò îêàçàòü ïåðâóþ ïîìîùü â ñîîòâåòñòâèè ñ âûÿâëåííûìè òðàâìàìè.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Âûÿâèâ èõ, òðåáóåòñÿ ïåðåíåñòè ïîñòðàäàâøåãî â áåçîïàñíîå ìåñòî..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..óêðûòü îò õîëîäà, çíîÿ èëè äîæäÿ è âûçâàòü âðà÷à, à çàòåì..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..îðãàíèçîâàòü òðàíñïîðòèðîâêó ïîñòðàäàâøåãî â ëå÷åáíîå ó÷ðåæäåíèå.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('Ñïàñèáî çà âíèìàíèå.')
       wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ äëÿ {139BEC}Íàðêîëîãà.',
    onclick = function()
	    sampSendChat('Çäðàñòâóéòå. Íà äîëæíîñòè Íàðêîëîã íîñèì ñâîè áýéäæèêè ¹18.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåàíñû îò íàðêîçàâèñèìîñòè ïðîèçâîäÿòñÿ ñïåöèàëèçèðîâàííûìè ïðåïàðàòàìè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåàíñû ïðîâîäÿòñÿ òîëüêî â îïåðàöèîííîé íà âòîðîì ýòàæå áîëüíèöå ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Òàê æå âû òåïåðü äîëæíû áóäåòå ïîìîãàòü íà ïðèçûâàõ. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('×òîáû ïîâûñèòñÿ â äîëæíîñòè, âàì íóæíî áóäåò ïðîéòè øêîëó Ñïàñàòåëåé, øêîëà ñîñòîèò èç 6-è ýòàïîâ. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ïîäðîáíåé íà îôèöèàëüíîì ñàéòå Ìèíèñòåðñòâà Çäðàâîîõðàíåíèÿ. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íà ýòîì ëåêöèÿ îêîí÷åíà. Âîïðîñû èìååþòñÿ? ')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ î {139BEC}âðåäå êóðåíèÿ.',
    onclick = function()
	    sampSendChat('Òåïåðü ÿ ðàññêàæó âàì î âðåäå êóðåíèÿ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êóðåíèå - îäíà èç ñàìûõ çíàìåíèòûõ è ðàñïðîñòðàíåííûõ ïðèâû÷åê íà ñåãîäíÿøíèé äåíü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Çàïîìíèòå, ãîñïîäà, íåñêîëüêî âåùåé.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êóðåíèå âûçûâàåò ðàê è õðîíè÷åñêîå çàáîëåâàíèå ëåãêèõ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Òàêæå, òàáà÷íûé äûì âûçûâàåò ó íåêîòîðûõ ëþäåé âñÿ÷åñêèå êîæíûå çàáîëåâàíèÿ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Áðîñü ñèãàðåòó - ñïàñè ñåáÿ è âåñü ìèð.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íà ýòîì âñå, ïîìíèòå, Ìèíèñòåðñòâî Çäðàâîîõðàíåíèÿ çàáîòèòñÿ î âàøåì çäîðîâüå.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ î òîì {139BEC} êàê íóæíî îáðàùàòüñÿ ñ ïàöèåíòàìè.',
    onclick = function()
	    sampSendChat('Òåïåðü ëåêöèÿ, î òîì, êàê íóæíî îáðàùàòüñÿ ñ ïàöèåíòàìè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Äëÿ íà÷àëà, âû äîëæíû âåæëèâî èõ ïîïðèâåòñòâîâàòü, ÷òî áû èì áûëî ïðèÿòíî.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Äàëüøå, âû äîëæíû ïðåäñòàâèòüñÿ, è ñïðîñèòü ÷åì ìîæåòå ïîìî÷ü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Åñëè æå ÷åëîâåê ìîë÷èò, íå óõîäèòå, ìîæåò äóìàåò ÷òî âûáðàòü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êîãäà ÷åëîâåê çàäàë âîïðîñ, âû äîëæíû êîððåêòíî îòâåòèòü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Åñëè æå âîïðîñ ãðóáûé, íåàäåêâàòíûé, íå îòâå÷àéòå.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ïðè óãðîçå è íåàäåêâàòíûõ äåéñòâèÿõ - âûçîâèòå ïîëèöèþ.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñïàñèáî çà âíèìàíèå, äàííàÿ ëåêöèÿ ïîäîøëà ê êîíöó.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ î {139BEC} íàðêîòè÷åñêèõ ïðåïàðàòàõ',
    onclick = function()
	    sampSendChat('Çäðàâñòâóéòå, óâàæàåìûå êîëëåãè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ñåé÷àñ ÿ ðàññêàæó âàì î âðåäå íàðêîòè÷åñêèõ âåùåñòâ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íàðêîòèêè - ýòî âåùåñòâà, ñïîñîáíûå âûçûâàòü ñîñòîÿíèå ýéôîðèè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íàðêîìàíèÿ - çàáîëåâàíèå, âûçâàííîå óïîòðåáëåíèåì íàðêîòè÷åñêèõ âåùåñòâ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Â ñðåäå óïîòðåáëÿþùèõ íàðêîòèêè, âûøå ðèñê çàðàæåíèÿ ðàçëè÷íûìè çàáîëåâàíèÿìè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êàæäîìó ïî ñèëàì ïîìî÷ü áîðîòüñÿ ñ íàðêîìàíèåé.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Êîëëåãè, îáðåòàéòå óâåðåííîñòü â òîì, ÷òî âàì íå íóæíû íàðêîòèêè.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íà ýòîì ëåêöèÿ îêîí÷åíà, ñïàñèáî çà âíèìàíèå.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
  {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ î {139BEC} âèðóñàõ.',
    onclick = function()
	    sampSendChat('Ñåé÷àñ ÿ ðàññêàæó âàì íåñêîëüêî ñîâåòîâ î âèðóñàõ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âñå ìû çíàåì î âèðóñàõ è î èõ áûñòðîì ðàçìíîæåíèè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âèðóñû îïàñíû. È ÷àùå âñåãî ïðèâîäÿò ê ëåòàëüíûì èñõîäàì.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ãîñïîäà, çàïîìíèòå íåñêîëüêî ñîâåòîâ îò Ìèíèíèñòåðñòâà Çäðàâîîõðàíåíèÿ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Ïåðâîå, åñëè âû çàðàæåíû, íå êîíòàêòèðóéòå ñî çäîðîâûì.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Âòîðîå, îáû÷íûé ïîöåëóé ìîæåò çàðàçèòü âàøó âòîðóþ ïîëîâèíêó.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('È òðåòüå, ÷àùå ìîéòå ðóêè. Îñîáåííî, åñëè âàñ îêðóæàþò áîëüíûå êîëëåãè.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Íà ýòîì âñå, ïîìíèòå, âðà÷è øòàòà çàáîòèòñÿ î âàøåì çäîðîâüå.')
		wait(1200)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
    end
  },
   {
    title = '{80a4bf}»{FFFFFF} Ëåêöèÿ{139BEC} ÏÌÏ.',
    onclick = function()
	sampSendChat('Çäðàñòâóéòå, óâàæàåìûå êîëëåãè.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Áîëüøèíñòâî ëþäåé, îêàçàâøèñü íà ìåñòå òåðàêòà, âïàäàþò â ïàíèêó è íå çíàþò, ÷òî èì äåëàòü äî ïðèåçäà ìåäèêîâ.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('À ìåæäó òåì äîðîãà áóêâàëüíî êàæäàÿ ìèíóòà, ãëàâíîå  ïîíèìàòü, êàê ïðàâèëüíî îêàçàòü ïåðâóþ ïîìîùü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Îñòàíîâèòü êðîâîòå÷åíèå, íå ïðîìûâàòü ðàíó, íå èçâëåêàòü èíîðîäíûå òåëà è ãëóáîêî äûøàòü...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...âîò îñíîâíûå äåéñòâèÿ, êîòîðûå ìîãóò ïîìî÷ü ïîñòðàäàâøèì ïðè òåðàêòå.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Äëèòåëüíîñòü ôàêòà èçîëÿöèè ÷åëîâåêà ñïåöèàëèñòû ñ÷èòàþò êëþ÷åâûì ìîìåíòîì...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...äëÿ ñîñòîÿíèÿ ïîñòðàäàâøèõ. Îïòèìàëüíî îíà íå äîëæíà ïðåâûøàòü 30 ìèíóò.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Åñëè äîëüøå  ó òÿæåëûõ ïîñòðàäàâøèõ ìîãóò ðàçâèòüñÿ îïàñíûå äëÿ æèçíè îñëîæíåíèÿ èëè ïðîñòî íàñòóïèò ñìåðòü.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('Èçâåñòíî, ÷òî â ñâÿçè ñ íåñâîåâðåìåííûì îêàçàíèåì ìåäèöèíñêîé ïîìîùè ïðè êàòàñòðîôàõ, èíöèäåíòàõ, ëþáûõ ïðîèñøåñòâèÿõ, ãäå åñòü ïîñòðàäàâøèå...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...â òå÷åíèå ïåðâîãî ÷àñà ïîãèáàåò äî 30% ïîñòðàäàâøèõ, ÷åðåç òðè ÷àñà  äî 70% à ÷åðåç øåñòü ÷àñîâ  äî 90%.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Ýòè öèôðû ïîêàçûâàþò: ïåðâàÿ ïîìîùü ïðè òåðàêòàõ íóæíà ÷åì ñêîðåå, òåì ëó÷øå, äî ïðèåçäà ìåäèêîâ.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Íà ìåñòå êàòàñòðîôû èëè òåðàêòà âàì íàäî ñïðàâèòüñÿ ñ òðåìÿ ïðîáëåìàìè, êîòîðûå óáèâàþò ëþäåé áûñòðåå âñåãî:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- âíåøíÿÿ óãðîçà;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- ñèëüíîå êðîâîòå÷åíèå;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- ïðîáëåìû ñ äûõàíèåì.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Èõ íàäî ëèêâèäèðîâàòü â òîé æå ïðèîðèòåòíîñòè. Âàì íàäî ñôîêóñèðîâàòüñÿ ëèøü íà ýòèõ òð¸õ âåùàõ è êîëè÷åñòâî âûæèâøèõ áóäåò ìàêñèìàëüíî.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Ïåðâàÿ ïîìîùü  ýòî êîìïëåêñ ñðî÷íûõ ìåð, íàïðàâëåííûõ íà ñïàñåíèå æèçíè ÷åëîâåêà.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('Íåñ÷àñòíûé ñëó÷àé, ðåçêèé ïðèñòóï çàáîëåâàíèÿ, îòðàâëåíèå  â ýòèõ è äðóãèõ ÷ðåçâû÷àéíûõ ñèòóàöèÿõ íåîáõîäèìà ãðàìîòíàÿ ïåðâàÿ ïîìîùü...')
		wait(cfg.commands.zaderjka * 1000)
		if cfg.main.hud then
        sampSendChat('/time 1')
        wait(500)
        setVirtualKeyDown(key.VK_F8, true)
        wait(150)
        setVirtualKeyDown(key.VK_F8, false)
		end
	end
   }
}
end

do

function imgui.OnDrawFrame()
   if first_window.v then
	local tagfr = imgui.ImBuffer(u8(cfg.main.tarr), 256)
	local tagb = imgui.ImBool(cfg.main.tarb)
	local clistb = imgui.ImBool(cfg.main.clistb)
	local autoscr = imgui.ImBool(cfg.main.hud)
	local hudik = imgui.ImBool(cfg.main.givra)
	local clisto = imgui.ImBool(cfg.main.clisto)
	local stateb = imgui.ImBool(cfg.main.male)
	local waitbuffer = imgui.ImInt(cfg.commands.zaderjka)
	local clistbuffer = imgui.ImInt(cfg.main.clist)
    local iScreenWidth, iScreenHeight = getScreenResolution()
	local btn_size = imgui.ImVec2(-0.1, 0)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
    imgui.Begin(fa.ICON_COGS .. u8 ' Íàñòðîéêè##1', first_window, btn_size, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("Èñïîëüçîâàòü àâòîòåã"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Èñïîëüçîâàòü àâòîòåã', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'Ââåäèòå âàø òåã.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	end
	imgui.Text(u8("Èíôî-áàð âûëå÷åííûõ"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Âêëþ÷èòü/âûêëþ÷èòü èíôî-áàð', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and 'Èíôî-áàð âêëþ÷åí, óñòàíîâèòü ïîëîæåíèå /sethud.' or 'Èíôî-áàð âûêëþ÷åí.')
    end
	imgui.Text(u8("Áûñòðûé îòâåò íà ïîñëåäíåå ÑÌÑ"))
	imgui.SameLine()
    if imgui.HotKey(u8'##Áûñòðûé îòâåò ñìñ', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('Êëàâèøà óñïåøíî èçìåíåíà. Ñòàðîå çíà÷åíèå: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | Íîâîå çíà÷åíèå: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/medick/keys.json')
	end
	imgui.Text(u8("Èñïîëüçîâàòü àâòîêëèñò"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Èñïîëüçîâàòü àâòîêëèñò', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"Âûáåðèòå çíà÷åíèå êëèñòà", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("Èñïîëüçîâàòü îòûãðîâêó ðàçäåâàëêè"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'Èñïîëüçîâàòü îòûãðîâêó ðàçäåâàëêè', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("Ìóæñêèå îòûãðîâêè"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Ìóæñêèå îòûãðîâêè', stateb) then
        cfg.main.male = not cfg.main.male
    end
	if imgui.SliderInt(u8'Çàäåðæêà â ëåêöèÿõ è îòûãðîâêàõ(ñåê)', waitbuffer, 1, 25) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("Àâòîñêðèí ëåêöèé/ãîñ.íîâîñòåé"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'Àâòîñêðèí ëåêöèé', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('Ñîõðàíèòü íàñòðîéêè'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('Íàñòðîéêè óñïåøíî ñîõðàíåíû.', -1)
    inicfg.save(cfg, 'medick/config.ini') -- ñîõðàíÿåì âñå íîâûå çíà÷åíèÿ â êîíôèãå
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Medic Tools | Óñòàâ áîëüíèöû'), ystwindow)
                for line in io.lines('moonloader\\medick\\ystav.txt') do
                    imgui.TextWrapped(u8(line))
                end
                imgui.End()
            end
  if second_window.v then
    imgui.LockPlayer = true
    imgui.ShowCursor = true
    local iScreenWidth, iScreenHeight = getScreenResolution()
    local btn_size1 = imgui.ImVec2(70, 0)
	local btn_size = imgui.ImVec2(130, 0)
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
    imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 5))
    imgui.Begin('Medick Helpers | Main Menu | Version: '..thisScript().version, second_window, mainw,  imgui.WindowFlags.NoResize)
	local text = 'Ðàçðàáîòàë:'
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(text)).x)/3)
    imgui.Text(u8(text))
	imgui.SameLine()
	imgui.TextColored(imgui.ImVec4(0.90, 0.16 , 0.30, 1.0), 'Rancho Grief.')
	imgui.Image(test, imgui.ImVec2(890, 140))
    imgui.Separator()
	if imgui.Button(u8'Áèíäåð', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_COGS .. u8' Íàñòðîéêè ñêðèïòà', imgui.ImVec2(141, 30)) then
      first_window.v = not first_window.v
    end
    imgui.SameLine()
    if imgui.Button(fa.ICON_EXCLAMATION_TRIANGLE .. u8' Ñîîáùèòü îá îøèáêå/áàãå', imgui.ImVec2(181, 30)) then os.execute('explorer "https://vk.com/artyom.fomin2016"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_REFRESH .. u8' Ïåðåçàãðóçèòü ñêðèïò', imgui.ImVec2(155, 30)) then
      showCursor(false)
      thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_WRENCH .. u8' Èíôîðìàöèÿ î îáíîâëåíèÿõ', imgui.ImVec2(192, 30)) then
      obnova.v = not obnova.v
    end
    if imgui.Button(fa.ICON_POWER_OFF .. u8' Îòêëþ÷èòü ñêðèïò', imgui.ImVec2(135, 30), btn_size) then
      showCursor(false)
      thisScript():unload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_INFO .. u8 ' Ïîìîùü', imgui.ImVec2(70, 30)) then
      helps.v = not helps.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_STOP_CIRCLE .. u8' Îñòàíîâèòü ëåêöèþ', imgui.ImVec2(145, 30)) then
	showCursor(false)
	thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_LINE_CHART .. u8' Ñèñòåìà ïîâûøåíèé', imgui.ImVec2(155, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-sistema-povyshenija-upd-14-03-20.133094/-Ñèñòåìà-ïîâûøåíèÿ-ñîòðóäíèêîâ-Áîëüíèöû.71029/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_BOOK .. u8' Óñòàâ', imgui.ImVec2(70, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-ustav-ministerstva-i-sistema-nakazanij.132703/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_QUESTION .. u8' Ïîìîùü äëÿ íîâè÷êîâ [FAQ]', imgui.ImVec2(195, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-f-a-q-informacija-dlja-novichkov.111667//"')
    btn_size = not btn_size
    end
	imgui.Separator()
	imgui.BeginChild("Èíôîðìàöèÿ", imgui.ImVec2(410, 150), true)
	imgui.Text(u8 'Èìÿ è Ôàìèëèÿ:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 'Äîëæíîñòü:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 'Íîìåð òåëåôîíà:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 'Òåã â ðàöèþ:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 'Íîìåð áåéäæèêà:   '..cfg.main.clist..'')
	end
	imgui.EndChild()
	imgui.Separator()
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("Òåêóùàÿ äàòà: %s")).x)/1.5)
	imgui.Text(u8(string.format("Òåêóùàÿ äàòà: %s", os.date())))
    imgui.End()
  end
  	if infbar.v then
            _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
            local myname = sampGetPlayerNickname(myid)
            local myping = sampGetPlayerPing(myid)
            local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
            imgui.SetNextWindowPos(imgui.ImVec2(cfg.main.posX, cfg.main.posY), imgui.ImVec2(0.5, 0.5))
            imgui.SetNextWindowSize(imgui.ImVec2(cfg.main.widehud, 175), imgui.Cond.FirstUseEver)
            imgui.Begin('Medic Helper', infbar, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoTitleBar)
            imgui.CentrText('Medic Helper')
            imgui.Separator()
            imgui.Text((u8"Èíôîðìàöèÿ: %s [%s] | Ïèíã: %s"):format(myname, myid, myping))
            if isCharInAnyCar(playerPed) then
                local vHandle = storeCarCharIsInNoSave(playerPed)
                local result, vID = sampGetVehicleIdByCarHandle(vHandle)
                local vHP = getCarHealth(vHandle)
                local carspeed = getCarSpeed(vHandle)
                local speed = math.floor(carspeed)
                local vehName = tCarsName[getCarModel(storeCarCharIsInNoSave(playerPed))-399]
                local ncspeed = math.floor(carspeed*2)
                imgui.Text((u8 'Òðàíñïîðò: %s [%s]|HP: %s|Ñêîðîñòü: %s'):format(vehName, vID, vHP, ncspeed))
            else
                imgui.Text(u8 'Òðàíñïîðò: Íåò')
            end
			    imgui.Text((u8 'Âðåìÿ: %s'):format(os.date('%H:%M:%S')))
            if valid and doesCharExist(ped) then 
                local result, id = sampGetPlayerIdByCharHandle(ped)
                if result then
                    local targetname = sampGetPlayerNickname(id)
                    local targetscore = sampGetPlayerScore(id)
                    imgui.Text((u8 'Öåëü: %s [%s] | Óðîâåíü: %s'):format(targetname, id, targetscore))
                else
                    imgui.Text(u8 'Öåëü: Íåò')
                end
            else
                imgui.Text(u8 'Öåëü: Íåò')
            end
			local cx, cy, cz = getCharCoordinates(PLAYER_PED)
			local zcode = getNameOfZone(cx, cy, cz)
			imgui.Text((u8 'Ëîêàöèÿ: %s | Êâàäðàò: %s'):format(u8(getZones(zcode)), u8(kvadrat())))
			imgui.Text((u8 'Âûëå÷åíî: %s | Âûëå÷åíî îò íàðêî: %s'):format((health), u8(narkoh)))
            inicfg.save(cfg, 'medick/config.ini')
            imgui.End()
        end
    if obnova.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                 imgui.Begin(fa.ICON_WRENCH .. u8'Îáíîâëåíèÿ.', obnova, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Îáíîâëåíèÿ.", imgui.ImVec2(540, 250), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '×òî áûëî ñäåëàíî:')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.2')
				imgui.BulletText(u8 '1.Êîìàíäà /z - Äëÿ ëå÷åíèÿ â àâòîìîáèëå.')
				imgui.BulletText(u8 '2.Ïîëíîñòüþ ïåðåïèñàíà Ìåíþøêà Ïêì+Z.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.3')
				imgui.BulletText(u8 '1.Óäàëåíî ïðîêòè÷åñêè âñå ÷òî ñâÿçíàíî ñ Medick Helper.')
                imgui.BulletText(u8 '2.Ïåðåðàáîòàíû çàäåðæêè âñåõ îòûãðîâîê.')
				imgui.BulletText(u8 '3.Óñòðàíåíû ìåëêèå áàãè è ïðîáëåìû ñ òåêñòîì.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.4')
				imgui.BulletText(u8 '1.Èçìåíåí öâåò èíòåðôåéñà')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.5')
				imgui.BulletText(u8 '1.Òåïåðü ãë.ìåíþ îòêðûâàåòñÿ íà /mh')
				imgui.BulletText(u8 '2.Äîáàâëåíî â ìåíþ Ïêì+Z ìåíþ ñîáåñåäîâàíèÿ')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.7')
				imgui.BulletText(u8 '1.Ïåðåðàáîòàí ïîëíîñòüþ /sethud')
				imgui.Separator()
				imgui.BulletText(u8 'v3.0')
				imgui.BulletText(u8 '1.Òåïåðü óáðàíî ÂÑÅ ÷òî îñòîâàëîñü îò Instructors helper.')
				imgui.BulletText(u8 '2.Â ìåíþ Ïêì+Z äîáàâëåíà ïðîâåðêà íà âèðóñ.')
				imgui.BulletText(u8 '3.Äîáàâëåíû íîâûå ëåêöèè è Gov.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.2')
				imgui.BulletText(u8 '1.Âîçâðàùåíà íàñòðîéêà çàäåðæêè â Íàñòðîéêàõ ñêðèïòà.')
				imgui.BulletText(u8 '2.Äîáàâëåíû íîâûå ëåêöèè è ìåòîäû ëå÷åíèÿ.')
				imgui.BulletText(u8 '3.Äîðàáîòàíû çàäåðæêè.')
                imgui.Separator()
				imgui.BulletText(u8 'v3.8')
				imgui.BulletText(u8 '1.Äîáàâëåíû ëîãè "/smslog" è "/rlog".')
				imgui.BulletText(u8 '2.Ïîëíîñòüþ èçìåíåí èíòåðôåéñ.')
				imgui.BulletText(u8 '3.Äîáàâëåíû íîâûå ëåêöèè, ìåëêèå èçìåíåíèÿ ïî òåêñòó.')
				imgui.BulletText(u8 '4.Äîáàâëåíà êàñòîìèçàöèÿ èíòåðôåéñà.')
				imgui.BulletText(u8 '5.Íåìíîãî èçìåíåí Õóä.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.8.1')
				imgui.BulletText(u8 '1.Ñäåëàë reboot ñêðèïòà íà âåðñèþ v3.7" ')
				imgui.BulletText(u8 '2.Âåðíóë èíòåðôåéñ, óáðàë êàñòîìèçàöèþ.')
				imgui.BulletText(u8 '3.Äîáàâëåíû íîâûå ëåêöèè, èçìåíåíû îòäåëû.')
				imgui.BulletText(u8 '4.Èñïðàâëåí "/smslog".')
				imgui.BulletText(u8 '5.Èñïðàâëåí áèíäåð.')
				imgui.BulletText(u8 '5.Èçìåíåí èíòåðôåéñ.')
				imgui.Separator()
				imgui.BulletText(u8 'Ñâÿçü è ïðåäëîæåíèÿ:')
				imgui.BulletText(u8('ÂÊ (êëèêàáåëüíî).'))
				if imgui.IsItemClicked() then
				os.execute('explorer https://vk.com/artyom.fomin2016')
				end
                imgui.BulletText(u8'Discord(Baerra#0419)')
				imgui.EndChild()
                imgui.End()
    end
	if helps.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                imgui.Begin(fa.ICON_INFO .. u8 'Ïîìîùü ïî ñêðèïòó.', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("Ñïèñîê êîìàíä", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/mh - Îòêðûòü ìåíþ ñêðèïòà.')
                imgui.Separator()
				imgui.BulletText(u8 '/z [id] - Âûëå÷èòü ïàöèåíòà â àâòî.')
				imgui.BulletText(u8 '/vig [id] [Ïðè÷èíà] - Âûäàòü âûãîâîð ïî ðàöèè.')
				imgui.BulletText(u8 '/ivig [id] [Ïðè÷èíà] - Âûäàòü ñòðîãèé âûãîâîð ïî ðàöèè.')
				imgui.BulletText(u8 '/unvig [id] [Ïðè÷èíà] - Ñíÿòü âûãîâîð ïî ðàöèè.')
                imgui.BulletText(u8 '/dmb - Îòêðûòü /members â äèàëîãå.')
				imgui.BulletText(u8 '/blg [id] [Ôðàêöèÿ] [Ïðè÷èíà] - Âûðàçèòü èãðîêó áëàãîäàðíîñòü â /d.')
				imgui.BulletText(u8 '/oinv[id] - Ïðèíÿòü ÷åëîâåêà â îòäåë.')
				imgui.BulletText(u8 '/zinv[id] - Íàçíà÷èòü ÷åëîâåêà Çàìåñòèòåëåì îòäåëà.')
				imgui.BulletText(u8 '/ginv[id] - Íàçíà÷èòü ÷åëîâåêà Ãëàâîé îòäåëà.')
                imgui.BulletText(u8 '/where [id] - Çàïðîñèòü ìåñòîïîëîæåíèå ïî ðàöèè.')
                imgui.BulletText(u8 '/yst - Îòêðûòü óñòàâ áîëüíèöû.')
				imgui.BulletText(u8 '/smsjob - Âûçâàòü íà ðàáîòó âåñü ìë.ñîñòàâ ïî ñìñ.')
                imgui.BulletText(u8 '/dlog - Îòêðûòü ëîã 25 ïîñëåäíèõ ñîîáùåíèé â äåïàðòàìåíò.')
				imgui.BulletText(u8 '/sethud - Óñòàíîâèòü ïîçèöèþ èíôî-áàðà.')
				imgui.BulletText(u8 '/cinv - Ïðèíÿòèå â CR.')
				imgui.Separator()
                imgui.BulletText(u8 'Êëàâèøè: ')
                imgui.BulletText(u8 'ÏÊÌ+Z íà èãðîêà - Ìåíþ âçàèìîäåéñòâèÿ.')
                imgui.BulletText(u8 'F3 - "Áûñòðîå ìåíþ."')
				imgui.EndChild()
                imgui.End()
    end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}

   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("Medic Help | Áèíäåð##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
	imgui.BeginChild("##bindlist", imgui.ImVec2(795, 442))
	for k, v in ipairs(tBindList) do
		if hk.HotKey("##HK" .. k, v, tLastKeys, 100) then
			if not rkeys.isHotKeyDefined(v.v) then
				if rkeys.isHotKeyDefined(tLastKeys.v) then
					rkeys.unRegisterHotKey(tLastKeys.v)
				end
				rkeys.registerHotKey(v.v, true, onHotKey)
			end
		end
		imgui.SameLine()
		if tEditData.id ~= k then
			local sText = v.text:gsub("%[enter%]$", "")
			imgui.BeginChild("##cliclzone" .. k, imgui.ImVec2(500, 21))
			imgui.AlignTextToFramePadding()
			if sText:len() > 0 then
				imgui.Text(u8(sText))
			else
				imgui.TextDisabled(u8("Ïóñòîå ñîîáùåíèå ..."))
			end
			imgui.EndChild()
			if imgui.IsItemClicked() then
				sInputEdit.v = sText:len() > 0 and u8(sText) or ""
				bIsEnterEdit.v = string.match(v.text, "(.)%[enter%]$") ~= nil
				tEditData.id = k
				tEditData.inputActve = true
			end
		else
			imgui.PushAllowKeyboardFocus(false)
			imgui.PushItemWidth(500)
			local save = imgui.InputText("##Edit" .. k, sInputEdit, imgui.InputTextFlags.EnterReturnsTrue)
			imgui.PopItemWidth()
			imgui.PopAllowKeyboardFocus()
			imgui.SameLine()
			imgui.Checkbox(u8("Ââîä") .. "##editCH" .. k, bIsEnterEdit)
			if save then
				tBindList[tEditData.id].text = u8:decode(sInputEdit.v) .. (bIsEnterEdit.v and "[enter]" or "")
				tEditData.id = -1
			end
			if tEditData.inputActve then
				tEditData.inputActve = false
				imgui.SetKeyboardFocusHere(-1)
			end
		end
	end
	imgui.EndChild()

	imgui.Separator()

	if imgui.Button(u8"Äîáàâèòü êëàâèøó") then
		tBindList[#tBindList + 1] = {text = "", v = {}}
	end

   imgui.End()
  end
  end
end

function onHotKey(id, keys)
	local sKeys = tostring(table.concat(keys, " "))
	for k, v in pairs(tBindList) do
		if sKeys == tostring(table.concat(v.v, " ")) then
			if tostring(v.text):len() > 0 then
				local bIsEnter = string.match(v.text, "(.)%[enter%]$") ~= nil
				if bIsEnter then
					sampProcessChatInput(v.text:gsub("%[enter%]$", ""))
				else
					sampSetChatInputText(v.text)
					sampSetChatInputEnabled(true)
				end
			end
		end
	end
end

function showHelp(param) -- "âîïðîñèê" äëÿ ñêðèïòà
    imgui.TextDisabled('(?)')
    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
        imgui.PushTextWrapPos(imgui.GetFontSize() * 35.0)
        imgui.TextUnformatted(param)
        imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function onScriptTerminate(scr)
	if scr == script.this then
		if doesFileExist(fileb) then
			os.remove(fileb)
		end
		local f = io.open(fileb, "w")
		if f then
			f:write(encodeJson(tBindList))
			f:close()
		end
		local fa = io.open("moonloader/config/medick/keys.json", "w")
        if fa then
            fa:write(encodeJson(config_keys))
            fa:close()
        end
	end
end

addEventHandler("onWindowMessage", function (msg, wparam, lparam)
	if msg == wm.WM_KEYDOWN or msg == wm.WM_SYSKEYDOWN then
		if tEditData.id > -1 then
			if wparam == key.VK_ESCAPE then
				tEditData.id = -1
				consumeWindowMessage(true, true)
			elseif wparam == key.VK_TAB then
				bIsEnterEdit.v = not bIsEnterEdit.v
				consumeWindowMessage(true, true)
			end
		end
	end
end)

function submenus_show(menu, caption, select_button, close_button, back_button)
    select_button, close_button, back_button = select_button or '»', close_button or 'x', back_button or '«'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. ' »' or v.title)
        end
        sampShowDialog(id, caption, table.concat(string_list, '\n'), select_button, (#prev_menus > 0) and back_button or close_button, sf.DIALOG_STYLE_LIST)
        repeat
            wait(0)
            local result, button, list = sampHasDialogRespond(id)
            if result then
                if button == 1 and list ~= -1 then
                    local item = menu[list + 1]
                    if type(item.submenu) == 'table' then -- submenu
                        table.insert(prev_menus, {menu = menu, caption = caption})
                        if type(item.onclick) == 'function' then
                            item.onclick(menu, list + 1, item.submenu)
                        end
                        return display(item.submenu, id + 1, item.submenu.title and item.submenu.title or item.title)
                    elseif type(item.onclick) == 'function' then
                        local result = item.onclick(menu, list + 1)
                        if not result then return result end
                        return display(menu, id, caption)
                    end
                else -- if button == 0
                    if #prev_menus > 0 then
                        local prev_menu = prev_menus[#prev_menus]
                        prev_menus[#prev_menus] = nil
                        return display(prev_menu.menu, id - 1, prev_menu.caption)
                    end
                    return false
                end
            end
        until result
    end
    return display(menu, 31337, caption or menu.title)
end

function r(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/r [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/r %s', pam))
        end
    else
        ftext('Ââåäèòå /r [òåêñò].')
    end
end
function f(pam)
    if #pam ~= 0 then
        if cfg.main.tarb then
            sampSendChat(string.format('/f [%s]: %s', cfg.main.tarr, pam))
        else
            sampSendChat(string.format('/f %s', pam))
        end
    else
        ftext('Ââåäèòå /f [òåêñò].')
    end
end
function ftext(message)
    sampAddChatMessage(string.format('%s %s', ctag, message), 0x139BEC)
end

function mh()
  second_window.v = not second_window.v
end

function tloadtk()
    if tload == true then
     sampSendChat('/tload'..u8(cfg.main.norma))
    else if tload == false then
     sampSendChat("/tunload")
    end
  end
end
function imgui.CentrText(text)
            local width = imgui.GetWindowWidth()
            local calc = imgui.CalcTextSize(text)
            imgui.SetCursorPosX( width / 2 - calc.x / 2 )
            imgui.Text(text)
        end
        function imgui.CustomButton(name, color, colorHovered, colorActive, size)
            local clr = imgui.Col
            imgui.PushStyleColor(clr.Button, color)
            imgui.PushStyleColor(clr.ButtonHovered, colorHovered)
            imgui.PushStyleColor(clr.ButtonActive, colorActive)
            if not size then size = imgui.ImVec2(0, 0) end
            local result = imgui.Button(name, size)
            imgui.PopStyleColor(3)
            return result
        end

function pkmmenu(id)
    local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
    return
    {
      {
        title = "{80a4bf}»{ffffff} Ìåíþ âðà÷à.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{80a4bf}» {ffffff}Ðàçäåë ëå÷åíèÿ.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
		title = "{80a4bf}»{FFFFFF} Âîïðîñû ïî Óñòàâó/Ðàñöåíêè {ff0000}(Ñò.Ñîñòàâà)",
		onclick = function()
		if rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
		submenus_show(ustav(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."]")
		else
		ftext('Äàííîå ìåíþ äîñòóïíî ñ äîëæíîñòè Ïñèõîëîã.')
		end
		end
   },
	  {
        title = "{80a4bf}» {ffffff}Ïðèçûâ ìåíþ.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(priziv(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Ïðîâåðêà âèðóñà",
        onclick = function()
        pID = tonumber(args)
        submenus_show(virus(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}» {ffffff}Ìåíþ ñîáåñåäîâàíèÿ.",
        onclick = function()
        pID = tonumber(args)
        if rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
		submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
		ftext('Äàííîå ìåíþ äîñòóïíî ñ äîëæíîñòè Ïñèõîëîã.')
		end
        end
      },
	  {
        title = "{ffffff}» Ìåíþ ðåíòãåíà, ïîðåçîâ, ïåðåëîìîâ.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(renmenu(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Ìåäèöèíñêèé îñìîòð.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(medosmotr(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}» Ïåðâàÿ ìåä.ïîìîùü.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(medpomosh(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	}
end
function agitmenu(id)
 return
{
   {
   title = '{80a4bf}»{FFFFFF} Àãèòàöèÿ ¹1.',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG, Ì×Ñ øòàòà Cleveland â ïîèñêàõ íîâûõ è îïûòíûõ ñîòðóäíèêîâ. Ïîäðîáíåå íà pgr. '..myid..'')
	end
	
	 },
    {
   title = '{80a4bf}»{FFFFFF} Àãèòàöèÿ ¹2.',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d AF, â øòàòå Cleveland äåéñòâóåò äîñòàâêà ìåäèêàìåíòîâ. Ïîäðîáíåå íà pgr. '..myid..'')
	end
   },
}
end
function ustav(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë óñòàâà. »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Ñêîëüêî ìèíóò äàåòñÿ ñîòðóäíèêó, ÷òîáû ïðèáûòü íà ðàáîòó è ïåðåîäåòüñÿ â ðàáî÷óþ ôîðìó?',
        onclick = function()
        sampSendChat("Ñêîëüêî ìèíóò äàåòñÿ ñîòðóäíèêó, ÷òîáû ïðèáûòü íà ðàáîòó è ïåðåîäåòüñÿ â ðàáî÷óþ ôîðìó?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}15 ìèíóò.", -1)
		end
      },
      {
        title = '{80a4bf}» {ffffff}Ñ êàêîé äîëæíîñòè ðàçðåøåíî èñïîëüçîâàòü âîëíó äåïàðòàìåíòà â êà÷åñòâå ïåðåãîâîðîâ?',
        onclick = function()
        sampSendChat("Ñ êàêîé äîëæíîñòè ðàçðåøåíî èñïîëüçîâàòü âîëíó äåïàðòàìåíòà â êà÷åñòâå ïåðåãîâîðîâ?")
		wait(500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ñ äîëæíîñòè Ìåä.Áðàòà.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ñ êàêîé äîëæíîñòè ðàçðåøåíî âûåçæàòü â íàçåìíûé ïàòðóëü øòàòà?',
        onclick = function()
        sampSendChat(" Ñ êàêîé äîëæíîñòè ðàçðåøåíî âûåçæàòü â íàçåìíûé ïàòðóëü øòàòà?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ñ äîëæíîñòè Ìåä.Áðàòà.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ñ êàêîé äîëæíîñòè ðàçðåøåíî èñïîëüçîâàòü âîçäóøíî-òðàíñïîðòíîå ñðåäñòâî?',
        onclick = function()
        sampSendChat("Ñ êàêîé äîëæíîñòè ðàçðåøåíî èñïîëüçîâàòü âîçäóøíî-òðàíñïîðòíîå ñðåäñòâî?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ñ äîëæíîñòè Ïñèõîëîãà, ïî ðàçðåøåíèþ {ff0000}ðóê-âà ñ Äîêòîðà.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå çàâåäåíèÿ çàïðåùåíî ïîñåùàòü âî âðåìÿ ðàáî÷åãî äíÿ?',
        onclick = function()
        sampSendChat("Êàêèå çàâåäåíèÿ çàïðåùåíî ïîñåùàòü âî âðåìÿ ðàáî÷åãî äíÿ?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Àâòîáàçàð, Êàçèíî.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ñêîëüêî äîëæåí çàïëàòèòü ãðàæäàíèí Evolve, ÷òîáû âûéòè èç ÷åðíîãî ñïèñêà?',
        onclick = function()
        sampSendChat("Ñêîëüêî äîëæåí çàïëàòèòü ãðàæäàíèí Evolve, ÷òîáû âûéòè èç ÷åðíîãî ñïèñêà?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}îò {ff0000}100.000 äî {ff0000}150.000 âèðò.", -1)
		end
      },
	  {
        title = '{5b83c2}« Ðàçäåë âîïðîñîâ ïî ìåäèêàìåíòàì. »',
        onclick = function()
        end
	  },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò áîëè â æèâîòå?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò áîëè â æèâîòå?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Íî-øïà, Äðîòàâåðèí, Êåòîðîëàê, Ñïàçìàëãîí, Êåòàíîâ.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå ïðè áîëè â ãîëîâå?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå ïðè áîëè â ãîëîâå?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Àñïèðèí, Àíàëüãèí, Öèòðàìîí, Äèêëîôåíàê, Ïåíòàëãèí.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò áîëè â ãîðëå?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò áîëè â ãîðëå?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ãåêñàëèç, Ôàëèìèíò, Ñòðåïñèëñ.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò òåìïåðàòóðû?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå îò òåìïåðàòóðû?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Ïàðàöåòàìîë, Íóðîôåí, Èáóêëèí, Ðèíçà.", -1)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå ïðè êàøëå?',
        onclick = function()
        sampSendChat("Êàêèå ìåä.ïðåïàðàòû âû âûïèøèòå ïðè êàøëå?")
		wait(1500)
		ftext("{FFFFFF}- Ïðàâèëüíûé îòâåò: {A52A2A}Àìáðîáåíå, Àìáðîãåêñàë, ÀÖÖ, Áðîìãåêñèí, Äîêòîð ÌÎÌ.", -1)
		end
      },
	  {
        title = '{5b83c2}« Ðàçäåë âîïðîñîâ ïî ìåäèêàìåíòàì. »',
        onclick = function()
        end
	  },
	  {
        title = '{80a4bf}» {ffffff}ÄÒÏ',
        onclick = function()
        sampSendChat("Ïðåäñòàâèì ñèòóàöèþ âû åõàëè íà ñðî÷íûé âûçîâ, è ñòàíîâèòåñü ñâèäåòåëåì ÄÒÏ, âîäèòåëü âûëåòàåò íà òðàññó...")
		wait(1500)
		sampSendChat("...óìèðàåò äâà ÷åëîâåêà îäèí êîòîðûé âàñ âûçûâàë, âòîðîé ïîñòðàäàâøèé â ýòîì ÄÒÏ, âàøè äåéñòâèÿ?")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Îãíåñòðåë.',
        onclick = function()
        sampSendChat("Âû èäåòå ïî ïîëþ è âèäèòå êàê íà çåìëå ëåæèò ÷åëîâåê ñ îãíåñòðåëüíûì ðàíåíèåì â íîãå...")
		wait(1500)
		sampSendChat("...ñ ñîáîé åñòü ìåä.ñóìêà, ñîâðåìåííûõ ïðåïàðàòîâ íåòó, âàøè äåéñòâèÿ?")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Îáìîðîê.',
        onclick = function()
        sampSendChat("Âû âèäèòå êàê ÷åëîâåê óïàë â îáìîðîê, âàøè äåéñòâèÿ?")
		end
      },
    }
end
function saveData(table, path)
	if doesFileExist(path) then os.remove(path) end
    local sfa = io.open(path, "w")
    if sfa then
        sfa:write(encodeJson(table))
        sfa:close()
    end
end
function ystf()
    if not doesFileExist('moonloader/medick/ystav.txt') then
        local file = io.open("moonloader/medick/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end
function instmenu(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë âðà÷à. »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("Çäðàâñòâóéòå. ß ñîòðóäíèê áîëüíèöû "..myname:gsub('_', ' ')..", ÷åì ìîãó ïîìî÷ü?")
		end
      },
      {
        title = '{80a4bf}» {ffffff}Ïàñïîðò.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("Âàø ïàñïîðò, ïîæàëóéñòà.")
		wait(5000)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïîïðîùàòüñÿ ñ êëèåíòîì.',
        onclick = function()
        sampSendChat("Âñåãî âàì äîáðîãî.")
        end
      }
    }
end

function ystf()
    if not doesFileExist('moonloader/medick/ystav.txt') then
        local file = io.open("moonloader/medick/ystav.txt", "w")
        file:write(fpt)
        file:close()
        file = nil
    end
end
function oformenu(id)
    return
    {
      {
        title = '{5b83c2}« Ðàçäåë ëå÷åíèÿ. »',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}» {ffffff}Ëå÷åíèå.',
        onclick = function()
		  sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä. ñóìêà íà ðåìíå.")
		  wait(2000)
          sampSendChat("/me äîñòàë èç ìåä.ñóìêè ëåêàðñòâî è áóòûëî÷êó âîäû")
          wait(2000)
		  sampSendChat('/me ïåðåäàë ëåêàðñòâî è áóòûëî÷êó âîäû '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1100)
		  sampSendChat("/heal "..id) 
		  end
      },
	  {
        title = '{80a4bf}» {ffffff}Ñïðàâêà.',
        onclick = function()
		sampSendChat("/do Íà ñòîëå ñòîèò ÿùèê ñ ìåä.êàðòàìè è íåâðîëîãè÷åñêèì ìîëîòî÷êîì.")
        wait(3000)
        sampSendChat(" Èìååòå ëè âû æàëîáû íà çäîðîâüå?")
        wait(3000)
        sampSendChat("/do Â ëåâîé ðóêå ÷¸ðíàÿ ðó÷êà.")
        wait(3000)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(3000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(3000)
        sampSendChat("Ïðèñàæèâàéòåñü, íà÷íåì îáñëåäîâàíèå.")
        wait(3000)
        sampSendChat("/me äîñòàë èç ÿùèêà íåâðîëîãè÷åñêèé ìîëîòî÷åê")
        wait(3000)
        sampSendChat('/me âîäèò ìîëîòî÷êîì ïåðåä ãëàçàìè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me óáåäèëñÿ, ÷òî çðà÷êè äâèæóòñÿ ñîäðóæåñòâåííî è ðåôëåêñ â íîðìå")
        wait(3000)
        sampSendChat("/me ñäåëàë çàïèñü â ìåä.êàðòå")
        wait(3000)
        sampSendChat('/me óäàðèë ìîëîòî÷êîì ïî ëåâîìó êîëåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat('/me óäàðèë ìîëîòî÷êîì ïî ïðàâîìó êîëåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
		sampSendChat("/checkheal "..id)
		end
      },
	  {
        title = '{ffffff}» Îáðàáîòêà âàòêè íàøàòûð¸ì.',
        onclick = function()
        sampSendChat("/me îòêðûë àïòå÷êó")
        wait(3000) 
        sampSendChat("/me äîñòàë èç àïòå÷êè âàòêó è íàøàòûðü")
        wait(3000) 
        sampSendChat("/me îáðàáîòàë âàòêó íàøàòûðåì, ïîñëå ÷åãî ïîäíåñ ê íîñó ïîñòðàäàâøåãî")
        wait(3000) 
        sampSendChat("/me âîäèò âàòêîé âîêðóã íîñà")
        wait(3000) 
        sampSendChat("Íå âîëíóéòåñü, ó âàñ ñëó÷èëñÿ â îáìîðîê.")
        wait(3000) 
        sampSendChat("Ñåé÷àñ ìû äîñòàâèì âàñ â áîëüíèöó, ãäå ðàçáåðåìñÿ ñ ïðè÷èíîé äàííîãî íåäóãà.") 
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ëå÷åíèå îò íàðêîçàâèñèìîñòè.',
        onclick = function()
		sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(2000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè øïðèö.")
		wait(2000)
		sampSendChat("/do Øïðèö â ëåâîé ðóêå.")
		wait(2000)
		sampSendChat('/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(2000)
		sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò ïðåïàðàò â âåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(2000)
		sampSendChat("/todo Íó âîò è âñ¸*âûòàùèâ øïðèö èç âåíû è ïðèëîæèâ âàòó ê ìåñòó óêîëà.")
        wait(2000)
        sampSendChat("/healaddict " .. id .. "  10000")
		end
      }
    }
end
function medpomosh(args)
    return
    {
      {
        title = '{5b83c2}« Ïðè çàêðûòûõ/îòêðûòûõ ïåðåëîìàõ: »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè çàêðûòîì ïåðåëîìå ðóêè/íîãè: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Äëÿ íà÷àëà âû äîëæíû ââåñòè àíàëüãåòèê ÷åðåç øïðèö â âåíó ïîñòðàäàâøåãî.',
        onclick = function()
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
        wait(3000) 
        sampSendChat("/me ïîëîæèë ìåäèöèíñêèé êåéñ íà ïîë è îòêðûë åãî")
        wait(3000) 
        sampSendChat("/do Â êåéñå ëåæàò: ñòåðèëüíûå øïðèöû, àìïóëà ñ àíàëüãåòèêîì, øèíà, áèíòû")
        wait(3000) 
        sampSendChat("/me äîñòàë ñòåðèëüíûé øïðèö ñ àìïóëîé, àêêóðàòíî ïðèîòêðûë àìïóëó ñ àíàëüãåòèêîì")
		wait(3000) 
        sampSendChat("/me ïåðåëèë ñîäåðæèìîå àìïóëû â øïðèö")
		wait(3000) 
        sampSendChat("/me çàêàòàë ðóêàâ ïîñòðàäàâøåãî, ïîñëå ÷åãî ââ¸ë àíàëüãåòèê ÷åðåç øïðèö â âåíó, âäàâèâ ïîðøåíü")
		wait(3000) 
        sampSendChat("/do Àíàëüãåòèê ïðîíèê â îðãàíèçì ïîñòðàäàâøåãî.")
		wait(3000) 
        sampSendChat("/me óáðàë èñïîëüçîâàííûé øïðèö â ìåäèöèíñêóþ ñóìêó")
		end
      },
	  {
        title = '{ffffff}» 2) Ñëåäóåò áûñòðî íàëîæèòü øèíó.',
        onclick = function()
        sampSendChat("/me äîñòàë èç êåéñà øèíó, çàòåì ïðèíÿëñÿ íàêëàäûâàòü å¸ íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
        wait(3000) 
        sampSendChat("/me àêêóðàòíî íàëîæèë øèíó íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
        wait(3000) 
        sampSendChat("/do Øèíà êà÷åñòâåííî íàëîæåíà íà ïîâðåæä¸ííóþ êîíå÷íîñòü.")
		end
      },
	  {
        title = '{ffffff}» 3) Íóæíî ñðî÷íî èììîáèëèçèðîâàòü ïîâðåæä¸ííóþ êîíå÷íîñòü ñ ïîìîùüþ êîñûíêè.',
        onclick = function()
        sampSendChat("/me âçÿë èç êåéñà ñòåðèëüíûå áèíòû è ñäåëàë êîñûíêó")
        wait(3000) 
        sampSendChat("/me ïîäâåñèë ïîâðåæä¸ííóþ êîíå÷íîñòü â ñîãíóòîì ïîëîæåíèè")
        wait(3000) 
        sampSendChat("/do Ïîâðåæä¸ííàÿ êîíå÷íîñòü èììîáèëèçîâàíà. ")
		end
      },
	  {
        title = '{5b83c2}« Ïðè îòêðûòîì ïåðåëîìå ðóêè/íîãè: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Äëÿ íà÷àëà âû äîëæíû ââåñòè àíàëüãåòèê ÷åðåç øïðèö â âåíó ïîñòðàäàâøåãî.',
        onclick = function()
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
        wait(3000) 
        sampSendChat("/me ïîëîæèë ìåäèöèíñêèé êåéñ íà ïîë è îòêðûë åãî")
        wait(3000) 
        sampSendChat("/do Â êåéñå ëåæàò: ñòåðèëüíûå øïðèöû, àìïóëà ñ àíàëüãåòèêîì, øèíà, áèíòû, àíòèñåïòèê è æãóò.")
        wait(3000) 
        sampSendChat("/me äîñòàë ñòåðèëüíûé øïðèö ñ àìïóëîé, àêêóðàòíî ïðèîòêðûâ àìïóëó ñ àíàëüãåòèêîì")
		wait(3000) 
        sampSendChat("/me ïåðåëèë ñîäåðæèìîå àìïóëû â øïðèö")
		wait(3000) 
        sampSendChat("/me çàêàòàë ðóêàâ ïîñòðàäàâøåãî, ïîñëå ÷åãî ââ¸ë àíàëüãåòèê ÷åðåç øïðèö â âåíó, âäàâèâ ïîðøåíü")
		wait(3000) 
        sampSendChat("/do Àíàëüãåòèê ïðîíèê â îðãàíèçì ïîñòðàäàâøåãî.")
		wait(3000) 
        sampSendChat("/me óáðàë èñïîëüçîâàííûé øïðèö â ìåäèöèíñêóþ ñóìêó")
		end
      },
	  {
        title = '{ffffff}» 2) Ñëåäóåò áûñòðî íàëîæèòü æãóò, îáðàáîòàòü ðàíó àíòèñåïòèêîì, íàëîæèòü øèíó.',
        onclick = function()
        sampSendChat("/me äîñòàë èç êåéñà êðîâîîñòàíàâëèâàþùèé æãóò, çàòåì íà÷àë íàêëàäûâàòü åãî")
        wait(3000) 
        sampSendChat("/me íàëîæèë æãóò ïîâåðõ ðàíû íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
        wait(3000) 
        sampSendChat("/me äîñòàë èç êåéñà ñïðåé ñ àíòèñåïòè÷åñêèì ñðåäñòâîì")
        wait(3000) 
        sampSendChat("/me îáðàáîòàë ðàíó àíòèñåïòè÷åñêèì ñðåäñòâîì")
		wait(3000) 
        sampSendChat("/me óáðàë ñïðåé â êåéñ, äîñòàë øèíó")
		wait(3000) 
        sampSendChat("/me àêêóðàòíî íàëîæèë øèíó íà ïîâðåæä¸ííóþ êîíå÷íîñòü")
		wait(3000) 
        sampSendChat("/do Øèíà êà÷åñòâåííî íàëîæåíà íà ïîâðåæä¸ííóþ êîíå÷íîñòü.")
		end
      },
	  {
        title = '{ffffff}» 3) Ñëåäóåò èììîáèëèçèðîâàòü ïîâðåæä¸ííóþ êîíå÷íîñòü ñ ïîìîùüþ êîñûíêè.',
        onclick = function()
        sampSendChat("/me âçÿë èç êåéñà ñòåðèëüíûå áèíòû è íà÷àë äåëàòü êîñûíêó")
        wait(3000) 
        sampSendChat("/me ñäåëàë êîñûíêó èç ñòåðèëüíîãî áèíòà")
        wait(3000) 
        sampSendChat("/me ïîäâåñèë ïîâðåæä¸ííóþ êîíå÷íîñòü â ñîãíóòîì ïîëîæåíèè")
		wait(3000) 
        sampSendChat("/do Ïîâðåæä¸ííàÿ êîíå÷íîñòü èììîáèëèçîâàíà.")
		end
      },
	  {
        title = '{5b83c2}« Ïðè óøèáàõ/ðàñòÿæåíèÿõ: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Äëÿ íà÷àëà íóæíî îáðàáîòàòü ìåñòî óøèáà îõëàæäàþùèì ñïðååì.',
        onclick = function()
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
        wait(3000) 
        sampSendChat("/me äîñòàë èç êåéñà ñïðåé 'Ôðîñò' è îáðàáîòàë óøèá ñïðååì")
        wait(3000) 
        sampSendChat("/do Ìåñòî óøèáà îáðàáîòàíî îõëàæäàþùèì ñïðååì.")
		end
      },
	  {
        title = '{ffffff}» 2) Äàëåå íóæíî íàëîæèòü íà ïîâðåæä¸ííóþ êîíå÷íîñòü ýëàñòè÷íûé áèíò.',
        onclick = function()
        sampSendChat("/me îòêðûë êåéñ è äîñòàë èç íå¸ ýëàñòè÷íûé áèíò")
        wait(3000) 
        sampSendChat("/me óáðàë ñïðåé â êåéñ è íàëîæèë íà êîíå÷íîñòü ïîñòðàäàâøåãî ýëàñòè÷íûõ áèíò")
        wait(3000) 
        sampSendChat("/me êðåïêî çàòÿíóë ýëàñòè÷íûé áèíò")
		wait(3000) 
        sampSendChat("/do Ýëàñòè÷íûé áèíò ïëîòíî ñèäèò íà êîíå÷íîñòè ïàöèåíòà.")
		end
      },
	  {
        title = '{5b83c2}«  »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè íîæåâûõ/îãíåñòðåëüíûõ ðàíåíèÿõ: »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè íîæåâûõ ðàíåíèÿõ: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Äëÿ íà÷àëà íóæíî îáðàáîòàòü ðàíó õëîðãåñèäèíîì èëè ëþáûì àíàëîãîì.',
        onclick = function()
        sampSendChat("/me îñìîòðåë ðàíó è îïîçíàë õàðàêòåð ïîâðåæäåíèÿ")
        wait(3000) 
        sampSendChat("/do Êîëîòàÿ ðàíà.")
        wait(3000) 
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
		wait(3000) 
        sampSendChat("/me äîñòàë èç íåãî ðàñòâîð õëîðãåêñèäèíà è îáðàáîòàë ðàíó ïîñòðàäàâøåãî")
		wait(3000) 
        sampSendChat("/me óáðàë â ñóìêó ðàñòâîð õëîðãåêñèäèíà")
		end
      },
	  {
        title = '{ffffff}» 2) Ïîñëå îáðàáîòêè ðàíû ñëåäóåò ñäåëàòü èç áèíòîâ íàêëàäíóþ ïîâÿçêó, íàëîæèòü å¸ íà ðàíó.',
        onclick = function()
        sampSendChat("/me äîñòàë áèíòû èç ìåäèöèíñêîãî êåéñà è ñäåëàë èç íèõ íàêëàäíóþ ïîâÿçêó")
        wait(3000) 
        sampSendChat("/me íàëîæèë ïîâÿçêó íà ðàíó")
        wait(3000) 
        sampSendChat("/do Áèíòû ñêðûëè ðàíó.")
		wait(3000) 
        sampSendChat("/do Ïîâÿçêà êðåïêî íàëîæåíà è ñòÿãèâàåò ðàíó.")
		end
      },
	  {
        title = '{5b83c2}« Ïðè îãíåñòðåëüíûõ ðàíåíèÿõ: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Ñíà÷àëà íóæíî îñòàíîâèòü êðîâîòå÷åíèå. Äëÿ ýòîãî íóæíî îñâîáîäèòü ìåñòî ðàíåíèÿ îò îäåæäû.',
        onclick = function()
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
        wait(3000) 
        sampSendChat("/me óâèäåë ðàíåíèå è äîñòàë èç ìåäèöèíñêîãî êåéñà æãóò")
        wait(3000) 
        sampSendChat("/me îñâîáîäèë ðóêó ïîñòðàäàâøåãî îò îäåæäû è íà÷àë íàêëàäûâàòü æãóò")
		wait(3000) 
        sampSendChat("/do Æãóò íàëîæåí, êðîâîòå÷åíèå îñòàíîâëåíî.")
		wait(3000) 
        sampSendChat("/me äîñòàë áëîêíîò èç êàðìàíà è íàïèñàë âðåìÿ íàëîæåíèÿ æãóòà")
		end
      },
	  {
        title = '{ffffff}» 2) Äàëåå íóæíî îáðàáîòàòü ðàíó õëîðãåêñèäèíîì èëè äðóãèì àíàëîãîì.',
        onclick = function()
        sampSendChat("/me îòêðûë ñóìêó è äîñòàë èç íå¸ ðàñòâîð õëîðãåêñèäèíà")
        wait(3000) 
        sampSendChat("/me îáðàáîòàë ðàíó ïîñòðàäàâøåãî è ïîëîæèë ðàñòâîð õëîðãåêñèäèíà â ñóìêó")
		end
      },
	  {
        title = '{ffffff}» 3) Ïîñëå âñåõ ïðîâåä¸ííûõ ïðîöåäóð íóæíî ñäåëàòü èç áèíòîâ íàêëàäíóþ ïîâÿçêó, íàëîæèòü å¸.',
        onclick = function()
        sampSendChat("/me äîñòàë áèíòû èç ìåäèöèíñêîãî êåéñà è ñäåëàë èç íèõ íàêëàäíóþ ïîâÿçêó")
        wait(3000) 
        sampSendChat("/me íà÷àë íàêëàäûâàòü ïîâÿçêó íà ðàíó")
        wait(3000) 
        sampSendChat("/do Áèíòû ïîñòåïåííî íà÷àëè ñêðûâàòü ðàíó.")
		wait(3000) 
        sampSendChat("/do Ïîâÿçêà êðåïêî íàëîæåíà è ñòÿãèâàåò ðàíó.")
		end
      },
	  {
        title = '{5b83c2}«  »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè îáìîðîêå: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Ïðèâåñòè ïàöèåíòà â ñîçíàíèå.',
        onclick = function()
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
        wait(3000) 
        sampSendChat("/me ïîëîæèë ìåäèöèíñêèé êåéñ íà ïîë è îòêðûë åãî")
        wait(3000) 
        sampSendChat("/me äîñòàë èç êåéñà ôëàêîí ñ íàøàòûðíûì ñïèðòîì è îòêðûë åãî")
		wait(3000) 
        sampSendChat("/me äîñòàë èç êåéñà âàòêó è íàìî÷èë å¸ íàøàòûðíûì ñïèðòîì")
		wait(3000) 
        sampSendChat("/me ïîäí¸ñ ñìî÷åííóþ âàòêó ê íîñó ïîñòðàäàâøåãî")
		wait(3000) 
        sampSendChat("/do ×åëîâåê î÷íóëñÿ?")
		wait(3000) 
        sampSendChat("/b /do Äa/Íåò.")
		end
      },
	  {
        title = '{ffffff}» 2) Åñëè ïàöèåíò ïðèøåë â ñåáÿ.',
        onclick = function()
        sampSendChat("Ñ âàìè âñ¸ õîðîøî, óñïîêîéòåñü, âû ïîòåðÿëè ñîçíàíèå.")
        wait(3000) 
        sampSendChat("Òåïåðü âñ¸ â ïîðÿäêå, ÿ ìîãó âàì åù¸ ÷åì-òî ïîìî÷ü?")
		end
      },
	  {
        title = '{ffffff}» 3) Åñëè ïàöèåíò íå ïðèøåë â ñåáÿ.',
        onclick = function()
        sampSendChat("/me ñëåãêà ïîõëîïàë ðóêàìè ïî ùåêàì ÷åëîâåêà")
        wait(3000) 
        sampSendChat("/me äîñòàë èç ñóìêè áóòûëêó ñ õîëîäíîé âîäîé è îòêðóòèë êðûøêó")
		wait(3000) 
        sampSendChat("/me áðûçíóë âîäîé èç áóòûëêè íà ëèöî ïîñòðàäàâøåãî")
		wait(3000) 
        sampSendChat("/me ïîõëîïàë ïîñòðàäàâøåãî ïî ùåêàì")
		wait(3000) 
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñîçíàíèå?")
		wait(3000) 
        sampSendChat("/b /do Äa/Íåò.")
		end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò ïðèøåë â ñåáÿ òî ïóíêò îáìîðîêà ¹2. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 4) Åñëè ïàöèåíò äî ñèõ ïîð íå ïðèøåë â ñåáÿ, ïðîâåðèòü ïóëüñ.',
        onclick = function()
        sampSendChat("/me ïîäí¸ñ äâà ïàëüöà ê øåå ïîñòðàäàâøåãî, ïðèëîæèâ èõ ê ñîííîé àðòåðèè")
        wait(3000) 
        sampSendChat("/do Ó ÷åëîâåêà åñòü ïóëüñ?")
		wait(3000) 
        sampSendChat("/b /do Äà/Íåò. ")
		end
      },
	  {
        title = '{ffffff}» 5) Åñëè ó ïîñòðàäàâøåãî íåò ïóëüñà, òî íóæíî ïðîâåñòè ðÿä ïðîöåäóð ðåàíèìèðîâàíèÿ.',
        onclick = function()
        sampSendChat("/me äîñòàë èç ñóìêè ïîëîòåíöå è ïîäëîæèë åãî ïîä øåþ ïîñòðàäàâøåãî")
        wait(3000) 
        sampSendChat("/me ñíÿë ñ ãðóäè ÷åëîâåêà âñþ îäåæäó")
		wait(3000) 
        sampSendChat("/me ñíÿë âñå ñäàâëèâàþùèå àêñåññóàðû")
		wait(3000) 
        sampSendChat("/me ñäåëàë ãëóáîêèé âäîõ è íà÷àë äåëàòü èñêóññòâåííîå äûõàíèå ë¸ãêèõ")
		wait(3000) 
        sampSendChat("/do Âîçäóõ ïîñòåïåííî íàïîëíÿåò ë¸ãêèå ïîñòðàäàâøåãî.")
		wait(3000) 
        sampSendChat("/me ïîëîæèë ðóêè äðóã íà äðóãà íà ãðóäü ÷åëîâåêà")
		wait(3000) 
        sampSendChat("/me äåëàåò íåïðÿìîé ìàññàæ ñåðäöà")
		wait(3000) 
        sampSendChat("/me ïîïåðåìåííî äåëàåò èñêóññòâåííîå äûõàíèå è íåïðÿìîé ìàññàæ ñåðäöà")
		wait(3000) 
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñåáÿ?")
		wait(3000) 
        sampSendChat("/b /do Äà/Íåò. ")
		end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò ïðèøåë ïîñëå âñåõ ïðîöåäóð âåçåì â áîëüíèöó äëÿ ëå÷åíèÿ. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò íå ïðèøåë â ñåáÿ âåçåì â áîëüíèöó äëÿ óñòàíàâëåíèÿ ñìåðòè. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}«  »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè ïîòåðå ïóëüñà: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Åñëè ó ïîñòðàäàâøåãî íåò ïóëüñà, òî íóæíî ïðîâåñòè ðÿä ïðîöåäóð ðåàíèìèðîâàíèÿ.',
        onclick = function()
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
        wait(3000) 
        sampSendChat("/me äîñòàë èç êåéñà ïîëîòåíöå è ïîäëîæèë åãî ïîä øåþ ïîñòðàäàâøåãî")
		wait(3000) 
        sampSendChat("/me ñíÿë ñ ãðóäè ÷åëîâåêà âñþ îäåæäó è âñå ñäàâëèâàþùèå àêñåññóàðû ")
		end
      },
	  {
        title = '{ffffff}» 2) Åñëè ó ïîñòðàäàâøåãî íåò ïóëüñà, òî íóæíî ïðîâåñòè ðÿä ïðîöåäóð ðåàíèìèðîâàíèÿ.',
        onclick = function()
        sampSendChat("/me ñäåëàë ãëóáîêèé âäîõ è íà÷àë äåëàòü èñêóññòâåííîå äûõàíèå ë¸ãêèõ")
        wait(3000) 
        sampSendChat("/do Âîçäóõ ïîñòåïåííî íàïîëíÿåò ë¸ãêèå ïîñòðàäàâøåãî.")
		wait(3000) 
        sampSendChat("/me ïîëîæèë ðóêè íà ãðóäü ÷åëîâåêà")
		wait(3000) 
        sampSendChat("/me äåëàåò íåïðÿìîé ìàññàæ ñåðäöà")
		wait(3000) 
        sampSendChat("/me ïîïåðåìåííî äåëàåò èñêóññòâåííîå äûõàíèå è íåïðÿìîé ìàññàæ ñåðäöà.")
		wait(3000) 
        sampSendChat("/do Ïðîøëà ìèíóòà.")
		wait(3000) 
        sampSendChat("/do ×åëîâåê ïðèø¸ë â ñåáÿ?")
		wait(3000) 
        sampSendChat("/b /do Äà/Íåò.")
		end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò íå ïðèøåë â ñåáÿ òî, ïðîäîëæàéòå òå æå äåéñòâèÿ â òå÷åíèè 4 ìèíóò. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Åñëè ïàöèåíò íå ïðèøåë â ñåáÿ òî, âåçèòå åãî â áîëüíèöó óñòàíàâëèâàòü ñìåðòü. »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}«  »',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}« Ïðè îæîãàõ: »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» 1) Íóæíî îñâîáîäèòü îáîææ¸ííûé ó÷àñòîê êîæè îò îäåæäû.',
        onclick = function()
        sampSendChat("/do Ìåäèöèíñêèé êåéñ â ðóêå.")
        wait(3000) 
        sampSendChat("/me ïîëîæèë êåéñ íà ïîë è äîñòàë èç íåãî ìåäèöèíñêèå íîæíèöû")
		wait(3000) 
        sampSendChat("/me èñïîëüçóåò íîæíèöû è îñâîáîäèë îáîææ¸ííûé ó÷àñòîê êîæè îò îäåæäû")
		end
      },
	  {
        title = '{ffffff}» 2) Äàëåå íóæíî îáðàáîòàòü îáãîðåâøèé ó÷àñòîê êîæè ñïðååì "Îëàçîëü".',
        onclick = function()
        sampSendChat("/me äîñòàë èç ñóìêè ñïðåé 'Îëàçîëü' è îòêðûë åãî êîëïà÷îê")
        wait(3000) 
        sampSendChat("/me ñáðûçíóë ñïðååì îáãîðåâøèå ó÷àñòêè êîæè è çàêðûë ñïðåé")
		wait(3000) 
        sampSendChat("/me óáðàë åãî â ìåäèöèíñêèé êåéñ è äîñòàë èç íå¸ áèíòû")
		end
      },
	  {
        title = '{ffffff}» 3) Â êîíöå âñåõ ïðîöåäóð ñëåäóåò íàëîæèòü ïîâÿçêó èç áèíòîâ íà îáîææ¸ííûé ó÷àñòîê êîæè.',
        onclick = function()
        sampSendChat("/me íàëîæèë ïîâÿçêó èç áèíòîâ íà îæîã")
        wait(3000) 
        sampSendChat("/do Ïîâÿçêà êðåïêî ñèäèò íà îæîãå.")
		end
      },
	 }
end
function medosmotr(args)
    return
    {
      {
        title = '{ffffff}» Ðåãèñòðàòóðà, çàïèñü íà îñìîòð',
        onclick = function()
        sampSendChat("Äîáðûé äåíü, ïîêàæèòå âàøó ìåä.êàðòó, ÷òîá ÿ ìîã âíåñòè âàñ â æóðíàë îñìîòðîâ.")
        wait(3000) 
        sampSendChat("/me ïîñìîòðåë ìåä.êàðòó")
        wait(3000) 
        sampSendChat("/me ñäåëàë çàïèñü â æóðíàëå îñìîòðîâ.")
        wait(3000) 
        sampSendChat("Ïðîõîäèòå ê ïåðâîìó âðà÷ó.")
		end
      },
	  {
        title = '{ffffff}» Îñìîòð ó Íàðêîëîãà ¹1.',
        onclick = function()
        sampSendChat("Äîáðûé äåíü, ïðèñàæèâàéòåñü íà êóøåòêó è çàêàòàéòå ðóêàâ.")
        wait(3000) 
        sampSendChat("Âàì íóæíî ñäàòü àíàëèç êðîâè.")
        wait(3000) 
        sampSendChat("/me äîñòàë èç øêàôà: æãóò, ïóñòîé øïðèö è âàòêó, ñìî÷åííóþ ñïèðòîì.")
        wait(3000) 
        sampSendChat("/me çàòÿíóë æãóò íà ðóêå ïàöèåíòà")
		wait(3000) 
        sampSendChat("/me îáðàáîòàë âàòêîé ìåñòî áóäóùåé èíúåêöèè")
		wait(3000) 
        sampSendChat("/me âçÿë øïðèöîì íåîáõîäèìîå êîëè÷åñòâî êðîâè ñ âåíû")
		wait(3000) 
        sampSendChat("/me ïðèëîæèë âàòêó ê ìåñòó óêîëà")
		wait(3000) 
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ïðîáèðêó")
		wait(3000) 
        sampSendChat("/me îïóñòèë òåñòîâóþ ïàëî÷êó â ïðîáèðêó")
		end
      },
	  {
        title = '{5b83c2}« Ïðîâåðÿåì êîìàíäîé /checkheal [id]. »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Îñìîòð ó Íàðêîëîãà ¹1.',
        onclick = function()
        sampSendChat("/me âïèñàë ðåçóëüòàòû àíàëèçîâ â ìåä.êàðòó")
		wait(3000) 
        sampSendChat("/me ïåðåäàë ìåä.êàðòó")
		wait(3000) 
        sampSendChat("Ìîæåòå ïðîõîäèòü â ñëåäóþùèé êàáèíåò.")
		end
      },
	  {
        title = '{ffffff}» Îñìîòð ó îêóëèñòà.',
        onclick = function()
        sampSendChat("Äîáðûé äåíü, ïðèñàæèâàéòåñü íà ñòóë.")
        wait(3000) 
        sampSendChat("/do Íà ñòåíå ñïåö.òàáåëü.")
        wait(3000) 
        sampSendChat("/me ïîêàçûâàåò íà áóêâó 'Ê'")
        wait(3000) 
        sampSendChat("Êàêàÿ ýòî áóêâà?")
		wait(10000) 
        sampSendChat("/me ïîêàçûâàåò íà áóêâó 'Ì'")
		wait(3000) 
        sampSendChat("Êàêóþ áóêâó âû âèäèòå?")
		wait(10000) 
        sampSendChat("/me ïîêàçûâàåò íà ôèãóðêó 'Åëî÷êà'")
		wait(3000) 
        sampSendChat("×òî âû âèäèòå?")
		wait(10000) 
        sampSendChat("/me ïîêàçûâàåò íà ôèãóðêó 'Ìÿ÷èê'")
		wait(3000) 
        sampSendChat("Íà ÷òî ÿ âàì ïîêàçûâàþ?")
		wait(10000) 
        sampSendChat("/me çàïèñàë ðåçóëüòàòû â ìåä.êàðòó")
		wait(3000) 
        sampSendChat("/me ïåðåäàë ìåä.êàðòó")
		wait(3000) 
        sampSendChat("Âñå õîðîøî, âû çäîðîâû. Ïðîõîäèòå äàëüøå.")
		end
      },
	  {
        title = '{5b83c2}« Îñìîòð ó Ïñèõîëîãà (ëþáûå âîïðîñû íà ñâîé âûáîð ïî ïñèõîëîãèè). »',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}» Ãëàâíûé îñìîòð (ïîñëåäíèé ïóíêò).',
        onclick = function()
        sampSendChat("Äîáðûé äåíü, âû ïðîøëè âñåõ ñïåöèàëèñòîâ?")
        wait(3000) 
        sampSendChat("Äàéòå ìíå âàøó ìåä.êàðòó äëÿ îçíàêîìëåíèÿ.")
        wait(3000) 
        sampSendChat("/do Â ðóêàõ ìåä.êàðòà.")
        wait(3000) 
        sampSendChat("/me ïîñìîòðåë ðåçóëüòàòû")
        wait(3000) 
        sampSendChat("/me ïîñòàâèë äèàãíîç Ãîäåí")
        wait(3000) 
        sampSendChat("/me îáíîâèë äàííûå ìåä.êàðòû")
        wait(3000) 
        sampSendChat("/do Â ðóêàõ ðó÷êà è ñïðàâêà.")
        wait(3000) 
        sampSendChat("/me âûïèñàë ñïðàâêó ñ äèàãíîçîì")
        wait(3000) 
        sampSendChat("/me ïåðåäàë ñïðàâêó")
        wait(3000) 
        sampSendChat("Âñåãî äîáðîãî.") 
		end
      },
	 }
end
function renmenu(args)
    return
    {
      {
        title = '{5b83c2}« Ñïèñîê ïðîöåäóð. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ðåíòãåíîâñêèé àïïàðàò.',
        onclick = function()
        sampSendChat("Ëîæèòåñü íà êóøåòêó è ëåæèòå ñìèðíî.")
        wait(3000) 
        sampSendChat("/me âêëþ÷èë ðåíòãåíîâñêèé àïïàðàò")
        wait(3000) 
        sampSendChat("/do Ðåíòãåíîâñêèé àïïàðàò çàøóìåë.")
        wait(3000) 
        sampSendChat("/me ïðîâåë ðåíòãåíîâñêèì àïïàðàòîì ïî ïîâðåæäåííîìó ó÷àñòêó")
        wait(3000) 
        sampSendChat("/me ðàññìàòðèâàåò ñíèìîê")
        wait(3000) 
        sampSendChat("/try îáíàðóæèë ïåðåëîì") 
		end
      },
      {
        title = '{5b83c2}« Åñëè ó ïàöèåíòà ïåðåëîì êîíå÷íîñòåé. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ïåðåëîì êîíå÷íîñòåé.',
        onclick = function()
        sampSendChat("Ñàäèòåñü íà êóøåòêó.")
        wait(3000) 
        sampSendChat("/me âçÿë ñî ñòîëà ïåð÷àòêè è íàäåë èõ")
        wait(3000) 
        sampSendChat("/do Ðåíòãåíîâñêèé àïïàðàò çàøóìåë.")
        wait(3000) 
        sampSendChat("/me âçÿë øïðèö ñ îáåçáàëèâàþùèì, ïîñëå ÷åãî îáåçáîëèë ïîâðåæäåííûé ó÷àñòîê")
        wait(3000) 
        sampSendChat("/me ïðîâåë ðåïîçèöèþ ïîâðåæäåííîãî ó÷àñòêà")
        wait(3000) 
        sampSendChat("/me ïîäãîòîâèë ãèïñîâûé ïîðîîøîê")
        wait(3000) 
        sampSendChat("/me ðàñêàòèë áèíò âäîëü ñòîëà, ïîñëå ÷åãî âòåð ãèïñîâûé ðàñòâîð")
        wait(3000) 
        sampSendChat("/me ñâåðíóë áèíò, ïîñëå ÷åãî çàôèêñèðîâàë ïåðåëîì")
        wait(3000) 
        sampSendChat("Ïðèõîäèòå ÷åðåç ìåñÿö. Âñåãî äîáðîãî.")
        wait(3000) 
        sampSendChat("/me ñíÿë ïåð÷àòêè è áðîñèë èõ â óðíó âîçëå ñòîëà") 
		end
      },
      {
        title = '{5b83c2}« Åñëè ó ïàöèåíòà ïåðåëîì ïîçâîíî÷íèêà/ðåáåð. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ïåðåëîì ïîçâîíî÷íèêà/ðåáåð.',
        onclick = function()
        sampSendChat("/me îñòîðîæíî óêëàë ïîñòðàäàâøåãî íà îïåðàöèîííûé ñòîë")
        wait(3000) 
        sampSendChat("/me âçÿë ñî ñòîëà ïåð÷àòêè è íàäåë èõ")
        wait(3000) 
        sampSendChat("/me ïîäêëþ÷èë ïîñòðàäàâøåãî ê êàïåëüíèöå")
        wait(3000) 
        sampSendChat("/me íàìî÷èë âàòêó ñïèðòîì è îáðàáîòàë êîæó íà ðóêå ïàöèåíòà")
        wait(3000) 
        sampSendChat("/me âíóòðèâåííî ââåë Ôòîðîòàí")
        wait(3000) 
        sampSendChat("/do Íàðêîç íà÷èíàåò äåéñòâîâàòü, ïàöèåíò ïîòåðÿë ñîçíàíèå.")
        wait(3000) 
        sampSendChat("/me äîñòàë ñêàëüïåëü è ïèíöåò")
        wait(3000) 
        sampSendChat("/me ñ ïîìîùüþ ðàçëè÷íûõ èíñòðóìåíòîâ ïðîèçâåë ðåïîçèöèþ ïîâðåæäåííîãî ó÷àñòêà")
        wait(3000) 
        sampSendChat("/me äîñòàë èç òóìáî÷êè ñïåöèàëüíûé êîðñåò")
        wait(3000) 
        sampSendChat("/me çàôèêñèðîâàë ïîâðåæäåííûé ó÷àñòîê ñ ïîìîùüþ êàðñåòà")
        wait(3000) 
        sampSendChat("/me ñíÿë ïåð÷àòêè è áðîñèë èõ â óðíó âîçëå ñòîëà")
        wait(3000) 
        sampSendChat("/me óáðàë â îòäåëüíûé êîíòåéíåð ãðÿçíûé èíñòðóìåíòàðèé")
        wait(3000) 
        sampSendChat("/do Ïðîøëî íåêîòîðîå âðåìÿ, ïàöèåíò ïðèøåë â ñîçíàíèå.") 
		end
      },
      {
        title = '{5b83c2}« Åñëè ó ïàöèåíòà ãëóáîêèé ïîðåç. »',
        onclick = function()
        end
      },
      {
        title = '{ffffff}» Ãëóáîêèé ïîðåç.',
        onclick = function()
        sampSendChat("/me âçÿë ñî ñòîëà ïåð÷àòêè è íàäåë èõ")
        wait(3000) 
        sampSendChat("/me ïðîâåë îñìîòð ïàöèåíòà")
        wait(3000) 
        sampSendChat("/me îïðåäåëèë ñòåïåíü òÿæåñòè ïîðåçà ó ïàöèåíòà")
        wait(3000) 
        sampSendChat("/me îáåçáîëèë ïîâðåæäåííûé ó÷àñòîê")
        wait(3000) 
        sampSendChat("/me äîñòàë èç ìåä. ñóìêè æãóò è íàëîæèë åãî ïîâåðõ ïîâðåæäåíèÿ")
        wait(3000) 
        sampSendChat("/me ðàçëîæèë õèðóðãè÷åñêèå èíñòðóìåíòû íà ñòîëå")
        wait(3000) 
        sampSendChat("/me âçÿë ñïåöèàëüíûå èãëó è íèòè")
        wait(3000) 
        sampSendChat("/me çàøèë êðîâåíîñíûé ñîñóä è ïðîâåðèë ïóëüñ")
        wait(3000) 
        sampSendChat("/me ïðîòåð êðîâü è çàøèë ìåñòî ïîðåçà")
        wait(3000) 
        sampSendChat("/me îòëîæèë èãëó è íèòè â ñòîðîíó")
        wait(3000) 
        sampSendChat("/me ñíÿë æãóò, âçÿë áèíòû è ïåðåáèíòîâàë ïîâðåæäåííûé ó÷àñòîê êîæè")
        wait(3000) 
        sampSendChat("Äî ñâàäüáû çàæèâåò, óäà÷íîãî äíÿ, íå áîëåéòå.")
        wait(3000) 
        sampSendChat("/me óáðàë â îòäåëüíûé êîíòåéíåð ãðÿçíûé èíñòðóìåíòàðèé") 
		end
      },
    }
end
function priziv(id)
    return
    {
	  {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		sampSendChat("Äîáðîãî âðåìåíè ñóòîê, ïðèâåòñòâóþ âàñ íà ïðèçûâå.")
        wait(2000)
		sampSendChat("Áóäüòå äîáðû ïðåäîñòàâèòü ïàñïîðò ïîòâåðæäàþùèå âàøó ëè÷íîñòü.")
        wait(2000)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîâåðêà äîêóìåíòîâ.',
        onclick = function()
		sampSendChat("/me ïðîòÿíóë ëåâóþ ðóêó è âçÿë ïàñïîðò ó ÷åëîâåêà íà ïðîòèâ.")
        wait(3000)
		sampSendChat("/do Ïàñïîðò â ëåâîé ðóêå.")
        wait(3000)
		sampSendChat("/me îòêðûë ïàñïîðò íà íóæíîé ñòðàíèöå è çàïîìíèë äàííûå ÷åëîâåêà.")
        wait(3000)
		sampSendChat("/me çàêðûë ïàñïîðò.")
        wait(3000)
		sampSendChat("/do Ïàñïîðò çàêðûò.")
        wait(3000)
		sampSendChat("/me âåðíóë ïàñïîðò ÷åëîâåêó íà ïðîòèâ.")
        wait(3000)
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîâåðêà íà ïðèçûâå.',
        onclick = function()
		sampSendChat("- Õîðîøî. Ñåé÷àñ ìû ïðîâåðèì âàñ íà íàëè÷èå íàðêîçàâèñèìîñòè.")
        wait(3000)
        sampSendChat("/do ×åðåç ïëå÷î âðà÷à íàêèíóòà ìåä.ñóìêà íà ðåìíå.")
        wait(3000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ñïåöèàëüíóþ êîëáî÷êó")
        wait(3000)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(3000)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(3000)
        sampSendChat('/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(3000)
        sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà")
        wait(3000)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó, çàòåì ïîìåñòèë å¸ â ìèíè-ëàáîðàòîðèþ")
        wait(1300)
		sampSendChat("/checkheal "..id)
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Ãîäåí.',
        onclick = function()
		sampSendChat('/do Íà ýêðàíå ïîêàçàí îòðèöàòåëüíûé ðåçóëüòàò òåñòà êðîâè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me âûïèñàë ñïðàâêó î òîì, ÷òî ïàöèåíò íå èìååò íàðêîçàâèñèìîñòè è ãîäåí ê ñëóæáå.")
        wait(3000)
		sampSendChat("/me ïåðåäàë ñïðàâêó ïàöèåíòó â ðóêè")
		wait(3000)
		sampSendChat("/do Ïðîòÿíóòà ïðàâàÿ ðóêà ñî ñïðàâêîé.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Íå ãîäåí',
        onclick = function()
		sampSendChat('/do Íà ýêðàíå ïîêàçàí ïîëîæèòåëüíûé ðåçóëüòàò òåñòà êðîâè '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("Âû èìååòå íàðêîçàâèñèìîñòü. Ïðîéäèòå ñåàíñ îò çàâèñèìîñòè ó Íàðêîëîãà.")
        wait(3000)
		sampSendChat("/me ïîñòàâèë ïå÷àòü 'Íå ãîäåí' íà ìåä.êàðòó ïðèçûâíèêà")
		end
      }
    }
end
function virus(id)
    return
    {
	  {
        title = '{80a4bf}» {ffffff}Ïðèâåòñòâèå.',
        onclick = function()
		sampSendChat("Äîáðûé äåíü,ñåé÷àñ ìû ïðîâåäåì âàì òåñò íà âèðóñ.")
        wait(7000)
		sampSendChat("Âû íå ïðîòèâ åñëè ÿ âàì çàäàì íåñêîëüêî âîïðîñîâ?")
        wait(10000)
		sampSendChat("Áûëè ëè ó âàñ ñèìïîìû â äàííîì ìåñÿöå, òàêèå êàê ãîëîâîêðóæåíèå, òîøíîòà, ñîíëèâîñòü?")
        wait(15000)
		sampSendChat("Õîðîøî.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîâåðêà òåìïåðàòóðû.',
        onclick = function()
		sampSendChat("/do Íà ïîëó ñòîèò Ìåäèöèíñêàÿ ñóìêà.")
        wait(10000)
        sampSendChat("/me îòêðûë ìåä.ñóìêó .")
        wait(10000)
        sampSendChat("/do Ìåä.ñóìêà îòêðûòà.")
        wait(10000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè ýëåêòðîííûé ãðàäóñíèê.")
        wait(10000)
        sampSendChat("/do Ýëåêòðîííûé ãðàäóñíèê â ëåâîé ðóêå.")
        wait(10000)
        sampSendChat("/me ïåðåäàë ýëåêòðîííûé ãðàäóñíèê ÷åëîâåêó íà ïðîòèâ.")
        wait(10000)
        sampSendChat("Âîçüìèòå, ãðàäóñíèê è ïîñòàâüòå åãî ïîä ïîäìûøêó.")
        wait(10000)
        sampSendChat("Õîðîøî, äàâàéòå íåìíîãî ïîäîæäåì.")
        wait(10000)
        sampSendChat("Âñå äàâàéòå ãðàäóñíèê ìíå.")
        wait(10000)
        sampSendChat("/me âçÿë ãðàäóñíèê ó ÷åëîâåêà íà ïðîòèâ è ïîñìîòðåë òåìïåðàòóðó.")
        wait(10000)
        sampSendChat("/do Òåìïåðàòóðà 36.6.")
        wait(10000)
        sampSendChat("Õîðîøî, ñ òåìïåðàòóðîé ó âàñ âñå õîðîøî.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff}Ïðîâåðêà òåìïåðàòóðû (åñëè íåìíîãî çàáîëåë).',
        onclick = function()
		sampSendChat("/do Íà ïîëó ñòîèò Ìåäèöèíñêàÿ ñóìêà.")
        wait(10000)
        sampSendChat("/me îòêðûë ìåä.ñóìêó .")
        wait(10000)
        sampSendChat("/do Ìåä.ñóìêà îòêðûòà.")
        wait(10000)
        sampSendChat("/me äîñòàë èç ìåä.ñóìêè ýëåêòðîííûé ãðàäóñíèê.")
        wait(10000)
        sampSendChat("/do Ýëåêòðîííûé ãðàäóñíèê â ëåâîé ðóêå.")
        wait(10000)
        sampSendChat("/me ïåðåäàë ýëåêòðîííûé ãðàäóñíèê ÷åëîâåêó íà ïðîòèâ.")
        wait(10000)
        sampSendChat("Âîçüìèòå, ãðàäóñíèê è ïîñòàâüòå åãî ïîä ïîäìûøêó.")
        wait(10000)
        sampSendChat("Õîðîøî, äàâàéòå íåìíîãî ïîäîæäåì.")
        wait(10000)
        sampSendChat("Âñå äàâàéòå ãðàäóñíèê ìíå.")
        wait(10000)
        sampSendChat("/me âçÿë ãðàäóñíèê ó ÷åëîâåêà íà ïðîòèâ è ïîñìîòðåë òåìïåðàòóðó.")
        wait(10000)
        sampSendChat("/do Òåìïåðàòóðà 36.7.")
        wait(10000)
        sampSendChat("Ïîõîäó âû íåìíîæêî ïðîñòóäèëèñü, íî â ýòîì íåò íè÷åãî ñòðàøíîãî.")
		end
      },
	  {
        title = '{80a4bf}» {ffffff} Âçÿòèå êðîâè',
        onclick = function()
		sampSendChat("/me äîñòàë èç ìåä.ñóìêè âàòó, ñïèðò, øïðèö è ñïåöèàëüíóþ êîëáî÷êó.")
        wait(10000)
        sampSendChat("/me ïðîïèòàë âàòó ñïèðòîì")
        wait(10000)
        sampSendChat("/do Ïðîïèòàííàÿ ñïèðòîì âàòà â ëåâîé ðóêå.")
        wait(10000)
        sampSendChat('/me îáðàáîòàë âàòîé ìåñòî óêîëà íà âåíå ïàöèåíòà.')
        wait(10000)
        sampSendChat("/do Øïðèö è ñïåöèàëüíàÿ êîëáî÷êà â ïðàâîé ðóêå.")
        wait(10000)
        sampSendChat('/me àêêóðàòíûì äâèæåíèåì ââîäèò øïðèö â âåíó.')
        wait(10000)
        sampSendChat("/me ñ ïîìîùüþ øïðèöà âçÿë íåìíîãî êðîâè äëÿ àíàëèçà.")
        wait(10000)
        sampSendChat("/me ïåðåëèë êðîâü èç øïðèöà â ñïåöèàëüíóþ êîëáó.")
        wait(10000)
        sampSendChat("/me çàêðûë êîëáó êðûøêîé.")
        wait(10000)
        sampSendChat("Ãîòîâî, òåïåðü îæèäàéòå ðåçóëüòàòû àíàëèçà.")
        wait(10000)
		end
      }
    }
end
function getFraktionBySkin(playerid)
    fraks = {
        [0] = 'Ãðàæäàíñêèé',
        [1] = 'Ãðàæäàíñêèé',
        [2] = 'Ãðàæäàíñêèé',
        [3] = 'Ãðàæäàíñêèé',
        [4] = 'Ãðàæäàíñêèé',
        [5] = 'Ãðàæäàíñêèé',
        [6] = 'Ãðàæäàíñêèé',
        [7] = 'Ãðàæäàíñêèé',
        [8] = 'Ãðàæäàíñêèé',
        [9] = 'Ãðàæäàíñêèé',
        [10] = 'Ãðàæäàíñêèé',
        [11] = 'Ãðàæäàíñêèé',
        [12] = 'Ãðàæäàíñêèé',
        [13] = 'Ãðàæäàíñêèé',
        [14] = 'Ãðàæäàíñêèé',
        [15] = 'Ãðàæäàíñêèé',
        [16] = 'Ãðàæäàíñêèé',
        [17] = 'Ãðàæäàíñêèé',
        [18] = 'Ãðàæäàíñêèé',
        [19] = 'Ãðàæäàíñêèé',
        [20] = 'Ãðàæäàíñêèé',
        [21] = 'Ballas',
        [22] = 'Ãðàæäàíñêèé',
        [23] = 'Ãðàæäàíñêèé',
        [24] = 'Ãðàæäàíñêèé',
        [25] = 'Ãðàæäàíñêèé',
        [26] = 'Ãðàæäàíñêèé',
        [27] = 'Ãðàæäàíñêèé',
        [28] = 'Ãðàæäàíñêèé',
        [29] = 'Ãðàæäàíñêèé',
        [30] = 'Rifa',
        [31] = 'Ãðàæäàíñêèé',
        [32] = 'Ãðàæäàíñêèé',
        [33] = 'Ãðàæäàíñêèé',
        [34] = 'Ãðàæäàíñêèé',
        [35] = 'Ãðàæäàíñêèé',
        [36] = 'Ãðàæäàíñêèé',
        [37] = 'Ãðàæäàíñêèé',
        [38] = 'Ãðàæäàíñêèé',
        [39] = 'Ãðàæäàíñêèé',
        [40] = 'Ãðàæäàíñêèé',
        [41] = 'Aztec',
        [42] = 'Ãðàæäàíñêèé',
        [43] = 'Ãðàæäàíñêèé',
        [44] = 'Aztec',
        [45] = 'Ãðàæäàíñêèé',
        [46] = 'Ãðàæäàíñêèé',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = 'Ãðàæäàíñêèé',
        [50] = 'Ãðàæäàíñêèé',
        [51] = 'Ãðàæäàíñêèé',
        [52] = 'Ãðàæäàíñêèé',
        [53] = 'Ãðàæäàíñêèé',
        [54] = 'Ãðàæäàíñêèé',
        [55] = 'Ãðàæäàíñêèé',
        [56] = 'Grove',
        [57] = 'Ìýðèÿ',
        [58] = 'Ãðàæäàíñêèé',
        [59] = 'Àâòîøêîëà',
        [60] = 'Ãðàæäàíñêèé',
        [61] = 'Àðìèÿ',
        [62] = 'Ãðàæäàíñêèé',
        [63] = 'Ãðàæäàíñêèé',
        [64] = 'Ãðàæäàíñêèé',
        [65] = 'Ãðàæäàíñêèé', -- íàä ïîäóìàòü
        [66] = 'Ãðàæäàíñêèé',
        [67] = 'Ãðàæäàíñêèé',
        [68] = 'Ãðàæäàíñêèé',
        [69] = 'Ãðàæäàíñêèé',
        [70] = 'ÌÎÍ',
        [71] = 'Ãðàæäàíñêèé',
        [72] = 'Ãðàæäàíñêèé',
        [73] = 'Army',
        [74] = 'Ãðàæäàíñêèé',
        [75] = 'Ãðàæäàíñêèé',
        [76] = 'Ãðàæäàíñêèé',
        [77] = 'Ãðàæäàíñêèé',
        [78] = 'Ãðàæäàíñêèé',
        [79] = 'Ãðàæäàíñêèé',
        [80] = 'Ãðàæäàíñêèé',
        [81] = 'Ãðàæäàíñêèé',
        [82] = 'Ãðàæäàíñêèé',
        [83] = 'Ãðàæäàíñêèé',
        [84] = 'Ãðàæäàíñêèé',
        [85] = 'Ãðàæäàíñêèé',
        [86] = 'Grove',
        [87] = 'Ãðàæäàíñêèé',
        [88] = 'Ãðàæäàíñêèé',
        [89] = 'Ãðàæäàíñêèé',
        [90] = 'Ãðàæäàíñêèé',
        [91] = 'Ãðàæäàíñêèé', -- ïîä âîïðîñîì
        [92] = 'Ãðàæäàíñêèé',
        [93] = 'Ãðàæäàíñêèé',
        [94] = 'Ãðàæäàíñêèé',
        [95] = 'Ãðàæäàíñêèé',
        [96] = 'Ãðàæäàíñêèé',
        [97] = 'Ãðàæäàíñêèé',
        [98] = 'Ìýðèÿ',
        [99] = 'Ãðàæäàíñêèé',
        [100] = 'Áàéêåð',
        [101] = 'Ãðàæäàíñêèé',
        [102] = 'Ballas',
        [103] = 'Ballas',
        [104] = 'Ballas',
        [105] = 'Grove',
        [106] = 'Grove',
        [107] = 'Grove',
        [108] = 'Vagos',
        [109] = 'Vagos',
        [110] = 'Vagos',
        [111] = 'RM',
        [112] = 'RM',
        [113] = 'LCN',
        [114] = 'Aztec',
        [115] = 'Aztec',
        [116] = 'Aztec',
        [117] = 'Yakuza',
        [118] = 'Yakuza',
        [119] = 'Rifa',
        [120] = 'Yakuza',
        [121] = 'Ãðàæäàíñêèé',
        [122] = 'Ãðàæäàíñêèé',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = 'Ãðàæäàíñêèé',
        [129] = 'Ãðàæäàíñêèé',
        [130] = 'Ãðàæäàíñêèé',
        [131] = 'Ãðàæäàíñêèé',
        [132] = 'Ãðàæäàíñêèé',
        [133] = 'Ãðàæäàíñêèé',
        [134] = 'Ãðàæäàíñêèé',
        [135] = 'Ãðàæäàíñêèé',
        [136] = 'Ãðàæäàíñêèé',
        [137] = 'Ãðàæäàíñêèé',
        [138] = 'Ãðàæäàíñêèé',
        [139] = 'Ãðàæäàíñêèé',
        [140] = 'Ãðàæäàíñêèé',
        [141] = 'FBI',
        [142] = 'Ãðàæäàíñêèé',
        [143] = 'Ãðàæäàíñêèé',
        [144] = 'Ãðàæäàíñêèé',
        [145] = 'Ãðàæäàíñêèé',
        [146] = 'Ãðàæäàíñêèé',
        [147] = 'Ìýðèÿ',
        [148] = 'Ãðàæäàíñêèé',
        [149] = 'Grove',
        [150] = 'Ìýðèÿ',
        [151] = 'Ãðàæäàíñêèé',
        [152] = 'Ãðàæäàíñêèé',
        [153] = 'Ãðàæäàíñêèé',
        [154] = 'Ãðàæäàíñêèé',
        [155] = 'Ãðàæäàíñêèé',
        [156] = 'Ãðàæäàíñêèé',
        [157] = 'Ãðàæäàíñêèé',
        [158] = 'Ãðàæäàíñêèé',
        [159] = 'Ãðàæäàíñêèé',
        [160] = 'Ãðàæäàíñêèé',
        [161] = 'Ãðàæäàíñêèé',
        [162] = 'Ãðàæäàíñêèé',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = 'Ãðàæäàíñêèé',
        [168] = 'Ãðàæäàíñêèé',
        [169] = 'Yakuza',
        [170] = 'Ãðàæäàíñêèé',
        [171] = 'Ãðàæäàíñêèé',
        [172] = 'Ãðàæäàíñêèé',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = 'Ãðàæäàíñêèé',
        [177] = 'Ãðàæäàíñêèé',
        [178] = 'Ãðàæäàíñêèé',
        [179] = 'Army',
        [180] = 'Ãðàæäàíñêèé',
        [181] = 'Áàéêåð',
        [182] = 'Ãðàæäàíñêèé',
        [183] = 'Ãðàæäàíñêèé',
        [184] = 'Ãðàæäàíñêèé',
        [185] = 'Ãðàæäàíñêèé',
        [186] = 'Yakuza',
        [187] = 'Ìýðèÿ',
        [188] = 'ÑÌÈ',
        [189] = 'Ãðàæäàíñêèé',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = 'Ãðàæäàíñêèé',
        [193] = 'Aztec',
        [194] = 'Ãðàæäàíñêèé',
        [195] = 'Ballas',
        [196] = 'Ãðàæäàíñêèé',
        [197] = 'Ãðàæäàíñêèé',
        [198] = 'Ãðàæäàíñêèé',
        [199] = 'Ãðàæäàíñêèé',
        [200] = 'Ãðàæäàíñêèé',
        [201] = 'Ãðàæäàíñêèé',
        [202] = 'Ãðàæäàíñêèé',
        [203] = 'Ãðàæäàíñêèé',
        [204] = 'Ãðàæäàíñêèé',
        [205] = 'Ãðàæäàíñêèé',
        [206] = 'Ãðàæäàíñêèé',
        [207] = 'Ãðàæäàíñêèé',
        [208] = 'Yakuza',
        [209] = 'Ãðàæäàíñêèé',
        [210] = 'Ãðàæäàíñêèé',
        [211] = 'ÑÌÈ',
        [212] = 'Ãðàæäàíñêèé',
        [213] = 'Ãðàæäàíñêèé',
        [214] = 'LCN',
        [215] = 'Ãðàæäàíñêèé',
        [216] = 'Ãðàæäàíñêèé',
        [217] = 'ÑÌÈ',
        [218] = 'Ãðàæäàíñêèé',
        [219] = 'ÌÎÍ',
        [220] = 'Ãðàæäàíñêèé',
        [221] = 'Ãðàæäàíñêèé',
        [222] = 'Ãðàæäàíñêèé',
        [223] = 'LCN',
        [224] = 'Ãðàæäàíñêèé',
        [225] = 'Ãðàæäàíñêèé',
        [226] = 'Rifa',
        [227] = 'Ìýðèÿ',
        [228] = 'Ãðàæäàíñêèé',
        [229] = 'Ãðàæäàíñêèé',
        [230] = 'Ãðàæäàíñêèé',
        [231] = 'Ãðàæäàíñêèé',
        [232] = 'Ãðàæäàíñêèé',
        [233] = 'Ãðàæäàíñêèé',
        [234] = 'Ãðàæäàíñêèé',
        [235] = 'Ãðàæäàíñêèé',
        [236] = 'Ãðàæäàíñêèé',
        [237] = 'Ãðàæäàíñêèé',
        [238] = 'Ãðàæäàíñêèé',
        [239] = 'Ãðàæäàíñêèé',
        [240] = 'Àâòîøêîëà',
        [241] = 'Ãðàæäàíñêèé',
        [242] = 'Ãðàæäàíñêèé',
        [243] = 'Ãðàæäàíñêèé',
        [244] = 'Ãðàæäàíñêèé',
        [245] = 'Ãðàæäàíñêèé',
        [246] = 'Áàéêåð',
        [247] = 'Áàéêåð',
        [248] = 'Áàéêåð',
        [249] = 'Ãðàæäàíñêèé',
        [250] = 'ÑÌÈ',
        [251] = 'Ãðàæäàíñêèé',
        [252] = 'Army',
        [253] = 'Ãðàæäàíñêèé',
        [254] = 'Áàéêåð',
        [255] = 'Army',
        [256] = 'Ãðàæäàíñêèé',
        [257] = 'Ãðàæäàíñêèé',
        [258] = 'Ãðàæäàíñêèé',
        [259] = 'Ãðàæäàíñêèé',
        [260] = 'Ãðàæäàíñêèé',
        [261] = 'ÑÌÈ',
        [262] = 'Ãðàæäàíñêèé',
        [263] = 'Ãðàæäàíñêèé',
        [264] = 'Ãðàæäàíñêèé',
        [265] = 'Ïîëèöèÿ',
        [266] = 'Ïîëèöèÿ',
        [267] = 'Ïîëèöèÿ',
        [268] = 'Ãðàæäàíñêèé',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = 'Ãðàæäàíñêèé', -- íàäî ïîäóìàòü
        [274] = 'ÌÎÍ',
        [275] = 'ÌÎÍ',
        [276] = 'ÌÎÍ',
        [277] = 'Ãðàæäàíñêèé',
        [278] = 'Ãðàæäàíñêèé',
        [279] = 'Ãðàæäàíñêèé',
        [280] = 'Ïîëèöèÿ',
        [281] = 'Ïîëèöèÿ',
        [282] = 'Ïîëèöèÿ',
        [283] = 'Ïîëèöèÿ',
        [284] = 'Ïîëèöèÿ',
        [285] = 'Ïîëèöèÿ',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = 'Ïîëèöèÿ',
        [289] = 'Ãðàæäàíñêèé',
        [290] = 'Ãðàæäàíñêèé',
        [291] = 'Ãðàæäàíñêèé',
        [292] = 'Aztec',
        [293] = 'Ãðàæäàíñêèé',
        [294] = 'Ãðàæäàíñêèé',
        [295] = 'Ãðàæäàíñêèé',
        [296] = 'Ãðàæäàíñêèé',
        [297] = 'Grove',
        [298] = 'Ãðàæäàíñêèé',
        [299] = 'Ãðàæäàíñêèé',
        [300] = 'Ïîëèöèÿ',
        [301] = 'Ïîëèöèÿ',
        [302] = 'Ïîëèöèÿ',
        [303] = 'Ïîëèöèÿ',
        [304] = 'Ïîëèöèÿ',
        [305] = 'Ïîëèöèÿ',
        [306] = 'Ïîëèöèÿ',
        [307] = 'Ïîëèöèÿ',
        [308] = 'ÌÎÍ',
        [309] = 'Ïîëèöèÿ',
        [310] = 'Ïîëèöèÿ',
        [311] = 'Ïîëèöèÿ'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function a.onSendClickPlayer(id)
	if rank == 'Ñòàæåð' or rank == 'Êîíñóëüòàíò' or rank == 'Ìë.Èíñòðóêòîð' or rank == 'Èíñòðóêòîð' or rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or rank == 'Ãëàâ.Âðà÷' then
    setClipboardText(sampGetPlayerNickname(id))
	ftext('Íèê ñêîïèðîâàí â áóôåð îáìåíà.')
	else
	end
end

function smsjob()
  if rank == 'Äîêòîð' or rank == 'Ïñèõîëîã' or rank == 'Õèðóðã' or rank == 'Çàì.Ãëàâ.Âðà÷à' or  rank == 'Ãëàâ.Âðà÷' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' Ïðèâåòñòâóþ, ÿâèòåñü íà ðàáîòó, ó âàñ 15 ìèíóò')
            wait(1200)
        end
        players2 = {'{ffffff}Íèê\t{ffffff}Ðàíã\t{ffffff}Ñòàòóñ'}
		players1 = {'{ffffff}Íèê\t{ffffff}Ðàíã'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else
	ftext('Äàííàÿ êîìàíäà äîñòóïíà ñ äîëæíîñòè Ïñèõîëîã.')
	end
end

function update()
    local updatePath = os.getenv('TEMP')..'\\Update.json'
    -- Ïðîâåðêà íîâîé âåðñèè
    downloadUrlToFile("https://raw.githubusercontent.com/RanchoGrief/medichelper/main/Update.json", updatePath, function(id, status, p1, p2)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local file = io.open(updatePath, 'r')
            if file and doesFileExist(updatePath) then
                local info = decodeJson(file:read("*a"))
                file:close(); os.remove(updatePath)
                if info.version ~= thisScript().version then
                    lua_thread.create(function()
                        wait(2000)
                        -- Çàãðóçêà ñêðèïòà, åñëè âåðñèÿ èçìåíèëàñü
                        downloadUrlToFile("https://raw.githubusercontent.com/RanchoGrief/medichelper/main/Medick_Helper_Rancho_Grief.lua", thisScript().path, function(id, status, p1, p2)
                            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                ftext('Îáíîâëåíèå äî àêòóàëüíîé âåðñèè '..info.version..' îáíàðóæåíî. Íà÷èíàþ óñòàíîâêó.')
                                thisScript():reload()
                            end
                        end)
                    end)
                else
                    ftext('Îáíîâëåíèé íå îáíàðóæåíî èëè îíî òîëüêî ÷òî óñòàíîâëåíî. Àêòóàëüíàÿ âåðñèÿ '..info.version..'.', -1)
                end
            end
        end
    end)
end

function cmd_color() -- ôóíêöèÿ ïîëó÷åíèÿ öâåòà ñòðîêè, õç çà÷åì îíà ìíå, íî êîãäà òî þçàë
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("Öâåò ïîñëåäíåé ñòðîêè ÷àòà - {934054}[%d] (ñêîïèðîâàí â áóôåð îáìåíà).",color),-1)
	setClipboardText(color)
end

function getcolor(id)
local colors =
        {
		[1] = 'Çåë¸íûé',
		[2] = 'Ñâåòëî-çåë¸íûé',
		[3] = 'ßðêî-çåë¸íûé',
		[4] = 'Áèðþçîâûé',
		[5] = 'Æ¸ëòî-çåë¸íûé',
		[6] = 'Òåìíî-çåë¸íûé',
		[7] = 'Ñåðî-çåë¸íûé',
		[8] = 'Êðàñíûé',
		[9] = 'ßðêî-êðàñíûé',
		[10] = 'Îðàíæåâûé',
		[11] = 'Êîðè÷íåâûé',
		[12] = 'Ò¸ìíî-êðàñíûé',
		[13] = 'Ñåðî-êðàñíûé',
		[14] = 'Æ¸ëòî-îðàíæåâûé',
		[15] = 'Ìàëèíîâûé',
		[16] = 'Ðîçîâûé',
		[17] = 'Ñèíèé',
		[18] = 'Ãîëóáîé',
		[19] = 'Ñèíÿÿ ñòàëü',
		[20] = 'Ñèíå-çåë¸íûé',
		[21] = 'Ò¸ìíî-ñèíèé',
		[22] = 'Ôèîëåòîâûé',
		[23] = 'Èíäèãî',
		[24] = 'Ñåðî-ñèíèé',
		[25] = 'Æ¸ëòûé',
		[26] = 'Êóêóðóçíûé',
		[27] = 'Çîëîòîé',
		[28] = 'Ñòàðîå çîëîòî',
		[29] = 'Îëèâêîâûé',
		[30] = 'Ñåðûé',
		[31] = 'Ñåðåáðî',
		[32] = '×åðíûé',
		[33] = 'Áåëûé',
		}
	return colors[id]
end
function sampev.onSendSpawn()
    pX, pY, pZ = getCharCoordinates(playerPed)
    if cfg.main.clistb and getDistanceBetweenCoords3d(pX, pY, pZ, 2337.3574,1666.1699,3040.9524) < 20 then
        lua_thread.create(function()
            wait(1200)
			sampSendChat('/clist '..tonumber(cfg.main.clist))
			wait(500)
			local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
			colors = getcolor(cfg.main.clist)
            ftext('Öâåò íèêà ñìåíåí íà: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end
-- Òåñò dmb n
-- Òåñò dmb z
function sampev.onServerMessage(color, text)
        if text:find('Ðàáî÷èé äåíü íà÷àò') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('Öâåò íèêà ñìåíåí íà: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me îòêðûë øêàô÷èê")
                wait(3000)
                sampSendChat("/me ñíÿë ñâîþ îäåæäó, ïîñëå ÷åãî ñëîæèë åå â øêàô")
                wait(3000)
                sampSendChat("/me âçÿë ðàáî÷óþ îäåæäó, çàòåì ïåðåîäåëñÿ â íåå")
                wait(3000)
                sampSendChat("/me íàöåïèë áåéäæèê íà ðóáàøêó")
                wait(3000)
                sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
				if cfg.main.male == false then
				sampSendChat("/me îòêðûëà øêàô÷èê")
                wait(3000)
                sampSendChat("/me ñíÿëà ñâîþ îäåæäó, ïîñëå ÷åãî ñëîæèëà åå â øêàô")
                wait(3000)
                sampSendChat("/me âçÿëà ðàáî÷óþ îäåæäó, çàòåì ïåðåîäåëàñü â íåå")
                wait(3000)
                sampSendChat("/me íàöåïèëà áåéäæèê íà ðóáàøêó")
                wait(3000)
                sampSendChat('/do Íà ðóáàøêå áåéäæèê ñ íàäïèñüþ "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('Îòïðàâèòåëü:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) Îòïðàâèòåëü: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('Ðàáî÷èé äåíü îêîí÷åí') and color ~= -1 then
        rabden = false
    end
	if text:find('Âû âûëå÷èëè') then
        local Nicks = text:match('Âû âûëå÷èëè èãðîêà (.+).')
		health = health + 1
   end
   	if text:find('Ñåàíñ ëå÷åíèÿ îò íàðêîçàâèñèìîñòè') then
        local Nicks = text:match('Âû âûëå÷èëè èãðîêà (.+) îò íàðêîçàâèñèìîñòè.')
		narkoh = narkoh + 1
   end
	if text:find('Âû âûãíàëè (.+) èç îðãàíèçàöèè. Ïðè÷èíà: (.+).') then
        local un1, un2 = text:match('Âû âûãíàëè (.+) èç îðãàíèçàöèè. Ïðè÷èíà: (.+).')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: %s - óâîëåí ïî ïðè÷èíå "%s".', cfg.main.tarr, un1:gsub('_', ' '), un2))
        else
		sampSendChat(string.format('/r %s - óâîëåí ïî ïðè÷èíå "%s".', un1:gsub('_', ' '), un2))
		end
		end)
    end
	if text:find('ïåðåäàë(- à) óäîñòîâåðåíèå (.+)') then
        local inv1 = text:match('ïåðåäàë(- à) óäîñòîâåðåíèå (.+)')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s íîâûé ñîòðóäíèê êîëëåêòèâà àâòîøêîëû. Ïðèâåòñòâóåì! %s%s', cfg.main.tarr, inv1:gsub('_', ' ')))
        else
		sampSendChat(string.format('/r %s - íîâûé ñîòðóäíèê êîëëåêòèâà àâòîøêîëû. Ïðèâåòñòâóåì! %s%s', inv1:gsub('_', ' ')))
		end
		end)
    end
	if color == -8224086 then
        local colors = ('{%06X}'):format(bit.rshift(color, 8))
        table.insert(departament, os.date(colors..'[%H:%M:%S] ') .. text)
    end
	if color == -1920073984 and (text:match('.+ .+%: .+') or text:match('%(%( .+ .+%: .+ %)%)')) then
            local colors = ("{%06X}"):format(bit.rshift(color, 8))
            table.insert(radio, os.date(colors.."[%H:%M:%S] ") .. text)
        end
	if color == -65366 and (text:match('SMS%: .+. Îòïðàâèòåëü%: .+') or text:match('SMS%: .+. Ïîëó÷àòåëü%: .+')) then
            local colors = ("{%06X}"):format(bit.rshift(color, 8))
            table.insert(smslogs, os.date(colors.."[%H:%M:%S] ") .. text)
        end
	if statusc then
		if text:match('ID: .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, nick, rang, stat = text:match('ID: (%d+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
		    src_good = ""
            src_bad = ""
			local _, myid = sampGetPlayerIdByCharHandle(playerPed)
			local _, handle = sampGetCharHandleBySampPlayerId(id)
			local myname = sampGetPlayerNickname(myid)
				if doesCharExist(handle) then
					local x, y, z = getCharCoordinates(handle)
					local mx, my, mz = getCharCoordinates(PLAYER_PED)
					local dist = getDistanceBetweenCoords3d(mx, my, mz, x, y, z)

					if dist <= 50 then
						src_good = src_good ..sampGetPlayerNickname(id).. ""
					end
					else
						src_bad = src_bad ..sampGetPlayerNickname(id).. ""
			if src_bad ~= myname then
			table.insert(players3, string.format('{'..color..'}%s[%s]{ffffff}\t%s\t%s', src_bad, id, rang, stat))
			return false
		end
		end
		end
		if text:match('Âñåãî: %d+ ÷åëîâåê') then
			local count = text:match('Âñåãî: (%d+) ÷åëîâåê')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
	if status then
		if text:match('ID: .+ | .+ | .+: .+ %- .+') and not fstatus then
			gosmb = true
			local id, data, nick, rang, stat = text:match('ID: (%d+) | (.+) | (.+): (.+) %- (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			local nmrang = rang:match('.+%[(%d+)%]')
            if stat:find('Âûõîäíîé') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('Âñåãî: %d+ ÷åëîâåê') then
			local count = text:match('Âñåãî: (%d+) ÷åëîâåê')
			gcount = count
			gotovo = true
			return false
		end
		if color == -1 then
			return false
		end
		if color == 647175338 then
			return false
        end
        if text:match('ID: .+ | .+: .+') and not fstatus then
			krimemb = true
			local id, nick, rang = text:match('ID: (%d+) | (.+): (.+)')
			local color = ("%06X"):format(bit.band(sampGetPlayerColor(id), 0xFFFFFF))
			table.insert(players1, string.format('{'..color..'}%s[%s]{ffffff}\t%s', nick, id, rang))
			return false
        end
    end
end
function getZones(zone)
    local names = {
      ['SUNMA'] = 'Bayside Marina',
      ['SUNNN'] = 'Bayside',
      ['BATTP'] = 'Battery Point',
      ['PARA'] = 'Paradiso',
      ['CIVI'] = 'Santa Flora',
      ['BAYV'] = 'Palisades',
      ['CITYS'] = 'City Hall',
      ['OCEAF'] = 'Ocean Flats',
      ['HASH'] = 'Hashbury',
      ['JUNIHO'] = 'Juniper Hollow',
      ['ESPN'] = 'Esplanade North',
      ['FINA'] = 'Financial',
      ['CALT'] = 'Calton Heights',
      ['SFDWT'] = 'Downtown',
      ['JUNIHI'] = 'Juniper Hill',
      ['CHINA'] = 'Chinatown',
      ['THEA'] = 'King`s',
      ['GARC'] = 'Garcia',
      ['DOH'] = 'Doherty',
      ['SFAIR'] = 'Easter Bay Airport',
      ['EASB'] = 'Easter Basin',
      ['ESPE'] = 'Esplanade East',
      ['ANGPI'] = 'Angel Pine',
      ['SHACA'] = 'Shady Cabin',
      ['BACKO'] = 'Back o Beyond',
      ['LEAFY'] = 'Leafy Hollow',
      ['FLINTR'] = 'Flint Range',
      ['HAUL'] = 'Fallen Tree',
      ['FARM'] = 'The Farm',
      ['ELQUE'] = 'El Quebrados',
      ['ALDEA'] = 'Aldea Malvada',
      ['DAM'] = 'The Sherman Dam',
      ['BARRA'] = 'Las Barrancas',
      ['CARSO'] = 'Fort Carson',
      ['QUARY'] = 'Hunter Quarry',
      ['OCTAN'] = 'Octane Springs',
      ['PALMS'] = 'Green Palms',
      ['TOM'] = 'Regular Tom',
      ['BRUJA'] = 'Las Brujas',
      ['MEAD'] = 'Verdant Meadows',
      ['PAYAS'] = 'Las Payasadas',
      ['ARCO'] = 'Arco del Oeste',
      ['HANKY'] = 'Hankypanky Point',
      ['PALO'] = 'Palomino Creek',
      ['NROCK'] = 'North Rock',
      ['MONT'] = 'Montgomery',
      ['HBARNS'] = 'Hampton Barns',
      ['FERN'] = 'Fern Ridge',
      ['DILLI'] = 'Dillimore',
      ['TOPFA'] = 'Hilltop Farm',
      ['BLUEB'] = 'Blueberry',
      ['PANOP'] = 'The Panopticon',
      ['FRED'] = 'Frederick Bridge',
      ['MAKO'] = 'The Mako Span',
      ['BLUAC'] = 'Blueberry Acres',
      ['MART'] = 'Martin Bridge',
      ['FALLO'] = 'Fallow Bridge',
      ['CREEK'] = 'Shady Creeks',
      ['WESTP'] = 'Queens',
      ['LA'] = 'Los Santos',
      ['VE'] = 'Las Venturas',
      ['BONE'] = 'Bone County',
      ['ROBAD'] = 'Tierra Robada',
      ['GANTB'] = 'Gant Bridge',
      ['SF'] = 'San Fierro',
      ['RED'] = 'Red County',
      ['FLINTC'] = 'Flint County',
      ['EBAY'] = 'Easter Bay Chemicals',
      ['SILLY'] = 'Foster Valley',
      ['WHET'] = 'Whetstone',
      ['LAIR'] = 'Los Santos International',
      ['BLUF'] = 'Verdant Bluffs',
      ['ELCO'] = 'El Corona',
      ['LIND'] = 'Willowfield',
      ['MAR'] = 'Marina',
      ['VERO'] = 'Verona Beach',
      ['CONF'] = 'Conference Center',
      ['COM'] = 'Commerce',
      ['PER1'] = 'Pershing Square',
      ['LMEX'] = 'Little Mexico',
      ['IWD'] = 'Idlewood',
      ['GLN'] = 'Glen Park',
      ['JEF'] = 'Jefferson',
      ['CHC'] = 'Las Colinas',
      ['GAN'] = 'Ganton',
      ['EBE'] = 'East Beach',
      ['ELS'] = 'East Los Santos',
      ['JEF'] = 'Jefferson',
      ['LFL'] = 'Los Flores',
      ['LDT'] = 'Downtown Los Santos',
      ['MULINT'] = 'Mulholland Intersection',
      ['MUL'] = 'Mulholland',
      ['MKT'] = 'Market',
      ['VIN'] = 'Vinewood',
      ['SUN'] = 'Temple',
      ['SMB'] = 'Santa Maria Beach',
      ['ROD'] = 'Rodeo',
      ['RIH'] = 'Richman',
      ['STRIP'] = 'The Strip',
      ['DRAG'] = 'The Four Dragons Casino',
      ['PINK'] = 'The Pink Swan',
      ['HIGH'] = 'The High Roller',
      ['PIRA'] = 'Pirates in Men`s Pants',
      ['VISA'] = 'The Visage',
      ['JTS'] = 'Julius Thruway South',
      ['JTW'] = 'Julius Thruway West',
      ['RSE'] = 'Rockshore East',
      ['LOT'] = 'Come-A-Lot',
      ['CAM'] = 'The Camel`s Toe',
      ['ROY'] = 'Royal Casino',
      ['CALI'] = 'Caligula`s Palace',
      ['PILL'] = 'Pilgrim',
      ['STAR'] = 'Starfish Casino',
      ['ISLE'] = 'The Emerald Isle',
      ['OVS'] = 'Old Venturas Strip',
      ['KACC'] = 'K.A.C.C. Military Fuels',
      ['CREE'] = 'Creek',
      ['SRY'] = 'Sobell Rail Yards',
      ['LST'] = 'Linden Station',
      ['JTE'] = 'Julius Thruway East',
      ['LDS'] = 'Linden Side',
      ['JTN'] = 'Julius Thruway North',
      ['HGP'] = 'Harry Gold Parkway',
      ['REDE'] = 'Redsands East',
      ['VAIR'] = 'Las Venturas Airport',
      ['LVA'] = 'LVA Freight Depot',
      ['BINT'] = 'Blackfield Intersection',
      ['GGC'] = 'Greenglass College',
      ['BFLD'] = 'Blackfield',
      ['ROCE'] = 'Roca Escalante',
      ['LDM'] = 'Last Dime Motel',
      ['RSW'] = 'Rockshore West',
      ['RIE'] = 'Randolph Industrial Estate',
      ['BFC'] = 'Blackfield Chapel',
      ['PINT'] = 'Pilson Intersection',
      ['WWE'] = 'Whitewood Estates',
      ['PRP'] = 'Prickle Pine',
      ['SPIN'] = 'Spinybed',
      ['SASO'] = 'San Andreas Sound',
      ['FISH'] = 'Fisher`s Lagoon',
      ['GARV'] = 'Garver Bridge',
      ['KINC'] = 'Kincaid Bridge',
      ['LSINL'] = 'Los Santos Inlet',
      ['SHERR'] = 'Sherman Reservoir',
      ['FLINW'] = 'Flint Water',
      ['ETUNN'] = 'Easter Tunnel',
      ['BYTUN'] = 'Bayside Tunnel',
      ['BIGE'] = 'The Big Ear',
      ['PROBE'] = 'Lil` Probe Inn',
      ['VALLE'] = 'Valle Ocultado',
      ['LINDEN'] = 'Linden Station',
      ['UNITY'] = 'Unity Station',
      ['MARKST'] = 'Market Station',
      ['CRANB'] = 'Cranberry Station',
      ['YELLOW'] = 'Yellow Bell Station',
      ['SANB'] = 'San Fierro Bay',
      ['ELCA'] = 'El Castillo del Diablo',
      ['REST'] = 'Restricted Area',
      ['MONINT'] = 'Montgomery Intersection',
      ['ROBINT'] = 'Robada Intersection',
      ['FLINTI'] = 'Flint Intersection',
      ['SFAIR'] = 'Easter Bay Airport',
      ['MKT'] = 'Market',
      ['CUNTC'] = 'Avispa Country Club',
      ['HILLP'] = 'Missionary Hill',
      ['MTCHI'] = 'Mount Chiliad',
      ['YBELL'] = 'Yellow Bell Golf Course',
      ['VAIR'] = 'Las Venturas Airport',
      ['LDOC'] = 'Ocean Docks',
      ['STAR'] = 'Starfish Casino',
      ['BEACO'] = 'Beacon Hill',
      ['GARC'] = 'Garcia',
      ['PLS'] = 'Playa del Seville',
      ['STAR'] = 'Starfish Casino',
      ['RING'] = 'The Clown`s Pocket',
      ['LIND'] = 'Willowfield',
      ['WWE'] = 'Whitewood Estates',
      ['LDT'] = 'Downtown Los Santos'
    }
    if names[zone] == nil then return 'Íå îïðåäåëåíî' end
    return names[zone]
end
function kvadrat()
    local KV = {
        [1] = "À",
        [2] = "Á",
        [3] = "Â",
        [4] = "Ã",
        [5] = "Ä",
        [6] = "Æ",
        [7] = "Ç",
        [8] = "È",
        [9] = "Ê",
        [10] = "Ë",
        [11] = "Ì",
        [12] = "Í",
        [13] = "Î",
        [14] = "Ï",
        [15] = "Ð",
        [16] = "Ñ",
        [17] = "Ò",
        [18] = "Ó",
        [19] = "Ô",
        [20] = "Õ",
        [21] = "Ö",
        [22] = "×",
        [23] = "Ø",
        [24] = "ß",
    }
    local X, Y, Z = getCharCoordinates(playerPed)
    X = math.ceil((X + 3000) / 250)
    Y = math.ceil((Y * - 1 + 3000) / 250)
    Y = KV[Y]
    local KVX = (Y.."-"..X)
    return KVX
end
