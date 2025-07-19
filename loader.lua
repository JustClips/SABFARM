local t={},v,w,x,y,z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s
t[1]=game:GetService("RunService")
t[2]=game:GetService("Players").LocalPlayer
t[3]=game:GetService("TweenService")
t[4]=game:GetService("VirtualUser")
t[5]=game:GetService("UserInputService")
t[6]=false --running
t[7]=""
t[8]={}
t[9]=14 --dots
t[10]=0.19
t[11]=0.39
t[12]=0.32
t[13]=0.70

t[2].Idled:Connect(function()t[4]:CaptureController()t[4]:ClickButton2(Vector2.new())end)

t[14]=Instance.new("ScreenGui")
t[14].Name="bRn"
t[14].Parent=t[2]:WaitForChild("PlayerGui")
t[14].ZIndexBehavior=Enum.ZIndexBehavior.Sibling

t[15]=Instance.new("Frame")
t[15].Size=UDim2.new(0,340,0,210)
t[15].Position=UDim2.new(0.5,-170,0.42,-105)
t[15].BackgroundColor3=Color3.fromRGB(20,32,50)
t[15].BorderSizePixel=0
t[15].AnchorPoint=Vector2.new(0.5,0.5)
t[15].ZIndex=2
t[15].Parent=t[14]
t[15].ClipsDescendants=true
Instance.new("UICorner",t[15]).CornerRadius=UDim.new(0,16)

t[16]=Instance.new("UIGradient",t[15])
t[16].Color=ColorSequence.new({ColorSequenceKeypoint.new(0,Color3.fromRGB(27,68,135)),ColorSequenceKeypoint.new(1,Color3.fromRGB(0,193,255))})
t[16].Rotation=35

t[17]=Instance.new("ImageLabel",t[15])
t[17].BackgroundTransparency=1
t[17].Image="rbxassetid://4996891970"
t[17].Size=UDim2.new(1,25,1,25)
t[17].Position=UDim2.new(-0.04,0,-0.08,0)
t[17].ImageColor3=Color3.fromRGB(0,194,255)
t[17].ImageTransparency=0.93
t[17].ZIndex=0

t[18]=Instance.new("Frame",t[15])
t[18].Name="bg"
t[18].Size=UDim2.new(1,0,1,0)
t[18].Position=UDim2.new(0,0,0,0)
t[18].BackgroundTransparency=1
t[18].ZIndex=1

do
    local aa,bb,cc,dd
    t[15].InputBegan:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseButton1 then
            dd=true;bb=input.Position;cc=t[15].Position
            input.Changed:Connect(function()
                if input.UserInputState==Enum.UserInputState.End then dd=false end
            end)
        end
    end)
    t[15].InputChanged:Connect(function(input)
        if input.UserInputType==Enum.UserInputType.MouseMovement then aa=input end
    end)
    t[5].InputChanged:Connect(function(input)
        if input==aa and dd then
            local delta=input.Position-bb
            t[15].Position=UDim2.new(cc.X.Scale,cc.X.Offset+delta.X,cc.Y.Scale,cc.Y.Offset+delta.Y)
        end
    end)
end

t[19]=Instance.new("TextLabel",t[15])
t[19].Size=UDim2.new(1,0,0,38)
t[19].BackgroundTransparency=1
t[19].Font=Enum.Font.GothamBold
t[19].Text="Brainrot AFK Farm"
t[19].TextColor3=Color3.fromRGB(180,235,255)
t[19].TextStrokeTransparency=0.9
t[19].TextSize=22
t[19].ZIndex=3

t[20]=Instance.new("TextButton",t[15])
t[20].Size=UDim2.new(0,32,0,32)
t[20].Position=UDim2.new(1,-38,0,6)
t[20].AnchorPoint=Vector2.new(0,0)
t[20].BackgroundTransparency=1
t[20].Text="-"
t[20].TextColor3=Color3.fromRGB(180,235,255)
t[20].Font=Enum.Font.GothamBlack
t[20].TextSize=30
t[20].ZIndex=5

t[21]=Instance.new("TextButton",t[14])
t[21].Size=UDim2.new(0,44,0,44)
t[21].Position=UDim2.new(1,-54,0,-24)
t[21].AnchorPoint=Vector2.new(0,0)
t[21].BackgroundColor3=Color3.fromRGB(32,46,72)
t[21].BackgroundTransparency=0.13
t[21].Text="+"
t[21].TextColor3=Color3.fromRGB(0,220,255)
t[21].Font=Enum.Font.GothamBlack
t[21].TextSize=36
t[21].Visible=false
t[21].ZIndex=100
Instance.new("UICorner",t[21]).CornerRadius=UDim.new(1,0)

t[20].MouseButton1Click:Connect(function()t[15].Visible=false;t[21].Visible=true end)
t[21].MouseButton1Click:Connect(function()t[15].Visible=true;t[21].Visible=false;t[15].ZIndex=t[15].ZIndex+1 end)

t[22]=Instance.new("TextBox",t[15])
t[22].Text=""
t[22].PlaceholderText="e.g Noobini Pizzanini"
t[22].Size=UDim2.new(1,-40,0,34)
t[22].Position=UDim2.new(0,20,0,48)
t[22].BackgroundColor3=Color3.fromRGB(32,46,72)
t[22].Font=Enum.Font.Gotham
t[22].TextColor3=Color3.fromRGB(0,180,255)
t[22].PlaceholderColor3=Color3.fromRGB(98,180,255)
t[22].TextSize=18
t[22].ClearTextOnFocus=false
t[22].ZIndex=3
Instance.new("UICorner",t[22]).CornerRadius=UDim.new(0,8)

t[23]=Instance.new("TextButton",t[15])
t[23].Size=UDim2.new(0.42,0,0,36)
t[23].Position=UDim2.new(0.08,0,0,104)
t[23].BackgroundColor3=Color3.fromRGB(0,140,255)
t[23].Font=Enum.Font.GothamBold
t[23].Text="Start"
t[23].TextColor3=Color3.fromRGB(255,255,255)
t[23].TextSize=20
t[23].AutoButtonColor=false
t[23].ZIndex=3
Instance.new("UICorner",t[23]).CornerRadius=UDim.new(0,8)

t[24]=Instance.new("TextButton",t[15])
t[24].Size=UDim2.new(0.42,0,0,36)
t[24].Position=UDim2.new(0.50,8,0,104)
t[24].BackgroundColor3=Color3.fromRGB(0,180,200)
t[24].Font=Enum.Font.GothamBold
t[24].Text="Stop"
t[24].TextColor3=Color3.fromRGB(255,255,255)
t[24].TextSize=20
t[24].AutoButtonColor=false
t[24].ZIndex=3
Instance.new("UICorner",t[24]).CornerRadius=UDim.new(0,8)

t[25]=Instance.new("TextLabel",t[15])
t[25].Size=UDim2.new(1,-24,0,32)
t[25].Position=UDim2.new(0,12,0,158)
t[25].BackgroundTransparency=1
t[25].Font=Enum.Font.Gotham
t[25].Text=""
t[25].TextColor3=Color3.fromRGB(170,230,255)
t[25].TextSize=18
t[25].ZIndex=3

-- Animated dots
local dots,vels,glows={}, {}, {}
function a()
    for _,v in pairs(t[18]:GetChildren()) do if v:IsA("Frame")then v:Destroy()end end
    dots,vels,glows = {}, {}, {}
    local sz = t[18].AbsoluteSize
    for i=1,t[9] do
        local d=Instance.new("Frame")
        local sz2=math.random(5,10)
        d.Size=UDim2.new(0,sz2,0,sz2)
        d.BackgroundTransparency=0.13
        d.BackgroundColor3=Color3.fromRGB(100+math.random(60),200,255)
        d.BorderSizePixel=0
        d.ZIndex=2
        d.AnchorPoint=Vector2.new(0.5,0.5)
        d.Position=UDim2.new(0,math.random(15,math.max(15,sz.X-15)),0,math.random(15,math.max(15,sz.Y-15)))
        d.Parent=t[18]
        Instance.new("UICorner",d).CornerRadius=UDim.new(1,0)
        local img=Instance.new("ImageLabel",d)
        img.BackgroundTransparency=1
        img.Image="rbxassetid://4996891970"
        img.ImageColor3=Color3.fromRGB(170,220,255)
        img.Size=UDim2.new(1,11,1,11)
        img.Position=UDim2.new(0.5,-5,0.5,-5)
        img.AnchorPoint=Vector2.new(0.5,0.5)
        img.ImageTransparency=0.63
        img.ZIndex=1
        local vx=(math.random()-0.5)*(t[11]-t[10])+(math.random()>0.5 and t[11] or -t[11])
        local vy=(math.random()-0.5)*(t[11]-t[10])+(math.random()>0.5 and t[11] or -t[11])
        table.insert(dots,d)
        table.insert(vels,{vx=vx,vy=vy})
        table.insert(glows,img)
    end
end
t[18]:GetPropertyChangedSignal("AbsoluteSize"):Connect(a)
a()
t[1].RenderStepped:Connect(function(dt)
    local sz = t[18].AbsoluteSize
    for i,d in ipairs(dots) do
        local pos = d.Position
        local px,py = pos.X.Offset,pos.Y.Offset
        local v = vels[i]
        local smin,smax = t[6] and t[12] or t[10], t[6] and t[13] or t[11]
        local tglow = t[6] and 0.30 or 0.63
        local cglow = glows[i].ImageTransparency
        glows[i].ImageTransparency = cglow + (tglow-cglow)*0.15
        if math.random()<0.017 then
            v.vx=(math.random()-0.5)*(smax-smin)+(math.random()>0.5 and smax or -smax)
            v.vy=(math.random()-0.5)*(smax-smin)+(math.random()>0.5 and smax or -smax)
        end
        px=px+v.vx*32*dt
        py=py+v.vy*32*dt
        if px<10 then px=sz.X-12 end
        if px>sz.X-10 then px=12 end
        if py<10 then py=sz.Y-12 end
        if py>sz.Y-10 then py=12 end
        d.Position=UDim2.new(0,px,0,py)
    end
end)

function b(n,pi)local f=workspace:FindFirstChild("RenderedMovingAnimals")if not f then return nil end
for _,a in ipairs(f:GetChildren())do if a.Name==n and not pi[a]then return a end end return nil end
function c(a)if a.PrimaryPart then return a.PrimaryPart.Position else for _,p in ipairs(a:GetDescendants())do if p:IsA("BasePart")then return p.Position end end end;return nil end
function d()
    local c=t[2].Character or t[2].CharacterAdded:Wait()
    local r=c:FindFirstChild("HumanoidRootPart")if not r then return nil end;local cp=nil;local cd=20
    for _,pr in ipairs(workspace:GetDescendants())do if pr:IsA("ProximityPrompt")and pr.Enabled then
        local pz=nil;if pr.Parent:IsA("BasePart")then pz=pr.Parent.Position elseif pr.Parent:IsA("Attachment")then pz=pr.Parent.WorldPosition end
        if pz then local dist=(r.Position-pz).Magnitude;if dist<cd then cd=dist;cp=pr end end end end;return cp end
function e(p)local c=t[2].Character;if not c then return end;local h=c:FindFirstChildOfClass("Humanoid")if h then h:MoveTo(p)end end

local conn
function f()
    if t[6] then t[23].Text="Looking for \""..(#t[7]>0 and t[7] or "???").."\"";t[24].Text="Stop"
    else t[23].Text="Start";t[24].Text="Paused"end
end
f()
t[22].FocusLost:Connect(function()t[7]=t[22].Text;if t[6] then f()end end)
t[23].MouseButton1Click:Connect(function()
    t[6]=true
    t[8]={}
    t[7]=t[22].Text
    f()
    t[25].Text="Looking for \""..(#t[7]>0 and t[7] or "???").."\"..."
    t[25].TextColor3=Color3.fromRGB(80,255,220)
    if conn then conn:Disconnect()end
    conn=t[1].RenderStepped:Connect(function()
        if t[6] and #t[7]>0 then
            local animal=b(t[7],t[8])
            if animal then
                local pos=c(animal)
                if pos then
                    local chr=t[2].Character
                    if chr and chr:FindFirstChild("HumanoidRootPart") then
                        local root=chr.HumanoidRootPart
                        local dist=(root.Position-pos).Magnitude
                        if dist>5 then e(pos)
                        elseif dist<=20 then
                            if not t[8][animal] then
                                local prompt=d()
                                if prompt then
                                    t[8][animal]=true
                                    fireproximityprompt(prompt,2.1)
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end)
t[24].MouseButton1Click:Connect(function()
    t[6]=false
    f()
    t[25].Text=""
    if conn then conn:Disconnect()end
end)
t[5].InputBegan:Connect(function(input,gp)if not gp and input.KeyCode==Enum.KeyCode.RightShift then t[14].Enabled=not t[14].Enabled end end)
