script_name('Medick Helper')
script_version '3.9.1'
local dlstatus = require "moonloader".download_status
script_author('Tema_White')
local sf = require 'sampfuncs'
local key = require "vkeys"
local inicfg = require 'inicfg'
local a = require 'samp.events'
local sampev = require 'lib.samp.events'
local imgui = require 'imgui' -- ��������� ����������/
local encoding = require 'encoding' -- ��������� ����������
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
local tCarsTypeName = {"����������", "���������", "�������", "������", "������", "�����", "������", "�����", "���������"}
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
encoding.default = 'CP1251' -- ��������� ��������� �� ���������, ��� ������ ��������� � ���������� �����. CP1251 - ��� Windows-1251
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
players1 = {'{ffffff}���\t{ffffff}����'}
players2 = {'{ffffff}���� ��������\t{ffffff}���\t{ffffff}����\t{ffffff}������'}
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
    tar = '������',
	tarr = '���',
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
	ftext('Medick Helper ��������, �������� ������ ��� ������� Cleveland.',-1)
	ftext('������� ����: Tema White.',-1)
	ftext('������ ������������: Tema White.',-1)
	ftext('������� ������� ������� � ������: /mh (��������� �������), F3 (������� ����) ��� ��� + Z (���������).',-1)
	ftext('������������� ������ ���� ����������, ������������ ������ CTRL + R.',-1)
        ftext('���� �������� �����-���� ������, �������� ����: {7e0059}VK - @artyom.sokolov2022.{7e0059}',-1)
  end
  if not doesDirectoryExist('moonloader/config/medick/') then createDirectory('moonloader/config/medick/') end
  if cfg == nil then
    sampAddChatMessage("{7e0059}Medick Help {7e0059}| ���������� ���� �������, �������.", -1)
    if inicfg.save(medick, 'medick/config.ini') then
      sampAddChatMessage("{7e0059}Medick Help {7e0059}| ���� ������� ������� ������.", -1)
      cfg = inicfg.load(nil, 'medick/config.ini')
    end
  end
  if not doesDirectoryExist('moonloader/lib/imcustom') then createDirectory('moonloader/lib/imcustom') end
  for k, v in pairs(libs) do
        if not doesFileExist('moonloader/lib/'..v) then
            downloadUrlToFile('https://raw.githubusercontent.com/WhackerH/kirya/master/lib/'..v, getWorkingDirectory()..'\\lib\\'..v)
            print('����������� ����������'..v)
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
  local frakc = proverkk:match('.+�����������%s+(.+)%s+���������')
  local rang = proverkk:match('.+���������%s+%d+ %((.+)%)%s+������')
  local telephone = proverkk:match('.+�������%s+(.+)%s+�����������������')
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
  sampCreate3dTextEx(643, '{ffffff}None.{ff0000}���!', 4294927974, 2337.8091,1669.0276,3040.9524, 3, true, -1, -1)
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
                ftext('�� ���������� ������� ������� ��� ���.')
            else
                changetextpos = false
				inicfg.save(cfg, 'medick/config.ini') -- ��������� ��� ����� �������� � �������
            end
        else
            ftext('��� ������ �������� ����-���.')
        end
    end)
  sampRegisterChatCommand('yst', function() ystwindow.v = not ystwindow.v end)
  while true do wait(0)
     datetime = os.date("!*t",os.time()) 
if datetime.min == 00 and datetime.sec == 10 then 
sampAddChatMessage("�� �������� �������� ����� � ���� �� ��������� ������.", -1) 
wait(1000)
end
    if #departament > 25 then table.remove(departament, 1) end
	if #smslogs > 25 then table.remove(smslogs, 1) end
	if #radio > 25 then table.remove(radio, 1) end
    if cfg == nil then
      sampAddChatMessage("{9966cc}Medick Helper {ffffff}| ���������� ���� �������, �������.", -1)
      if inicfg.save(medick, 'medick/config.ini') then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| ���� ������� ������� ������.", -1)
        cfg = inicfg.load(nil, 'medick/config.ini')
      end
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| ������� ����")
    end
	    local myhp = getCharHealth(PLAYER_PED)
        local valid, ped = getCharPlayerIsTargeting(PLAYER_HANDLE)
    if wasKeyPressed(cfg.keys.fastmenu) and not sampIsDialogActive() and not sampIsChatInputActive() then
    submenus_show(fastmenu(id), "{9966cc}Medick Helper {ffffff}| ������� ���������")
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
����� �1, ����� ���������:

� 1.1. ����� ����������� �������� ������������ � ��������� � ���������� ������������ ����������� ��������.
� 1.2. ����� ����������� �������� ����������, ��������������� ��������������� ����� ������������ ����������� �������� � ������������, � ����� ��������� ����������� �������� ��������������� ��������������.
� 1.3. ���������� ������ ������ ����������� �� ����������� �� ���������������.
� 1.4. � ������ ��������� ������ ��� ���������� ������� ������ �����������, � ���������� ����� ���� ��������� �������, �� ��������������� ��������� �� ���������� � ���������� � ������ ������.
� 1.5. ������� �������� ����� �������� ��������� � �������������, � ����������� ��� �� ��������.
� 1.6. ����� ����������� ����� ���������� � ����� ������ ��� ���������������� �����������.
� 1.7. ����� ����������� ����� �������� ������ � ������������ ��� ����������� � ��� ���������� (� �������� �����).
� 1.8. ������ ��������� ����� ����� ������ ����� �� ��������� ����������� �����, ��� ����������� �� �������������.


����� �2, ������ �������� ���:

� 2.1. ������� ����� � ������ ��� (� ������������ �� �������) ����������� � 10:00 �� 21:00.
� 2.2. ������� ����� � �������� ��� (� ������� �� �����������) ����������� � 10:00 �� 20:00.
� 2.3. �� ������� �������� ����� ��� ����������� �����������, ��������� ������ ������� �� ������� ����� � ������� 30 �����.
� 2.4. � ���������� ����������� �����������, ��������� ����� ������ ����� ����� ����� � �������� ������� ������ �� 120 ����� � ���� (�� ��� �� 60).
� 2.5. ������� ���� ����� ������ ����� �� ����� �������� ������ ������� �����.


����� �3, ����������� �����������:

� 3.1. ��������� ������ ��������� ����������� ������, ������������� ����������� ������ �� ������� ��������. ����������: ��������� ����� �������� � �������� ������, ���� ��� ��������� ������������ ��������, � ����� ����� ������� ����������� SAPD.
� 3.2. ���������� ������� ���� ��������� �� ��������� � ���������, � ����� � ����� ��������.
� 3.3. ��������� ������ ������������ ��� ������ � ������ (RP-���������), ����� ������� ������ �������������. ���������: �������������� ��������� ������ �� 7 ����.
� 3.4. ��������� ������ ��������� ���� ������ ��������� �� ��������������� ��� ����� �������� ��������.
� 3.5. ��������� ������ ��������� �������� ������������, �������������� �� ��������. ����������: ������� �� ���������.
� 3.6. �������� ������� �������� � ��������� ��������, ��������� � ���������.
� 3.7. ������� �������������� ������, � ����� ��� ������������� ����������� ������ ����������� �����������.
� 3.8. ������� ����� ����������� �������������� �� ���� ��������� � ���������.


����� �4, ������� �����������:

� 4.1. ����� �� ���������� �� ������� �����, ����������� ���������� ������� �����. ���������: �������������� ��������� ������ �� 7 ����.
� 4.2. ����������� � ������ �������� �� ������� ����� (� �����). ���������: �������������� ��������� ������ �� 7 ���� ��� ��������� � ���������.
� 4.3. ���� � RP-��� (� ��������������� ���������� �������� �������������� �������). ���������: �������������� ��������� ������ �� 7 ���� ��� ��������� � ���������.
� 4.4. ������������� ����� ����������� ����������� ��� �������� �����. ���������: �������������� ��������� ������ �� 7 ����.
� 4.5. ����� ��� ���� � ����������� ����������� �����������. ���������: �������������� ��������� ������ �� 7 ���� ��� ��������� � ���������.
� 4.6. ����� �� ���������� ����� ����������� ������������ (��� �����������). ���������: ��������� � ���������.
� 4.7. ������������� ���������������� ���������� � ������ �����.
� 4.8. ������������ ������������� ����� ������������. ���������: �������������� ��������� ������ �� 7 ����.
� 4.9. ��������� ��������� � ���������� ��� ���������. ���������: �������������� ��������� ������ �� 7 ����.
� 4.10. ������������ ���������. ���������: �������������� ��������� ������ �� 7 ����.
� 4.11. ���������� ����� �� ����� ������. ���������: ��������� � ���������.


����� �5, ��� �����������:

� 5.1. ���������� ������� ����� ������� ������������� �����, � ����� �������� ���� (IC/OOC).
� 5.2. ��� ������ �� �������� ��� �����, ��������� ������ �������� �� ���� �� ����� �����������.
� 5.3. ��� ������� ������-���� �����, ��������� ������ �������� �� ���� �� ����� �����������.
� 5.4. ���������, ���������� �����-���� ����, ������ ����� ������ ������ 5 �����.
� 5.5. ��� ����� �� ����������� ����������� ��� �������� �����, ��������� ������ ������� � ����������� ����� ��� ���������� � ������ � ������� 5-10 �����.


����� �6, ������� ���������:

� 6.1. ������� ��������� � ����������� ����� ��� ������� ����������.
� 6.2. ��� �������� � ������������, ���������� �� ������������������ �������.
� 6.3. ���������� ����� ���� ������������ ����� � ��������� ��� ���������� ������.
� 6.4. ��������� ���� �� ���������� ����������� ����������� � �������� �����.
� 6.5. ����������� ����� �� ����������� ���������.


����� �7, ������� ������� � ��������:

� 7.1. ������ ��������� ����� ������ ����� �������� ������ ��� ������� � ��������� ������������ �����.
� 7.2. ������������ ������� � �������� ���������� �� 14 ����.
� 7.3. ��� �������������, ��������� ����� ���� ������ � �������.
� 7.4. � ������ ���������� � �������, ����������� �������� ������ �����, ��������� � ���������������� ������, � ����� ��������������� �������������.
]]

function dmb()
	lua_thread.create(function()
		status = true
		players2 = {'{ffffff}���� ��������\t{ffffff}���\t{ffffff}����\t{ffffff}������'}
		players1 = {'{ffffff}���\t{ffffff}����'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{ffffff}� ����: "..gcount.." | {ae433d}����������� | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players2, "\n"), "x", _, 5) -- ���������� ����������.
		elseif krimemb then
			sampShowDialog(716, "{ffffff}� ����: "..gcount.." | {ae433d}����������� | {ffffff}Time: "..os.date("%H:%M:%S"), table.concat(players1, "\n"), "x", _, 5) -- ���������� ����������.
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
        sampSendChat(string.format("/d %s, ��������� %s �� %s. ������!", frack, rpname, pric))
    else
        ftext("�������: /blg [id] [�������] [�������]", -1)
		ftext("������: ���������������, �������� �����, � �.�. ", -1)
    end
end

function dmch()
	lua_thread.create(function()
		statusc = true
		players3 = {'{ffffff}���\t{ffffff}����\t{ffffff}������'}
		sampSendChat('/members')
		while not gotovo do wait(0) end
		if gosmb then
			sampShowDialog(716, "{9966cc}Medick Helper {ffffff}| {ae433d}��� ����� {ffffff}| Time: "..os.date("%H:%M:%S"), table.concat(players3, "\n"), "x", _, 5) -- ���������� ����������.
		end
		gosmb = false
		krimemb = false
		gotovo = false
		statusc = false
	end)
end

function dlog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | ��� ��������� ������������', table.concat(departament, '\n'), '�', 'x', 0)
end
function slog()
    sampShowDialog(97987, '{9966cc}Medick Help{ffffff} | ��� SMS', table.concat(smslogs, '\n'), '�', 'x', 0)
end

function rlog()
    sampShowDialog(97988, '{9966cc}Medick Help{ffffff} | ��� �����', table.concat(radio, '\n'), '�', 'x', 0)
end

function yvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == '��������' or rank == '������' or rank == '���.����.�����' or rank == '����.����' or  rank == '������' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| �������: /yvig [ID] [�������]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| ����� � ID: "..id.." �� ��������� � �������.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| �������: /yvig [ID] [�������]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - �������� ������ ������� �� �������: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - �������� ������ ������� �� �������: %s.", rpname, pric))
      end
  end
end
end
end

function vig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '������� ����' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| �������: /vig [ID] [�������]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| ����� � ID: "..id.." �� ��������� � �������.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| �������: /vig [ID] [�������]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - �������� ������� �� �������: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - �������� ������� �� �������: %s.", rpname, pric))
      end
  end
end
end
end
function ivig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '����.����' or  rank == '������' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| �������: /ivig [ID] [�������]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| ����� � ID: "..id.." �� ��������� � �������.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| �������: /ivig [ID] [�������]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - �������� ������� ������� �� �������: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - �������� ������� ������� �� �������: %s.", rpname, pric))
      end
  end
end
end
end

function unvig(pam)
  local id, pric = string.match(pam, '(%d+)%s+(.+)')
  if rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '����.����' then
  if id == nil then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| �������: /unvig [ID] [�������]", -1)
  end
  if id ~=nil and not sampIsPlayerConnected(id) then
    sampAddChatMessage("{9966cc}Medick Helper {ffffff}| ����� � ID: "..id.." �� ��������� � �������.", -1)
  end
  if id ~= nil and sampIsPlayerConnected(id) then
  
      if pric == nil then
        sampAddChatMessage("{9966cc}Medick Helper {ffffff}| �������: /unvig [ID] [�������]", -1)
      end
      if pric ~= nil then
	   if cfg.main.tarb then
        name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
        sampSendChat(string.format("/r [%s]: %s - �������� c����� �������� �� �������: %s.", cfg.main.tarr, rpname, pric))
		else
		name = sampGetPlayerNickname(id)
        rpname = name:gsub('_', ' ')
		sampSendChat(string.format("/r %s - �������� c����� �������� �� �������: %s.", rpname, pric))
      end
  end
end
end
end

function where(params) -- ������ ��������������
   if rank == '������' or rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '����.����' then
	if params:match("^%d+") then
		params = tonumber(params:match("^(%d+)"))
		if sampIsPlayerConnected(params) then
			local name = string.gsub(sampGetPlayerNickname(params), "_", " ")
			 if cfg.main.tarb then
			    sampSendChat(string.format("/r [%s]: %s, �������� ���� ��������������. �� ����� 20 ������.", cfg.main.tarr, name))
			else
			sampSendChat(string.format("/r %s, �������� ���� ��������������. �� ����� 20 ������.", name))
			end
			else
			ftext('{FFFFFF} ����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.', 0x046D63)
		end
		else
		ftext('{FFFFFF} �����������: /where [ID].', 0x046D63)
		end
		else
		ftext('{FFFFFF}������ ������� �������� � 6 �����.', 0x046D63)
	end
end

function getrang(rangg)
local ranks = 
        {
		['1'] = '������',
		['2'] = '�������',
		['3'] = '���.����',
		['4'] = '���������',
		['5'] = '��������',
		['6'] = '������',
		['7'] = '��������',
		['8'] = '������',
		['9'] = '���.����.�����',
		['10'] = '����.����'
		}
	return ranks[rangg]
end

function giverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '����.����' then
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
				sampSendChat('/me ���� ������ ������� � �������� �������� ��������')
				wait(3000)
				sampSendChat('/me ����� ������ ������� � ������')
				wait(3000)
                sampSendChat(string.format('/me ������ ����� ������� %s', ranks))
				wait(3000)
				sampSendChat('/me �������� �� ������� �������� �������� ����� �������')
				wait(3000)
				else
				sampSendChat('/me ����� ������ ������� � �������� �������� ��������')
				wait(3000)
				sampSendChat('/me ������ ������ ������� � ������')
				wait(3000)
                sampSendChat(string.format('/me ������� ����� ������� %s', ranks))
				wait(3000)
				sampSendChat('/me ��������� �� ������� �������� �������� ����� �������')
				wait(3000)
				end
				end
				end
				sampSendChat(string.format('/giverank %s %s', id, rangg))
				wait(3000)
				if cfg.main.tarb then
                sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s � ��������� �� %s%s.', cfg.main.tarr, plus == '+' and '�������' or '�������(�)', ranks, plus == '+' and ', �����������.' or ''))
                else
				sampSendChat(string.format('/r '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s � ��������� �� %s%s.', plus == '+' and '�������' or '�������', ranks, plus == '+' and ', �����������!' or ''))
				wait(3000)
				sampSendChat('/b /time 1 + F8, �����������.')
            end
			else
			ftext('�� ����� �������� ��� [+/-]')
		end
		else
			ftext('�������: /giverank [id] [����] [+/-]')
		end
		else
			ftext('������ ������� �������� � ��������� ��������.')
	  end
	  else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
	  end
   end)
 end
function fgiverank(pam)
    lua_thread.create(function()
    local id, rangg, plus = pam:match('(%d+) (%d+)%s+(.+)')
	if sampIsPlayerConnected(id) then
	  if rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '����.����' then
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
				sampSendChat('/me ���� ������ ������� � �������� �������� ��������')
				wait(3000)
				sampSendChat('/me ����� ������ ������� � ������')
				wait(3000)
                sampSendChat(string.format('/me ������ ����� ������� %s', ranks))
				wait(3000)
				sampSendChat('/me �������� �� ������� �������� �������� ����� �������')
				wait(3000)
				else
				sampSendChat('/me ����� ������ ������� � �������� �������� ��������')
				wait(3000)
				sampSendChat('/me ������ ������ ������� � ������')
				wait(3000)
                sampSendChat(string.format('/me ������� ����� ������� %s', ranks))
				wait(3000)
				sampSendChat('/me ��������� �� ������� �������� �������� ����� �������')
				wait(3000)
				end
				end
				end
			else
			ftext('�� ����� �������� ��� [+/-].')
		end
		else
			ftext('�������: /giverank [id] [����] [+/-]')
		end
		else
			ftext('������ ������� �������� � ��������� ������.')
	  end
	  else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
	  end
   end)
 end
function invite(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == '���.����.�����' or  rank == '����.����' or  rank == '������' or  rank == '��������' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me ������(�) ������� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
			else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
		end
		else
			ftext('�������: /invite [id]')
		end
		else
			ftext('������ ������� �������� � ��������� ��������.')
	  end
   end)
 end
 function fixcar()
    lua_thread.create(function()
	  if rank == '���.����.�����' or  rank == '����.����' or  rank == '������' or  rank == '��������' then
	sampSendChat('/ffixcar')
	  end
   end)
 end
 function invitenarko(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
	  if rank == '���.����.�����' or  rank == '����.����' or  rank == '������' or rank == '��������' then
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me ������(�) ������� ��������� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/invite %s', id))
				wait(6000)
				sampSendChat(string.format('/giverank %s 5', id))
				wait(2000)
				sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ��� ������ �� ���������, �����������', cfg.main.tarr))
			else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
		end
		else
			ftext('�������: /invn [id]')
		end
		else
			ftext('������ ������� �������� � ��������� ��������.')
	  end
   end)
 end
function zheal(pam)
    lua_thread.create(function()
        local id = pam:match('(%d+)')
        if id then
		if sampIsPlayerConnected(id) then
                sampSendChat("/do ����� ����� ����� �������� ���. ����� �� �����.")
				wait(3000)
				sampSendChat("/me ������ �� ���.����� ��������� � ��������� ����")
				wait(3000)
				sampSendChat('/me ������� ��������� � ��������� ���� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(1100)
				sampSendChat(string.format('/heal %s', id))
			else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
		end
		else
			ftext('�������: /z [id]')
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
                submenus_show(ginvite(id), "{9966cc}Medick Helpers {ffffff}| ����� ������")
				else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
            end
		else
			ftext('�������� ������� � ����������.')
		end
		else
			ftext('����� � ���� ��� ������� ������.')
	  end
	  else
			ftext('����� � ���� ��� ������� ������.')
	end
	  else
			ftext('�������: /ginv [id]')
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
                submenus_show(crpinv(id), "{9966cc}Medick Helpers {ffffff}| ����� ������")
				else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
            end
		else
			ftext('�������� ������� � ����������.')
		end
		else
			ftext('����� � ���� ��� ������� ������.')
	  end
	  else
			ftext('����� � ���� ��� ������� ������.')
	end
	  else
			ftext('�������: /cinv [id]')
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
                submenus_show(zinvite(id), "{9966cc}Medick Helpers {ffffff}| ����� ������")
				else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
            end
		else
			ftext('�������� ������� � ����������.')
		end
		else
			ftext('����� � ���� ��� ������� ������.')
	  end
	  else
			ftext('����� � ���� ��� ������� ������.')
	end
	  else
			ftext('�������: /zinv [id]')
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
                submenus_show(oinvite(id), "{9966cc}Medick Helpers {ffffff}| ����� ������")
				else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
            end
		else
			ftext('�������� ������� � ����������.')
		end
		else
			ftext('����� � ���� ��� ������� ������.')
	  end
	  else
			ftext('����� � ���� ��� ������� ������.')
	end
	  else
			ftext('�������: /oinv [id]')
	end
	  end)
   end

 function uninvite(pam)
    lua_thread.create(function()
        local id, pri4ina = pam:match('(%d+)%s+(.+)')
	  if rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '����.����' then
        if id and pri4ina then
		if sampIsPlayerConnected(id) then
                sampSendChat('/me ������(�) ����� � ������� � '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
				wait(3000)
				sampSendChat(string.format('/uninvite %s %s', id, pri4ina))
			else
			ftext('����� � ������ ID �� ��������� � ������� ��� ������ ��� ID.')
		end
		else
			ftext('�������: /uninvite [id] [�������]')
		end
		else
			ftext('������ ������� �������� � ��������� ������.')
	  end
   end)
 end
 function zinvite(id)
 return
{
  {
   title = "{80a4bf}� {FFFFFF}����� SES",
    onclick = function()
	sampSendChat('/me ������(�) ������� ����������� ����� ���������-������������������-������� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 12.')
	wait(5000)
	sampSendChat('/b ��� � /r [���.�����.SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ����������� ���������-������������������-�������.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}� {FFFFFF}����� ���",
    onclick = function()
	sampSendChat('/me ������(�) ������� ����������� ����� ��������-������������ ������� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(4000)
	sampSendChat('/b /clist 29.')
	wait(4000)
	sampSendChat('/b ��� � /r [���.����� ���]:')
	wait(4000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ����������� ��������-������������ �������.', cfg.main.tarr))
	end
   },
 }
end
function crpinv(id)
 return
{
  {
   title = "{80a4bf}� {FFFFFF}���������",
    onclick = function()
	sampSendChat('/me ������(�) ������� ���������� Control Room � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 15.')
	wait(7000)
	sampSendChat('/b ��� � /r [Chief CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ��������� Control Room.', cfg.main.tarr))
	end
   },
   
   {
   title = "{80a4bf}� {FFFFFF}��.���������",
    onclick = function()
	sampSendChat('/me ������(�) ������� �������� ���������� Control Room � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 10.')
	wait(7000)
	sampSendChat('/b ��� � /r [Senior Dispatcher]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ��.��������� Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}� {FFFFFF}���������",
    onclick = function()
	sampSendChat('/me ������(�) ������� ���������� Control Room � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 11.')
	wait(7000)
	sampSendChat('/b ��� � /r [Dispatcher CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ��������� Control Room.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}� {FFFFFF}���������",
    onclick = function()
	sampSendChat('/me ������(�) ������� ���������� Control Room � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(7000)
	sampSendChat('/b /clist 16.')
	wait(7000)
	sampSendChat('/b ��� � /r [Employee CR]:')
	wait(7000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ��������� Control Room.', cfg.main.tarr))
	end
   },
 }
end
function oinvite(id)
 return
{
  {
   title = "{80a4bf}� {FFFFFF}����� SES [��������� SES]",
    onclick = function()
	sampSendChat('/me ������(�) ������� ���������� ���������-�����������������-������� � ������� ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10.')
	wait(5000)
	sampSendChat('/b ��� � /r [SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ���������� � �������� �� ���������� ���������-�����������������-�������.', cfg.main.tarr))
	end
   },
  {
   title = "{80a4bf}� {FFFFFF}����� SES",
    onclick = function()
	sampSendChat('/me ������(�) ������� ������� ���������-�����������������-������� � ������� ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 19.')
	wait(5000)
	sampSendChat('/b ��� � /r [C����� SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - �����  ���������  ���������-�����������������-�������.', cfg.main.tarr))
	end
   },

   -- {
   -- title = "{80a4bf}� {FFFFFF}����� ���",
    -- onclick = function()
	-- sampSendChat('/me ������(�) ������� ����������(��) ������-���������� ��������� � ������� ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	-- wait(5000)
	-- sampSendChat('/b /clist 15.')
	-- wait(5000)
	-- sampSendChat('/b ��� � /r [���]:')
	-- wait(5000)
	-- sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - �����  ��������� ������ MA.', cfg.main.tarr))
	-- end
   -- },
   {
   title = "{80a4bf}� {FFFFFF}����� ��� [��������� ���]",
    onclick = function()
	sampSendChat('/me ������(�) ������� ���������� ��������-������������ ������� � ������� ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 10.')
	wait(5000)
	sampSendChat('/b ��� � /r [���]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ���������� � �������� �� ���������� ��������-������������ �������.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}� {FFFFFF}����� ���",
    onclick = function()
	sampSendChat('/me ������(�) ������� ������� ��������-������������ ������� � ������� ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 2.')
	wait(5000)
	sampSendChat('/b ��� � /r [C����� ���]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - �����  ���������  ��������-������������ �������.', cfg.main.tarr))
	end
   },
 }
end
function ginvite(id)
 return
{
  {
   title = "{80a4bf}� {FFFFFF}����� ��� �����.",
    onclick = function()
	if rank == '���.����.�����' or  rank == '������� ����' or  rank == '������' or  rank == '������' or  rank == '��������' then
	sampSendChat('/me ������(�) ������� �����  ��������-������������ ������� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 21.')
	wait(5000)
	sampSendChat('/b ��� � /r [����� ���]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ����� ��������-������������ ������� ', cfg.main.tarr))
	else
	ftext('�� �� ������ ��������� ����� ������� ������.')
	end
	end
   },
   {
   title = "{80a4bf}� {FFFFFF}����� SES �����.",
    onclick = function()
	if rank == '���.����.�����' or  rank == '������� ����' or  rank == '������' then
	sampSendChat('/me ������(�) ������� �����  ���������-������������������-������� � �������(�) ��� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
	wait(5000)
	sampSendChat('/b /clist 8.')
	wait(5000)
	sampSendChat('/b ��� � /r [����� SES]:')
	wait(5000)
	sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - ����� ����� ���������-������������������-������� ', cfg.main.tarr))
	else
	ftext('�� �� ������ ��������� ����� ������� ������.')
	end
	end
   },
 }
end
function fastmenu(id)
 return
{
  {
   title = "{80a4bf}�{FFFFFF} ���� {ffffff}������",
    onclick = function()
	submenus_show(fthmenu(id), "{9966cc}Medick Helper {0033cc}| ���� ������")
	end
   },
   {
   title = "{80a4bf}�{FFFFFF} C������������",
    onclick = function()
	submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {0033cc}| ���� �������������")
	end
   },
   -- {
   -- title = "{80a4bf}�{FFFFFF} �������� ����",
    -- onclick = function()
	-- submenus_show(osmrmenu(id), "{9966cc}Medick Helper {0033cc}| �������� ����")
	-- end
   -- },
   -- {
   -- title = "{80a4bf}�{FFFFFF} �������������",
    -- onclick = function()
	-- submenus_show(osmrmenu1(id), "{9966cc}Medick Helper {0033cc}| ����������� ������")
	-- end
   -- },
   {
	title = '{80a4bf}�{FFFFFF} ���� {ffffff}���� �������� {ff0000}(��.������)',
    onclick = function()
	  if rank == '���.����.�����' or  rank == '����.����' or  rank == '������' or  rank == '��������' then
	submenus_show(agitmenu(id), '{9966cc} Medick Helper {0033cc}| ���� ��������')
	else
	ftext('�� �� ���������� � ������� �������.')
	end
	end
   },
    {
   title = "{80a4bf}�{FFFFFF} ���� {ffffff}���.�������� {ff0000}(��.������)",
    onclick = function()
	if rank == '��������' or rank == '������' or rank == '���.����.�����' or rank == '����.����' then
	submenus_show(govmenu(id), "{9966cc}Medick Helper {0033cc}| ���� ���.��������")
	else
	ftext('�� �� ���������� � ������� �������.')
	end
	end
   },
   {
   title = "{80a4bf}�{FFFFFF} ���� {ffffff}�������",
    onclick = function()
	if rank == '��������' or rank == '������' or rank == '���.����.�����' or rank == '����.����' or rank == '������' or rank == '��������' then
	submenus_show(otmenu(id), "{9966cc}Medick Helper {0033cc}| ���� �������")
	else
	ftext('������ ���� �������� � ��������� ��������.')
	end
	end
   },
   {
   title = "{80a4bf}�{FFFFFF} ������� ���������� �� � �������� (/d).",
    onclick = function()
	if rank == '���.����' or rank =='���������' or rank =='��������' or rank == '������' or rank == '��������' or rank == '������' or rank == '���.����.�����' or rank == '����.����' then
	sampSendChat(string.format('/d SAPD, ������� ���������� � ��������. ������� �������.'))
	else
	ftext('������ ������� �������� � ��������� ���.����.')
	end
	end
   },
   {
   title = "{80a4bf}�{FFFFFF} �������� ��������/�����������",
    onclick = function()
	submenus_show(proverkabizorg(id), "{9966cc}Medick Helper {0033cc}| �������� ��������/�����������")
	end
   },
   {
   title = "{80a4bf}�{FFFFFF} ���� ��������",
    onclick = function()
	submenus_show(operacia(id), "{9966cc}Medick Helper {0033cc}| ��������")
	end
   },
}
end

function otmenu(id)
 return
{
  {
   title = "{80a4bf}�{FFFFFF} ���� ������ � ����� {ff00ff}���{ff0000}(��� ����/����� ������)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: ��������� ����������, ��������� ��������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: � ���������-������������������-������� ������������ ���������� �����������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: �������� � ����� ����� � ��������� "���.����".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: ��� ��������� ���������� ������ �� �.'..myid..'.', cfg.main.tarr))
	wait(5000)
    sampSendChat(string.format('/rb [%s]: �� ��� ��������� ������� ����������� �� ��������.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}�{FFFFFF} ���� ������ � ����� {0000ff}FI{ff0000}(��� ����/����� ������)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: ��������� ����������, ��������� ��������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: � Fire Inspection ��������� ������������ ���������� �����������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: �������� � ����� ����� � ��������� "��������".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: ��� ��������� ���������� ������ �� �.'..myid..'.', cfg.main.tarr))
	end
   },
   {
   title = "{80a4bf}�{FFFFFF} ���� ������ � ����� {0000ff}���{ff0000}(��� ����/����� ������)",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	sampSendChat(string.format('/r [%s]: ��������� ����������, ��������� ��������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: � ��������-������������ ������� ��������� ������������ ���������� �����������.', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: �������� � ����� ����� � ��������� "���.����".', cfg.main.tarr))
    wait(5000)
    sampSendChat(string.format('/r [%s]: ��� ��������� ���������� ������ �� �.'..myid..'.', cfg.main.tarr))
	end
   },
   -- {
   -- title = "{80a4bf}�{FFFFFF} ���� ������ � ����� {0000ff}CR{ff0000}(��� ����/����� ������)",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- sampSendChat(string.format('/r [%s]: ��������� ����������, ��������� ��������.', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: � Control Room ������������ ���������� �����������.', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: �������� � ����� ����� � ��������� "���.����".', cfg.main.tarr))
    -- wait(5000)
    -- sampSendChat(string.format('/r [%s]: ��� ��������� ���������� ������ �� �.'..myid..'.', cfg.main.tarr))
	-- end
   -- },
}
end

function operacia(id)
    return
    {
      {
        title = '{ffffff}� ������� ����/���� �1.',
        onclick = function()
        sampSendChat("/me �������� �������� ����� �� ������������� �����")
        wait(3000) 
        sampSendChat("/me ����� �������� �� ���� ���� � ������ ����")
        wait(3000) 
        sampSendChat("/me ������� �������-������� � ����, ���� ���������� �� ��������")
		wait(3000) 
        sampSendChat("/do ������ ��� �����.")
		wait(3000) 
        sampSendChat("/me ���� � ���� ���� ������ � ����� ��� �������������")
		wait(3000) 
        sampSendChat("/todo ��� �������� �������*������� �������� ������� �� ������� ����� �� ��������.")
		wait(3000) 
        sampSendChat("/me ������ �������� �� ������������ ����")
		wait(3000) 
        sampSendChat("/me ������ �� ����� ���������� ���� � ������� ��� �����")
		wait(3000) 
        sampSendChat("/me ������������ ���� � ����������� ���������")
		wait(3000) 
        sampSendChat("/do � ���� ����������� ����.")
		wait(3000) 
        sampSendChat("/me ������� ���� �� ����� �������� ��� �������� �� ������")
		wait(3000) 
        sampSendChat("/try ��������� ������ ���� ���������� ���� ����������� ������� ����")
		end
      },
	  {
        title = '{5b83c2}� ���� ��������, �� ��������� � �2. �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� ������� ����/���� �2.',
        onclick = function()
        sampSendChat("/do � �������� ���� ������ �� ����, ������������ ��� ����.")
        wait(3000) 
        sampSendChat("/me ������� ������� ����, ������� ���� ����")
        wait(3000) 
        sampSendChat("/try �������� �� ���� �������� � ���� ��������� �� ���������� ��� ����")
		end
      },
	  {
        title = '{ffffff}� ������� ������� �1.',
        onclick = function()
        sampSendChat("/me ������� � �����, ������ �� ���� ��������")
        wait(3000) 
        sampSendChat("/me ����� ���� ��� ������, ���� �������� � ������ ����")
        wait(3000) 
        sampSendChat("/todo ��������, � ��� ����� ������*������� ����� �� ����.")
		wait(3000) 
        sampSendChat("/do ����������� ����� ������ ����� �����.")
		wait(3000) 
        sampSendChat("/me ��������� �������, ����� ��� ����� ������")
		wait(3000) 
        sampSendChat("/do ����� ������ ������� ������� �����.")
		wait(3000) 
        sampSendChat("/me ���� �� ����� ������ � �������������� �������������")
		wait(3000) 
        sampSendChat("/me �������� ������ �� ������� ����� � ������������ ������")
		wait(3000) 
        sampSendChat("/me ������ ����� � 2 ���������� �������� � ��� ��������������")
		wait(3000) 
        sampSendChat("/me ���� � ������� ������ � ������ �� � ����")
		wait(3000) 
        sampSendChat("/me ��������� ��������� �������� ���� ��������")
		wait(3000) 
        sampSendChat("/try ����� ����, ������� �")
		end
      },
	  {
        title = '{5b83c2}� ���� ��������, �� ��������� � �2. �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� ������� ������� �2.',
        onclick = function()
        sampSendChat("/me ������� ����, ����� ��� ���������")
        wait(3000) 
        sampSendChat("/try ����� ����, ������� �")
		end
      },
	  {
        title = '{5b83c2}� ���� ������, �� ��������� � �3. �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� ������� ������� �3.',
        onclick = function()
        sampSendChat("/me ����� ���� �� �������� � ������� � �� ������")
        wait(3000) 
        sampSendChat("/me ���� �������� ���� � ������ ����� � ���� ����")
		wait(3000) 
        sampSendChat("/me ����� ����������� ���, �������� ���� � ����")
		wait(3000) 
        sampSendChat("/do ����� ��������� ����, ��� ���� �������������.")
		wait(3000) 
        sampSendChat("/me ���� ������� � ������� ������ �������")
		wait(3000) 
        sampSendChat("/me ��������� ����� ������� ������������ � ������ �� �� ������")
		end
      },
	  {
        title = '{ffffff}� ������� �������.',
        onclick = function()
        sampSendChat("/me ������� � �����, ������ �� ���� ��������")
        wait(3000) 
        sampSendChat("/me ����� ���� ��� ������, ���� �������� � ������ ����")
        wait(3000) 
        sampSendChat("/todo ������������, ���� �������� ����*������� ����� �� ����.")
		wait(3000) 
        sampSendChat("/do ����������� ����� ������ ����� �����.")
		wait(3000) 
        sampSendChat("/me ��������� �������, ����� ��� ����� ������")
		wait(3000) 
        sampSendChat("/me ���� �� ����� ������ � �������������� �������������")
		wait(3000) 
        sampSendChat("/me ���� ������ � ����� � �������� ������ �� �������")
		wait(3000) 
        sampSendChat("/me ���� � ������� ����� � ��������� ��������")
		wait(3000) 
        sampSendChat("/me ������ ����� ����� � ������ �������")
		wait(3000) 
        sampSendChat("/do �������������� �������������.")
		wait(3000) 
        sampSendChat("/me ����� ����������� ���, ������ ���� � ����")
		wait(3000) 
        sampSendChat("/me �������� ��������� ����, ����� ������������ ��")
		wait(3000) 
        sampSendChat("/me ������� ������ ���� ��������� � ���� ����������")
		wait(3000) 
        sampSendChat("/me ��������� ��� ������������ � ������ �� �� ������")
		end
      },
	  {
        title = '{ffffff}� �������� �����������.',
        onclick = function()
        sampSendChat("/me ������� � �����, ������ �� ���� ��������")
        wait(3000) 
        sampSendChat("/me ����� ���� ��� ������, ���� �������� � ������ ����")
        wait(3000) 
        sampSendChat("/do ����������� ����� ������ ����� �����.")
		wait(3000) 
        sampSendChat("/me ��������� �������, ����� ��� ����� ������")
		wait(3000) 
        sampSendChat("/do ����� ������ ������� ������� �����.")
		wait(3000) 
        sampSendChat("/me ���� �� ����� ������ � �������������� �������������")
		wait(3000) 
        sampSendChat("/me ���� � ������� ����������� ������ � ��� � ������ ��������")
		wait(3000) 
        sampSendChat("/me ������� �������� ����� �������, ����� ������ ������")
		wait(3000) 
        sampSendChat("/me ���� � ���� ������ � ������ � ������")
		wait(3000) 
        sampSendChat("/me ������� �������� ��������� � ������� ���������� �����")
		wait(3000) 
        sampSendChat("/me ����� ��������� �������� �� ����, ����� �� ������ ���������")
		wait(3000) 
        sampSendChat("/me ���� �� ����� ���� � ����, ����� ������ ���� � ����")
		wait(3000) 
        sampSendChat("/me ������ ����� � ������ ����� � ������� ���")
		wait(3000) 
        sampSendChat("/me ������������ ��� � ������� ���� ���������")
		wait(3000) 
        sampSendChat("/do ������� ��������� ���� �� ���� ��������.")
		wait(3000) 
        sampSendChat("/me ������ �� �� ������ � ���������")
		wait(3000) 
        sampSendChat("/me ������� �� �� ������, ���� ���������")
		wait(3000) 
        sampSendChat("/me ��������� ����� ���� ������������")
		end
      },
    }
end

function proverkabizorg(id)
    return
    {
      {
        title = '{5b83c2}� �������� ���������. �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) ���������� � ���������.',
        onclick = function()
        sampSendChat("/me ��������� �� ��������, �������� ����� ��� ������������ ����")
        wait(3000) 
        sampSendChat("/try ��������� �� ������, ��� ����� ��� ������������ ���� �����")
        wait(3000) 
        sampSendChat("/me ������ ������ � ��������")
		end
      },
	  {
        title = '{ffffff}� 2) �������� ����� �� �����.',
        onclick = function()
        sampSendChat("/me ������ ������ �������� �� �����")
        wait(3000) 
        sampSendChat("/me ������� �������� �� ���� � ������ ����� �� ����� �� �����")
        wait(3000) 
        sampSendChat("/try ��������� �� ���� � �������� � ��������� ����� �� ��������")
		wait(3000) 
        sampSendChat("/me ������ �������� � ��� � �������� � �������")
		wait(3000) 
        sampSendChat("/me ������ ������ � ��������")
		end
      },
	  {
        title = '{ffffff}� 3) ���������� ��������� (�� ������� ���������).',
        onclick = function()
        sampSendChat("/me ��������� �� �������� ��������� � ������� ���")
        wait(3000) 
        sampSendChat("/me ����� ����������� ��� ����� � ������� ���������")
        wait(3000) 
        sampSendChat("/try ��������� ��� (���������) � ��������� ������")
		wait(3000) 
        sampSendChat("/me ������ ������ � ��������")
		end
      },
	  {
        title = '{ffffff}� 4) �������� �������� ������������� ����.',
        onclick = function()
        sampSendChat("/me ������ ������ �������� �� ����� � ����� �� �� ����")
        wait(3000) 
        sampSendChat("/me ��������� ������� �������������� ��� ������������� ����")
        wait(3000) 
        sampSendChat("/try ��������� �� ���� � �������� � ��������� ����� �� ��������")
		wait(3000) 
        sampSendChat("/me ������ �������� � ��� � ������� � �������")
		wait(3000) 
        sampSendChat("/me ������ ������ � ��������")
		end
      },
	  {
        title = '{ffffff}� 5) �������� ��������� �� ����� ��������.',
        onclick = function()
        sampSendChat("/me ������ ���� � ����� ��������� �������� � ���")
        wait(3000) 
        sampSendChat("/try ��������� �������������� � ������� �������� ���������")
        wait(3000) 
        sampSendChat("/me ������� � ������� � ������ ���")
		end
      },
	  {
        title = '{5b83c2}� /do "���������" ������� �� ������ �����: ��������� � �����������: [?/5] �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}�  �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� �������� �����������. �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) �������� �����.',
        onclick = function()
        sampSendChat("������ ����. �������������� ���������� �� ��������, ������ ������ ������ �����")
        wait(3000) 
        sampSendChat("/me ������ ����� � �������� �����")
        wait(3000) 
        sampSendChat("/do ����� �������.")
		wait(3000) 
        sampSendChat("/me ����� ���� ����� ������������")
		wait(3000) 
        sampSendChat("/do ������� ������-�������.")
		end
      },
	  {
        title = '{5b83c2}� ��������� �������� /checkheal [id] �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� �������� �������, ���� ������ - �� �������������, �������� - �� �������������.',
        onclick = function()
        sampSendChat("/try ������-������� ������� �������������/������������� ������")
		wait(3000) 
        sampSendChat("/me ������� ��� �������")
		end
      },
	  {
        title = '{5b83c2}� ������ � ����� �� ������ �������� ������� ��� �� ������� �� ����������. �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� /r [���] "Nick_Name ���.���������" - �� �������� ��������������. ������. �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� /r [���] "Nick_Name ���.���������" - ����� 1000% ����������������. �',
        onclick = function()
        end
      },
    }
end

function sobesedmenu(id)
    return
    {
      {
        title = '{5b83c2}� ������ �������������. �',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}� {ffffff}�����������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat('������������. � ��������� �������� '..myname:gsub('_', ' ')..', �� �� �������������?')
		wait(4000)
		sampSendChat('/do �� ������� ������� � �������� '..rank..' | '..myname:gsub('_', ' ')..'.')
		end
      },
      {
        title = '{80a4bf}� {ffffff}���������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('��� ������� � ������,����������.')
		wait(3000)
		sampSendChat('/b /showpass '..myid..'')
		wait(3000)
		sampSendChat('/b ������ �� ��.')
        end
      },
	  {
        title = '{80a4bf}� {ffffff}��������� �� ��.������ �� ���������{ff0000} � 6 ��� � �����.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('�� ������ �������� ��������� �� ��.�������, �� ��������� ���������, � ������ ������ �� �������.')
		wait(5000)
		sampSendChat('/b evolve-rp.su -> Cleveland -> ���.��������� -> ������������ �������������� -> ��������� �� ��������� ���������.')
		wait(3000)
		sampSendChat('�������� ��������� ��� ������ �� �������?')
        end
      },
	  {
        title = '{80a4bf}� {ffffff} �������� ����������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('/me ���� ��������� � �������� ��������, ����� ����� �� �������')
		wait(4000)
        sampSendChat('/me ������������� � �����������, ������ �� �������')
        end
      },
	  {
        title = '{80a4bf}� {ffffff}���������� ������� � ����.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampSendChat('������, ���������� ������� � ����.')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}� {ffffff}�������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('��� �� �� ������, ����� ����������� ���� �������?')
        end
      },
	  {
	     title = '{80a4bf}� {ffffff}���� � ������ �����.',
        onclick = function()
        sampSendChat('����� ������ ���� � ������ �����?')
		wait(4000)
        end
      },
	  {
	   title = '{80a4bf}� {ffffff}�������� � �������.',
	   onclick = function()
	   sampSendChat('����� ������ �������� � �������?')
	   wait(4000)
	   end
      },
	  {
        title = '{80a4bf}� {ffffff}C����� �� ������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('��� �� ������������ �� �������� �� ������?')
        end
      },
	  {
        title = '{80a4bf}� {ffffff}������� ������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('��� ��� �� ���������� �� ������� ������?')
        end
      },
	  {
        title = '{80a4bf}� {ffffff}��������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('�� ����� �������� �� ������������?')
        end
      },
	  {
        title = '{80a4bf}� {ffffff}�� �������.',
        onclick = function()
        sampSendChat('��� �� ������ �������� ������� ��� �� � ��?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}� {ffffff}��� ��� �������.',
        onclick = function()
        sampSendChat('��� � ���� ��� �������?')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}� {ffffff}������� �����������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('��� �� ���������� ������� �����������?')
        end
      },
	  {
        title = '{80a4bf}� {ffffff}�� ������� � /b.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('/b �� � �� � /sms '..myid..'')
		wait(4000)
        end
      },
	  {
        title = '{80a4bf}� {ffffff}�� �������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('����������, �� ��� ���������.')
        end
      },
	  {
        title = '{80a4bf}� {ffffff}�� �� �������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat('����� ��������, �� �� ��� �� ���������. �������� �������������.')
        end
	  },
    }
end

function govmenu(id)
 return
{
   {
   title = "{80a4bf}�{FFFFFF} � �������������.",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, ����� ������� �� ����� ��������������� ��������.")
		wait(1300)
		sampSendChat("/gov [Medic]: ���� � �������, ������ ������� ��� ��������� ��������.")
        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: � �������� ����� ��� ��������, ��� �������� ������������� � ��� ���������.')
        wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [Medic]: ��� ����� � ���, �� ��������� ��������������� ����� � ������� 40.000$.')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: ��� ����� ��������� �������� � ����� �� 5 ��� � ���������� ������� � �������.')
		wait(cfg.commands.zaderjka * 750)
		sampSendChat('/gov [Medic]: � ���������, ����������� ����������� �������� ����� Cleveland.')
		wait(750)
        sampSendChat("/d OG, �������� ������� �� ����� ��������������� ��������.")
		wait(1200)
		sampAddChatMessage("{F80505}� ������������ ������� {F80505}�������� {0CF513} /addvacancy.", -1)
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
   title = "{80a4bf}�{FFFFFF} � �����.",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, ����� ������� �� ����� ��������������� ��������.")
        wait(1300)
        sampSendChat("/gov [Medic]: ���� � �������, ������ ������� ��� ��������� ��������.")
                wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: ����� ��� ��������, ��� ������ � ��������� �������� ���� ��������.')
                wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [Medic]: � ��� ������ ������ ���� - ���������� �������������� ����� ����������� �����.')
	        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: ����� ����� ���� ������ ������� �� ���, �� ��������� ���� ����.')
		wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: � ���������, ����������� ����������� �������� ����� Cleveland.')
		wait(750)
        sampSendChat("/d OG, �������� ������� �� ����� ��������������� ��������.")
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
   title = "{80a4bf}�{FFFFFF} � ����������.",
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat("/d OG, ����� ������� �� ����� ��������������� ��������.")
        wait(1300)
        sampSendChat("/gov [Medic]: ���� � �������, ������ ������� ��� ��������� ��������.")
        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: �� ����������� ������� ������� ��������� �� ��������������� � ���������.')
        wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [Medic]: � ������ ��������� ����� ����������, �� ��������� ������� � ������� 750.000$.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: ���� ���������� ���������� 7 ����������� ���� � ������� ������ ����� � ��������.')
        wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: � ���������, ����������� ����������� �������� ����� Cleveland.')
		wait(750)
        sampSendChat("/d OG, �������� ������� �� ����� ��������������� ��������.")
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
   title = '{80a4bf}�{FFFFFF} � �����������.',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG, ����� ������� �� ����� ��������������� ��������.')
                wait(1300)
        sampSendChat('/gov [Medic]: ���� � �������, ������ ������� ��� ��������� ��������.')
        wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [Medic]: �� ����������� ������� ���������� ����������� - ���������� �����.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: ������� ������, ���������� �����-���� ������� ����� �� 6 �������.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/gov [Medic]: � ����� ������ ��������� �� ���������������, �������� ���� ���������� 9.000.000$.')
	wait(cfg.commands.zaderjka * 750)
	sampSendChat('/gov [Medic]: � ���������, ����������� ����������� �������� ����� Cleveland.')
	wait(cfg.commands.zaderjka * 750)
        sampSendChat('/d OG, �������� ������� �� ����� ��������������� ��������.')
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
   -- title = "{80a4bf}�{FFFFFF} �������� ������� ������ ���.",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- local myname = sampGetPlayerNickname(myid)
	-- sampSendChat("/d OG, ����� ����� ��������������� ��������.")
                -- wait(1300)
        -- sampSendChat("/gov [MOH]: ��������� ������ � ����� �����, ��������� ��������.")
        -- wait(cfg.commands.zaderjka * 750)
	-- sampSendChat('/gov [MOH]: ����������� ������� ������� � �������� ������� ������.')
	-- wait(cfg.commands.zaderjka * 750)
        -- sampSendChat('/gov [MOH]: ������ ��� � ��� ���, ������ ����� ����� �������� ����� � ��� ������� ���������.')
	-- wait(cfg.commands.zaderjka * 750)
        -- sampSendChat('/gov [MOH]: ��� ��� ���� �������� ���� ����� � �������.')
	-- wait(cfg.commands.zaderjka * 750)
	-- sampSendChat('/gov [MOH]: � ���������, ����������� ����������� �������� �����.')
	-- wait(cfg.commands.zaderjka * 750)
        -- sampSendChat("/d OG, ��������� ����� ��������������� ��������.")
		-- wait(1200)
		-- if cfg.main.hud then
        -- sampSendChat("/time 1")
        -- wait(500)
        -- setVirtualKeyDown(key.VK_F8, true)
        -- wait(150)
        -- setVirtualKeyDown(key.VK_F8, false)
		-- end
	-- end
   -- },
   -- {
   -- title = "{80a4bf}�{FFFFFF} COVID-19.",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- local myname = sampGetPlayerNickname(myid)
	-- sampSendChat("/d OG, ����� ����� ��������������� ��������.")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat("/me ������ ���, ����� ���� ����������� � ���. ����� ��������")
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/gov [���]: ��������� ������ �����, ��������� ��������!")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [���]: � ������ ������, ��������� ���������� ��� �����.')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [���]: ������ ���������, ������ ����� � ������� ���������, ����� �� ��������� ���� ���� � �����.')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [���]: ��� ����� �� ������� ������ �� ��.������� �����.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH]: � ���������, '..rank..' �������� ������ Los-Santos - '..myname:gsub('_', ' ')..'.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [���] ������ �������, �� �������!')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/d OG, ��������� ����� ��������������� ��������.")
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
   -- title = "{80a4bf}�{FFFFFF} ������� {fb05d6}���������.",
    -- onclick = function()
	-- local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	-- local myname = sampGetPlayerNickname(myid)
	-- sampSendChat("/d OG, ����� ����� ��������������� ��������.")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat("/me ������ ���, ����� ���� ����������� � ���. ����� ��������")
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/gov [���]: ��������� ������ �����, ��������� ��������!")
        -- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH]: � ����������� �������� ������ Los-Santos`a ��������� ����������� �������.')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat('/gov [MOH]: � ������ �������� �� ������ ������������ �� ��.������� ��������.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [MOH]: � ���������, '..rank..' �������� ������ Los-Santos - '..myname:gsub('_', ' ')..'.')
		-- wait(cfg.commands.zaderjka * 1300)
		-- sampSendChat('/gov [���]: ������ �������, �� �������!')
		-- wait(cfg.commands.zaderjka * 1300)
        -- sampSendChat("/d OG, ��������� ����� ��������������� ��������.")
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
		ftext("�� ����� �� �������� �������� ���������.", 0x046D63)
	end
end

function osmrmenu(id)
 return
{
  {
    title = "{80a4bf}�{FFFFFF} ������� ��������.",
    onclick = function()
	    sampSendChat("/do ����� ����� ����� �������� ���. ����� �� �����.")
        wait(3000)
        sampSendChat("/me ������ �� ���.����� ��������� � ��������� ����")
        wait(3000)
        sampSendChat("/me ������� ��������� � ��������� ���� ��������")
        wait(3000)
        sampSendChat("/heal")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} �����.",
    onclick = function()
	    sampSendChat("/do ����� ����� ����� �������� ���.����� �� �����.")
        wait(4000)
        sampSendChat("/me ������ �� ���.����� ����, �����, ����� � ��������")
        wait(4000)
		sampSendChat("/me �������� ���� �������")
		wait(4000)
		sampSendChat("/do ����������� ������� ���� � ����� ����.")
		wait(4000)
		sampSendChat("/me ��������� ����� ����� ����� �� ���� ��������")
		wait(4000)
		sampSendChat("/do ����� � �������� � ������ ����.")
                wait(4000)
		sampSendChat("/me ���������� ��������� ������ �������� � ���� ��������")
                wait(4000)
		sampSendChat("/todo �� ��� � ��*������� ����� �� ���� � �������� ���� � ����� �����.")
                wait(4000)
		sampSendChat("/healaddict")





    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ������� �1.",
    onclick = function()
	    sampSendChat("/do �� ����� ����� ���� � ���.������� � ��������������� ����������.")
        wait(5000)
        sampSendChat(" ������ �� �� ������ �� ��������?")
        wait(5000)
        sampSendChat("/do � ����� ���� ������ �����.")
        wait(5000)
        sampSendChat("/me ������ ������ � ���.�����")
        wait(5000)
        sampSendChat("/me ������ �� ����� ��������������� ���������")
        wait(5000)
        sampSendChat("��������������, ������ ������������.")
        wait(5000)
        sampSendChat("/me ������ �� ����� ��������������� ���������")
        wait(5000)
        sampSendChat("/me ����� ���������� ����� ������� ��������")
        wait(5000)
        sampSendChat("/me ��������, ��� ������ �������� �������������� � ������� � �����")
        wait(5000)
        sampSendChat("/me ������ ������ � ���.�����")
        wait(5000)
        sampSendChat("/me ������ ���������� �� ������ ������ ��������")
        wait(5000)
        sampSendChat("/me ������ ���������� �� ������� ������ ��������")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ������� �2",
    onclick = function()
	    sampSendChat("����� ���� ��� � �������. ������ �������� ���� �����.")
        wait(5000)
        sampSendChat("/do �� ���� ����� ����-�����������.")
        wait(5000)
        sampSendChat("/do ����� ����� ����� �������� ���.����� �� �����.")
        wait(5000)
        sampSendChat("/me �������� ���� �������")
        wait(5000)
        sampSendChat("/do ����������� ������� ���� � ����� ����.")
        wait(5000)
        sampSendChat("/me ��������� ����� ����� ����� �� ���� ��������")
        wait(5000)
        sampSendChat("/do ����� � ����������� �������� � ������ ����.")
        wait(5000)
        sampSendChat("/me ���������� ��������� ������ ����� � ���� ��������")
        wait(5000)
        sampSendChat("/me ������� ����� �� ������ � ����������� �����, ����� �������� � � ����-�����������")
        wait(5000)
        sampSendChat("/checkheal")
    end
  },  
  {
    title = "{80a4bf}�{FFFFFF} ������� ��������.",
    onclick = function()
		sampSendChat(" ������������, ��� ��� ���������?")
		wait(5000)
		sampSendChat("/do ����� ����� ����� �������� ���. ����� �� �����.")
		wait(5000)
		sampSendChat("/me ������ �� ���.����� ��������� � ��������� ����")
		wait(5000)
		sampSendChat("/me ������� ��������� � ��������� ���� ��������")
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
    title = "{80a4bf}�{FFFFFF} �����.",
    onclick = function()
	    sampSendChat("/do ����� ����� ����� �������� ���.����� �� �����.")
        wait(5000)
		sampSendChat("/me ������ �� ���.����� ����, �����, ����� � ��������")
		wait(5000)
		sampSendChat("/me �������� ���� �������")
		wait(5000)
		sampSendChat("/do ����������� ������� ���� � ����� ����.")
		wait(5000)
		sampSendChat("/me ��������� ����� ����� ����� �� ���� ��������")
		wait(5000)
		sampSendChat("/do ����� � �������� � ������ ����.")
		wait(5000)
		sampSendChat("/me ������ � ����� ��������")
		wait(5000)
		sampSendChat("/me ���������� ��������� ������ �������� � ���� ��������")
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
    title = "{80a4bf}�{FFFFFF} ������� ��������.",
    onclick = function()
	    sampSendChat("/do ����� ����� ����� �������� ���. ����� �� �����.")
            wait(3000)
            sampSendChat("/me ������ �� ���.����� ��������� � ��������� ����")
            wait(3000)
           sampSendChat("/me ������� ��������� � ��������� ���� ��������")
           wait(3000)
           sampSendChat("/heal") 
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ������� �1",
    onclick = function()
	     sampSendChat("/do �� ����� ����� ���� � ���.������� � ��������������� ����������.")
        wait(5000)
        sampSendChat(" ������ �� �� ������ �� ��������?")
        wait(5000)
        sampSendChat("/do � ����� ���� ������ �����.")
        wait(5000)
        sampSendChat("/me ������ ������ � ���.�����")
        wait(5000)
        sampSendChat("/me ������ �� ����� ��������������� ���������")
        wait(5000)
        sampSendChat("��������������, ������ ������������.")
        wait(5000)
        sampSendChat("/me ������ �� ����� ��������������� ���������")
        wait(5000)
        sampSendChat("/me ����� ���������� ����� ������� ��������")
        wait(5000)
        sampSendChat("/me ��������, ��� ������ �������� �������������� � ������� � �����")
        wait(5000)
        sampSendChat("/me ������ ������ � ���.�����")
        wait(5000)
        sampSendChat("/me ������ ���������� �� ������ ������ ��������")
        wait(5000)
        sampSendChat("/me ������ ���������� �� ������� ������ ��������")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ������� �2",
    onclick = function()
	    sampSendChat("����� ���� ��� � �������. ������ �������� ���� �����.")
        wait(5000)
        sampSendChat("/do �� ���� ����� ����-�����������.")
        wait(5000)
        sampSendChat("/do ����� ����� ����� �������� ���.����� �� �����.")
        wait(5000)
        sampSendChat("/me �������� ���� �������")
        wait(5000)
        sampSendChat("/do ����������� ������� ���� � ����� ����.")
        wait(5000)
        sampSendChat("/me ��������� ����� ����� ����� �� ���� ��������")
        wait(5000)
        sampSendChat("/do ����� � ����������� �������� � ������ ����.")
        wait(5000)
        sampSendChat("/me ���������� ��������� ������ ����� � ���� ��������")
        wait(5000)
        sampSendChat("/me ������� ����� �� ������ � ����������� �����, ����� �������� � � ����-�����������")
        wait(5000)
        sampSendChat("/checkheal")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ���������� �������.",
    onclick = function()
	    sampSendChat("/do ������� ������.")
        wait(5000)
        sampSendChat("/do � �������� ����� ������ �������.")
        wait(5000)
        sampSendChat("/me ������ �� �������� ����� �������")
        wait(5000)
        sampSendChat("/me ������� ������� � ���, ��� ������� �� ����� ���������������� � ����� � ������")
        wait(5000)
        sampSendChat("/me ������� ������� �������� � ����")
        wait(5000)
        sampSendChat("/do ��������� ������ ���� �� ��������.")
        wait(5000)
		sampSendChat("/checkheal")
    end
  },  
  {
    title = "{80a4bf}�{FFFFFF} ������ �����, ���� ������� �������.",
    onclick = function()
		sampSendChat("/do �� ������ ������� ������������� ��������� ����� ����� ��������.")
		wait(5000)
		sampSendChat("/me ������ �� �������� ����� �������.")
		wait(5000)
		sampSendChat("/me ������� ������� � ���, ��� ������� ������ � ����� � ������.")
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
    title = "{80a4bf}�{FFFFFF} ��������� ����� � ������.",
    onclick = function()
	    sampSendChat("/do �� ���� ����� � ������.")
        wait(5000)
        sampSendChat("/me ������ ����� � ������")
		wait(5000)
		sampSendChat("/do ����� � ������ ������.")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ����� ������.",
    onclick = function()
	    sampSendChat("/do ����� ����� ����� ������, �������� � �����. ")
        wait(5000)
        sampSendChat("/me ���� ������, �������� � �����")
		wait(5000)
		sampSendChat("/me �������� ����� ����� ������")
		wait(5000)
		sampSendChat("/do ����� ����� ������.")
		wait(5000)
		sampSendChat("/do �������.")
		wait(5000)
		sampSendChat("/me �������� ����������� ����� � �����")
		wait(5000)
		sampSendChat("/do ����� ������.")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ��� � ���.",
    onclick = function()
	    sampSendChat("/me ������ ����� � ����� � ���")
        wait(5000)
        sampSendChat("/do � �������� �������� ���.")
		wait(5000)
		sampSendChat("/me ������� ����� � ���")
		wait(5000)
		sampSendChat("/do ����� � ���.")
		wait(5000)
		sampSendChat("/me ����� ����� � ������ ��������")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} �������� � ����.",
    onclick = function()
	    sampSendChat("/do �������� � ����.")
        wait(5000)
        sampSendChat("/me ������������ ����� ���������")
		wait(5000)
		sampSendChat("/do �������.")
		wait(5000)
		sampSendChat("/me �������� ������� �����")
		wait(5000)
		sampSendChat("/do ����� ����� �����.")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ������������� � ����� ��� ����� ����� � ����������� ���������� ��.",
    onclick = function()
	    sampSendChat("/do �� ���� ����� �������.")
        wait(5000)
        sampSendChat("/me ������� ����������� ������� � �����")
		wait(5000)
		sampSendChat("/do �������.")
		wait(5000)
		sampSendChat("/me �������� ����������� ������� � �����")
		wait(5000)
		sampSendChat("/do ����� ��������� ������ ���������.")
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ������������� � ����� ���� �������� ����� � ����������� ���������� ��.",
    onclick = function()
	    sampSendChat("/me �������� ����� ����� ���")
        wait(5000)
        sampSendChat("/do ����� ����� ���")
		wait(5000)
		sampSendChat("/me ������� ����������� ������� �� �����")
		wait(5000)
		sampSendChat("/do �������.")
		wait(5000)
		sampSendChat("/me ������� ������� �� �����")
		wait(5000)
		sampSendChat("/do ������� ����� �� �����.")
		wait(5000)
		sampSendChat("/me ������ �������� � ����� ������������ �������")
		wait(5000)
		sampSendChat("/me ��������� ��������� �������")
		wait(5000)
		sampSendChat("/do ������� ���.")
    end
  },
}
end

function osmrmenu1(id)
 return
{
  {
    title = "{80a4bf}�{FFFFFF} ����������� ������ �� �������.",
    onclick = function()
	    sampSendChat("- ������. ������ �� �������� ��� �� ������� ����������������.")
        wait(5000)
        sampSendChat("/do ����� ����� ����� �������� ���.����� �� �����.")
        wait(5000)
        sampSendChat("/me ������ �� ���.����� ����, �����, ����� � ����������� ��������")
        wait(5000)
        sampSendChat("/me �������� ���� �������")
        wait(5000)
        sampSendChat("/do ����������� ������� ���� � ����� ����.")
        wait(5000)
         sampSendChat("/me ��������� ����� ����� ����� �� ���� ��������")
        wait(5000)
        sampSendChat("/do ����� � ����������� �������� � ������ ����.")
        wait(5000)
        sampSendChat("/me ���������� ��������� ������ ����� � ���� ��������")
        wait(5000)
        sampSendChat("/me � ������� ������ ���� ������� ����� ��� �������")
        wait(5000)
        sampSendChat("/me ������� ����� �� ������ � ����������� �����, ����� �������� � � ����-�����������")
        wait(5000)
        sampSendChat("/me � ������� ������ ���� ������� ����� ��� �������")
        wait(5000)
        sampSendChat("/me ������� ����� �� ������ � ����������� �����, ����� �������� � � ����-�����������")
        wait(5000)
    end
  },
  {
    title = "{80a4bf}�{FFFFFF} ������������ ������ ������� � �����.",
    onclick = function()
		sampSendChat("/do �� ����� ����� ���� � ���.������� � ��������������� ����������.")
		wait(5000)
		sampSendChat("/me ������ �� ����� ���.����� �� ��� ��������")
		wait(5000)
		sampSendChat(" ������ �� �� ������ �� ��������?")
		wait(5000)
		sampSendChat("/do � ����� ���� ������ �����.")
		wait(5000)
		sampSendChat("/me ������ ������ � ���.�����")
		wait(5000)
		sampSendChat("/me ������ �� ����� ��������������� ���������")
		wait(5000)
		sampSendChat(" ��������������, ������ ������������.")
		wait(5000)
		sampSendChat("/me ����� ���������� ����� ������� ��������")
		wait(5000)
		sampSendChat("/me ��������, ��� ������ �������� �������������� � ������� � �����")
		wait(5000)
		sampSendChat(" ������. �������� ������ � �����.")
		wait(5000)
		sampSendChat("/me ������ ������ � ���.�����")
		wait(5000)
		sampSendChat("/me ������ ���������� �� ������ ������ ��������")
		wait(5000)
		sampSendChat(" ����� ���� ��� � �������. �������� ���� �����.")
		wait(5000)
		sampSendChat("��������� ��� ������� ������� � �����.")
		wait(5000)
		sampSendChat("/me ������ �� ���. ����� � ����� ���������� ��������")
		wait(5000)
		sampSendChat("/do �������� ������.")
        wait(5000)
        sampSendChat("/me ���� ������������ �� ����� � �������� ����� ��������")
		wait(5000)
		sampSendChat("/me ������ ������ � ���.�����")
        wait(5000)
		sampSendChat("/me ���� �������� �� ����� � ������ � �� ����� �� ������, ����� �������� � � ����-�����������")
		wait(5000)
		sampSendChat("/do �� ������ ������� ��������� ����� �����: 4,5 �����/�.")
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
    title = '{80a4bf}�{FFFFFF} ������ ��� {139BEC}�������.',
    onclick = function()
	    sampSendChat('�����������, �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�� ���� �������������� ��� � ������ ����� ��������. �������, �� ���� ������ �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('���������� ��� ������, ��� ���������� � ������ ��������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��������, ��� ������������� ��������� ����������� ������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��������� ����� �����������, � ����� ���������� � ������� ���������, ��� ������ ��� �� �����.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('� ���, ����� �������� ����������� � �������� ������������ ���������, ��� ����������:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������������ � �������� �����, ���������� ��� ������, ����� ����� � �������� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��� � ��� ��������� ������ ������, �������� ����������. � ��������� ��� ��������� � ���������.')
         wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�����, �� ��������� ������ ���� �������� �13. �� ���� ������ ��������. ������� ����?')
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
   title = '{80a4bf}�{FFFFFF} ������ ������ ��� {139BEC}�������������.',
    onclick = function()
       sampSendChat('�����������, �������. ������� � ������ ��� ������ �� ���� ������� ������ ��� ������������.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('����� ����� ��������, ��� ������������ ������������ ������������ ����������� ��������� ��� �����.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('������, ��� ��������� � ��������� ����� ���� ������������� �����.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('��� ����� �������� ������� �������� � ������ �������� ����.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('����������� � ����� ������ ����� ���������� ��������:')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('����, ������, ������, �������� ������� ����� ������.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('���������� ���� �� ��� ���, ���� ����� �� ���������� �������� �� ����.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('� ������ ��������� ������������ �������� �����������, �� ����������� ����, ���..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..���� ������������� ���� ���� ������������ �����.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('������� �������, ��� ��� ����� ����� ������������ ���� ������������� �� ����� ���� �����..') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..� ������ ������ � �� ����� ���� � ��������.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('��� ����������� ������������ ������� ���������� ������������ ����� ��������� ��������..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..� �������� ��������, ���� ������������� ����. ')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('������� �� ��������.')
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
  title = '{80a4bf}�{FFFFFF} ������ ������ ��� {139BEC}���������.',
    onclick = function()
      sampSendChat('�����������, �������. ������� � ������ ��� ������ �� ���� ������� ������ ��� ����������.')
      wait(cfg.commands.zaderjka * 5000)
      sampSendChat('�������� �������������� ��������������� ������� ��������, ���������..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..������������� ��������������� �����. ')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('������� ����� �������: ������ ����, ������������� ������, ��� � ��� �����.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('���������������� ��������� ������ ������������ ������ ��������� ������������..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..��������� ��������, ���������� �������, ��������������, ��� ��� ���� � ����.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('����� ������� ��������, ����������� �������� ����� � �������� ������ ��������.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('������ ������ ������ ���� ���������� �� ��������� �������������� �����..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..� ����������� ���������� �������.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('���� ������������ ��������� � ������, ����� ������������ ���������, ��..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..�������� ����, �������� ���������� ��� �������� ����������� �������� �� ������.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('�������� ��� ���� � ��� �������� �����, ���������� �� ����� �..')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('..����� ������������� �������� �����, ��������� ���������� �������.')
      wait(cfg.commands.zaderjka * 1000)
      sampSendChat('������� �� ��������.')
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
    title = '{80a4bf}�{FFFFFF} ������ ������ ��� {139BEC}���.',
    onclick = function()
       sampSendChat('�����������, �������. ������� � ������ ��� ������ �� ���� ������� ������ ��� ��ϻ.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('�������� ������ ������, ���������� ����������� �� ��������.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('���������� ���������� �������� � �������� ������.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('�������� ������ ������ � ������ ��� - ��������� ����������� ������..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..� ������ ����������� � ������� ������.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('���������� ������� ������������� �� ����������, ��������� ���.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('����� ������� ������� ������ ������ � ������������ � ����������� ��������.')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('������ ��, ��������� ��������� ������������� � ���������� �����..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..������ �� ������, ���� ��� ����� � ������� �����, � �����..')
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('..������������ ��������������� ������������� � �������� ����������.') 
       wait(cfg.commands.zaderjka * 1000)
       sampSendChat('������� �� ��������.')
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
    title = '{80a4bf}�{FFFFFF} ������ ��� {139BEC}���������.',
    onclick = function()
	    sampSendChat('�����������. �� ��������� �������� ����� ���� �������� �18.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ �� ���������������� ������������ ������������������� �����������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ ���������� ������ � ������������ �� ������ ����� �������� ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��� �� �� ������ ������ ������ �������� �� ��������. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('����� ��������� � ���������, ��� ����� ����� ������ ����� ����������, ����� ������� �� 6-� ������. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��������� �� ����������� ����� ������������ ���������������. ')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�� ���� ������ ��������. ������� ��������? ')
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
    title = '{80a4bf}�{FFFFFF} ������ � {139BEC}����� �������.',
    onclick = function()
	    sampSendChat('������ � �������� ��� � ����� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������� - ���� �� ����� ���������� � ���������������� �������� �� ����������� ����.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('���������, �������, ��������� �����.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������� �������� ��� � ����������� ����������� ������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�����, �������� ��� �������� � ��������� ����� ��������� ������ �����������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('����� �������� - ����� ���� � ���� ���.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�� ���� ���, �������, ������������ ��������������� ��������� � ����� ��������.')
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
    title = '{80a4bf}�{FFFFFF} ������ � ��� {139BEC} ��� ����� ���������� � ����������.',
    onclick = function()
	    sampSendChat('������ ������, � ���, ��� ����� ���������� � ����������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��� ������, �� ������ ������� �� ����������������, ��� �� �� ���� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������, �� ������ �������������, � �������� ��� ������ ������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('���� �� ������� ������, �� �������, ����� ������ ��� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('����� ������� ����� ������, �� ������ ��������� ��������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('���� �� ������ ������, ������������, �� ���������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��� ������ � ������������ ��������� - �������� �������.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������� �� ��������, ������ ������ ������� � �����.')
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
    title = '{80a4bf}�{FFFFFF} ������ � {139BEC} ������������� ����������',
    onclick = function()
	    sampSendChat('������������, ��������� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ � �������� ��� � ����� ������������� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��������� - ��� ��������, ��������� �������� ��������� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('���������� - �����������, ��������� ������������� ������������� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('� ����� ������������� ���������, ���� ���� ��������� ���������� �������������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������� �� ����� ������ �������� � �����������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�������, ��������� ����������� � ���, ��� ��� �� ����� ���������.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�� ���� ������ ��������, ������� �� ��������.')
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
    title = '{80a4bf}�{FFFFFF} ������ � {139BEC} �������.',
    onclick = function()
	    sampSendChat('������ � �������� ��� ��������� ������� � �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��� �� ����� � ������� � � �� ������� �����������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������ ������. � ���� ����� �������� � ��������� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�������, ��������� ��������� ������� �� �������������� ���������������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������, ���� �� ��������, �� ������������� �� ��������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������, ������� ������� ����� �������� ���� ������ ���������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('� ������, ���� ����� ����. ��������, ���� ��� �������� ������� �������.')
		wait(cfg.commands.zaderjka * 1000)
        sampSendChat('�� ���� ���, �������, ����� ����� ��������� � ����� ��������.')
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
    title = '{80a4bf}�{FFFFFF} ������{139BEC} ���.',
    onclick = function()
	sampSendChat('�����������, ��������� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('����������� �����, ���������� �� ����� �������, ������� � ������ � �� �����, ��� �� ������ �� ������� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('� ����� ��� ������ ��������� ������ ������, ������� � ��������, ��� ��������� ������� ������ ������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('���������� ������������, �� ��������� ����, �� ��������� ��������� ���� � ������� ������...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...��� �������� ��������, ������� ����� ������ ������������ ��� �������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('������������ ����� �������� �������� ����������� ������� �������� ��������...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...��� ��������� ������������. ���������� ��� �� ������ ��������� 30 �����.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('���� ������ � � ������� ������������ ����� ��������� ������� ��� ����� ���������� ��� ������ �������� ������.')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('��������, ��� � ����� � ��������������� ��������� ����������� ������ ��� �����������, ����������, ����� �������������, ��� ���� ������������...')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('...� ������� ������� ���� �������� �� 30% ������������, ����� ��� ���� � �� 70% � ����� ����� ����� � �� 90%.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('��� ����� ����������: ������ ������ ��� �������� ����� ��� ������, ��� �����, �� ������� �������.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('�� ����� ���������� ��� ������� ��� ���� ���������� � ����� ����������, ������� ������� ����� ������� �����:')
        wait(cfg.commands.zaderjka * 1000)
        sampSendChat('- ������� ������;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- ������� ������������;')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('- �������� � ��������.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('�� ���� ������������� � ��� �� ��������������. ��� ���� ��������������� ���� �� ���� ��� ����� � ���������� �������� ����� �����������.')
        wait(cfg.commands.zaderjka * 1000)
		sampSendChat('������ ������ � ��� �������� ������� ���, ������������ �� �������� ����� ��������.')
		wait(cfg.commands.zaderjka * 1000)
		sampSendChat('���������� ������, ������ ������� �����������, ���������� � � ���� � ������ ������������ ��������� ���������� ��������� ������ ������...')
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
    imgui.Begin(fa.ICON_COGS .. u8 ' ���������##1', first_window, btn_size, imgui.WindowFlags.NoResize)
	imgui.PushItemWidth(200)
	imgui.AlignTextToFramePadding(); imgui.Text(u8("������������ �������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'������������ �������', tagb) then
    cfg.main.tarb = not cfg.main.tarb
    end
	if tagb.v then
	if imgui.InputText(u8'������� ��� ���.', tagfr) then
    cfg.main.tarr = u8:decode(tagfr.v)
    end
	end
	imgui.Text(u8("����-��� ����������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'��������/��������� ����-���', hudik) then
        cfg.main.givra = not cfg.main.givra
		ftext(cfg.main.givra and '����-��� �������, ���������� ��������� /sethud.' or '����-��� ��������.')
    end
	imgui.Text(u8("������� ����� �� ��������� ���"))
	imgui.SameLine()
    if imgui.HotKey(u8'##������� ����� ���', config_keys.fastsms, tLastKeys, 100) then
	    rkeys.changeHotKey(fastsmskey, config_keys.fastsms.v)
		ftext('������� ������� ��������. ������ ��������: '.. table.concat(rkeys.getKeysName(tLastKeys.v), " + ") .. ' | ����� ��������: '.. table.concat(rkeys.getKeysName(config_keys.fastsms.v), " + "))
		saveData(config_keys, 'moonloader/config/medick/keys.json')
	end
	imgui.Text(u8("������������ ���������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'������������ ���������', clistb) then
        cfg.main.clistb = not cfg.main.clistb
    end
    if clistb.v then
        if imgui.SliderInt(u8"�������� �������� ������", clistbuffer, 0, 33) then
            cfg.main.clist = clistbuffer.v
        end
		imgui.Text(u8("������������ ��������� ����������"))
	    imgui.SameLine()
		if imgui.ToggleButton(u8'������������ ��������� ����������', clisto) then
        cfg.main.clisto = not cfg.main.clisto
        end
    end
	imgui.Text(u8("������� ���������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'������� ���������', stateb) then
        cfg.main.male = not cfg.main.male
    end
	if imgui.SliderInt(u8'�������� � ������� � ����������(���)', waitbuffer, 1, 25) then
     cfg.commands.zaderjka = waitbuffer.v
    end
	imgui.Text(u8("��������� ������/���.��������"))
	imgui.SameLine()
	if imgui.ToggleButton(u8'��������� ������', autoscr) then
        cfg.main.hud = not cfg.main.hud
    end
    if imgui.CustomButton(u8('��������� ���������'), imgui.ImVec4(0.08, 0.61, 0.92, 0.40), imgui.ImVec4(0.08, 0.61, 0.92, 1.00), imgui.ImVec4(0.08, 0.61, 0.92, 0.76), btn_size) then
	ftext('��������� ������� ���������.', -1)
    inicfg.save(cfg, 'medick/config.ini') -- ��������� ��� ����� �������� � �������
    end
    imgui.End()
   end
    if ystwindow.v then
                imgui.LockPlayer = true
                imgui.ShowCursor = true
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
                imgui.SetNextWindowSize(imgui.ImVec2(iScreenWidth/2, iScreenHeight / 2), imgui.Cond.FirstUseEver)
                imgui.Begin(u8('Medic Tools | ����� ��������'), ystwindow)
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
	local text = '����������:'
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8(text)).x)/3)
    imgui.Text(u8(text))
	imgui.SameLine()
	imgui.TextColored(imgui.ImVec4(0.90, 0.16 , 0.30, 1.0), 'Rancho Grief.')
	imgui.Image(test, imgui.ImVec2(890, 140))
    imgui.Separator()
	if imgui.Button(u8'������', imgui.ImVec2(50, 30)) then
      bMainWindow.v = not bMainWindow.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_COGS .. u8' ��������� �������', imgui.ImVec2(141, 30)) then
      first_window.v = not first_window.v
    end
    imgui.SameLine()
    if imgui.Button(fa.ICON_EXCLAMATION_TRIANGLE .. u8' �������� �� ������/����', imgui.ImVec2(181, 30)) then os.execute('explorer "https://vk.com/artyom.fomin2016"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_REFRESH .. u8' ������������� ������', imgui.ImVec2(155, 30)) then
      showCursor(false)
      thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_WRENCH .. u8' ���������� � �����������', imgui.ImVec2(192, 30)) then
      obnova.v = not obnova.v
    end
    if imgui.Button(fa.ICON_POWER_OFF .. u8' ��������� ������', imgui.ImVec2(135, 30), btn_size) then
      showCursor(false)
      thisScript():unload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_INFO .. u8 ' ������', imgui.ImVec2(70, 30)) then
      helps.v = not helps.v
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_STOP_CIRCLE .. u8' ���������� ������', imgui.ImVec2(145, 30)) then
	showCursor(false)
	thisScript():reload()
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_LINE_CHART .. u8' ������� ���������', imgui.ImVec2(155, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-sistema-povyshenija-upd-14-03-20.133094/-�������-���������-�����������-��������.71029/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_BOOK .. u8' �����', imgui.ImVec2(70, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-ustav-ministerstva-i-sistema-nakazanij.132703/"')
    btn_size = not btn_size
    end
	imgui.SameLine()
    if imgui.Button(fa.ICON_QUESTION .. u8' ������ ��� �������� [FAQ]', imgui.ImVec2(195, 30)) then os.execute('explorer "https://evolve-rp.su/index.php?threads/moh-f-a-q-informacija-dlja-novichkov.111667//"')
    btn_size = not btn_size
    end
	imgui.Separator()
	imgui.BeginChild("����������", imgui.ImVec2(410, 150), true)
	imgui.Text(u8 '��� � �������:   '..sampGetPlayerNickname(myid):gsub('_', ' ')..'')
	imgui.Text(u8 '���������:') imgui.SameLine() imgui.Text(u8(rank))
	imgui.Text(u8 '����� ��������:   '..tel..'')
	if cfg.main.tarb then
	imgui.Text(u8 '��� � �����:') imgui.SameLine() imgui.Text(u8(cfg.main.tarr))
	end
	if cfg.main.clistb then
	imgui.Text(u8 '����� ��������:   '..cfg.main.clist..'')
	end
	imgui.EndChild()
	imgui.Separator()
	imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(u8("������� ����: %s")).x)/1.5)
	imgui.Text(u8(string.format("������� ����: %s", os.date())))
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
            imgui.Text((u8"����������: %s [%s] | ����: %s"):format(myname, myid, myping))
            if isCharInAnyCar(playerPed) then
                local vHandle = storeCarCharIsInNoSave(playerPed)
                local result, vID = sampGetVehicleIdByCarHandle(vHandle)
                local vHP = getCarHealth(vHandle)
                local carspeed = getCarSpeed(vHandle)
                local speed = math.floor(carspeed)
                local vehName = tCarsName[getCarModel(storeCarCharIsInNoSave(playerPed))-399]
                local ncspeed = math.floor(carspeed*2)
                imgui.Text((u8 '���������: %s [%s]|HP: %s|��������: %s'):format(vehName, vID, vHP, ncspeed))
            else
                imgui.Text(u8 '���������: ���')
            end
			    imgui.Text((u8 '�����: %s'):format(os.date('%H:%M:%S')))
            if valid and doesCharExist(ped) then 
                local result, id = sampGetPlayerIdByCharHandle(ped)
                if result then
                    local targetname = sampGetPlayerNickname(id)
                    local targetscore = sampGetPlayerScore(id)
                    imgui.Text((u8 '����: %s [%s] | �������: %s'):format(targetname, id, targetscore))
                else
                    imgui.Text(u8 '����: ���')
                end
            else
                imgui.Text(u8 '����: ���')
            end
			local cx, cy, cz = getCharCoordinates(PLAYER_PED)
			local zcode = getNameOfZone(cx, cy, cz)
			imgui.Text((u8 '�������: %s | �������: %s'):format(u8(getZones(zcode)), u8(kvadrat())))
			imgui.Text((u8 '��������: %s | �������� �� �����: %s'):format((health), u8(narkoh)))
            inicfg.save(cfg, 'medick/config.ini')
            imgui.End()
        end
    if obnova.v then
                local iScreenWidth, iScreenHeight = getScreenResolution()
                imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(7, 3))
                 imgui.Begin(fa.ICON_WRENCH .. u8'����������.', obnova, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("����������.", imgui.ImVec2(540, 250), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '��� ���� �������:')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.2')
				imgui.BulletText(u8 '1.������� /z - ��� ������� � ����������.')
				imgui.BulletText(u8 '2.��������� ���������� ������� ���+Z.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.3')
				imgui.BulletText(u8 '1.������� ����������� ��� ��� �������� � Medick Helper.')
                imgui.BulletText(u8 '2.������������ �������� ���� ���������.')
				imgui.BulletText(u8 '3.��������� ������ ���� � �������� � �������.')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.4')
				imgui.BulletText(u8 '1.������� ���� ����������')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.5')
				imgui.BulletText(u8 '1.������ ��.���� ����������� �� /mh')
				imgui.BulletText(u8 '2.��������� � ���� ���+Z ���� �������������')
				imgui.Separator()
				imgui.BulletText(u8 'v2.9.7')
				imgui.BulletText(u8 '1.����������� ��������� /sethud')
				imgui.Separator()
				imgui.BulletText(u8 'v3.0')
				imgui.BulletText(u8 '1.������ ������ ��� ��� ���������� �� Instructors helper.')
				imgui.BulletText(u8 '2.� ���� ���+Z ��������� �������� �� �����.')
				imgui.BulletText(u8 '3.��������� ����� ������ � Gov.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.2')
				imgui.BulletText(u8 '1.���������� ��������� �������� � ���������� �������.')
				imgui.BulletText(u8 '2.��������� ����� ������ � ������ �������.')
				imgui.BulletText(u8 '3.���������� ��������.')
                imgui.Separator()
				imgui.BulletText(u8 'v3.8')
				imgui.BulletText(u8 '1.��������� ���� "/smslog" � "/rlog".')
				imgui.BulletText(u8 '2.��������� ������� ���������.')
				imgui.BulletText(u8 '3.��������� ����� ������, ������ ��������� �� ������.')
				imgui.BulletText(u8 '4.��������� ������������ ����������.')
				imgui.BulletText(u8 '5.������� ������� ���.')
				imgui.Separator()
				imgui.BulletText(u8 'v3.8.1')
				imgui.BulletText(u8 '1.������ reboot ������� �� ������ v3.7" ')
				imgui.BulletText(u8 '2.������ ���������, ����� ������������.')
				imgui.BulletText(u8 '3.��������� ����� ������, �������� ������.')
				imgui.BulletText(u8 '4.��������� "/smslog".')
				imgui.BulletText(u8 '5.��������� ������.')
				imgui.BulletText(u8 '5.������� ���������.')
				imgui.Separator()
				imgui.BulletText(u8 '����� � �����������:')
				imgui.BulletText(u8('�� (�����������).'))
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
                imgui.Begin(fa.ICON_INFO .. u8 '������ �� �������.', helps, imgui.WindowFlags.NoResize, imgui.WindowFlags.NoCollapse)
				imgui.BeginChild("������ ������", imgui.ImVec2(495, 230), true, imgui.WindowFlags.VerticalScrollbar)
                imgui.BulletText(u8 '/mh - ������� ���� �������.')
                imgui.Separator()
				imgui.BulletText(u8 '/z [id] - �������� �������� � ����.')
				imgui.BulletText(u8 '/vig [id] [�������] - ������ ������� �� �����.')
				imgui.BulletText(u8 '/ivig [id] [�������] - ������ ������� ������� �� �����.')
				imgui.BulletText(u8 '/unvig [id] [�������] - ����� ������� �� �����.')
                imgui.BulletText(u8 '/dmb - ������� /members � �������.')
				imgui.BulletText(u8 '/blg [id] [�������] [�������] - �������� ������ ������������� � /d.')
				imgui.BulletText(u8 '/oinv[id] - ������� �������� � �����.')
				imgui.BulletText(u8 '/zinv[id] - ��������� �������� ������������ ������.')
				imgui.BulletText(u8 '/ginv[id] - ��������� �������� ������ ������.')
                imgui.BulletText(u8 '/where [id] - ��������� �������������� �� �����.')
                imgui.BulletText(u8 '/yst - ������� ����� ��������.')
				imgui.BulletText(u8 '/smsjob - ������� �� ������ ���� ��.������ �� ���.')
                imgui.BulletText(u8 '/dlog - ������� ��� 25 ��������� ��������� � �����������.')
				imgui.BulletText(u8 '/sethud - ���������� ������� ����-����.')
				imgui.BulletText(u8 '/cinv - �������� � CR.')
				imgui.Separator()
                imgui.BulletText(u8 '�������: ')
                imgui.BulletText(u8 '���+Z �� ������ - ���� ��������������.')
                imgui.BulletText(u8 'F3 - "������� ����."')
				imgui.EndChild()
                imgui.End()
    end
  if bMainWindow.v then
  local iScreenWidth, iScreenHeight = getScreenResolution()
	local tLastKeys = {}

   imgui.SetNextWindowPos(imgui.ImVec2(iScreenWidth / 2, iScreenHeight / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
   imgui.SetNextWindowSize(imgui.ImVec2(800, 530), imgui.Cond.FirstUseEver)

   imgui.Begin(u8("Medic Help | ������##main"), bMainWindow, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize)
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
				imgui.TextDisabled(u8("������ ��������� ..."))
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
			imgui.Checkbox(u8("����") .. "##editCH" .. k, bIsEnterEdit)
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

	if imgui.Button(u8"�������� �������") then
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

function showHelp(param) -- "��������" ��� �������
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
    select_button, close_button, back_button = select_button or '�', close_button or 'x', back_button or '�'
    prev_menus = {}
    function display(menu, id, caption)
        local string_list = {}
        for i, v in ipairs(menu) do
            table.insert(string_list, type(v.submenu) == 'table' and v.title .. ' �' or v.title)
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
        ftext('������� /r [�����].')
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
        ftext('������� /f [�����].')
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
        title = "{80a4bf}�{ffffff} ���� �����.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(instmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
      {
        title = "{80a4bf}� {ffffff}������ �������.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(oformenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
		title = "{80a4bf}�{FFFFFF} ������� �� ������/�������� {ff0000}(��.�������)",
		onclick = function()
		if rank == '��������' or rank == '������' or rank == '���.����.�����' or rank == '����.����' then
		submenus_show(ustav(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."]")
		else
		ftext('������ ���� �������� � ��������� ��������.')
		end
		end
   },
	  {
        title = "{80a4bf}� {ffffff}������ ����.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(priziv(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}� {ffffff}�������� ������",
        onclick = function()
        pID = tonumber(args)
        submenus_show(virus(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{80a4bf}� {ffffff}���� �������������.",
        onclick = function()
        pID = tonumber(args)
        if rank == '������' or rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '����.����' then
		submenus_show(sobesedmenu(id), "{9966cc}Medick Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
		else
		ftext('������ ���� �������� � ��������� ��������.')
		end
        end
      },
	  {
        title = "{ffffff}� ���� ��������, �������, ���������.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(renmenu(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}� ����������� ������.",
        onclick = function()
        pID = tonumber(args)
        submenus_show(medosmotr(id), "{9966cc}Medic Helper {ffffff}| {"..color.."}"..sampGetPlayerNickname(id).."["..id.."] ")
        end
      },
	  {
        title = "{ffffff}� ������ ���.������.",
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
   title = '{80a4bf}�{FFFFFF} �������� �1.',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d OG, ����������� �������� ����� � ������� ����� �����������. ��������� �� pgr. '..myid..'.')
	end
	
	 },
    {
   title = '{80a4bf}�{FFFFFF} �������� �2.',
    onclick = function()
	local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
	local myname = sampGetPlayerNickname(myid)
	sampSendChat('/d AF, � ����� Cleveland ��������� �������� ������������. ��������� �� pgr. '..myid..'.')
	end
   },
}
end
function ustav(id)
    return
    {
      {
        title = '{5b83c2}� ������ ������. �',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}� {ffffff}������� ����� ������ ����������, ����� ������� �� ������ � ����������� � ������� �����?',
        onclick = function()
        sampSendChat("������� ����� ������ ����������, ����� ������� �� ������ � ����������� � ������� �����?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}15 �����.", -1)
		end
      },
      {
        title = '{80a4bf}� {ffffff}� ����� ��������� ��������� ������������ ����� ������������ � �������� �����������?',
        onclick = function()
        sampSendChat("� ����� ��������� ��������� ������������ ����� ������������ � �������� �����������?")
		wait(500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}� ��������� ���.�����.", -1)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}� ����� ��������� ��������� �������� � �������� ������� �����?',
        onclick = function()
        sampSendChat(" � ����� ��������� ��������� �������� � �������� ������� �����?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}� ��������� ���.�����.", -1)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}� ����� ��������� ��������� ������������ ��������-������������ ��������?',
        onclick = function()
        sampSendChat("� ����� ��������� ��������� ������������ ��������-������������ ��������?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}� ��������� ���������, �� ���������� {ff0000}���-�� � �������.", -1)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}����� ��������� ��������� �������� �� ����� �������� ���?',
        onclick = function()
        sampSendChat("����� ��������� ��������� �������� �� ����� �������� ���?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}���������, ������.", -1)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}������� ������ ��������� ��������� Evolve, ����� ����� �� ������� ������?',
        onclick = function()
        sampSendChat("������� ������ ��������� ��������� Evolve, ����� ����� �� ������� ������?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}�� {ff0000}100.000 �� {ff0000}150.000 ����.", -1)
		end
      },
	  {
        title = '{5b83c2}� ������ �������� �� ������������. �',
        onclick = function()
        end
	  },
	  {
        title = '{80a4bf}� {ffffff}����� ���.��������� �� �������� �� ���� � ������?',
        onclick = function()
        sampSendChat("����� ���.��������� �� �������� �� ���� � ������?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}��-���, ����������, ���������, ����������, �������.", -1)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}����� ���.��������� �� �������� ��� ���� � ������?',
        onclick = function()
        sampSendChat("����� ���.��������� �� �������� ��� ���� � ������?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}�������, ��������, ��������, ����������, ���������.", -1)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}����� ���.��������� �� �������� �� ���� � �����?',
        onclick = function()
        sampSendChat("����� ���.��������� �� �������� �� ���� � �����?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}��������, ��������, ���������.", -1)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}����� ���.��������� �� �������� �� �����������?',
        onclick = function()
        sampSendChat("����� ���.��������� �� �������� �� �����������?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}�����������, �������, �������, �����.", -1)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}����� ���.��������� �� �������� ��� �����?',
        onclick = function()
        sampSendChat("����� ���.��������� �� �������� ��� �����?")
		wait(1500)
		ftext("{FFFFFF}- ���������� �����: {A52A2A}���������, �����������, ���, ����������, ������ ���.", -1)
		end
      },
	  {
        title = '{5b83c2}� ������ �������� �� ������������. �',
        onclick = function()
        end
	  },
	  {
        title = '{80a4bf}� {ffffff}���',
        onclick = function()
        sampSendChat("���������� �������� �� ����� �� ������� �����, � ����������� ���������� ���, �������� �������� �� ������...")
		wait(1500)
		sampSendChat("...������� ��� �������� ���� ������� ��� �������, ������ ������������ � ���� ���, ���� ��������?")
		end
      },
	  {
        title = '{80a4bf}� {ffffff}���������.',
        onclick = function()
        sampSendChat("�� ����� �� ���� � ������ ��� �� ����� ����� ������� � ������������� �������� � ����...")
		wait(1500)
		sampSendChat("...� ����� ���� ���.�����, ����������� ���������� ����, ���� ��������?")
		end
      },
	  {
        title = '{80a4bf}� {ffffff}�������.',
        onclick = function()
        sampSendChat("�� ������ ��� ������� ���� � �������, ���� ��������?")
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
        title = '{5b83c2}� ������ �����. �',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}� {ffffff}�����������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        local myname = sampGetPlayerNickname(myid)
        sampSendChat("������������. � ��������� �������� "..myname:gsub('_', ' ')..", ��� ���� ������?")
		end
      },
      {
        title = '{80a4bf}� {ffffff}�������.',
        onclick = function()
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
        sampSendChat("��� �������, ����������.")
		wait(5000)
		sampSendChat("/b /showpass "..myid.."")
        end
      },
	  {
        title = '{80a4bf}� {ffffff}����������� � ��������.',
        onclick = function()
        sampSendChat("����� ��� �������.")
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
        title = '{5b83c2}� ������ �������. �',
        onclick = function()
        end
      },
      {
        title = '{80a4bf}� {ffffff}�������.',
        onclick = function()
		  sampSendChat("/do ����� ����� ����� �������� ���. ����� �� �����.")
		  wait(2000)
          sampSendChat("/me ������ �� ���.����� ��������� � ��������� ����")
          wait(2000)
		  sampSendChat('/me ������� ��������� � ��������� ���� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
		  wait(1100)
		  sampSendChat("/heal "..id) 
		  end
      },
	  {
        title = '{80a4bf}� {ffffff}�������.',
        onclick = function()
		sampSendChat("/do �� ����� ����� ���� � ���.������� � ��������������� ����������.")
        wait(3000)
        sampSendChat(" ������ �� �� ������ �� ��������?")
        wait(3000)
        sampSendChat("/do � ����� ���� ������ �����.")
        wait(3000)
        sampSendChat("/me ������ ������ � ���.�����")
        wait(3000)
        sampSendChat("/me ������ �� ����� ��������������� ���������")
        wait(3000)
        sampSendChat("��������������, ������ ������������.")
        wait(3000)
        sampSendChat("/me ������ �� ����� ��������������� ���������")
        wait(3000)
        sampSendChat('/me ����� ���������� ����� ������� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me ��������, ��� ������ �������� �������������� � ������� � �����")
        wait(3000)
        sampSendChat("/me ������ ������ � ���.�����")
        wait(3000)
        sampSendChat('/me ������ ���������� �� ������ ������ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat('/me ������ ���������� �� ������� ������ '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
		sampSendChat("/checkheal "..id)
		end
      },
	  {
        title = '{ffffff}� ��������� ����� ��������.',
        onclick = function()
        sampSendChat("/me ������ �������")
        wait(3000) 
        sampSendChat("/me ������ �� ������� ����� � ��������")
        wait(3000) 
        sampSendChat("/me ��������� ����� ���������, ����� ���� ������ � ���� �������������")
        wait(3000) 
        sampSendChat("/me ����� ������ ������ ����")
        wait(3000) 
        sampSendChat("�� ����������, � ��� �������� � �������.")
        wait(3000) 
        sampSendChat("������ �� �������� ��� � ��������, ��� ���������� � �������� ������� ������.") 
		end
      },
	  {
        title = '{80a4bf}� {ffffff}������� �� ����������������.',
        onclick = function()
		sampSendChat("/do ����� ����� ����� �������� ���.����� �� �����.")
        wait(2000)
        sampSendChat("/me ������ �� ���.����� �����.")
		wait(2000)
		sampSendChat("/do ����� � ����� ����.")
		wait(2000)
		sampSendChat('/me ��������� ����� ����� ����� �� ���� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(2000)
		sampSendChat('/me ���������� ��������� ������ �������� � ���� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(2000)
		sampSendChat("/todo �� ��� � ��*������� ����� �� ���� � �������� ���� � ����� �����.")
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
        title = '{5b83c2}� ��� ��������/�������� ���������: �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� ��� �������� �������� ����/����: �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) ��� ������ �� ������ ������ ���������� ����� ����� � ���� �������������.',
        onclick = function()
        sampSendChat("/do ����������� ���� � ����.")
        wait(3000) 
        sampSendChat("/me ������� ����������� ���� �� ��� � ������ ���")
        wait(3000) 
        sampSendChat("/do � ����� �����: ���������� ������, ������ � ������������, ����, �����")
        wait(3000) 
        sampSendChat("/me ������ ���������� ����� � �������, ��������� ��������� ������ � ������������")
		wait(3000) 
        sampSendChat("/me ������� ���������� ������ � �����")
		wait(3000) 
        sampSendChat("/me ������� ����� �������������, ����� ���� ��� ���������� ����� ����� � ����, ������ �������")
		wait(3000) 
        sampSendChat("/do ���������� ������ � �������� �������������.")
		wait(3000) 
        sampSendChat("/me ����� �������������� ����� � ����������� �����")
		end
      },
	  {
        title = '{ffffff}� 2) ������� ������ �������� ����.',
        onclick = function()
        sampSendChat("/me ������ �� ����� ����, ����� �������� ����������� � �� ����������� ����������")
        wait(3000) 
        sampSendChat("/me ��������� ������� ���� �� ����������� ����������")
        wait(3000) 
        sampSendChat("/do ���� ����������� �������� �� ����������� ����������.")
		end
      },
	  {
        title = '{ffffff}� 3) ����� ������ ���������������� ����������� ���������� � ������� �������.',
        onclick = function()
        sampSendChat("/me ���� �� ����� ���������� ����� � ������ �������")
        wait(3000) 
        sampSendChat("/me �������� ����������� ���������� � �������� ���������")
        wait(3000) 
        sampSendChat("/do ����������� ���������� ��������������. ")
		end
      },
	  {
        title = '{5b83c2}� ��� �������� �������� ����/����: �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) ��� ������ �� ������ ������ ���������� ����� ����� � ���� �������������.',
        onclick = function()
        sampSendChat("/do ����������� ���� � ����.")
        wait(3000) 
        sampSendChat("/me ������� ����������� ���� �� ��� � ������ ���")
        wait(3000) 
        sampSendChat("/do � ����� �����: ���������� ������, ������ � ������������, ����, �����, ���������� � ����.")
        wait(3000) 
        sampSendChat("/me ������ ���������� ����� � �������, ��������� ��������� ������ � ������������")
		wait(3000) 
        sampSendChat("/me ������� ���������� ������ � �����")
		wait(3000) 
        sampSendChat("/me ������� ����� �������������, ����� ���� ��� ���������� ����� ����� � ����, ������ �������")
		wait(3000) 
        sampSendChat("/do ���������� ������ � �������� �������������.")
		wait(3000) 
        sampSendChat("/me ����� �������������� ����� � ����������� �����")
		end
      },
	  {
        title = '{ffffff}� 2) ������� ������ �������� ����, ���������� ���� ������������, �������� ����.',
        onclick = function()
        sampSendChat("/me ������ �� ����� �������������������� ����, ����� ����� ����������� ���")
        wait(3000) 
        sampSendChat("/me ������� ���� ������ ���� �� ����������� ����������")
        wait(3000) 
        sampSendChat("/me ������ �� ����� ����� � ��������������� ���������")
        wait(3000) 
        sampSendChat("/me ��������� ���� ��������������� ���������")
		wait(3000) 
        sampSendChat("/me ����� ����� � ����, ������ ����")
		wait(3000) 
        sampSendChat("/me ��������� ������� ���� �� ����������� ����������")
		wait(3000) 
        sampSendChat("/do ���� ����������� �������� �� ����������� ����������.")
		end
      },
	  {
        title = '{ffffff}� 3) ������� ���������������� ����������� ���������� � ������� �������.',
        onclick = function()
        sampSendChat("/me ���� �� ����� ���������� ����� � ����� ������ �������")
        wait(3000) 
        sampSendChat("/me ������ ������� �� ����������� �����")
        wait(3000) 
        sampSendChat("/me �������� ����������� ���������� � �������� ���������")
		wait(3000) 
        sampSendChat("/do ����������� ���������� ��������������.")
		end
      },
	  {
        title = '{5b83c2}� ��� ������/�����������: �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) ��� ������ ����� ���������� ����� ����� ����������� ������.',
        onclick = function()
        sampSendChat("/do ����������� ���� � ����.")
        wait(3000) 
        sampSendChat("/me ������ �� ����� ����� '�����' � ��������� ���� ������")
        wait(3000) 
        sampSendChat("/do ����� ����� ���������� ����������� ������.")
		end
      },
	  {
        title = '{ffffff}� 2) ����� ����� �������� �� ����������� ���������� ���������� ����.',
        onclick = function()
        sampSendChat("/me ������ ���� � ������ �� �� ���������� ����")
        wait(3000) 
        sampSendChat("/me ����� ����� � ���� � ������� �� ���������� ������������� ���������� ����")
        wait(3000) 
        sampSendChat("/me ������ ������� ���������� ����")
		wait(3000) 
        sampSendChat("/do ���������� ���� ������ ����� �� ���������� ��������.")
		end
      },
	  {
        title = '{5b83c2}�  �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� ��� �������/������������� ��������: �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� ��� ������� ��������: �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) ��� ������ ����� ���������� ���� ������������� ��� ����� ��������.',
        onclick = function()
        sampSendChat("/me �������� ���� � ������� �������� �����������")
        wait(3000) 
        sampSendChat("/do ������� ����.")
        wait(3000) 
        sampSendChat("/do ����������� ���� � ����.")
		wait(3000) 
        sampSendChat("/me ������ �� ���� ������� ������������� � ��������� ���� �������������")
		wait(3000) 
        sampSendChat("/me ����� � ����� ������� �������������")
		end
      },
	  {
        title = '{ffffff}� 2) ����� ��������� ���� ������� ������� �� ������ ��������� �������, �������� � �� ����.',
        onclick = function()
        sampSendChat("/me ������ ����� �� ������������ ����� � ������ �� ��� ��������� �������")
        wait(3000) 
        sampSendChat("/me ������� ������� �� ����")
        wait(3000) 
        sampSendChat("/do ����� ������ ����.")
		wait(3000) 
        sampSendChat("/do ������� ������ �������� � ��������� ����.")
		end
      },
	  {
        title = '{5b83c2}� ��� ������������� ��������: �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) ������� ����� ���������� ������������. ��� ����� ����� ���������� ����� ������� �� ������.',
        onclick = function()
        sampSendChat("/do ����������� ���� � ����.")
        wait(3000) 
        sampSendChat("/me ������ ������� � ������ �� ������������ ����� ����")
        wait(3000) 
        sampSendChat("/me ��������� ���� ������������� �� ������ � ����� ����������� ����")
		wait(3000) 
        sampSendChat("/do ���� �������, ������������ �����������.")
		wait(3000) 
        sampSendChat("/me ������ ������� �� ������� � ������� ����� ��������� �����")
		end
      },
	  {
        title = '{ffffff}� 2) ����� ����� ���������� ���� �������������� ��� ������ ��������.',
        onclick = function()
        sampSendChat("/me ������ ����� � ������ �� �� ������� �������������")
        wait(3000) 
        sampSendChat("/me ��������� ���� ������������� � ������� ������� ������������� � �����")
		end
      },
	  {
        title = '{ffffff}� 3) ����� ���� ���������� �������� ����� ������� �� ������ ��������� �������, �������� �.',
        onclick = function()
        sampSendChat("/me ������ ����� �� ������������ ����� � ������ �� ��� ��������� �������")
        wait(3000) 
        sampSendChat("/me ����� ����������� ������� �� ����")
        wait(3000) 
        sampSendChat("/do ����� ���������� ������ �������� ����.")
		wait(3000) 
        sampSendChat("/do ������� ������ �������� � ��������� ����.")
		end
      },
	  {
        title = '{5b83c2}�  �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� ��� ��������: �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) �������� �������� � ��������.',
        onclick = function()
        sampSendChat("/do ����������� ���� � ����.")
        wait(3000) 
        sampSendChat("/me ������� ����������� ���� �� ��� � ������ ���")
        wait(3000) 
        sampSendChat("/me ������ �� ����� ������ � ���������� ������� � ������ ���")
		wait(3000) 
        sampSendChat("/me ������ �� ����� ����� � ������� � ���������� �������")
		wait(3000) 
        sampSendChat("/me ������ ��������� ����� � ���� �������������")
		wait(3000) 
        sampSendChat("/do ������� �������?")
		wait(3000) 
        sampSendChat("/b /do �a/���.")
		end
      },
	  {
        title = '{ffffff}� 2) ���� ������� ������ � ����.',
        onclick = function()
        sampSendChat("� ���� �� ������, �����������, �� �������� ��������.")
        wait(3000) 
        sampSendChat("������ �� � �������, � ���� ��� ��� ���-�� ������?")
		end
      },
	  {
        title = '{ffffff}� 3) ���� ������� �� ������ � ����.',
        onclick = function()
        sampSendChat("/me ������ �������� ������ �� ����� ��������")
        wait(3000) 
        sampSendChat("/me ������ �� ����� ������� � �������� ����� � �������� ������")
		wait(3000) 
        sampSendChat("/me ������� ����� �� ������� �� ���� �������������")
		wait(3000) 
        sampSendChat("/me �������� ������������� �� �����")
		wait(3000) 
        sampSendChat("/do ������� ������ � ��������?")
		wait(3000) 
        sampSendChat("/b /do �a/���.")
		end
      },
	  {
        title = '{5b83c2}� ���� ������� ������ � ���� �� ����� �������� �2. �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 4) ���� ������� �� ��� ��� �� ������ � ����, ��������� �����.',
        onclick = function()
        sampSendChat("/me ������ ��� ������ � ��� �������������, �������� �� � ������ �������")
        wait(3000) 
        sampSendChat("/do � �������� ���� �����?")
		wait(3000) 
        sampSendChat("/b /do ��/���. ")
		end
      },
	  {
        title = '{ffffff}� 5) ���� � ������������� ��� ������, �� ����� �������� ��� �������� ��������������.',
        onclick = function()
        sampSendChat("/me ������ �� ����� ��������� � �������� ��� ��� ��� �������������")
        wait(3000) 
        sampSendChat("/me ���� � ����� �������� ��� ������")
		wait(3000) 
        sampSendChat("/me ���� ��� ������������ ����������")
		wait(3000) 
        sampSendChat("/me ������ �������� ���� � ����� ������ ������������� ������� �����")
		wait(3000) 
        sampSendChat("/do ������ ���������� ��������� ����� �������������.")
		wait(3000) 
        sampSendChat("/me ������� ���� ���� �� ����� �� ����� ��������")
		wait(3000) 
        sampSendChat("/me ������ �������� ������ ������")
		wait(3000) 
        sampSendChat("/me ����������� ������ ������������� ������� � �������� ������ ������")
		wait(3000) 
        sampSendChat("/do ������� ������ � ����?")
		wait(3000) 
        sampSendChat("/b /do ��/���. ")
		end
      },
	  {
        title = '{5b83c2}� ���� ������� ������ ����� ���� �������� ����� � �������� ��� �������. �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� ���� ������� �� ������ � ���� ����� � �������� ��� ������������ ������. �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}�  �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� ��� ������ ������: �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) ���� � ������������� ��� ������, �� ����� �������� ��� �������� ��������������.',
        onclick = function()
        sampSendChat("/do ����������� ���� � ����.")
        wait(3000) 
        sampSendChat("/me ������ �� ����� ��������� � �������� ��� ��� ��� �������������")
		wait(3000) 
        sampSendChat("/me ���� � ����� �������� ��� ������ � ��� ������������ ���������� ")
		end
      },
	  {
        title = '{ffffff}� 2) ���� � ������������� ��� ������, �� ����� �������� ��� �������� ��������������.',
        onclick = function()
        sampSendChat("/me ������ �������� ���� � ����� ������ ������������� ������� �����")
        wait(3000) 
        sampSendChat("/do ������ ���������� ��������� ����� �������������.")
		wait(3000) 
        sampSendChat("/me ������� ���� �� ����� ��������")
		wait(3000) 
        sampSendChat("/me ������ �������� ������ ������")
		wait(3000) 
        sampSendChat("/me ����������� ������ ������������� ������� � �������� ������ ������.")
		wait(3000) 
        sampSendChat("/do ������ ������.")
		wait(3000) 
        sampSendChat("/do ������� ������ � ����?")
		wait(3000) 
        sampSendChat("/b /do ��/���.")
		end
      },
	  {
        title = '{5b83c2}� ���� ������� �� ������ � ���� ��, ����������� �� �� �������� � ������� 4 �����. �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� ���� ������� �� ������ � ���� ��, ������ ��� � �������� ������������� ������. �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}�  �',
        onclick = function()
        end
      },
	  {
        title = '{5b83c2}� ��� ������: �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� 1) ����� ���������� ��������� ������� ���� �� ������.',
        onclick = function()
        sampSendChat("/do ����������� ���� � ����.")
        wait(3000) 
        sampSendChat("/me ������� ���� �� ��� � ������ �� ���� ����������� �������")
		wait(3000) 
        sampSendChat("/me ���������� ������� � ��������� ��������� ������� ���� �� ������")
		end
      },
	  {
        title = '{ffffff}� 2) ����� ����� ���������� ���������� ������� ���� ������ "�������".',
        onclick = function()
        sampSendChat("/me ������ �� ����� ����� '�������' � ������ ��� ��������")
        wait(3000) 
        sampSendChat("/me �������� ������ ���������� ������� ���� � ������ �����")
		wait(3000) 
        sampSendChat("/me ����� ��� � ����������� ���� � ������ �� �� �����")
		end
      },
	  {
        title = '{ffffff}� 3) � ����� ���� �������� ������� �������� ������� �� ������ �� ��������� ������� ����.',
        onclick = function()
        sampSendChat("/me ������� ������� �� ������ �� ����")
        wait(3000) 
        sampSendChat("/do ������� ������ ����� �� �����.")
		end
      },
	 }
end
function medosmotr(args)
    return
    {
      {
        title = '{ffffff}� ������������, ������ �� ������',
        onclick = function()
        sampSendChat("������ ����, �������� ���� ���.�����, ���� � ��� ������ ��� � ������ ��������.")
        wait(3000) 
        sampSendChat("/me ��������� ���.�����")
        wait(3000) 
        sampSendChat("/me ������ ������ � ������� ��������.")
        wait(3000) 
        sampSendChat("��������� � ������� �����.")
		end
      },
	  {
        title = '{ffffff}� ������ � ��������� �1.',
        onclick = function()
        sampSendChat("������ ����, �������������� �� ������� � ��������� �����.")
        wait(3000) 
        sampSendChat("��� ����� ����� ������ �����.")
        wait(3000) 
        sampSendChat("/me ������ �� �����: ����, ������ ����� � �����, ��������� �������.")
        wait(3000) 
        sampSendChat("/me ������� ���� �� ���� ��������")
		wait(3000) 
        sampSendChat("/me ��������� ������ ����� ������� ��������")
		wait(3000) 
        sampSendChat("/me ���� ������� ����������� ���������� ����� � ����")
		wait(3000) 
        sampSendChat("/me �������� ����� � ����� �����")
		wait(3000) 
        sampSendChat("/me ������� ����� �� ������ � ��������")
		wait(3000) 
        sampSendChat("/me ������� �������� ������� � ��������")
		end
      },
	  {
        title = '{5b83c2}� ��������� �������� /checkheal [id]. �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� ������ � ��������� �1.',
        onclick = function()
        sampSendChat("/me ������ ���������� �������� � ���.�����")
		wait(3000) 
        sampSendChat("/me ������� ���.�����")
		wait(3000) 
        sampSendChat("������ ��������� � ��������� �������.")
		end
      },
	  {
        title = '{ffffff}� ������ � ��������.',
        onclick = function()
        sampSendChat("������ ����, �������������� �� ����.")
        wait(3000) 
        sampSendChat("/do �� ����� ����.������.")
        wait(3000) 
        sampSendChat("/me ���������� �� ����� '�'")
        wait(3000) 
        sampSendChat("����� ��� �����?")
		wait(10000) 
        sampSendChat("/me ���������� �� ����� '�'")
		wait(3000) 
        sampSendChat("����� ����� �� ������?")
		wait(10000) 
        sampSendChat("/me ���������� �� ������� '������'")
		wait(3000) 
        sampSendChat("��� �� ������?")
		wait(10000) 
        sampSendChat("/me ���������� �� ������� '�����'")
		wait(3000) 
        sampSendChat("�� ��� � ��� ���������?")
		wait(10000) 
        sampSendChat("/me ������� ���������� � ���.�����")
		wait(3000) 
        sampSendChat("/me ������� ���.�����")
		wait(3000) 
        sampSendChat("��� ������, �� �������. ��������� ������.")
		end
      },
	  {
        title = '{5b83c2}� ������ � ��������� (����� ������� �� ���� ����� �� ����������). �',
        onclick = function()
        end
      },
	  {
        title = '{ffffff}� ������� ������ (��������� �����).',
        onclick = function()
        sampSendChat("������ ����, �� ������ ���� ������������?")
        wait(3000) 
        sampSendChat("����� ��� ���� ���.����� ��� ������������.")
        wait(3000) 
        sampSendChat("/do � ����� ���.�����.")
        wait(3000) 
        sampSendChat("/me ��������� ����������")
        wait(3000) 
        sampSendChat("/me �������� ������� �����")
        wait(3000) 
        sampSendChat("/me ������� ������ ���.�����")
        wait(3000) 
        sampSendChat("/do � ����� ����� � �������.")
        wait(3000) 
        sampSendChat("/me ������� ������� � ���������")
        wait(3000) 
        sampSendChat("/me ������� �������")
        wait(3000) 
        sampSendChat("����� �������.") 
		end
      },
	 }
end
function renmenu(args)
    return
    {
      {
        title = '{5b83c2}� ������ ��������. �',
        onclick = function()
        end
      },
      {
        title = '{ffffff}� ������������� �������.',
        onclick = function()
        sampSendChat("�������� �� ������� � ������ ������.")
        wait(3000) 
        sampSendChat("/me ������� ������������� �������")
        wait(3000) 
        sampSendChat("/do ������������� ������� �������.")
        wait(3000) 
        sampSendChat("/me ������ ������������� ��������� �� ������������� �������")
        wait(3000) 
        sampSendChat("/me ������������� ������")
        wait(3000) 
        sampSendChat("/try ��������� �������") 
		end
      },
      {
        title = '{5b83c2}� ���� � �������� ������� �����������. �',
        onclick = function()
        end
      },
      {
        title = '{ffffff}� ������� �����������.',
        onclick = function()
        sampSendChat("�������� �� �������.")
        wait(3000) 
        sampSendChat("/me ���� �� ����� �������� � ����� ��")
        wait(3000) 
        sampSendChat("/do ������������� ������� �������.")
        wait(3000) 
        sampSendChat("/me ���� ����� � ��������������, ����� ���� ��������� ������������ �������")
        wait(3000) 
        sampSendChat("/me ������ ��������� ������������� �������")
        wait(3000) 
        sampSendChat("/me ���������� �������� ��������")
        wait(3000) 
        sampSendChat("/me �������� ���� ����� �����, ����� ���� ���� �������� �������")
        wait(3000) 
        sampSendChat("/me ������� ����, ����� ���� ������������ �������")
        wait(3000) 
        sampSendChat("��������� ����� �����. ����� �������.")
        wait(3000) 
        sampSendChat("/me ���� �������� � ������ �� � ���� ����� �����") 
		end
      },
      {
        title = '{5b83c2}� ���� � �������� ������� ������������/�����. �',
        onclick = function()
        end
      },
      {
        title = '{ffffff}� ������� ������������/�����.',
        onclick = function()
        sampSendChat("/me ��������� ����� ������������� �� ������������ ����")
        wait(3000) 
        sampSendChat("/me ���� �� ����� �������� � ����� ��")
        wait(3000) 
        sampSendChat("/me ��������� ������������� � ����������")
        wait(3000) 
        sampSendChat("/me ������� ����� ������� � ��������� ���� �� ���� ��������")
        wait(3000) 
        sampSendChat("/me ����������� ���� ��������")
        wait(3000) 
        sampSendChat("/do ������ �������� �����������, ������� ������� ��������.")
        wait(3000) 
        sampSendChat("/me ������ ��������� � ������")
        wait(3000) 
        sampSendChat("/me � ������� ��������� ������������ �������� ��������� ������������� �������")
        wait(3000) 
        sampSendChat("/me ������ �� �������� ����������� ������")
        wait(3000) 
        sampSendChat("/me ������������ ������������ ������� � ������� �������")
        wait(3000) 
        sampSendChat("/me ���� �������� � ������ �� � ���� ����� �����")
        wait(3000) 
        sampSendChat("/me ����� � ��������� ��������� ������� ��������������")
        wait(3000) 
        sampSendChat("/do ������ ��������� �����, ������� ������ � ��������.") 
		end
      },
      {
        title = '{5b83c2}� ���� � �������� �������� �����. �',
        onclick = function()
        end
      },
      {
        title = '{ffffff}� �������� �����.',
        onclick = function()
        sampSendChat("/me ���� �� ����� �������� � ����� ��")
        wait(3000) 
        sampSendChat("/me ������ ������ ��������")
        wait(3000) 
        sampSendChat("/me ��������� ������� ������� ������ � ��������")
        wait(3000) 
        sampSendChat("/me ��������� ������������ �������")
        wait(3000) 
        sampSendChat("/me ������ �� ���. ����� ���� � ������� ��� ������ �����������")
        wait(3000) 
        sampSendChat("/me �������� ������������� ����������� �� �����")
        wait(3000) 
        sampSendChat("/me ���� ����������� ���� � ����")
        wait(3000) 
        sampSendChat("/me ����� ����������� ����� � �������� �����")
        wait(3000) 
        sampSendChat("/me ������ ����� � ����� ����� ������")
        wait(3000) 
        sampSendChat("/me ������� ���� � ���� � �������")
        wait(3000) 
        sampSendChat("/me ���� ����, ���� ����� � ������������ ������������ ������� ����")
        wait(3000) 
        sampSendChat("�� ������� �������, �������� ���, �� �������.")
        wait(3000) 
        sampSendChat("/me ����� � ��������� ��������� ������� ��������������") 
		end
      },
    }
end
function priziv(id)
    return
    {
	  {
        title = '{80a4bf}� {ffffff}�����������.',
        onclick = function()
		sampSendChat("������� ������� �����, ����������� ��� �� �������.")
        wait(2000)
		sampSendChat("������ ����� ������������ ������� ������������� ���� ��������.")
        wait(2000)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}�������� ����������.',
        onclick = function()
		sampSendChat("/me �������� ����� ���� � ���� ������� � �������� �� ������.")
        wait(3000)
		sampSendChat("/do ������� � ����� ����.")
        wait(3000)
		sampSendChat("/me ������ ������� �� ������ �������� � �������� ������ ��������.")
        wait(3000)
		sampSendChat("/me ������ �������.")
        wait(3000)
		sampSendChat("/do ������� ������.")
        wait(3000)
		sampSendChat("/me ������ ������� �������� �� ������.")
        wait(3000)
		end
      },
	  {
        title = '{80a4bf}� {ffffff}�������� �� �������.',
        onclick = function()
		sampSendChat("- ������. ������ �� �������� ��� �� ������� ����������������.")
        wait(3000)
        sampSendChat("/do ����� ����� ����� �������� ���.����� �� �����.")
        wait(3000)
        sampSendChat("/me ������ �� ���.����� ����, �����, ����� � ����������� ��������")
        wait(3000)
        sampSendChat("/me �������� ���� �������")
        wait(3000)
        sampSendChat("/do ����������� ������� ���� � ����� ����.")
        wait(3000)
        sampSendChat('/me ��������� ����� ����� ����� �� ���� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/do ����� � ����������� �������� � ������ ����.")
        wait(3000)
        sampSendChat('/me ���������� ��������� ������ ����� � ���� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me � ������� ������ ���� ������� ����� ��� �������")
        wait(3000)
        sampSendChat("/me ������� ����� �� ������ � ����������� �����, ����� �������� � � ����-�����������")
        wait(1300)
		sampSendChat("/checkheal "..id)
		end
      },
	  {
        title = '{80a4bf}� {ffffff} �����.',
        onclick = function()
		sampSendChat('/do �� ������ ������� ������������� ��������� ����� ����� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("/me ������� ������� � ���, ��� ������� �� ����� ���������������� � ����� � ������.")
        wait(3000)
		sampSendChat("/me ������� ������� �������� � ����")
		wait(3000)
		sampSendChat("/do ��������� ������ ���� �� ��������.")
		end
      },
	  {
        title = '{80a4bf}� {ffffff} �� �����',
        onclick = function()
		sampSendChat('/do �� ������ ������� ������������� ��������� ����� ����� '..sampGetPlayerNickname(id):gsub('_', ' ')..'')
        wait(3000)
        sampSendChat("�� ������ ����������������. �������� ����� �� ����������� � ���������.")
        wait(3000)
		sampSendChat("/me �������� ������ '�� �����' �� ���.����� ����������")
		end
      }
    }
end
function virus(id)
    return
    {
	  {
        title = '{80a4bf}� {ffffff}�����������.',
        onclick = function()
		sampSendChat("������ ����,������ �� �������� ��� ���� �� �����.")
        wait(7000)
		sampSendChat("�� �� ������ ���� � ��� ����� ��������� ��������?")
        wait(10000)
		sampSendChat("���� �� � ��� ������� � ������ ������, ����� ��� ��������������, �������, ����������?")
        wait(15000)
		sampSendChat("������.")
		end
      },
	  {
        title = '{80a4bf}� {ffffff}�������� �����������.',
        onclick = function()
		sampSendChat("/do �� ���� ����� ����������� �����.")
        wait(10000)
        sampSendChat("/me ������ ���.����� .")
        wait(10000)
        sampSendChat("/do ���.����� �������.")
        wait(10000)
        sampSendChat("/me ������ �� ���.����� ����������� ���������.")
        wait(10000)
        sampSendChat("/do ����������� ��������� � ����� ����.")
        wait(10000)
        sampSendChat("/me ������� ����������� ��������� �������� �� ������.")
        wait(10000)
        sampSendChat("��������, ��������� � ��������� ��� ��� ��������.")
        wait(10000)
        sampSendChat("������, ������� ������� ��������.")
        wait(10000)
        sampSendChat("��� ������� ��������� ���.")
        wait(10000)
        sampSendChat("/me ���� ��������� � �������� �� ������ � ��������� �����������.")
        wait(10000)
        sampSendChat("/do ����������� 36.6.")
        wait(10000)
        sampSendChat("������, � ������������ � ��� ��� ������.")
		end
      },
	  {
        title = '{80a4bf}� {ffffff}�������� ����������� (���� ������� �������).',
        onclick = function()
		sampSendChat("/do �� ���� ����� ����������� �����.")
        wait(10000)
        sampSendChat("/me ������ ���.����� .")
        wait(10000)
        sampSendChat("/do ���.����� �������.")
        wait(10000)
        sampSendChat("/me ������ �� ���.����� ����������� ���������.")
        wait(10000)
        sampSendChat("/do ����������� ��������� � ����� ����.")
        wait(10000)
        sampSendChat("/me ������� ����������� ��������� �������� �� ������.")
        wait(10000)
        sampSendChat("��������, ��������� � ��������� ��� ��� ��������.")
        wait(10000)
        sampSendChat("������, ������� ������� ��������.")
        wait(10000)
        sampSendChat("��� ������� ��������� ���.")
        wait(10000)
        sampSendChat("/me ���� ��������� � �������� �� ������ � ��������� �����������.")
        wait(10000)
        sampSendChat("/do ����������� 36.7.")
        wait(10000)
        sampSendChat("������ �� �������� ������������, �� � ���� ��� ������ ���������.")
		end
      },
	  {
        title = '{80a4bf}� {ffffff} ������ �����',
        onclick = function()
		sampSendChat("/me ������ �� ���.����� ����, �����, ����� � ����������� ��������.")
        wait(10000)
        sampSendChat("/me �������� ���� �������")
        wait(10000)
        sampSendChat("/do ����������� ������� ���� � ����� ����.")
        wait(10000)
        sampSendChat('/me ��������� ����� ����� ����� �� ���� ��������.')
        wait(10000)
        sampSendChat("/do ����� � ����������� �������� � ������ ����.")
        wait(10000)
        sampSendChat('/me ���������� ��������� ������ ����� � ����.')
        wait(10000)
        sampSendChat("/me � ������� ������ ���� ������� ����� ��� �������.")
        wait(10000)
        sampSendChat("/me ������� ����� �� ������ � ����������� �����.")
        wait(10000)
        sampSendChat("/me ������ ����� �������.")
        wait(10000)
        sampSendChat("������, ������ �������� ���������� �������.")
        wait(10000)
		end
      }
    }
end
function getFraktionBySkin(playerid)
    fraks = {
        [0] = '�����������',
        [1] = '�����������',
        [2] = '�����������',
        [3] = '�����������',
        [4] = '�����������',
        [5] = '�����������',
        [6] = '�����������',
        [7] = '�����������',
        [8] = '�����������',
        [9] = '�����������',
        [10] = '�����������',
        [11] = '�����������',
        [12] = '�����������',
        [13] = '�����������',
        [14] = '�����������',
        [15] = '�����������',
        [16] = '�����������',
        [17] = '�����������',
        [18] = '�����������',
        [19] = '�����������',
        [20] = '�����������',
        [21] = 'Ballas',
        [22] = '�����������',
        [23] = '�����������',
        [24] = '�����������',
        [25] = '�����������',
        [26] = '�����������',
        [27] = '�����������',
        [28] = '�����������',
        [29] = '�����������',
        [30] = 'Rifa',
        [31] = '�����������',
        [32] = '�����������',
        [33] = '�����������',
        [34] = '�����������',
        [35] = '�����������',
        [36] = '�����������',
        [37] = '�����������',
        [38] = '�����������',
        [39] = '�����������',
        [40] = '�����������',
        [41] = 'Aztec',
        [42] = '�����������',
        [43] = '�����������',
        [44] = 'Aztec',
        [45] = '�����������',
        [46] = '�����������',
        [47] = 'Vagos',
        [48] = 'Aztec',
        [49] = '�����������',
        [50] = '�����������',
        [51] = '�����������',
        [52] = '�����������',
        [53] = '�����������',
        [54] = '�����������',
        [55] = '�����������',
        [56] = 'Grove',
        [57] = '�����',
        [58] = '�����������',
        [59] = '���������',
        [60] = '�����������',
        [61] = '�����',
        [62] = '�����������',
        [63] = '�����������',
        [64] = '�����������',
        [65] = '�����������', -- ��� ��������
        [66] = '�����������',
        [67] = '�����������',
        [68] = '�����������',
        [69] = '�����������',
        [70] = '���',
        [71] = '�����������',
        [72] = '�����������',
        [73] = 'Army',
        [74] = '�����������',
        [75] = '�����������',
        [76] = '�����������',
        [77] = '�����������',
        [78] = '�����������',
        [79] = '�����������',
        [80] = '�����������',
        [81] = '�����������',
        [82] = '�����������',
        [83] = '�����������',
        [84] = '�����������',
        [85] = '�����������',
        [86] = 'Grove',
        [87] = '�����������',
        [88] = '�����������',
        [89] = '�����������',
        [90] = '�����������',
        [91] = '�����������', -- ��� ��������
        [92] = '�����������',
        [93] = '�����������',
        [94] = '�����������',
        [95] = '�����������',
        [96] = '�����������',
        [97] = '�����������',
        [98] = '�����',
        [99] = '�����������',
        [100] = '������',
        [101] = '�����������',
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
        [121] = '�����������',
        [122] = '�����������',
        [123] = 'Yakuza',
        [124] = 'LCN',
        [125] = 'RM',
        [126] = 'RM',
        [127] = 'LCN',
        [128] = '�����������',
        [129] = '�����������',
        [130] = '�����������',
        [131] = '�����������',
        [132] = '�����������',
        [133] = '�����������',
        [134] = '�����������',
        [135] = '�����������',
        [136] = '�����������',
        [137] = '�����������',
        [138] = '�����������',
        [139] = '�����������',
        [140] = '�����������',
        [141] = 'FBI',
        [142] = '�����������',
        [143] = '�����������',
        [144] = '�����������',
        [145] = '�����������',
        [146] = '�����������',
        [147] = '�����',
        [148] = '�����������',
        [149] = 'Grove',
        [150] = '�����',
        [151] = '�����������',
        [152] = '�����������',
        [153] = '�����������',
        [154] = '�����������',
        [155] = '�����������',
        [156] = '�����������',
        [157] = '�����������',
        [158] = '�����������',
        [159] = '�����������',
        [160] = '�����������',
        [161] = '�����������',
        [162] = '�����������',
        [163] = 'FBI',
        [164] = 'FBI',
        [165] = 'FBI',
        [166] = 'FBI',
        [167] = '�����������',
        [168] = '�����������',
        [169] = 'Yakuza',
        [170] = '�����������',
        [171] = '�����������',
        [172] = '�����������',
        [173] = 'Rifa',
        [174] = 'Rifa',
        [175] = 'Rifa',
        [176] = '�����������',
        [177] = '�����������',
        [178] = '�����������',
        [179] = 'Army',
        [180] = '�����������',
        [181] = '������',
        [182] = '�����������',
        [183] = '�����������',
        [184] = '�����������',
        [185] = '�����������',
        [186] = 'Yakuza',
        [187] = '�����',
        [188] = '���',
        [189] = '�����������',
        [190] = 'Vagos',
        [191] = 'Army',
        [192] = '�����������',
        [193] = 'Aztec',
        [194] = '�����������',
        [195] = 'Ballas',
        [196] = '�����������',
        [197] = '�����������',
        [198] = '�����������',
        [199] = '�����������',
        [200] = '�����������',
        [201] = '�����������',
        [202] = '�����������',
        [203] = '�����������',
        [204] = '�����������',
        [205] = '�����������',
        [206] = '�����������',
        [207] = '�����������',
        [208] = 'Yakuza',
        [209] = '�����������',
        [210] = '�����������',
        [211] = '���',
        [212] = '�����������',
        [213] = '�����������',
        [214] = 'LCN',
        [215] = '�����������',
        [216] = '�����������',
        [217] = '���',
        [218] = '�����������',
        [219] = '���',
        [220] = '�����������',
        [221] = '�����������',
        [222] = '�����������',
        [223] = 'LCN',
        [224] = '�����������',
        [225] = '�����������',
        [226] = 'Rifa',
        [227] = '�����',
        [228] = '�����������',
        [229] = '�����������',
        [230] = '�����������',
        [231] = '�����������',
        [232] = '�����������',
        [233] = '�����������',
        [234] = '�����������',
        [235] = '�����������',
        [236] = '�����������',
        [237] = '�����������',
        [238] = '�����������',
        [239] = '�����������',
        [240] = '���������',
        [241] = '�����������',
        [242] = '�����������',
        [243] = '�����������',
        [244] = '�����������',
        [245] = '�����������',
        [246] = '������',
        [247] = '������',
        [248] = '������',
        [249] = '�����������',
        [250] = '���',
        [251] = '�����������',
        [252] = 'Army',
        [253] = '�����������',
        [254] = '������',
        [255] = 'Army',
        [256] = '�����������',
        [257] = '�����������',
        [258] = '�����������',
        [259] = '�����������',
        [260] = '�����������',
        [261] = '���',
        [262] = '�����������',
        [263] = '�����������',
        [264] = '�����������',
        [265] = '�������',
        [266] = '�������',
        [267] = '�������',
        [268] = '�����������',
        [269] = 'Grove',
        [270] = 'Grove',
        [271] = 'Grove',
        [272] = 'RM',
        [273] = '�����������', -- ���� ��������
        [274] = '���',
        [275] = '���',
        [276] = '���',
        [277] = '�����������',
        [278] = '�����������',
        [279] = '�����������',
        [280] = '�������',
        [281] = '�������',
        [282] = '�������',
        [283] = '�������',
        [284] = '�������',
        [285] = '�������',
        [286] = 'FBI',
        [287] = 'Army',
        [288] = '�������',
        [289] = '�����������',
        [290] = '�����������',
        [291] = '�����������',
        [292] = 'Aztec',
        [293] = '�����������',
        [294] = '�����������',
        [295] = '�����������',
        [296] = '�����������',
        [297] = 'Grove',
        [298] = '�����������',
        [299] = '�����������',
        [300] = '�������',
        [301] = '�������',
        [302] = '�������',
        [303] = '�������',
        [304] = '�������',
        [305] = '�������',
        [306] = '�������',
        [307] = '�������',
        [308] = '���',
        [309] = '�������',
        [310] = '�������',
        [311] = '�������'
    }
    if sampIsPlayerConnected(playerid) then
        local result, handle = sampGetCharHandleBySampPlayerId(playerid)
        local skin = getCharModel(handle)
        return fraks[skin]
    end
end

function a.onSendClickPlayer(id)
	if rank == '������' or rank == '�����������' or rank == '��.����������' or rank == '����������' or rank == '������' or rank == '��������' or rank == '������' or rank == '���.����.�����' or rank == '����.����' then
    setClipboardText(sampGetPlayerNickname(id))
	ftext('��� ���������� � ����� ������.')
	else
	end
end

function smsjob()
  if rank == '������' or rank == '��������' or rank == '������' or rank == '���.����.�����' or  rank == '����.����' then
    lua_thread.create(function()
        vixodid = {}
		status = true
		sampSendChat('/members')
        while not gotovo do wait(0) end
        wait(1200)
        for k, v in pairs(vixodid) do
            sampSendChat('/sms '..v..' �����������, ������� �� ������, � ��� 15 �����')
            wait(1200)
        end
        players2 = {'{ffffff}���\t{ffffff}����\t{ffffff}������'}
		players1 = {'{ffffff}���\t{ffffff}����'}
		gotovo = false
        status = false
        vixodid = {}
	end)
	else
	ftext('������ ������� �������� � ��������� ��������.')
	end
end

function update()
    local updatePath = os.getenv('TEMP')..'\\Update.json'
    -- �������� ����� ������
    downloadUrlToFile("https://raw.githubusercontent.com/RanchoGrief/medichelper/main/Update.json", updatePath, function(id, status, p1, p2)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            local file = io.open(updatePath, 'r')
            if file and doesFileExist(updatePath) then
                local info = decodeJson(file:read("*a"))
                file:close(); os.remove(updatePath)
                if info.version ~= thisScript().version then
                    lua_thread.create(function()
                        wait(2000)
                        -- �������� �������, ���� ������ ����������
                        downloadUrlToFile("https://raw.githubusercontent.com/RanchoGrief/medichelper/main/Medick_Helper_Rancho_Grief.lua", thisScript().path, function(id, status, p1, p2)
                            if status == dlstatus.STATUS_ENDDOWNLOADDATA then
                                ftext('���������� �� ���������� ������ '..info.version..' ����������. ������� ���������.')
                                thisScript():reload()
                            end
                        end)
                    end)
                else
                    ftext('���������� �� ���������� ��� ��� ������ ��� �����������. ���������� ������ '..info.version..'.', -1)
                end
            end
        end
    end)
end

function cmd_color() -- ������� ��������� ����� ������, �� ����� ��� ���, �� ����� �� ����
	local text, prefix, color, pcolor = sampGetChatString(99)
	sampAddChatMessage(string.format("���� ��������� ������ ���� - {934054}[%d] (���������� � ����� ������).",color),-1)
	setClipboardText(color)
end

function getcolor(id)
local colors =
        {
		[1] = '������',
		[2] = '������-������',
		[3] = '����-������',
		[4] = '���������',
		[5] = 'Ƹ���-������',
		[6] = '�����-������',
		[7] = '����-������',
		[8] = '�������',
		[9] = '����-�������',
		[10] = '���������',
		[11] = '����������',
		[12] = 'Ҹ���-�������',
		[13] = '����-�������',
		[14] = 'Ƹ���-���������',
		[15] = '���������',
		[16] = '�������',
		[17] = '�����',
		[18] = '�������',
		[19] = '����� �����',
		[20] = '����-������',
		[21] = 'Ҹ���-�����',
		[22] = '����������',
		[23] = '������',
		[24] = '����-�����',
		[25] = 'Ƹ����',
		[26] = '����������',
		[27] = '�������',
		[28] = '������ ������',
		[29] = '���������',
		[30] = '�����',
		[31] = '�������',
		[32] = '������',
		[33] = '�����',
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
            ftext('���� ���� ������ ��: {'..color..'}'..cfg.main.clist..' ['..colors..']')
        end)
    end
end
-- ���� dmb n
-- ���� dmb z
function sampev.onServerMessage(color, text)
        if text:find('������� ���� �����') and color ~= -1 then
        if cfg.main.clistb then
		if rabden == false then
            lua_thread.create(function()
                wait(100)
				sampSendChat('/clist '..tonumber(cfg.main.clist))
				wait(500)
                local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
			    local color = ("%06X"):format(bit.band(sampGetPlayerColor(myid), 0xFFFFFF))
                colors = getcolor(cfg.main.clist)
                ftext('���� ���� ������ ��: {'..color..'}'..cfg.main.clist..' ['..colors..']')
                rabden = true
				wait(1000)
				if cfg.main.clisto then
				local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local myname = sampGetPlayerNickname(myid)
				if cfg.main.male == true then
				sampSendChat("/me ������ �������")
                wait(3000)
                sampSendChat("/me ���� ���� ������, ����� ���� ������ �� � ����")
                wait(3000)
                sampSendChat("/me ���� ������� ������, ����� ���������� � ���")
                wait(3000)
                sampSendChat("/me ������� ������� �� �������")
                wait(3000)
                sampSendChat('/do �� ������� ������� � �������� "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
				if cfg.main.male == false then
				sampSendChat("/me ������� �������")
                wait(3000)
                sampSendChat("/me ����� ���� ������, ����� ���� ������� �� � ����")
                wait(3000)
                sampSendChat("/me ����� ������� ������, ����� ����������� � ���")
                wait(3000)
                sampSendChat("/me �������� ������� �� �������")
                wait(3000)
                sampSendChat('/do �� ������� ������� � �������� "'..rank..' | '..myname:gsub('_', ' ')..'".')
				end
			end
            end)
        end
	  end
    end
	if text:find('SMS:') and text:find('�����������:') then
		wordsSMS, nickSMS = string.match(text, 'SMS: (.+) �����������: (.+)');
		local idsms = nickSMS:match('.+%[(%d+)%]')
		lastnumber = idsms
	end
    if text:find('������� ���� �������') and color ~= -1 then
        rabden = false
    end
	if text:find('�� ��������') then
        local Nicks = text:match('�� �������� ������ (.+).')
		health = health + 1
   end
   	if text:find('����� ������� �� ����������������') then
        local Nicks = text:match('�� �������� ������ (.+) �� ����������������.')
		narkoh = narkoh + 1
   end
	if text:find('�� ������� (.+) �� �����������. �������: (.+).') then
        local un1, un2 = text:match('�� ������� (.+) �� �����������. �������: (.+).')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: %s - ������ �� ������� "%s".', cfg.main.tarr, un1:gsub('_', ' '), un2))
        else
		sampSendChat(string.format('/r %s - ������ �� ������� "%s".', un1:gsub('_', ' '), un2))
		end
		end)
    end
	if text:find('�������(- �) ������������� (.+)') then
        local inv1 = text:match('�������(- �) ������������� (.+)')
		lua_thread.create(function()
		wait(3000)
		if cfg.main.tarb then
        sampSendChat(string.format('/r [%s]: '..sampGetPlayerNickname(id):gsub('_', ' ')..' - %s ����� ��������� ���������� ���������. ������������! %s%s', cfg.main.tarr, inv1:gsub('_', ' ')))
        else
		sampSendChat(string.format('/r %s - ����� ��������� ���������� ���������. ������������! %s%s', inv1:gsub('_', ' ')))
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
	if color == -65366 and (text:match('SMS%: .+. �����������%: .+') or text:match('SMS%: .+. ����������%: .+')) then
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
		if text:match('�����: %d+ �������') then
			local count = text:match('�����: (%d+) �������')
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
            if stat:find('��������') and tonumber(nmrang) < 7 then
                table.insert(vixodid, id)
            end
			table.insert(players2, string.format('{ffffff}%s\t {'..color..'}%s[%s]{ffffff}\t%s\t%s', data, nick, id, rang, stat))
			return false
		end
		if text:match('�����: %d+ �������') then
			local count = text:match('�����: (%d+) �������')
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
    if names[zone] == nil then return '�� ����������' end
    return names[zone]
end
function kvadrat()
    local KV = {
        [1] = "�",
        [2] = "�",
        [3] = "�",
        [4] = "�",
        [5] = "�",
        [6] = "�",
        [7] = "�",
        [8] = "�",
        [9] = "�",
        [10] = "�",
        [11] = "�",
        [12] = "�",
        [13] = "�",
        [14] = "�",
        [15] = "�",
        [16] = "�",
        [17] = "�",
        [18] = "�",
        [19] = "�",
        [20] = "�",
        [21] = "�",
        [22] = "�",
        [23] = "�",
        [24] = "�",
    }
    local X, Y, Z = getCharCoordinates(playerPed)
    X = math.ceil((X + 3000) / 250)
    Y = math.ceil((Y * - 1 + 3000) / 250)
    Y = KV[Y]
    local KVX = (Y.."-"..X)
    return KVX
end