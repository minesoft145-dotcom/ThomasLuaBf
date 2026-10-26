local Players=game:GetService("Players")
local CoreGui=game:GetService("CoreGui")
local TweenService=game:GetService("TweenService")
local Workspace=game:GetService("Workspace")
local PathfindingService=game:GetService("PathfindingService")
local UserInputService=game:GetService("UserInputService")
local VirtualUser=game:GetService("VirtualUser")
local LP=Players.LocalPlayer

local Themes={
Spirits={BgTop=Color3.fromRGB(0,0,0),BgBottom=Color3.fromRGB(60,0,0),Sidebar=Color3.fromRGB(15,0,0),Accent=Color3.fromRGB(139,0,0),Text=Color3.fromRGB(255,255,255),SubText=Color3.fromRGB(200,200,200),ToggleOn=Color3.fromRGB(139,0,0),ToggleOff=Color3.fromRGB(40,40,40),Divider=Color3.fromRGB(139,0,0)},
Skeet={BgTop=Color3.fromRGB(0,0,0),BgBottom=Color3.fromRGB(0,45,20),Sidebar=Color3.fromRGB(0,15,5),Accent=Color3.fromRGB(0,120,60),Text=Color3.fromRGB(255,255,255),SubText=Color3.fromRGB(180,220,200),ToggleOn=Color3.fromRGB(0,120,60),ToggleOff=Color3.fromRGB(40,40,40),Divider=Color3.fromRGB(0,120,60)},
["Purple Haze"]={BgTop=Color3.fromRGB(0,0,0),BgBottom=Color3.fromRGB(45,0,60),Sidebar=Color3.fromRGB(15,0,20),Accent=Color3.fromRGB(120,0,160),Text=Color3.fromRGB(255,255,255),SubText=Color3.fromRGB(210,190,230),ToggleOn=Color3.fromRGB(120,0,160),ToggleOff=Color3.fromRGB(40,40,40),Divider=Color3.fromRGB(120,0,160)},
Shailushai={BgTop=Color3.fromRGB(25,75,155),BgBottom=Color3.fromRGB(15,55,125),Sidebar=Color3.fromRGB(35,95,185),Accent=Color3.fromRGB(85,165,255),Text=Color3.fromRGB(245,250,255),SubText=Color3.fromRGB(200,220,240),ToggleOn=Color3.fromRGB(85,165,255),ToggleOff=Color3.fromRGB(70,90,130),Divider=Color3.fromRGB(105,185,255)}}

local CTN="Shailushai"
local Theme=Themes[CTN]
local State={ChestESP=false,FruitESP=false,AutoChest=false,AutoLevel=false,FastAttack=false,Magnet=false,AutoCollectFruit=false,AutoStats=false,SelectedStat="Melee"}
local CH,FH={},{}
local ACR=false
local ALR=false
local FastAttackEnabled=false
local MagnetEnabled=false
local ALR=false
local ACFR=false
local ASR=false

if CoreGui:FindFirstChild("BloxLegitMenu") then CoreGui.BloxLegitMenu:Destroy() end

local SG=Instance.new("ScreenGui")
SG.Name="ThomasLua"
SG.ResetOnSpawn=false
SG.IgnoreGuiInset=true
SG.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
SG.Parent=CoreGui

local Main=Instance.new("Frame")
Main.Size=UDim2.new(0,650,0,550)
Main.Position=UDim2.new(0.5,-325,0.5,-275)
Main.BackgroundColor3=Theme.BgTop
Main.BorderSizePixel=0
Main.Active=true
Main.Draggable=true
Main.ClipsDescendants=true
Main.Parent=SG
local MC=Instance.new("UICorner");MC.CornerRadius=UDim.new(0,16);MC.Parent=Main
local MS=Instance.new("UIStroke");MS.Color=Theme.Accent;MS.Thickness=2.5;MS.Parent=Main
local Grad=Instance.new("UIGradient");Grad.Rotation=90
Grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Theme.BgTop),ColorSequenceKeypoint.new(1,Theme.BgBottom)})
Grad.Parent=Main

-- Glassmorphism effect
local GlassOverlay=Instance.new("Frame")
GlassOverlay.Size=UDim2.new(1,0,1,0)
GlassOverlay.BackgroundColor3=Color3.fromRGB(255,255,255)
GlassOverlay.BackgroundTransparency=0.97
GlassOverlay.BorderSizePixel=0
GlassOverlay.Parent=Main
local GlassC=Instance.new("UICorner")
GlassC.CornerRadius=UDim.new(0,16)
GlassC.Parent=GlassOverlay

-- Улучшенная тень с blur эффектом
local Shadow=Instance.new("ImageLabel")
Shadow.Size=UDim2.new(1,30,1,30)
Shadow.Position=UDim2.new(0,-15,0,-15)
Shadow.BackgroundTransparency=1
Shadow.Image="rbxassetid://6014261993"
Shadow.ImageColor3=Color3.fromRGB(0,0,0)
Shadow.ImageTransparency=0.75
Shadow.ScaleType=Enum.ScaleType.Slice
Shadow.SliceCenter=Rect.new(49,49,450,450)
Shadow.ZIndex=-1
Shadow.Parent=SG

-- Animated border glow
local GlowBorder=Instance.new("Frame")
GlowBorder.Size=UDim2.new(1,4,1,4)
GlowBorder.Position=UDim2.new(0,-2,0,-2)
GlowBorder.BackgroundColor3=Theme.Accent
GlowBorder.BackgroundTransparency=0.85
GlowBorder.BorderSizePixel=0
GlowBorder.ZIndex=-1
GlowBorder.Parent=Main
local GlowC=Instance.new("UICorner")
GlowC.CornerRadius=UDim.new(0,18)
GlowC.Parent=GlowBorder

local Side=Instance.new("Frame")
Side.Size=UDim2.new(0,160,1,0)
Side.BackgroundColor3=Theme.Sidebar
Side.BackgroundTransparency=0.05
Side.BorderSizePixel=0
Side.Parent=Main
local SideCorner=Instance.new("UICorner")
SideCorner.CornerRadius=UDim.new(0,16)
SideCorner.Parent=Side

-- Sidebar gradient overlay
local SideGrad=Instance.new("UIGradient")
SideGrad.Rotation=180
SideGrad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(255,255,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,0,0))})
SideGrad.Parent=Side

local SA=Instance.new("Frame")
SA.Size=UDim2.new(0,5,1,-30)
SA.Position=UDim2.new(0,0,0,15)
SA.BackgroundColor3=Theme.Accent
SA.BorderSizePixel=0
SA.Parent=Side
local SAC=Instance.new("UICorner")
SAC.CornerRadius=UDim.new(0,3)
SAC.Parent=SA

-- Animated accent indicator
spawn(function()
while true do
for i=0.5,1,0.02 do
pcall(function()
SA.BackgroundTransparency=1-i
end)
task.wait(0.03)
end
for i=1,0.5,-0.02 do
pcall(function()
SA.BackgroundTransparency=1-i
end)
task.wait(0.03)
end
task.wait(0.5)
end
end)

local VD=Instance.new("Frame")
VD.Size=UDim2.new(0,1,1,0)
VD.Position=UDim2.new(0,160,0,0)
VD.BackgroundColor3=Theme.Divider
VD.BackgroundTransparency=0.2
VD.BorderSizePixel=0
VD.Parent=Main

local LogoContainer=Instance.new("Frame")
LogoContainer.Size=UDim2.new(1,-20,0,70)
LogoContainer.Position=UDim2.new(0,10,0,15)
LogoContainer.BackgroundColor3=Theme.Accent
LogoContainer.BackgroundTransparency=0.75
LogoContainer.BorderSizePixel=0
LogoContainer.Parent=Side
local LogoC=Instance.new("UICorner")
LogoC.CornerRadius=UDim.new(0,12)
LogoC.Parent=LogoContainer
local LogoS=Instance.new("UIStroke")
LogoS.Color=Theme.Accent
LogoS.Thickness=2
LogoS.Transparency=0.5
LogoS.Parent=LogoContainer

-- Animated logo glow
spawn(function()
while true do
for i=0.5,1,0.03 do
pcall(function()
LogoS.Transparency=i
end)
task.wait(0.05)
end
for i=1,0.5,-0.03 do
pcall(function()
LogoS.Transparency=i
end)
task.wait(0.05)
end
task.wait(0.3)
end
end)

local Title=Instance.new("TextLabel")
Title.Size=UDim2.new(1,0,1,0)
Title.BackgroundTransparency=1
Title.Text="THOMAS\nLUA"
Title.Font=Enum.Font.GothamBold
Title.TextSize=20
Title.TextColor3=Theme.Text
Title.TextXAlignment=Enum.TextXAlignment.Center
Title.TextYAlignment=Enum.TextYAlignment.Center
Title.Parent=LogoContainer

-- Version label
local VerLabel=Instance.new("TextLabel")
VerLabel.Size=UDim2.new(1,0,0,14)
VerLabel.Position=UDim2.new(0,0,1,-2)
VerLabel.BackgroundTransparency=1
VerLabel.Text="v1.0 Premium"
VerLabel.Font=Enum.Font.Gotham
VerLabel.TextSize=10
VerLabel.TextColor3=Theme.Accent
VerLabel.TextTransparency=0.3
VerLabel.Parent=LogoContainer

-- Make pages scrollable
local function makeScrollable(page)
local SF=Instance.new("ScrollingFrame")
SF.Size=UDim2.new(1,0,1,0)
SF.BackgroundTransparency=1
SF.ScrollBarThickness=4
SF.ScrollBarImageColor3=Theme.Accent
SF.ScrollingDirection=Enum.ScrollingDirection.Y
SF.CanvasSize=UDim2.new(0,0,0,0)
SF.Parent=page

local Layout=Instance.new("UIListLayout")
Layout.SortOrder=Enum.SortOrder.LayoutOrder
Layout.Padding=UDim.new(0,8)
Layout.Parent=SF

Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
SF.CanvasSize=UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y+20)
end)

return SF
end

local Sections={"Auto Farm","ESP","Teleport","Settings"}
local SB={}
local AS="Auto Farm"
for i,name in ipairs(Sections) do
local B=Instance.new("TextButton")
B.Size=UDim2.new(1,-20,0,42)
B.Position=UDim2.new(0,10,0,90+(i-1)*48)
B.BackgroundColor3=Theme.Accent
B.BackgroundTransparency=0.85
B.BorderSizePixel=0
B.Text=name
B.Font=Enum.Font.GothamSemibold
B.TextSize=14
B.TextColor3=Theme.SubText
B.TextXAlignment=Enum.TextXAlignment.Left
B.AutoButtonColor=false
B.Parent=Side
local BC=Instance.new("UICorner");BC.CornerRadius=UDim.new(0,8);BC.Parent=B
local Ind=Instance.new("Frame")
Ind.Size=UDim2.new(0,4,1,-12)
Ind.Position=UDim2.new(0,0,0,6)
Ind.BackgroundColor3=Theme.Accent
Ind.BorderSizePixel=0
Ind.Visible=false
Ind.Parent=B
local IndC=Instance.new("UICorner")
IndC.CornerRadius=UDim.new(0,2)
IndC.Parent=Ind

local TextP=Instance.new("TextLabel")
TextP.Size=UDim2.new(1,-20,1,0)
TextP.Position=UDim2.new(0,10,0,0)
TextP.BackgroundTransparency=1
TextP.Text=name
TextP.Font=Enum.Font.GothamSemibold
TextP.TextSize=14
TextP.TextColor3=Theme.SubText
TextP.TextXAlignment=Enum.TextXAlignment.Left
TextP.Parent=B

B.MouseEnter:Connect(function() 
TextP.TextColor3=Theme.Text
B.BackgroundTransparency=0.75
end)
B.MouseLeave:Connect(function() 
if AS~=name then 
TextP.TextColor3=Theme.SubText
B.BackgroundTransparency=0.85 
end 
end)
SB[name]={Button=B,Indicator=Ind,Text=TextP}
end

local Content=Instance.new("Frame")
Content.Size=UDim2.new(1,-161,1,0)
Content.Position=UDim2.new(0,161,0,0)
Content.BackgroundTransparency=1
Content.Parent=Main
local CT=Instance.new("TextLabel")
CT.Size=UDim2.new(1,-20,0,50)
CT.Position=UDim2.new(0,16,0,16)
CT.BackgroundTransparency=1
CT.Text=AS
CT.Font=Enum.Font.GothamBold
CT.TextSize=20
CT.TextColor3=Theme.Text
CT.TextXAlignment=Enum.TextXAlignment.Left
CT.Parent=Content
local TD=Instance.new("Frame")
TD.Size=UDim2.new(1,-20,0,2)
TD.Position=UDim2.new(0,16,0,50)
TD.BackgroundColor3=Theme.Accent
TD.BackgroundTransparency=0.3
TD.BorderSizePixel=0
TD.Parent=Content
local TDC=Instance.new("UICorner")
TDC.CornerRadius=UDim.new(1,0)
TDC.Parent=TD
local Pages=Instance.new("Frame")
Pages.Size=UDim2.new(1,-20,1,-62)
Pages.Position=UDim2.new(0,16,0,62)
Pages.BackgroundTransparency=1
Pages.Parent=Content

local function mkToggle(parent,txt,y,init,cb)
local F=Instance.new("Frame")
F.Size=UDim2.new(1,0,0,46)
F.Position=UDim2.new(0,0,0,y)
F.BackgroundColor3=Theme.Sidebar
F.BackgroundTransparency=0.8
F.BorderSizePixel=0
F.Parent=parent
local FC=Instance.new("UICorner")
FC.CornerRadius=UDim.new(0,10)
FC.Parent=F
local FS=Instance.new("UIStroke")
FS.Color=Theme.Accent
FS.Thickness=1.5
FS.Transparency=0.7
FS.Parent=F

local L=Instance.new("TextLabel")
L.Size=UDim2.new(1,-70,0,46)
L.Position=UDim2.new(0,14,0,0)
L.BackgroundTransparency=1
L.Text=txt
L.Font=Enum.Font.GothamSemibold
L.TextSize=14
L.TextColor3=Theme.Text
L.TextXAlignment=Enum.TextXAlignment.Left
L.TextYAlignment=Enum.TextYAlignment.Center
L.Parent=F

local B=Instance.new("TextButton")
B.Size=UDim2.new(0,56,0,30)
B.Position=UDim2.new(1,-62,0.5,-15)
B.BackgroundColor3=init and Theme.ToggleOn or Theme.ToggleOff
B.BorderSizePixel=0
B.Text=""
B.AutoButtonColor=false
B.Parent=F
local BC=Instance.new("UICorner");BC.CornerRadius=UDim.new(1,0);BC.Parent=B
local BS=Instance.new("UIStroke")
BS.Color=Color3.fromRGB(255,255,255)
BS.Thickness=1
BS.Transparency=0.6
BS.Parent=B
local K=Instance.new("Frame")
K.Size=UDim2.new(0,26,0,26)
K.Position=init and UDim2.new(1,-28,0.5,-13) or UDim2.new(0,2,0.5,-13)
K.BackgroundColor3=Color3.fromRGB(255,255,255)
K.BorderSizePixel=0
K.Parent=B
local KC=Instance.new("UICorner");KC.CornerRadius=UDim.new(1,0);KC.Parent=K

-- Pulse animation when on
local pulseConn=nil
local function set(v)
on=v
TweenService:Create(B,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{BackgroundColor3=v and Theme.ToggleOn or Theme.ToggleOff}):Play()
TweenService:Create(K,TweenInfo.new(0.25,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Position=v and UDim2.new(1,-28,0.5,-13) or UDim2.new(0,2,0.5,-13)}):Play()
if v then
FS.Transparency=0.3
pulseConn=spawn(function()
while on do
for i=0.3,0.7,0.05 do
if not on then break end
pcall(function() FS.Transparency=i end)
task.wait(0.05)
end
for i=0.7,0.3,-0.05 do
if not on then break end
pcall(function() FS.Transparency=i end)
task.wait(0.05)
end
task.wait(0.2)
end
end)
else
FS.Transparency=0.7
end
cb(v)
end
B.MouseButton1Click:Connect(function() set(not on) end)

F.MouseEnter:Connect(function()
TweenService:Create(F,TweenInfo.new(0.15),{BackgroundTransparency=0.65}):Play()
end)
F.MouseLeave:Connect(function()
TweenService:Create(F,TweenInfo.new(0.15),{BackgroundTransparency=0.8}):Play()
end)

return {Label=L,Btn=B,Set=set,Frame=F}
end

local AFP=Instance.new("Frame")
AFP.Size=UDim2.new(1,0,1,0)
AFP.BackgroundTransparency=1
AFP.Visible=false
AFP.Parent=Pages

-- Scrollable container for Auto Farm
local AFPScroll=Instance.new("ScrollingFrame")
AFPScroll.Size=UDim2.new(1,0,1,0)
AFPScroll.BackgroundTransparency=1
AFPScroll.ScrollBarThickness=4
AFPScroll.ScrollBarImageColor3=Theme.Accent
AFPScroll.ScrollingDirection=Enum.ScrollingDirection.Y
AFPScroll.CanvasSize=UDim2.new(0,0,0,600)
AFPScroll.Parent=AFP

local AFPList=Instance.new("UIListLayout")
AFPList.SortOrder=Enum.SortOrder.LayoutOrder
AFPList.Padding=UDim.new(0,6)
AFPList.Parent=AFPScroll

AFPList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
AFPScroll.CanvasSize=UDim2.new(0,0,0,AFPList.AbsoluteContentSize.Y+20)
end)

local ACT=mkToggle(AFPScroll,"Auto Farm Chest",0,false,function(on) State.AutoChest=on; if on then startAutoChest() else stopAutoChest() end end)
local ALT=mkToggle(AFPScroll,"Auto Level Farm",56,false,function(on) State.AutoLevel=on; if on then startAutoLevel() else stopAutoLevel() end end)
local FastAT=mkToggle(AFPScroll,"Fast Attack",112,false,function(on) State.FastAttack=on end)
local MagT=mkToggle(AFPScroll,"Magnet Mobs",168,false,function(on) State.Magnet=on end)
local ACFruit=mkToggle(AFPScroll,"Auto Collect Fruits",224,false,function(on) State.AutoCollectFruit=on; if on then startAutoCollectFruit() else stopAutoCollectFruit() end end)
local AST=mkToggle(AFPScroll,"Auto Stats",280,false,function(on) State.AutoStats=on; if on then startAutoStats() else stopAutoStats() end end)

-- Stats dropdown
local StatsDropdown=Instance.new("TextButton")
StatsDropdown.Size=UDim2.new(1,0,0,40)
StatsDropdown.Position=UDim2.new(0,0,0,336)
StatsDropdown.BackgroundColor3=Theme.Sidebar
StatsDropdown.BackgroundTransparency=0.75
StatsDropdown.BorderSizePixel=0
StatsDropdown.Text="Selected: Melee"
StatsDropdown.Font=Enum.Font.GothamSemibold
StatsDropdown.TextSize=13
StatsDropdown.TextColor3=Theme.Text
StatsDropdown.AutoButtonColor=false
StatsDropdown.Parent=AFPScroll
local SDC=Instance.new("UICorner")
SDC.CornerRadius=UDim.new(0,8)
SDC.Parent=StatsDropdown
local SDS=Instance.new("UIStroke")
SDS.Color=Theme.Accent
SDS.Thickness=1.5
SDS.Transparency=0.5
SDS.Parent=StatsDropdown

local statsList={"Melee","Defense","Sword","Gun","Fruit"}
local currentStatIndex=1
StatsDropdown.MouseButton1Click:Connect(function()
currentStatIndex=currentStatIndex%#statsList+1
State.SelectedStat=statsList[currentStatIndex]
StatsDropdown.Text="Selected: "..State.SelectedStat
end)

local ScanBtn=Instance.new("TextButton")
ScanBtn.Size=UDim2.new(1,0,0,44)
ScanBtn.Position=UDim2.new(0,0,0,386)
ScanBtn.BackgroundColor3=Theme.Accent
ScanBtn.BackgroundTransparency=0.15
ScanBtn.BorderSizePixel=0
ScanBtn.Text="Scan World"
ScanBtn.Font=Enum.Font.GothamBold
ScanBtn.TextSize=15
ScanBtn.TextColor3=Color3.fromRGB(255,255,255)
ScanBtn.AutoButtonColor=false
ScanBtn.Parent=AFPScroll
local SC=Instance.new("UICorner");SC.CornerRadius=UDim.new(0,10);SC.Parent=ScanBtn
local SS=Instance.new("UIStroke")
SS.Color=Color3.fromRGB(255,255,255)
SS.Thickness=1
SS.Transparency=0.7
SS.Parent=ScanBtn
ScanBtn.MouseButton1Click:Connect(function() scanWorld() end)

ScanBtn.MouseEnter:Connect(function()
TweenService:Create(ScanBtn,TweenInfo.new(0.15),{BackgroundTransparency=0.05}):Play()
TweenService:Create(SS,TweenInfo.new(0.15),{Transparency=0.3}):Play()
end)
ScanBtn.MouseLeave:Connect(function()
TweenService:Create(ScanBtn,TweenInfo.new(0.15),{BackgroundTransparency=0.15}):Play()
TweenService:Create(SS,TweenInfo.new(0.15),{Transparency=0.7}):Play()
end)

local AFSContainer=Instance.new("Frame")
AFSContainer.Size=UDim2.new(1,0,0,80)
AFSContainer.Position=UDim2.new(0,0,0,440)
AFSContainer.BackgroundColor3=Theme.Sidebar
AFSContainer.BackgroundTransparency=0.75
AFSContainer.BorderSizePixel=0
AFSContainer.Parent=AFPScroll
local AFSCC=Instance.new("UICorner")
AFSCC.CornerRadius=UDim.new(0,10)
AFSCC.Parent=AFSContainer
local AFSS=Instance.new("UIStroke")
AFSS.Color=Theme.Accent
AFSS.Thickness=1.5
AFSS.Transparency=0.5
AFSS.Parent=AFSContainer

local AFS=Instance.new("TextLabel")
AFS.Size=UDim2.new(1,-12,1,-12)
AFS.Position=UDim2.new(0,6,0,6)
AFS.BackgroundTransparency=1
AFS.Text="📊 Статус: ожидание\n━━━━━━━━━━━━━━━━━━\nГотов к работе"
AFS.Font=Enum.Font.Gotham
AFS.TextSize=12
AFS.TextColor3=Theme.SubText
AFS.TextWrapped=true
AFS.TextXAlignment=Enum.TextXAlignment.Left
AFS.TextYAlignment=Enum.TextYAlignment.Top
AFS.Parent=AFSContainer

local ESPP=Instance.new("Frame")
ESPP.Size=UDim2.new(1,0,1,0)
ESPP.BackgroundTransparency=1
ESPP.Visible=false
ESPP.Parent=Pages
local ChestT=mkToggle(ESPP,"Chest ESP",0,false,function(on) State.ChestESP=on; if on then startChestESP() else stopChestESP() end end)
local FruitT=mkToggle(ESPP,"Fruit ESP",52,false,function(on) State.FruitESP=on; if on then startFruitESP() else stopFruitESP() end end)

-- TELEPORT PAGE
local TPP=Instance.new("ScrollingFrame")
TPP.Size=UDim2.new(1,0,1,0)
TPP.BackgroundTransparency=1
TPP.Visible=false
TPP.ScrollBarThickness=4
TPP.ScrollBarImageColor3=Theme.Accent
TPP.Parent=Pages

local TPList=Instance.new("UIListLayout")
TPList.SortOrder=Enum.SortOrder.LayoutOrder
TPList.Padding=UDim.new(0,6)
TPList.Parent=TPP

TPP.CanvasSize=UDim2.new(0,0,0,TPList.AbsoluteContentSize.Y)

local function tpTo(pos)
pcall(function()
local char = LP.Character or LP.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart", 5)
if hrp and pos then
hrp.CFrame = pos
end
end)
end

local function mkTPBtn(txt,pos)
local B=Instance.new("TextButton")
B.Size=UDim2.new(1,-8,0,36)
B.BackgroundColor3=Theme.Sidebar
B.BackgroundTransparency=0.8
B.BorderSizePixel=0
B.Text="  "..txt
B.Font=Enum.Font.GothamSemibold
B.TextSize=13
B.TextColor3=Theme.Text
B.TextXAlignment=Enum.TextXAlignment.Left
B.AutoButtonColor=false
B.Parent=TPP
local BC=Instance.new("UICorner")
BC.CornerRadius=UDim.new(0,6)
BC.Parent=B
B.MouseButton1Click:Connect(function() tpTo(pos) end)
B.MouseEnter:Connect(function()
TweenService:Create(B,TweenInfo.new(0.2),{BackgroundTransparency=0.6}):Play()
end)
B.MouseLeave:Connect(function()
TweenService:Create(B,TweenInfo.new(0.2),{BackgroundTransparency=0.8}):Play()
end)
return B
end

-- Old World Locations
mkTPBtn("🏝️ Start Island",CFrame.new(1071.2832,16.3085976,1426.86792))
mkTPBtn("🏝️ Marine Start",CFrame.new(-2573.3374,6.88881969,2046.99817))
mkTPBtn("🏝️ Middle Town",CFrame.new(-655.824158,7.88708115,1436.67908))
mkTPBtn("🏝️ Jungle",CFrame.new(-1249.77222,11.8870859,341.356476))
mkTPBtn("🏝️ Pirate Village",CFrame.new(-1122.34998,4.78708982,3855.91992))
mkTPBtn("🏝️ Desert",CFrame.new(1094.14587,6.47350502,4192.88721))
mkTPBtn("🏝️ Frozen Village",CFrame.new(1198.00928,27.0074959,-1211.73376))
mkTPBtn("🏝️ MarineFord",CFrame.new(-4505.375,20.687294,4260.55908))
mkTPBtn("🏝️ Colosseum",CFrame.new(-1428.35474,7.38933945,-3014.37305))
mkTPBtn("🏝️ Sky Island 1",CFrame.new(-4970.21875,717.707275,-2622.35449))
mkTPBtn("🏝️ Sky Island 2",CFrame.new(-4813.0249,903.708557,-1912.69055))
mkTPBtn("🏝️ Sky Island 3",CFrame.new(-7952.31006,5545.52832,-320.704956))
mkTPBtn("🏝️ Prison",CFrame.new(4854.16455,5.68742752,740.194641))
mkTPBtn("🏝️ Magma Village",CFrame.new(-5231.75879,8.61593437,8467.87695))
mkTPBtn("🏝️ Underwater City",CFrame.new(61163.8516,11.7796879,1819.78418))
mkTPBtn("🏝️ Fountain City",CFrame.new(5132.7124,4.53632832,4037.8562))

-- New World Locations
mkTPBtn("🌋 Dock",CFrame.new(82.9490662,18.0710983,2834.98779))
mkTPBtn("🌋 Kingdom of Rose",CFrame.new(-394.983521,118.503128,1245.8446))
mkTPBtn("🌋 Mansion",CFrame.new(-390.096313,331.886475,673.464966))
mkTPBtn("🌋 Green Zone",CFrame.new(-2372.14697,72.9919434,-3166.51416))
mkTPBtn("🌲 Grave Island",CFrame.new(-5411.47607,48.8234024,-721.272522))
mkTPBtn("❄️ Snow Mountain",CFrame.new(511.825226,401.765198,-5380.396))
mkTPBtn("❄️ Cold Island",CFrame.new(-6026.96484,14.7461271,-5071.96338))
mkTPBtn("🔥 Hot Island",CFrame.new(-5478.39209,15.9775667,-5246.9126))
mkTPBtn("🚢 Cursed Ship",CFrame.new(902.059143,124.752518,33071.8125))
mkTPBtn("❄️ Ice Castle",CFrame.new(5400.40381,28.21698,-6236.99219))
mkTPBtn("🌊 Forgotten Island",CFrame.new(-3043.31543,238.881271,-10191.5791))

-- Third World Locations
mkTPBtn("🐢 Port Town",CFrame.new(-610.309692,57.8323097,6436.33594))
mkTPBtn("🐉 Hydra Island",CFrame.new(5229.99561,603.916565,345.154022))
mkTPBtn("🌳 Great Tree",CFrame.new(2174.94873,28.7312393,-6728.83154))
mkTPBtn("🏰 Castle on the Sea",CFrame.new(-5477.62842,313.794739,-2808.4585))
mkTPBtn("🐢 Floating Turtle",CFrame.new(-10919.2998,331.788452,-8637.57227))
mkTPBtn("🥜 Peanut Island",CFrame.new(-2062.67773,38.1294556,-10287.752))
mkTPBtn("🍦 Ice Cream Island",CFrame.new(-840.188477,65.8452759,-10877.3789))

local SP=Instance.new("Frame")
SP.Size=UDim2.new(1,0,1,0)
SP.BackgroundTransparency=1
SP.Visible=false
SP.Parent=Pages
local TL=Instance.new("TextLabel")
TL.Size=UDim2.new(1,0,0,32)
TL.BackgroundTransparency=1
TL.Text="🎨 Тема оформления"
TL.Font=Enum.Font.GothamBold
TL.TextSize=16
TL.TextColor3=Theme.Text
TL.TextXAlignment=Enum.TextXAlignment.Left
TL.Parent=SP

local TB={}
local function mkTheme(name,y)
local B=Instance.new("TextButton")
B.Size=UDim2.new(1,0,0,44)
B.Position=UDim2.new(0,0,0,y)
B.BackgroundColor3=Theme.Sidebar
B.BackgroundTransparency=0.8
B.BorderSizePixel=0
B.Text=""
B.AutoButtonColor=false
B.Parent=SP
local C=Instance.new("UICorner");C.CornerRadius=UDim.new(0,8);C.Parent=B
local S=Instance.new("UIStroke");S.Color=Theme.Divider;S.Thickness=2;S.Transparency=0.3;S.Parent=B

local ColorPreview=Instance.new("Frame")
ColorPreview.Size=UDim2.new(0,32,1,-12)
ColorPreview.Position=UDim2.new(0,8,0,6)
ColorPreview.BackgroundColor3=Themes[name].Accent
ColorPreview.BorderSizePixel=0
ColorPreview.Parent=B
local ColorC=Instance.new("UICorner")
ColorC.CornerRadius=UDim.new(0,6)
ColorC.Parent=ColorPreview

local NameLabel=Instance.new("TextLabel")
NameLabel.Size=UDim2.new(1,-48,0,24)
NameLabel.Position=UDim2.new(0,48,0,4)
NameLabel.BackgroundTransparency=1
NameLabel.Text="  "..name
NameLabel.Font=Enum.Font.GothamSemibold
NameLabel.TextSize=14
NameLabel.TextColor3=Theme.Text
NameLabel.TextXAlignment=Enum.TextXAlignment.Left
NameLabel.Parent=B

local Ch=Instance.new("TextLabel")
Ch.Size=UDim2.new(0,24,0,24)
Ch.Position=UDim2.new(1,-32,0.5,-12)
Ch.BackgroundTransparency=1
Ch.Text=(name==CTN) and "✓" or ""
Ch.Font=Enum.Font.GothamBold
Ch.TextSize=18
Ch.TextColor3=Theme.Accent
Ch.Parent=B

TB[name]={Button=B,Check=Ch,Stroke=S,Color=ColorPreview,Name=NameLabel}

B.MouseEnter:Connect(function()
TweenService:Create(B,TweenInfo.new(0.2),{BackgroundTransparency=0.6}):Play()
end)
B.MouseLeave:Connect(function()
TweenService:Create(B,TweenInfo.new(0.2),{BackgroundTransparency=0.8}):Play()
end)

B.MouseButton1Click:Connect(function() applyTheme(name) end)
end
mkTheme("Spirits",40)
mkTheme("Skeet",92)
mkTheme("Purple Haze",144)
mkTheme("Shailushai",196)

local UnhookBtn=Instance.new("TextButton")
UnhookBtn.Size=UDim2.new(1,0,0,44)
UnhookBtn.Position=UDim2.new(0,0,0,248)
UnhookBtn.BackgroundColor3=Color3.fromRGB(180,0,0)
UnhookBtn.BackgroundTransparency=0.2
UnhookBtn.BorderSizePixel=0
UnhookBtn.Text="🚫 UNHOOK (Удалить меню)"
UnhookBtn.Font=Enum.Font.GothamBold
UnhookBtn.TextSize=14
UnhookBtn.TextColor3=Color3.fromRGB(255,255,255)
UnhookBtn.AutoButtonColor=false
UnhookBtn.Parent=SP
local UC=Instance.new("UICorner");UC.CornerRadius=UDim.new(0,8);UC.Parent=UnhookBtn
local US=Instance.new("UIStroke");US.Color=Color3.fromRGB(255,100,100);US.Thickness=1;US.Parent=UnhookBtn

UnhookBtn.MouseEnter:Connect(function()
TweenService:Create(UnhookBtn,TweenInfo.new(0.2),{BackgroundTransparency=0.1}):Play()
end)
UnhookBtn.MouseLeave:Connect(function()
TweenService:Create(UnhookBtn,TweenInfo.new(0.2),{BackgroundTransparency=0.2}):Play()
end)

UnhookBtn.MouseButton1Click:Connect(function() unhook() end)

function refreshAllThemes()
Theme=Themes[CTN]
Main.BackgroundColor3=Theme.BgTop
Grad.Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Theme.BgTop),ColorSequenceKeypoint.new(1,Theme.BgBottom)})
MS.Color=Theme.Accent
Shadow.ImageColor3=Theme.BgTop
Side.BackgroundColor3=Theme.Sidebar
SA.BackgroundColor3=Theme.Accent
VD.BackgroundColor3=Theme.Divider
LogoContainer.BackgroundColor3=Theme.Accent
Title.TextColor3=Theme.Text
for n,d in pairs(SB) do
d.Text.TextColor3=(AS==n) and Theme.Text or Theme.SubText
d.Indicator.BackgroundColor3=Theme.Accent
d.Indicator.Visible=(AS==n)
d.Button.BackgroundTransparency=(AS==n) and 0.75 or 0.85
end
CT.TextColor3=Theme.Text
TD.BackgroundColor3=Theme.Accent
if ChestT then 
ChestT.Label.TextColor3=Theme.Text 
if ChestT.Frame then ChestT.Frame.BackgroundColor3=Theme.Sidebar end
end
if FruitT then 
FruitT.Label.TextColor3=Theme.Text 
if FruitT.Frame then FruitT.Frame.BackgroundColor3=Theme.Sidebar end
end
if ACT then 
ACT.Label.TextColor3=Theme.Text 
if ACT.Frame then ACT.Frame.BackgroundColor3=Theme.Sidebar end
end
if ALT then
ALT.Label.TextColor3=Theme.Text
if ALT.Frame then ALT.Frame.BackgroundColor3=Theme.Sidebar end
end
if FastAT then
FastAT.Label.TextColor3=Theme.Text
if FastAT.Frame then FastAT.Frame.BackgroundColor3=Theme.Sidebar end
end
if MagT then
MagT.Label.TextColor3=Theme.Text
if MagT.Frame then MagT.Frame.BackgroundColor3=Theme.Sidebar end
end
if AFSContainer then AFSContainer.BackgroundColor3=Theme.Sidebar end
if AFS then AFS.TextColor3=Theme.SubText end
if ScanBtn then ScanBtn.BackgroundColor3=Theme.Accent end
for n,d in pairs(TB) do
d.Name.TextColor3=Theme.Text
d.Button.BackgroundColor3=Theme.Sidebar
d.Stroke.Color=Theme.Divider
d.Check.TextColor3=Theme.Accent
d.Check.Text=(n==CTN) and "✓" or ""
if d.Color then d.Color.BackgroundColor3=Themes[n].Accent end
end
if Footer then Footer.TextColor3=Theme.SubText end
if HotkeyInfo then HotkeyInfo.TextColor3=Theme.SubText end
end

function applyTheme(n)
if not Themes[n] then return end
CTN=n
refreshAllThemes()
end

local function switchPage(n)
AS=n
CT.Text=n
AFP.Visible=(n=="Auto Farm")
ESPP.Visible=(n=="ESP")
TPP.Visible=(n=="Teleport")
SP.Visible=(n=="Settings")
for nn,d in pairs(SB) do
local a=(nn==n)
d.Indicator.Visible=a
d.Text.TextColor3=a and Theme.Text or Theme.SubText
d.Button.BackgroundTransparency=a and 0.75 or 0.85
end
end

for n,d in pairs(SB) do
d.Button.MouseButton1Click:Connect(function() switchPage(n) end)
end

UserInputService.InputBegan:Connect(function(input,gp)
if gp then return end
if input.KeyCode==Enum.KeyCode.Insert then 
Main.Visible=not Main.Visible
if Main.Visible then
local notif=Instance.new("TextLabel")
notif.Size=UDim2.new(0,200,0,40)
notif.Position=UDim2.new(0.5,-100,0.8,-20)
notif.BackgroundColor3=Theme.Accent
notif.BackgroundTransparency=0.2
notif.BorderSizePixel=0
notif.Text="📱 Меню открыто\nInsert - скрыть/показать"
notif.Font=Enum.Font.Gotham
notif.TextSize=12
notif.TextColor3=Color3.fromRGB(255,255,255)
notif.Parent=SG
local NC=Instance.new("UICorner")
NC.CornerRadius=UDim.new(0,8)
NC.Parent=notif
task.delay(3,function() if notif and notif.Parent then notif:Destroy() end end)
end
end
end)

local function mkHL(adornee,color,trans)
local hl=Instance.new("Highlight")
hl.FillColor=color
hl.FillTransparency=trans or 0.6
hl.OutlineColor=color
hl.OutlineTransparency=0.2
hl.Adornee=adornee
hl.DepthMode=Enum.HighlightDepthMode.AlwaysOnTop
hl.Parent=CoreGui
return hl
end

local function mkBox(adornee,color)
local b=Instance.new("BoxHandleAdornment")
b.Size=adornee:GetExtentsSize()
b.Adornee=adornee
b.AlwaysOnTop=true
b.ZIndex=5
b.Transparency=0.5
b.Color3=color
b.Parent=CoreGui
return b
end

local function isChest(o)
if not o or not o:IsA("Model") then return false end
local name=o.Name:lower()
if not name:find("chest") then return false end
-- Исключаем большие объекты (острова, здания)
local size=o:GetExtentsSize()
if size.X>50 or size.Y>50 or size.Z>50 then return false end
-- Проверяем что это действительно модель с простой структурой
local partCount=0
for _,child in ipairs(o:GetChildren()) do
if child:IsA("BasePart") or child:IsA("MeshPart") or child:IsA("UnionOperation") then
partCount=partCount+1
end
end
-- Сундуки обычно имеют мало частей (1-10)
if partCount>15 then return false end
return true
end

local function isChestInRange(o,r)
if not LP.Character then return false end
local hrp=LP.Character:FindFirstChild("HumanoidRootPart")
local p=o:FindFirstChild("HumanoidRootPart") or o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart")
if not hrp or not p then return false end
return (hrp.Position-p.Position).Magnitude<=(r or 3000)
end

function startChestESP()
for _,o in ipairs(Workspace:GetDescendants()) do
if isChest(o) and not CH[o] then
CH[o]={mkHL(o,Color3.fromRGB(255,200,80),0.55),mkBox(o,Color3.fromRGB(255,200,80))}
end
end
end

function stopChestESP()
for _,l in pairs(CH) do for _,g in ipairs(l) do if g and g.Parent then g:Destroy() end end end
CH={}
end

Workspace.DescendantAdded:Connect(function(o)
if State.ChestESP and isChest(o) and not CH[o] then
CH[o]={mkHL(o,Color3.fromRGB(255,200,80),0.55),mkBox(o,Color3.fromRGB(255,200,80))}
end
end)
Workspace.DescendantRemoving:Connect(function(o)
if CH[o] then for _,g in ipairs(CH[o]) do if g and g.Parent then g:Destroy() end end CH[o]=nil end
end)

-- УЛУЧШЕННЫЙ FRUIT ESP
local function isFruitImproved(o)
if not o then return false end

local name = o.Name:lower()

-- Проверяем инструменты (Tools) в Workspace
if o:IsA("Tool") then
-- Список всех фруктов
local fruitNames = {
"rocket","spin","blade","spring","bomb","smoke","spike","flame","falcon","ice",
"sand","dark","diamond","light","rubber","barrier","magma","door","quake","buddha",
"love","spider","sound","phoenix","portal","rumble","pain","blizzard","gravity",
"mammoth","trex","dough","shadow","venom","control","spirit","dragon","leopard",
"kitsune","yeti","gas","chop","human","creation","revive","eagle","lightning","magnet"
}

for _, fruit in ipairs(fruitNames) do
if name:find(fruit) then
return true
end
end
end

-- Проверяем модели с Fruit внутри
if o:IsA("Model") then
if o:FindFirstChild("Fruit") then
return true
end
-- Проверяем Tool внутри модели
for _, child in pairs(o:GetChildren()) do
if child:IsA("Tool") then
local toolName = child.Name:lower()
for _, fruit in ipairs({"rocket","spin","spring","bomb","smoke","spike","flame","ice","sand","dark","light","rubber","magma","quake","buddha","dough","shadow","venom","dragon","leopard"}) do
if toolName:find(fruit) then
return true
end
end
end
end
end

-- Проверяем папку Fruits
local fruitsContainer = Workspace:FindFirstChild("Fruits")
if fruitsContainer and o.Parent == fruitsContainer then
return true
end

-- Проверяем фрукт по Handle (упрощённо)
if o:FindFirstChild("Handle") and (o:IsA("Tool") or o:IsA("Model")) then
local handleName = o.Handle.Name:lower()
if handleName:find("fruit") or name:find("fruit") then
return true
end
end

return false
end

function startFruitESP()
for _,o in ipairs(Workspace:GetDescendants()) do
if isFruitImproved(o) and not FH[o] then
FH[o]={mkHL(o,Color3.fromRGB(255,120,180),0.55),mkBox(o,Color3.fromRGB(255,120,180))}
end
end
-- Также сканируем контейнер Fruits если есть
local fruitsContainer=Workspace:FindFirstChild("Fruits")
if fruitsContainer then
for _,f in ipairs(fruitsContainer:GetChildren()) do
if not FH[f] then
FH[f]={mkHL(f,Color3.fromRGB(255,120,180),0.55),mkBox(f,Color3.fromRGB(255,120,180))}
end
end
end
end

function stopFruitESP()
for _,l in pairs(FH) do for _,g in ipairs(l) do if g and g.Parent then g:Destroy() end end end
FH={}
end

Workspace.DescendantAdded:Connect(function(o)
if State.FruitESP and isFruitImproved(o) and not FH[o] then
FH[o]={mkHL(o,Color3.fromRGB(255,120,180),0.55),mkBox(o,Color3.fromRGB(255,120,180))}
end
end)
Workspace.DescendantRemoving:Connect(function(o)
if FH[o] then for _,g in ipairs(FH[o]) do if g and g.Parent then g:Destroy() end end FH[o]=nil end
end)

-- AUTO COLLECT FRUITS
local function findNearestFruit(r)
local hrp = getHRP()
if not hrp then return nil, 0 end
local best, bd = nil, math.huge

-- Способ 1: Сканируем через папку Fruits (самый надёжный)
local fruitsContainer = Workspace:FindFirstChild("Fruits")
if fruitsContainer then
for _, f in pairs(fruitsContainer:GetChildren()) do
local p = f:FindFirstChild("HumanoidRootPart") or f.PrimaryPart or f:FindFirstChildWhichIsA("BasePart")
if p then
local d = (hrp.Position - p.Position).Magnitude
if d < bd and (not r or d < r) then
best, bd = f, d
end
end
end
end

-- Способ 2: Сканируем все Tools в Workspace
if not best then
for _, o in pairs(Workspace:GetDescendants()) do
if o:IsA("Tool") or (o:IsA("Model") and o:FindFirstChild("Handle")) then
if isFruitImproved(o) then
local p = o:FindFirstChild("Handle") or o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart")
if p then
local d = (hrp.Position - p.Position).Magnitude
if d < bd and (not r or d < r) then
best, bd = o, d
end
end
end
end
end
end

-- Способ 3: Ищем по названию (fallback)
if not best then
for _, o in pairs(Workspace:GetDescendants()) do
if o:IsA("Tool") or o:IsA("Model") then
local name = o.Name:lower()
if name:find("fruit") or name:find("dough") or name:find("dragon") or name:find("shadow") or name:find("venom") or name:find("spirit") or name:find("leopard") or name:find("kitsune") then
local p = o:FindFirstChild("Handle") or o:FindFirstChild("HumanoidRootPart") or o.PrimaryPart
if p then
local d = (hrp.Position - p.Position).Magnitude
if d < bd and (not r or d < r) then
best, bd = o, d
end
end
end
end
end
end

return best, bd
end

function startAutoCollectFruit()
if ACFR then return end
ACFR=true
task.spawn(function()
while ACFR and State.AutoCollectFruit do
pcall(function()
local fruit, dist = findNearestFruit(5000)
if fruit then
local hrp = getHRP()
local p = fruit:FindFirstChild("Handle") or fruit:FindFirstChild("HumanoidRootPart") or fruit.PrimaryPart or fruit:FindFirstChildWhichIsA("BasePart")
if hrp and p then
AFS.Text = "🍎 ThomasLua Auto Fruit\n━━━━━━━━━━━━━━━━━━\nФрукт: "..fruit.Name.."\nДистанция: "..math.floor(dist).." st\nТелепортация..."
hrp.CFrame = CFrame.new(p.Position + Vector3.new(0, 3, 0))
task.wait(0.5)
AFS.Text = "✅ ThomasLua Auto Fruit\n━━━━━━━━━━━━━━━━━━\nСобран: "..fruit.Name.."\nИщем следующий..."
task.wait(0.5)
end
else
AFS.Text = "🔍 ThomasLua Auto Fruit\n━━━━━━━━━━━━━━━━━━\nФрукты не найдены\nОжидание..."
end
end)
task.wait(1)
end
end)
end

function stopAutoCollectFruit()
ACFR=false
AFS.Text="🛑 Auto Collect Fruit\n━━━━━━━━━━━━━━━━━━\nВыключен"
end

-- AUTO STATS SYSTEM
function startAutoStats()
if ASR then return end
ASR=true
task.spawn(function()
while ASR and State.AutoStats do
local points=0
local stats=LP:FindFirstChild("Stats")
if not stats then
stats=LP:FindFirstChild("Data")
end
if stats then
-- Получаем очки статов
local pointsObj=stats:FindFirstChild("Points") or stats:FindFirstChild("StatPoints")
if pointsObj then
points=tonumber(pointsObj.Value) or 0
end

if points>0 then
local statName=State.SelectedStat
-- Ищем стат
local statObj=stats:FindFirstChild(statName) or stats:FindFirstChild(statName.."Level")

if statObj then
-- Remote для добавления статов
local remotes=game:GetService("ReplicatedStorage"):FindFirstChild("Remotes")
if remotes then
local addStatRemote=remotes:FindFirstChild("AddStat") or remotes:FindFirstChild("AddPoint")
if addStatRemote then
pcall(function()
addStatRemote:FireServer(statName, 1)
end)
AFS.Text="📊 Auto Stats\n━━━━━━━━━━━━━━━━━━\nПрокачиваем: "..statName.."\nОчков: "..points
end
end

-- Альтернативный метод - клик по GUI
pcall(function()
local statsGui=LP:FindFirstChild("PlayerGui"):FindFirstChild("Stats")
if statsGui then
for _,btn in ipairs(statsGui:GetDescendants()) do
if btn:IsA("TextButton") and btn.Name:lower():find(statName:lower()) then
btn.MouseButton1Click:Fire()
break
end
end
end
end)
end
end
end
task.wait(0.5)
end
end)
end

function stopAutoStats()
ASR=false
AFS.Text="🛑 Auto Stats\n━━━━━━━━━━━━━━━━━━\nВыключен"
end

local function getHRP() if not LP.Character then return nil end return LP.Character:FindFirstChild("HumanoidRootPart") end
local function getHum() if not LP.Character then return nil end return LP.Character:FindFirstChildOfClass("Humanoid") end

local function hardJump()
local hum=getHum()
if not hum then return end
pcall(function()
VirtualUser:CaptureController()
VirtualUser:ButtonDown({Enum.KeyCode.Space})
task.wait(0.05)
VirtualUser:ButtonUp({Enum.KeyCode.Space})
end)
pcall(function() hum.Jump=true end)
end

local function walkTo(pos,tmo,cb)
local hrp=getHRP()
local hum=getHum()
if not hrp or not hum then return false end
tmo=tmo or 30
local path=PathfindingService:CreatePath({AgentRadius=3,AgentHeight=5,AgentCanJump=true,AgentJumpHeight=7})
local ok=pcall(function() path:ComputeAsync(hrp.Position,pos) end)
local wps
if ok and path.Status==Enum.PathStatus.Success then
wps=path:GetWaypoints()
else
wps={{Position=pos,Action=Enum.PathWaypointAction.Walk}}
end

local stuck=0
local t0=tick()
for i,wp in ipairs(wps) do
if not getHRP() or not getHum() then return false end
if tick()-t0>tmo then break end
if cb then cb(("WP %d/%d"):format(i,#wps)) end
if wp.Action==Enum.PathWaypointAction.Jump then hardJump() end
hum:MoveTo(wp.Position)
local last=hrp.Position
local reached=false
local w0=tick()
while tick()-w0<5 do
if not getHRP() then return false end
local cur=getHRP().Position
if (cur-wp.Position).Magnitude<4 then reached=true break end
if (cur-last).Magnitude<1.5 then
stuck=stuck+0.15
if stuck>1.0 then
hum:MoveTo(cur - (wp.Position-cur).Unit*3)
task.wait(0.2)
hardJump()
hardJump()
task.wait(0.2)
hum:MoveTo(wp.Position)
hardJump()
stuck=0
end
else stuck=0 end
last=cur
task.wait(0.1)
end
if not reached then
hum:MoveTo(pos)
end
end
if getHum() then getHum():MoveTo(pos) end
return true
end

local function nearestChest(r)
local hrp=getHRP()
if not hrp then return nil end
local best,bd=nil,math.huge
for _,o in ipairs(Workspace:GetDescendants()) do
if isChest(o) and isChestInRange(o,r) then
local p=o:FindFirstChild("HumanoidRootPart") or o.PrimaryPart or o:FindFirstChildWhichIsA("BasePart")
if p then
local d=(hrp.Position-p.Position).Magnitude
if d<bd then best,bd=o,d end
end
end
end
return best
end

function startAutoChest()
if ACR then return end
ACR=true
task.spawn(function()
while ACR and State.AutoChest do
local c=nearestChest(3000)
if not c then
AFS.Text="🔄 Auto Chest\n━━━━━━━━━━━━━━━━━━\nНет доступных сундуков\nОжидание... ⏳"
task.wait(2)
else
local p=c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart or c:FindFirstChildWhichIsA("BasePart")
local hrp=getHRP()
if p and hrp then
local dist=(hrp.Position-p.Position).Magnitude
AFS.Text="⚡ Auto Chest\n━━━━━━━━━━━━━━━━━━\nЦель: "..c.Name.."\nДистанция: "..math.floor(dist).." st\nТелепортация... �"
hrp.CFrame=CFrame.new(p.Position+Vector3.new(0,3,0))
task.wait(0.3)
AFS.Text="💰 Auto Chest\n━━━━━━━━━━━━━━━━━━\nЦель: "..c.Name.."\nСбор... ✅"
task.wait(0.5)
end
end
task.wait(0.2)
end
end)
end

function stopAutoChest()
ACR=false
local hum=getHum()
if hum and getHRP() then hum:MoveTo(getHRP().Position) end
AFS.Text="🛑 Auto Chest\n━━━━━━━━━━━━━━━━━━\nВыключен\nОжидание команд..."
end

local function getLvl()
local ls=LP:FindFirstChild("leaderstats")
if ls then
local l=ls:FindFirstChild("Level") or ls:FindFirstChild("Lvl")
if l then return tonumber(l.Value) or 0 end
end
local d=LP:FindFirstChild("Data")
if d then local l=d:FindFirstChild("Level"); if l then return tonumber(l.Value) or 0 end end
return 0
end

local function getMoney()
local ls=LP:FindFirstChild("leaderstats")
if ls then
local m=ls:FindFirstChild("Beli") or ls:FindFirstChild("Money")
if m then return tonumber(m.Value) or 0 end
end
return 0
end

-- Функция для экипировки оружия
local function equipWeapon()
local char=LP.Character
if not char then return end
local backpack=LP:FindFirstChild("Backpack")
if not backpack then return end
local weapon=nil
for _,item in ipairs(backpack:GetChildren()) do
if item:IsA("Tool") then
local name=item.Name:lower()
if name:find("sword") or name:find("blade") or name:find("katana") or name:find("cutlass") or name:find("saber") then
weapon=item
break
end
end
end
if weapon then
weapon.Parent=char
task.wait(0.2)
end
end

local currentQuestData=nil
local questKills=0
local QuestActive=false
local QuestName=""
local QuestNumber=1
local Ms=""
local CFrameQuest=nil
local CFrameMon=nil
local NameMon=""

-- Полная система квестов как в примере
local function CheckQuest()
local MyLevel = getLvl()
local placeId = game.PlaceId

-- Old World
if placeId == 2753915549 then
if MyLevel == 1 or MyLevel <= 9 then
Ms = "Bandit [Lv. 5]"
QuestName = "BanditQuest1"
QuestNumber = 1
NameMon = "Bandit"
CFrameQuest = CFrame.new(1060.9383544922, 16.455066680908, 1547.7841796875)
CFrameMon = CFrame.new(1038.5533447266, 41.296249389648, 1576.5098876953)
elseif MyLevel == 10 or MyLevel <= 14 then
Ms = "Monkey [Lv. 14]"
QuestName = "JungleQuest"
QuestNumber = 1
NameMon = "Monkey"
CFrameQuest = CFrame.new(-1604.12012, 36.8521118, 154.23732)
CFrameMon = CFrame.new(-1448.1446533203, 50.851993560791, 63.60718536377)
elseif MyLevel == 15 or MyLevel <= 29 then
Ms = "Gorilla [Lv. 20]"
QuestName = "JungleQuest"
QuestNumber = 2
NameMon = "Gorilla"
CFrameQuest = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102)
CFrameMon = CFrame.new(-1142.6488037109, 40.462348937988, -515.39227294922)
elseif MyLevel == 30 or MyLevel <= 39 then
Ms = "Pirate [Lv. 35]"
QuestName = "BuggyQuest1"
QuestNumber = 1
NameMon = "Pirate"
CFrameQuest = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
CFrameMon = CFrame.new(-1201.0881347656, 40.628940582275, 3857.5966796875)
elseif MyLevel == 40 or MyLevel <= 59 then
Ms = "Brute [Lv. 45]"
QuestName = "BuggyQuest1"
QuestNumber = 2
NameMon = "Brute"
CFrameQuest = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188)
CFrameMon = CFrame.new(-1387.5324707031, 24.592035293579, 4100.9575195313)
elseif MyLevel == 60 or MyLevel <= 74 then
Ms = "Desert Bandit [Lv. 60]"
QuestName = "DesertQuest"
QuestNumber = 1
NameMon = "Desert Bandit"
CFrameQuest = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
CFrameMon = CFrame.new(984.99896240234, 16.109552383423, 4417.91015625)
elseif MyLevel == 75 or MyLevel <= 89 then
Ms = "Desert Officer [Lv. 70]"
QuestName = "DesertQuest"
QuestNumber = 2
NameMon = "Desert Officer"
CFrameQuest = CFrame.new(896.51721191406, 6.4384617805481, 4390.1494140625)
CFrameMon = CFrame.new(1547.1510009766, 14.452038764954, 4381.8002929688)
elseif MyLevel == 90 or MyLevel <= 99 then
Ms = "Snow Bandit [Lv. 90]"
QuestName = "SnowQuest"
QuestNumber = 1
NameMon = "Snow Bandits"
CFrameQuest = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
CFrameMon = CFrame.new(1356.3028564453, 105.76865386963, -1328.2418212891)
elseif MyLevel == 100 or MyLevel <= 119 then
Ms = "Snowman [Lv. 100]"
QuestName = "SnowQuest"
QuestNumber = 2
NameMon = "Snowman"
CFrameQuest = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156)
CFrameMon = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172)
elseif MyLevel == 120 or MyLevel <= 149 then
Ms = "Chief Petty Officer [Lv. 120]"
QuestName = "MarineQuest2"
QuestNumber = 1
NameMon = "Chief Petty Officer"
CFrameQuest = CFrame.new(-5035.49609375, 28.677835464478, 4324.1840820313)
CFrameMon = CFrame.new(-4931.1552734375, 65.793113708496, 4121.8393554688)
elseif MyLevel == 150 or MyLevel <= 174 then
Ms = "Sky Bandit [Lv. 150]"
QuestName = "SkyQuest"
QuestNumber = 1
NameMon = "Sky Bandit"
CFrameQuest = CFrame.new(-4841.83447, 717.669617, -2623.96436)
CFrameMon = CFrame.new(-4970.74219, 294.544342, -2890.11353)
elseif MyLevel == 175 or MyLevel <= 224 then
Ms = "Dark Master [Lv. 175]"
QuestName = "SkyQuest"
QuestNumber = 2
NameMon = "Dark Master"
CFrameQuest = CFrame.new(-4841.83447, 717.669617, -2623.96436)
CFrameMon = CFrame.new(-5220.58594, 430.693298, -2278.17456)
elseif MyLevel == 225 or MyLevel <= 274 then
Ms = "Toga Warrior [Lv. 225]"
QuestName = "ColosseumQuest"
QuestNumber = 1
NameMon = "Toga Warrior"
CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762)
CFrameMon = CFrame.new(-1779.97583, 44.6077499, -2736.35474)
elseif MyLevel == 275 or MyLevel <= 299 then
Ms = "Gladiator [Lv. 275]"
QuestName = "ColosseumQuest"
QuestNumber = 2
NameMon = "Gladiato"
CFrameQuest = CFrame.new(-1576.11743, 7.38933945, -2983.30762)
CFrameMon = CFrame.new(-1274.75903, 58.1895943, -3188.16309)
elseif MyLevel == 300 or MyLevel <= 329 then
Ms = "Military Soldier [Lv. 300]"
QuestName = "MagmaQuest"
QuestNumber = 1
NameMon = "Military Soldier"
CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998)
CFrameMon = CFrame.new(-5363.01123, 41.5056877, 8548.47266)
elseif MyLevel == 330 or MyLevel <= 374 then
Ms = "Military Spy [Lv. 330]"
QuestName = "MagmaQuest"
QuestNumber = 2
NameMon = "Military Spy"
CFrameQuest = CFrame.new(-5316.55859, 12.2370615, 8517.2998)
CFrameMon = CFrame.new(-5787.99023, 120.864456, 8762.25293)
elseif MyLevel == 375 or MyLevel <= 399 then
Ms = "Fishman Warrior [Lv. 375]"
QuestName = "FishmanQuest"
QuestNumber = 1
NameMon = "Fishman Warrior"
CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504)
CFrameMon = CFrame.new(61163.8515625, 5.3073043823242, 1819.7841796875)
elseif MyLevel == 400 or MyLevel <= 449 then
Ms = "Fishman Commando [Lv. 400]"
QuestName = "FishmanQuest"
QuestNumber = 2
NameMon = "Fishman Commando"
CFrameQuest = CFrame.new(61122.5625, 18.4716396, 1568.16504)
CFrameMon = CFrame.new(61163.8515625, 5.3073043823242, 1819.7841796875)
elseif MyLevel == 450 or MyLevel <= 474 then
Ms = "God's Guard [Lv. 450]"
QuestName = "SkyExp1Quest"
QuestNumber = 1
NameMon = "God's Guards"
CFrameQuest = CFrame.new(-4721.71436, 845.277161, -1954.20105)
CFrameMon = CFrame.new(-4716.95703, 853.089722, -1933.925427)
elseif MyLevel == 475 or MyLevel <= 524 then
Ms = "Shanda [Lv. 475]"
QuestName = "SkyExp1Quest"
QuestNumber = 2
NameMon = "Shandas"
CFrameQuest = CFrame.new(-7863.63672, 5545.49316, -379.826324)
CFrameMon = CFrame.new(-7685.12354, 5601.05127, -443.171509)
elseif MyLevel == 525 or MyLevel <= 549 then
Ms = "Royal Squad [Lv. 525]"
QuestName = "SkyExp2Quest"
QuestNumber = 1
NameMon = "Royal Squad"
CFrameQuest = CFrame.new(-7902.66895, 5635.96387, -1411.71802)
CFrameMon = CFrame.new(-7685.02051, 5606.87842, -1442.729)
elseif MyLevel == 550 or MyLevel <= 624 then
Ms = "Royal Soldier [Lv. 550]"
QuestName = "SkyExp2Quest"
QuestNumber = 2
NameMon = "Royal Soldier"
CFrameQuest = CFrame.new(-7902.66895, 5635.96387, -1411.71802)
CFrameMon = CFrame.new(-7864.44775, 5661.94092, -1708.22351)
elseif MyLevel == 625 or MyLevel <= 649 then
Ms = "Galley Pirate [Lv. 625]"
QuestName = "FountainQuest"
QuestNumber = 1
NameMon = "Galley Pirate"
CFrameQuest = CFrame.new(5254.60156, 38.5011406, 4049.69678)
CFrameMon = CFrame.new(5595.06982, 41.5013695, 3961.47095)
elseif MyLevel >= 650 then
Ms = "Galley Captain [Lv. 650]"
QuestName = "FountainQuest"
QuestNumber = 2
NameMon = "Galley Captain"
CFrameQuest = CFrame.new(5254.60156, 38.5011406, 4049.69678)
CFrameMon = CFrame.new(5658.5752, 38.5361786, 4928.93506)
end
-- New World
elseif placeId == 4442272183 then
if MyLevel == 700 or MyLevel <= 724 then
Ms = "Raider [Lv. 700]"
QuestName = "Area1Quest"
QuestNumber = 1
NameMon = "Raider"
CFrameQuest = CFrame.new(-424.080078, 73.0055847, 1836.91589)
CFrameMon = CFrame.new(-737.026123, 39.1748352, 2392.57959)
elseif MyLevel == 725 or MyLevel <= 774 then
Ms = "Mercenary [Lv. 725]"
QuestName = "Area1Quest"
QuestNumber = 2
NameMon = "Mercenary"
CFrameQuest = CFrame.new(-424.080078, 73.0055847, 1836.91589)
CFrameMon = CFrame.new(-973.731995, 95.8733215, 1836.46936)
elseif MyLevel == 775 or MyLevel <= 874 then
Ms = "Swan Pirate [Lv. 775]"
QuestName = "Area2Quest"
QuestNumber = 1
NameMon = "Swan Pirate"
CFrameQuest = CFrame.new(632.698608, 73.1055908, 918.666321)
CFrameMon = CFrame.new(970.369446, 142.653198, 1217.3667)
elseif MyLevel == 875 or MyLevel <= 899 then
Ms = "Marine Lieutenant [Lv. 875]"
QuestName = "MarineQuest3"
QuestNumber = 1
NameMon = "Marine Lieutenant"
CFrameQuest = CFrame.new(-2442.65015, 73.0511475, -3219.11523)
CFrameMon = CFrame.new(-2913.26367, 73.0011826, -3220.11523)
elseif MyLevel == 900 or MyLevel <= 949 then
Ms = "Marine Captain [Lv. 900]"
QuestName = "MarineQuest3"
QuestNumber = 2
NameMon = "Marine Captain"
CFrameQuest = CFrame.new(-2442.65015, 73.0511475, -3219.11523)
CFrameMon = CFrame.new(-1868.67688, 73.0011826, -3321.66333)
elseif MyLevel == 950 or MyLevel <= 974 then
Ms = "Zombie [Lv. 950]"
QuestName = "ZombieQuest"
QuestNumber = 1
NameMon = "Zombie"
CFrameQuest = CFrame.new(-5492.79395, 48.5151672, -793.710571)
CFrameMon = CFrame.new(-5634.83838, 126.067039, -697.665039)
elseif MyLevel == 975 or MyLevel <= 999 then
Ms = "Vampire [Lv. 975]"
QuestName = "ZombieQuest"
QuestNumber = 2
NameMon = "Vampire"
CFrameQuest = CFrame.new(-5492.79395, 48.5151672, -793.710571)
CFrameMon = CFrame.new(-6030.32031, 6.4377408, -1313.5564)
elseif MyLevel == 1000 or MyLevel <= 1049 then
Ms = "Snow Trooper [Lv. 1000]"
QuestName = "SnowMountainQuest"
QuestNumber = 1
NameMon = "Snow Trooper"
CFrameQuest = CFrame.new(604.964966, 401.457062, -5371.69287)
CFrameMon = CFrame.new(535.893433, 401.457062, -5329.6958)
elseif MyLevel == 1050 or MyLevel <= 1099 then
Ms = "Winter Warrior [Lv. 1050]"
QuestName = "SnowMountainQuest"
QuestNumber = 2
NameMon = "Winter Warrior"
CFrameQuest = CFrame.new(604.964966, 401.457062, -5371.69287)
CFrameMon = CFrame.new(1223.7417, 454.575226, -5170.02148)
elseif MyLevel == 1100 or MyLevel <= 1124 then
Ms = "Lab Subordinate [Lv. 1100]"
QuestName = "IceSideQuest"
QuestNumber = 1
NameMon = "Lab Subordinate"
CFrameQuest = CFrame.new(-6060.10693, 15.9868021, -4904.7876)
CFrameMon = CFrame.new(-5769.2041, 37.9288292, -4468.38721)
elseif MyLevel == 1125 or MyLevel <= 1174 then
Ms = "Horned Warrior [Lv. 1125]"
QuestName = "IceSideQuest"
QuestNumber = 2
NameMon = "Horned Warrior"
CFrameQuest = CFrame.new(-6060.10693, 15.9868021, -4904.7876)
CFrameMon = CFrame.new(-6400.85889, 24.7645149, -5818.63574)
elseif MyLevel == 1175 or MyLevel <= 1199 then
Ms = "Magma Ninja [Lv. 1175]"
QuestName = "FireSideQuest"
QuestNumber = 1
NameMon = "Magma Ninja"
CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223)
CFrameMon = CFrame.new(-5496.65576, 58.6890411, -5929.76855)
elseif MyLevel == 1200 or MyLevel <= 1349 then
Ms = "Lava Pirate [Lv. 1200]"
QuestName = "FireSideQuest"
QuestNumber = 2
NameMon = "Lava Pirate"
CFrameQuest = CFrame.new(-5431.09473, 15.9868021, -5296.53223)
CFrameMon = CFrame.new(-5169.71729, 34.1234779, -4669.73633)
elseif MyLevel == 1350 or MyLevel <= 1374 then
Ms = "Arctic Warrior [Lv. 1350]"
QuestName = "FrostQuest"
QuestNumber = 1
NameMon = "Arctic Warrior"
CFrameQuest = CFrame.new(5669.43506, 28.2117786, -6482.60107)
CFrameMon = CFrame.new(5995.07471, 57.3188477, -6183.47314)
elseif MyLevel == 1375 or MyLevel <= 1424 then
Ms = "Snow Lurker [Lv. 1375]"
QuestName = "FrostQuest"
QuestNumber = 2
NameMon = "Snow Lurker"
CFrameQuest = CFrame.new(5669.43506, 28.2117786, -6482.60107)
CFrameMon = CFrame.new(5518.00684, 60.5559731, -6828.80518)
elseif MyLevel == 1425 or MyLevel <= 1449 then
Ms = "Sea Soldier [Lv. 1425]"
QuestName = "ForgottenQuest"
QuestNumber = 1
NameMon = "Sea Soldier"
CFrameQuest = CFrame.new(-3052.99097, 236.881363, -10148.1943)
CFrameMon = CFrame.new(-3030.3696289063, 191.13464355469, -9859.7958984375)
elseif MyLevel >= 1450 then
Ms = "Water Fighter [Lv. 1450]"
QuestName = "ForgottenQuest"
QuestNumber = 2
NameMon = "Water Fighter"
CFrameQuest = CFrame.new(-3052.99097, 236.881363, -10148.1943)
CFrameMon = CFrame.new(-3436.7727050781, 290.52191162109, -10503.438476563)
end
-- Third World
elseif placeId == 7449423635 then
if MyLevel >= 1500 and MyLevel <= 1524 then
Ms = "Pirate Millionaire [Lv. 1500]"
QuestName = "PiratePortQuest"
QuestNumber = 1
NameMon = "Pirate Millionaire"
CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984)
CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
elseif MyLevel >= 1525 and MyLevel <= 1574 then
Ms = "Pistol Billionaire [Lv. 1525]"
QuestName = "PiratePortQuest"
QuestNumber = 2
NameMon = "Pistol Billionaire"
CFrameQuest = CFrame.new(-290.074677, 42.9034653, 5581.58984)
CFrameMon = CFrame.new(81.164993286133, 43.755737304688, 5724.7021484375)
elseif MyLevel >= 1575 and MyLevel <= 1599 then
Ms = "Dragon Crew Warrior [Lv. 1575]"
QuestName = "AmazonQuest"
QuestNumber = 1
NameMon = "Dragon Crew Warrior"
CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563)
CFrameMon = CFrame.new(6241.9951171875, 51.522083282471, -1243.9771728516)
elseif MyLevel >= 1600 and MyLevel <= 1624 then
Ms = "Dragon Crew Archer [Lv. 1600]"
QuestName = "AmazonQuest"
QuestNumber = 2
NameMon = "Dragon Crew Archer"
CFrameQuest = CFrame.new(5832.83594, 51.6806107, -1101.51563)
CFrameMon = CFrame.new(6488.9155273438, 383.38375854492, -110.66246032715)
elseif MyLevel >= 1625 and MyLevel <= 1649 then
Ms = "Female Islander [Lv. 1625]"
QuestName = "AmazonQuest2"
QuestNumber = 1
NameMon = "Female Islander"
CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676)
CFrameMon = CFrame.new(5825.2241210938, 682.89245605469, 704.57958984375)
elseif MyLevel >= 1650 and MyLevel <= 1699 then
Ms = "Giant Islander [Lv. 1650]"
QuestName = "AmazonQuest2"
QuestNumber = 2
NameMon = "Giant Islander"
CFrameQuest = CFrame.new(5448.86133, 601.516174, 751.130676)
CFrameMon = CFrame.new(4530.3540039063, 656.75695800781, -131.60952758789)
elseif MyLevel >= 1700 and MyLevel <= 1724 then
Ms = "Marine Commodore [Lv. 1700]"
QuestName = "MarineTreeIsland"
QuestNumber = 1
NameMon = "Marine Commodore"
CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498)
CFrameMon = CFrame.new(2490.0844726563, 190.4232635498, -7160.0502929688)
elseif MyLevel >= 1725 and MyLevel <= 1774 then
Ms = "Marine Rear Admiral [Lv. 1725]"
QuestName = "MarineTreeIsland"
QuestNumber = 2
NameMon = "Marine Rear Admiral"
CFrameQuest = CFrame.new(2180.54126, 27.8156815, -6741.5498)
CFrameMon = CFrame.new(3951.3903808594, 229.11549377441, -6912.81640625)
elseif MyLevel >= 1775 and MyLevel <= 1799 then
Ms = "Fishman Raider [Lv. 1775]"
QuestName = "DeepForestIsland3"
QuestNumber = 1
NameMon = "Fishman Raider"
CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
CFrameMon = CFrame.new(-10322.400390625, 390.94473266602, -8580.0908203125)
elseif MyLevel >= 1800 and MyLevel <= 1824 then
Ms = "Fishman Captain [Lv. 1800]"
QuestName = "DeepForestIsland3"
QuestNumber = 2
NameMon = "Fishman Captain"
CFrameQuest = CFrame.new(-10581.6563, 330.872955, -8761.18652)
CFrameMon = CFrame.new(-11194.541992188, 442.02795410156, -8608.806640625)
elseif MyLevel >= 1825 and MyLevel <= 1849 then
Ms = "Forest Pirate [Lv. 1825]"
QuestName = "DeepForestIsland"
QuestNumber = 1
NameMon = "Forest Pirate"
CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
CFrameMon = CFrame.new(-13225.809570313, 428.19387817383, -7753.1245117188)
elseif MyLevel >= 1850 and MyLevel <= 1899 then
Ms = "Mythological Pirate [Lv. 1850]"
QuestName = "DeepForestIsland"
QuestNumber = 2
NameMon = "Mythological Pirate"
CFrameQuest = CFrame.new(-13234.04, 331.488495, -7625.40137)
CFrameMon = CFrame.new(-13869.172851563, 564.95251464844, -7084.4135742188)
elseif MyLevel >= 1900 and MyLevel <= 1924 then
Ms = "Jungle Pirate [Lv. 1900]"
QuestName = "DeepForestIsland2"
QuestNumber = 1
NameMon = "Jungle Pirate"
CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
CFrameMon = CFrame.new(-11982.221679688, 376.32522583008, -10451.415039063)
elseif MyLevel >= 1925 and MyLevel <= 1974 then
Ms = "Musketeer Pirate [Lv. 1925]"
QuestName = "DeepForestIsland2"
QuestNumber = 2
NameMon = "Musketeer Pirate"
CFrameQuest = CFrame.new(-12680.3818, 389.971039, -9902.01953)
CFrameMon = CFrame.new(-13282.3046875, 496.23684692383, -9565.150390625)
elseif MyLevel >= 1975 and MyLevel <= 1999 then
Ms = "Reborn Skeleton [Lv. 1975]"
QuestName = "HauntedQuest1"
QuestNumber = 1
NameMon = "Reborn Skeleton"
CFrameQuest = CFrame.new(-9480.8271484375, 142.13066101074, 5566.0712890625)
CFrameMon = CFrame.new(-8817.880859375, 191.16761779785, 6298.6557617188)
elseif MyLevel >= 2000 and MyLevel <= 2024 then
Ms = "Living Zombie [Lv. 2000]"
QuestName = "HauntedQuest1"
QuestNumber = 2
NameMon = "Living Zombie"
CFrameQuest = CFrame.new(-9480.8271484375, 142.13066101074, 5566.0712890625)
CFrameMon = CFrame.new(-10125.234375, 183.94705200195, 6242.013671875)
elseif MyLevel >= 2025 and MyLevel <= 2049 then
Ms = "Demonic Soul [Lv. 2025]"
QuestName = "HauntedQuest2"
QuestNumber = 1
NameMon = "Demonic Soul"
CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
CFrameMon = CFrame.new(-9712.03125, 204.69589233398, 6193.322265625)
elseif MyLevel >= 2050 and MyLevel <= 2074 then
Ms = "Posessed Mummy [Lv. 2050]"
QuestName = "HauntedQuest2"
QuestNumber = 2
NameMon = "Posessed Mummy"
CFrameQuest = CFrame.new(-9516.9931640625, 178.00651550293, 6078.4653320313)
CFrameMon = CFrame.new(-9545.7763671875, 69.619895935059, 6339.5615234375)
elseif MyLevel >= 2075 and MyLevel <= 2099 then
Ms = "Peanut Scout [Lv. 2075]"
QuestName = "NutsIslandQuest"
QuestNumber = 1
NameMon = "Peanut Scout"
CFrameQuest = CFrame.new(-2104.35669, 38.1299706, -10194.0654)
CFrameMon = CFrame.new(-2126.40723, 90.5567474, -10301.9639)
elseif MyLevel >= 2100 and MyLevel <= 2124 then
Ms = "Peanut President [Lv. 2100]"
QuestName = "NutsIslandQuest"
QuestNumber = 2
NameMon = "Peanut President"
CFrameQuest = CFrame.new(-2104.35669, 38.1299706, -10194.0654)
CFrameMon = CFrame.new(-2118.75439, 70.3045197, -10509.3223)
elseif MyLevel >= 2125 and MyLevel <= 2149 then
Ms = "Ice Cream Chef [Lv. 2125]"
QuestName = "IceCreamIslandQuest"
QuestNumber = 1
NameMon = "Ice Cream Chef"
CFrameQuest = CFrame.new(-820.218994, 65.8453293, -10966.1689)
CFrameMon = CFrame.new(-685.287781, 96.3186417, -10957.5898)
elseif MyLevel >= 2150 then
Ms = "Ice Cream Commander [Lv. 2150]"
QuestName = "IceCreamIslandQuest"
QuestNumber = 2
NameMon = "Ice Cream Commander"
CFrameQuest = CFrame.new(-820.218994, 65.8453293, -10966.1689)
CFrameMon = CFrame.new(-635.736145, 143.049561, -11335.2236)
end
end
end

-- Улучшенная функция телепорта через Tween
local function TweenToTarget(CFgo)
local hrp = getHRP()
if not hrp then return end
local dist = (hrp.Position - CFgo.Position).Magnitude
local speed = 300
local time = dist / speed
local tweenInfo = TweenInfo.new(time, Enum.EasingStyle.Linear)
local tween = TweenService:Create(hrp, tweenInfo, {CFrame = CFgo})
tween:Play()
end

-- Улучшенная функция поиска мобов
local function findNearestMob()
local hrp = getHRP()
if not hrp then return nil end
local nearest = nil
local minDist = math.huge

-- Сканируем папку Enemies
local enemiesFolder = Workspace:FindFirstChild("Enemies")
if enemiesFolder then
for i, v in pairs(enemiesFolder:GetChildren()) do
if v.Name == Ms and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart") then
local dist = (v.HumanoidRootPart.Position - hrp.Position).Magnitude
if dist < minDist then
nearest = v
minDist = dist
end
end
end
end

-- Если не нашли в Enemies, ищем во всём Workspace
if not nearest then
for i, v in pairs(Workspace:GetDescendants()) do
if v:IsA("Model") and v.Name == Ms then
local hum = v:FindFirstChildOfClass("Humanoid")
local hrp2 = v:FindFirstChild("HumanoidRootPart")
if hum and hrp2 and hum.Health > 0 then
local dist = (hrp2.Position - hrp.Position).Magnitude
if dist < minDist then
nearest = v
minDist = dist
end
end
end
end
end

return nearest, minDist
end

function startAutoLevel()
if ALR then return end
ALR=true
questKills=0
currentQuestData=nil
task.spawn(function()
while ALR and State.AutoLevel do
pcall(function()
local lvl = getLvl()
CheckQuest()

-- Проверяем наличие квеста - ИСПРАВЛЕННАЯ ВЕРСИЯ
local QuestActive = false
pcall(function()
-- Способ 1: Проверяем через Main.Quest
local MainGui = LP.PlayerGui:FindFirstChild("Main")
if MainGui then
local QuestFrame = MainGui:FindFirstChild("Quest")
if QuestFrame and QuestFrame.Visible == true then
QuestActive = true
end
end

-- Способ 2: Ищем любой видимый фрейм с квестом
if not QuestActive then
for _, gui in pairs(LP.PlayerGui:GetChildren()) do
if gui:IsA("ScreenGui") or gui:IsA("Frame") then
for _, child in pairs(gui:GetDescendants()) do
if child.Name == "Quest" and child:IsA("Frame") and child.Visible == true then
QuestActive = true
break
end
end
end
if QuestActive then break end
end
end

-- Способ 3: Проверяем через Remote (самый надёжный)
if not QuestActive then
local questCheck = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("GetQuest")
if questCheck and type(questCheck) == "table" and questCheck[1] then
QuestActive = true
end
end
end)

if not QuestActive then
-- Берём квест
AFS.Text = "🎯 ThomasLua Auto Level\n━━━━━━━━━━━━━━━━━━\nУровень: "..lvl.."\nКвест: "..NameMon.."\nБерём квест..."
TweenToTarget(CFrameQuest)
task.wait(1)

pcall(function()
game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", QuestName, QuestNumber)
end)
task.wait(1)
else
-- Ищем ближайшего моба
local mob, dist = findNearestMob()

if mob and dist then
-- Атакуем моба
AFS.Text = "⚔️ ThomasLua Auto Level\n━━━━━━━━━━━━━━━━━━\nУровень: "..lvl.."\nЦель: "..mob.Name.."\nHP: "..math.floor(mob.Humanoid.Health).." | Дист: "..math.floor(dist)

-- Телепортируемся к мобу
TweenToTarget(mob.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))

-- Магнит эффект
if State.Magnet then
mob.Humanoid.PlatformStand = true
mob.Humanoid.Sit = true
mob.HumanoidRootPart.CanCollide = false
mob.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
mob.HumanoidRootPart.CFrame = getHRP().CFrame
end

-- Атака
equipWeapon()
pcall(function()
VirtualUser:CaptureController()
VirtualUser:Button1Down(Vector2.new(1280, 672))
end)
else
-- Мобы не найдены, идём к точке спавна
AFS.Text = "🔍 ThomasLua Auto Level\n━━━━━━━━━━━━━━━━━━\nУровень: "..lvl.."\nМобы: "..Ms.."\nИдём к точке спавна..."
TweenToTarget(CFrameMon)
end
end
end)
task.wait(0.1)
end
end)
end

function stopAutoLevel()
ALR=false
QuestActive=false
currentQuestData=nil
questKills=0
Ms=""
CFrameQuest=nil
CFrameMon=nil
local hum=getHum()
if hum and getHRP() then hum:MoveTo(getHRP().Position) end
AFS.Text="🛑 Auto Level\n━━━━━━━━━━━━━━━━━━\nВыключен\nОжидание команд..."
end

function scanWorld()
local lines={"СКАНИРОВАНИЕ МИРА","━━━━━━━━━━━━━━━━━━"}
local npcs,mobs,chests,fruits={},{},{},{}
local seen={}
for _,o in ipairs(Workspace:GetDescendants()) do
if o:IsA("Model") and not seen[o] and not isPlayerModel(o) then
local h=o:FindFirstChildOfClass("Humanoid")
if h then
seen[o]=true
local nm=o.Name
if nm:lower():find("quest") or nm:lower():find("npc") then
table.insert(npcs,nm)
else
table.insert(mobs,nm.." (HP:"..math.floor(h.Health)..")")
end
end
if isChest(o) then table.insert(chests,o.Name) end
end
if isFruitImproved(o) then table.insert(fruits,o.Name.." ["..o.ClassName.."]") end
end
local function uniq(t)
local s,u={},{}
for _,v in ipairs(t) do if not s[v] then s[v]=true table.insert(u,v) end end
return u
end
npcs=uniq(npcs);mobs=uniq(mobs);chests=uniq(chests);fruits=uniq(fruits)
table.insert(lines,"NPC: "..#npcs.." шт.")
for i=1,math.min(#npcs,8) do table.insert(lines,"  ├ "..npcs[i]) end
if #npcs>8 then table.insert(lines,"  └ ... и еще "..#npcs-8) end
table.insert(lines,"MOBS: "..#mobs.." шт.")
for i=1,math.min(#mobs,8) do table.insert(lines,"  ├ "..mobs[i]) end
if #mobs>8 then table.insert(lines,"  └ ... и еще "..#mobs-8) end
table.insert(lines,"CHESTS: "..#chests.." шт.")
for i=1,math.min(#chests,5) do table.insert(lines,"  ├ "..chests[i]) end
if #chests>5 then table.insert(lines,"  └ ... и еще "..#chests-5) end
table.insert(lines,"FRUITS: "..#fruits.." шт.")
for i=1,math.min(#fruits,5) do table.insert(lines,"  ├ "..fruits[i]) end
if #fruits>5 then table.insert(lines,"  └ ... и еще "..#fruits-5) end
table.insert(lines,"━━━━━━━━━━━━━━━━━━")
table.insert(lines,"Сканирование завершено")
AFS.Text=table.concat(lines,"\n")
end

function unhook()
State.ChestESP=false
State.FruitESP=false
State.AutoChest=false
State.AutoLevel=false
ACR=false
ALR=false
if stopChestESP then stopChestESP() end
if stopFruitESP then stopFruitESP() end
if stopAutoChest then stopAutoChest() end
if stopAutoLevel then stopAutoLevel() end
local hum=getHum()
if hum and getHRP() then pcall(function() hum:MoveTo(getHRP().Position) end) end
for _,gui in ipairs(CoreGui:GetChildren()) do
if gui.Name=="ThomasLua" then pcall(function() gui:Destroy() end) end
end
end

-- Добавляем версию в футер
local Footer=Instance.new("TextLabel")
Footer.Size=UDim2.new(1,-16,0,24)
Footer.Position=UDim2.new(0,8,1,-28)
Footer.BackgroundTransparency=1
Footer.Text="⚔️ ThomasLua v1.0 Premium | 🎨 Shailushai | 🚀 Modern UI"
Footer.Font=Enum.Font.Gotham
Footer.TextSize=11
Footer.TextColor3=Theme.SubText
Footer.TextXAlignment=Enum.TextXAlignment.Center
Footer.Parent=Main

local HotkeyInfo=Instance.new("TextLabel")
HotkeyInfo.Size=UDim2.new(1,-16,0,16)
HotkeyInfo.Position=UDim2.new(0,8,1,-12)
HotkeyInfo.BackgroundTransparency=1
HotkeyInfo.Text="[Insert] - Меню | [Mouse] - Перетаскивание"
HotkeyInfo.Font=Enum.Font.Gotham
HotkeyInfo.TextSize=10
HotkeyInfo.TextColor3=Theme.SubText
HotkeyInfo.TextXAlignment=Enum.TextXAlignment.Center
HotkeyInfo.Parent=Main

switchPage(AS)
refreshAllThemes()

-- Watermark (Ватермарка)
local Watermark = Instance.new("TextLabel")
Watermark.Name = "Watermark"
Watermark.Size = UDim2.new(0, 180, 0, 30)
Watermark.Position = UDim2.new(1, -190, 0, 10)
Watermark.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Watermark.BackgroundTransparency = 0.3
Watermark.BorderSizePixel = 0
Watermark.Text = "⚔️ ThomasLua v1.0"
Watermark.Font = Enum.Font.GothamBold
Watermark.TextSize = 13
Watermark.TextColor3 = Color3.fromRGB(85, 165, 255)
Watermark.Parent = SG
local WMC = Instance.new("UICorner")
WMC.CornerRadius = UDim.new(0, 8)
WMC.Parent = Watermark
local WMS = Instance.new("UIStroke")
WMS.Color = Color3.fromRGB(85, 165, 255)
WMS.Thickness = 1.5
WMS.Transparency = 0.5
WMS.Parent = Watermark

-- Анимация ватермарки
spawn(function()
while true do
for i = 0.3, 0.7, 0.05 do
pcall(function()
WMS.Transparency = i
end)
task.wait(0.05)
end
for i = 0.7, 0.3, -0.05 do
pcall(function()
WMS.Transparency = i
end)
task.wait(0.05)
end
task.wait(0.3)
end
end)

-- FAST ATTACK SYSTEM
local CombatFrameworkR=nil
local CameraShakerR=nil
pcall(function()
CombatFrameworkR=require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
CameraShakerR=require(game.ReplicatedStorage.Util.CameraShaker)
end)

spawn(function()
game:GetService('RunService').Heartbeat:Connect(function()
if State.FastAttack and CombatFrameworkR then
pcall(function()
CombatFrameworkR.activeController.attacking=false
CombatFrameworkR.activeController.blocking=false
CombatFrameworkR.activeController.timeToNextAttack=tick()-1
CombatFrameworkR.activeController.timeToNextBlock=0
CombatFrameworkR.activeController.increment=3
CombatFrameworkR.activeController.hitboxMagnitude=120
game.Players.LocalPlayer.Character.Stun.Value=0
game.Players.LocalPlayer.Character.Humanoid.Sit=false
VirtualUser:CaptureController()
VirtualUser:Button1Down(Vector2.new(1280,672))
if CameraShakerR then CameraShakerR:Stop() end
end)
end
end)
end)

spawn(function()
for i=1,99999 do
game:GetService('RunService').Heartbeat:Wait()
if State.FastAttack then
VirtualUser:CaptureController()
VirtualUser:Button1Down(Vector2.new(1280,672))
end
end
end)

-- MAGNET SYSTEM
spawn(function()
while true do
pcall(function()
if State.Magnet then
sethiddenproperty(game.Players.LocalPlayer,"SimulationRadius",math.huge)
for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
if v:FindFirstChild("Humanoid") and v.Humanoid.Health>0 and v:FindFirstChild("HumanoidRootPart") then
local dist=(v.HumanoidRootPart.Position-game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
if dist<=350 then
v.Humanoid.PlatformStand=true
v.Humanoid.Sit=true
v.HumanoidRootPart.CanCollide=false
v.HumanoidRootPart.Size=Vector3.new(60,60,60)
v.HumanoidRootPart.CFrame=game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
end
end
end
end
end)
task.wait(0.1)
end
end)
-- Анимация открытия
Main.Position=UDim2.new(0.5,-325,0.5,-275)
Main.Size=UDim2.new(0,650,0,0)
Main.BackgroundTransparency=1
MS.Transparency=1
Shadow.ImageTransparency=1
GlowBorder.BackgroundTransparency=1

spawn(function()
task.wait(0.1)
TweenService:Create(Main,TweenInfo.new(0.6,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,650,0,550)}):Play()
TweenService:Create(Main,TweenInfo.new(0.4),{BackgroundTransparency=0}):Play()
TweenService:Create(MS,TweenInfo.new(0.4),{Transparency=0}):Play()
TweenService:Create(Shadow,TweenInfo.new(0.4),{ImageTransparency=0.75}):Play()
TweenService:Create(GlowBorder,TweenInfo.new(0.5),{BackgroundTransparency=0.85}):Play()
end)

-- Version info
print("==========================================")
print("   ⚔️ THOMASLUA v1.0 PREMIUM LOADED ⚔️")
print("   🎨 Shailushai Theme Active")
print("   🚀 Modern UI with Glassmorphism")
print("   ✅ Auto Level Farm with Quest System")
print("   ✅ Auto Collect Fruits")
print("   ✅ Auto Stats System")
print("   ✅ Improved Fruit ESP")
print("   ✅ Watermark Added")
print("==========================================")