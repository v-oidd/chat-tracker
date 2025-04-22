local Players = game:GetService("Players")
local TextChatService = game:GetService("TextChatService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local MAX_MESSAGES = 1000
local connections = {}

local ChatLoggerGui = Instance.new("ScreenGui")
ChatLoggerGui.Name = "ChatLoggerGui"
ChatLoggerGui.ResetOnSpawn = false
ChatLoggerGui.DisplayOrder = 100

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 330) 
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -165) 
MainFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 36)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ChatLoggerGui

local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 24)
TitleBar.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
TitleBar.BorderSizePixel = 0
TitleBar.Position = UDim2.new(0, 0, 0, 0)
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.AnchorPoint     = Vector2.new(0.5, 0.5)
TitleLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TitleLabel.TextXAlignment  = Enum.TextXAlignment.Center
TitleLabel.TextYAlignment  = Enum.TextYAlignment.Center
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Chat Tracker"
TitleLabel.TextColor3 = Color3.fromRGB(240, 240, 240)
TitleLabel.TextSize = 14
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Center
TitleLabel.Parent = TitleBar

local HelpButton = Instance.new("TextButton")
HelpButton.Name = "HelpButton"
HelpButton.Size = UDim2.new(0, 24, 0, 24)
HelpButton.Position = UDim2.new(1, -48, 0, 0)
HelpButton.BackgroundTransparency = 1
HelpButton.Text = "?"
HelpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
HelpButton.TextSize = 17
HelpButton.Font = Enum.Font.SourceSansBold
HelpButton.Parent = TitleBar

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Position = UDim2.new(1, -24, 0, 0)
CloseButton.BackgroundTransparency = 1
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 17
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Parent = TitleBar

local HelpPanel = Instance.new("Frame")
HelpPanel.Name = "HelpPanel"
HelpPanel.Size = UDim2.new(1, -10, 1, -64) 
HelpPanel.Position = UDim2.new(0, 5, 0, 29)
HelpPanel.BackgroundColor3 = Color3.fromRGB(40, 40, 42)
HelpPanel.BorderSizePixel = 0
HelpPanel.Visible = false
HelpPanel.Parent = MainFrame

local HelpScrollFrame = Instance.new("ScrollingFrame")
HelpScrollFrame.Name = "HelpScrollFrame"
HelpScrollFrame.Size = UDim2.new(1, -10, 1, -10)
HelpScrollFrame.Position = UDim2.new(0, 5, 0, 5)
HelpScrollFrame.BackgroundTransparency = 1
HelpScrollFrame.BorderSizePixel = 0
HelpScrollFrame.ScrollBarThickness = 8
HelpScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
HelpScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
HelpScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
HelpScrollFrame.Parent = HelpPanel

local HelpContentLayout = Instance.new("UIListLayout")
HelpContentLayout.Name = "HelpContentLayout"
HelpContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
HelpContentLayout.Padding = UDim.new(0, 10)
HelpContentLayout.Parent = HelpScrollFrame

local SearchBarFrame = Instance.new("Frame")
SearchBarFrame.Name = "SearchBarFrame"
SearchBarFrame.Size = UDim2.new(1, -10, 0, 24)
SearchBarFrame.Position = UDim2.new(0, 5, 0, 28)
SearchBarFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 52)
SearchBarFrame.BorderSizePixel = 0
SearchBarFrame.Parent = MainFrame

local SearchBar = Instance.new("TextBox")
SearchBar.Name = "SearchBar"
SearchBar.Size = UDim2.new(1, -10, 1, -4)
SearchBar.Position = UDim2.new(0, 5, 0, 2)
SearchBar.BackgroundTransparency = 1
SearchBar.Text = ""
SearchBar.PlaceholderText = "Search..."
SearchBar.TextColor3 = Color3.fromRGB(240, 240, 240)
SearchBar.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
SearchBar.TextSize = 14
SearchBar.Font = Enum.Font.SourceSans
SearchBar.TextXAlignment = Enum.TextXAlignment.Left
SearchBar.ClearTextOnFocus = false
SearchBar.Parent = SearchBarFrame

local ChatLogScrollFrame = Instance.new("ScrollingFrame")
ChatLogScrollFrame.Name = "ChatLogScrollFrame"
ChatLogScrollFrame.Size = UDim2.new(1, -10, 1, -90) 
ChatLogScrollFrame.Position = UDim2.new(0, 5, 0, 56)
ChatLogScrollFrame.BackgroundColor3 = Color3.fromRGB(34, 34, 36)
ChatLogScrollFrame.BorderSizePixel = 0
ChatLogScrollFrame.ScrollBarThickness = 8
ChatLogScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
ChatLogScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
ChatLogScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ChatLogScrollFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Name = "UIListLayout"
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 2)
UIListLayout.Parent = ChatLogScrollFrame

local ControlBar = Instance.new("Frame")
ControlBar.Name = "ControlBar"
ControlBar.Size = UDim2.new(1, 0, 0, 40) 
ControlBar.Position = UDim2.new(0, 0, 1, -30) 
ControlBar.BackgroundColor3 = Color3.fromRGB(26, 26, 28)
ControlBar.BorderSizePixel = 0
ControlBar.Parent = MainFrame

local ControlLayout = Instance.new("UIListLayout")
ControlLayout.Name = "ControlLayout"
ControlLayout.FillDirection = Enum.FillDirection.Horizontal
ControlLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ControlLayout.VerticalAlignment = Enum.VerticalAlignment.Center
ControlLayout.SortOrder = Enum.SortOrder.LayoutOrder
ControlLayout.Padding = UDim.new(0, 10)
ControlLayout.Parent = ControlBar

local function createControlButton(name, text, order)
    local button = Instance.new("TextButton")
    button.Name = name
    button.Size = UDim2.new(0, 100, 0, 24)
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 52)
    button.BorderSizePixel = 0
    button.Text = text
    button.TextColor3 = Color3.fromRGB(240, 240, 240)
    button.TextSize = 12
    button.Font = Enum.Font.SourceSansBold
    button.LayoutOrder = order
    button.AutoButtonColor = true

    button.Parent = ControlBar
    return button
end

local ColorToggleButton = createControlButton("ColorToggleButton", "Colors: ON", 1)
local HighlightButton = createControlButton("HighlightButton", "Highlight: OFF", 2)
local CopyButton = createControlButton("CopyButton", "Copy Chat", 3)

local ChatMessages = {}
local FilteredMessages = {}
local shouldAutoScroll = true
local colorCodingEnabled = true
local highlightEnabled = false

local function track(conn)
    table.insert(connections, conn)
    return conn 
end

local function createHelpSection(title, content, layoutOrder)
    local section = Instance.new("Frame")
    section.Name = "HelpSection_" .. title:gsub("%s+", "")
    section.Size = UDim2.new(1, 0, 0, 0)
    section.BackgroundTransparency = 1
    section.LayoutOrder = layoutOrder
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.Parent = HelpScrollFrame

    local sectionTitle = Instance.new("TextLabel")
    sectionTitle.Name = "Title"
    sectionTitle.Size = UDim2.new(1, -16, 0, 24)
    sectionTitle.Position = UDim2.new(0, 5, 0, 0)
    sectionTitle.BackgroundTransparency = 1
    sectionTitle.Text = title
    sectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    sectionTitle.TextSize = 16
    sectionTitle.Font = Enum.Font.SourceSansBold
    sectionTitle.TextXAlignment = Enum.TextXAlignment.Left
    sectionTitle.Parent = section

    local sectionContent = Instance.new("TextLabel")
    sectionContent.Name = "Content"
    sectionContent.Size = UDim2.new(1, -16, 0, 0)  
    sectionContent.Position = UDim2.new(0, 5, 0, 24)  
    sectionContent.BackgroundTransparency = 1
    sectionContent.Text = content
    sectionContent.TextColor3 = Color3.fromRGB(220, 220, 220)
    sectionContent.TextSize = 14
    sectionContent.Font = Enum.Font.SourceSans
    sectionContent.TextXAlignment = Enum.TextXAlignment.Left
    sectionContent.TextYAlignment = Enum.TextYAlignment.Top
    sectionContent.TextWrapped = true
    sectionContent.AutomaticSize = Enum.AutomaticSize.Y
    sectionContent.Parent = section

    return section
end

local function populateHelpContent()
    createHelpSection("Basic Usage", "Press Shift+B to toggle the window\nDrag the title bar to move the window", 1)

    createHelpSection("Search Filters", "You can use special filters in the search bar:\n• Type text to find messages containing that text\n• Use quotes for phrases: \"hello world\"\n• Team filter: %team (e.g., %red)\n• Player filter: ?name (e.g., ?john)\n• Word filter: *word (matches whole word only)", 2)

    createHelpSection("Search Operators", "Combine search terms with operators:\n• AND: requires both terms (e.g., hello AND world)\n• OR: matches either term (e.g., hello OR world)\n• NOT: excludes matches (e.g., hello AND NOT world)\n• Parentheses for grouping: (hello OR hi) AND world\nMultiple terms have an implicit OR between them\nSearches are case insensitive, except operators must be UPPERCASE", 3)

    createHelpSection("Examples", "• Find messages from RedTeam: %red\n• Find messages from player starting with \"J\": ?j\n• Find \"hello\" but not \"world\": hello AND NOT world\n• Find messages about food from Team Red: %red AND (pizza OR burger)", 4)

    createHelpSection("Controls", "• Colors: Toggle team color indicators\n• Copy Chat: Copy filtered messages to clipboard\n• Highlight: Toggle highlighting of filtered messages", 5)

    HelpScrollFrame.CanvasSize = UDim2.new(0, 0, 0, HelpContentLayout.AbsoluteContentSize.Y + 10)
end

local function createChatMessageEntry(player, message, teamColor)
    local timeStamp = os.date("%H:%M:%S")
    local teamName = player.Team and player.Team.Name or "No Team"
    local teamColorValue = teamColor or Color3.fromRGB(200, 200, 200)

    local entry = {
        playerName   = player.Name,
        displayName  = player.DisplayName,
        message      = message,
        teamName     = teamName,
        teamColor    = teamColorValue,
        timeStamp    = timeStamp,
        layoutOrder  = #ChatMessages + 1,
        tweened      = false,
    }

    table.insert(ChatMessages, entry)
    if #ChatMessages > MAX_MESSAGES then
        table.remove(ChatMessages, 1)
    end
    return entry
end

local function createMessageElement(messageData)
    local wrapper = Instance.new("Frame")
    wrapper.Name = "MessageWrapper"
    wrapper.Size = UDim2.new(1, 0, 0, 0)
    wrapper.BackgroundTransparency = 1
    wrapper.BorderSizePixel = 0
    wrapper.LayoutOrder = messageData.layoutOrder
    wrapper.AutomaticSize = Enum.AutomaticSize.Y

    local inner = Instance.new("Frame")
    inner.Name = "InnerFrame"
    inner.Size = UDim2.new(1, 0, 0, 20)
    if messageData.tweened then
        inner.Position = UDim2.new(0, 0, 0, 0)
    else
        inner.Position = UDim2.new(-1, 0, 0, 0)
    end
    inner.BackgroundTransparency = 1
    inner.BorderSizePixel = 0
    inner.AutomaticSize = Enum.AutomaticSize.Y
    inner.Parent = wrapper

    local TimeLabel = Instance.new("TextLabel")
    TimeLabel.Name = "TimeLabel"
    TimeLabel.Size = UDim2.new(0, 50, 1, 0)
    TimeLabel.Position = UDim2.new(0, 4, 0, 0)
    TimeLabel.BackgroundTransparency = 1
    TimeLabel.Text = messageData.timeStamp
    TimeLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    TimeLabel.TextSize = 13
    TimeLabel.Font = Enum.Font.SourceSans
    TimeLabel.TextXAlignment = Enum.TextXAlignment.Left
    TimeLabel.Parent = inner

    local TeamColorIndicator = Instance.new("Frame")
    TeamColorIndicator.Name = "TeamColorIndicator"
    TeamColorIndicator.Size = UDim2.new(0, 3, 1, -4)
    TeamColorIndicator.Position = UDim2.new(0, 45, 0, 2)
    TeamColorIndicator.BackgroundColor3 = messageData.teamColor
    TeamColorIndicator.BorderSizePixel = 0
    TeamColorIndicator.Visible = colorCodingEnabled
    TeamColorIndicator.Parent = inner

    local PlayerAndMessage = Instance.new("TextLabel")
    PlayerAndMessage.Name = "PlayerAndMessage"
    PlayerAndMessage.Size = UDim2.new(1, -80, 0, 0)
    local xOffset = colorCodingEnabled and 53 or 45
    PlayerAndMessage.Position = UDim2.new(0, xOffset, 0, 2)
    PlayerAndMessage.BackgroundTransparency = 1
    PlayerAndMessage.Text = string.format("[%s]: %s", messageData.playerName, messageData.message)
    PlayerAndMessage.TextColor3 = Color3.fromRGB(240, 240, 240)
    PlayerAndMessage.TextSize = 14
    PlayerAndMessage.Font = Enum.Font.SourceSans
    PlayerAndMessage.TextXAlignment = Enum.TextXAlignment.Left
    PlayerAndMessage.TextWrapped = true
    PlayerAndMessage.AutomaticSize = Enum.AutomaticSize.Y
    PlayerAndMessage.Parent = inner

    return wrapper
end

local function tokenize(str)
    local tokens = {}
    local i = 1

    while i <= #str do
        local c = str:sub(i,i)

        if c:match("%s") then
            i = i + 1

        elseif (c == "%" or c == "?" or c == "*")
               and (str:sub(i+1,i+1) == '"' or str:sub(i+1,i+1) == "'") then
            local prefix = c
            local quote  = str:sub(i+1,i+1)
            local j      = str:find(quote, i+2, true) or (#str + 1)
            local content= str:sub(i+2, j-1)
            table.insert(tokens, { type = "term", value = prefix .. content })
            i = j + 1

        elseif c == '"' or c == "'" then
            local quote = c
            local j     = str:find(quote, i+1, true) or (#str + 1)
            local content = str:sub(i+1, j-1)
            table.insert(tokens, { type = "term", value = content })
            i = j + 1

        elseif str:sub(i,i+2) == "AND"
               and (i+3 > #str or str:sub(i+3,i+3):match("%s")) then
            table.insert(tokens, { type = "op", value = "AND" })
            i = i + 3

        elseif str:sub(i,i+1) == "OR"
               and (i+2 > #str or str:sub(i+2,i+2):match("%s")) then
            table.insert(tokens, { type = "op", value = "OR" })
            i = i + 2

        elseif str:sub(i,i+2) == "NOT"
               and (i+3 > #str or str:sub(i+3,i+3):match("%s")) then
            table.insert(tokens, { type = "op", value = "NOT" })
            i = i + 3

        elseif c == "(" or c == ")" then
            table.insert(tokens, { type = c })
            i = i + 1

        else
            local j = str:find("[%s%(%)]", i) or (#str + 1)
            local term = str:sub(i, j-1)
            table.insert(tokens, { type = "term", value = term })
            i = j
        end
    end

    local out = {}
    for idx = 1, #tokens do
        table.insert(out, tokens[idx])
        local cur, nxt = tokens[idx], tokens[idx+1]
        if cur and nxt
           and (cur.type == "term" or cur.type == ")")
           and (nxt.type == "term" or nxt.type == "(") then
            table.insert(out, { type = "op", value = "OR" })
        end
    end

    return out
end

local function parseExpression(tokens)
    local pos = 1

    local function peek()
        return tokens[pos]
    end

    local function consume(expected)
        local t = tokens[pos]
        if not t or (expected and t.type ~= expected and t.value ~= expected) then
            error("Parse error, expected "..expected)
        end
        pos = pos + 1
        return t
    end

    local function parsePrimary()
        local t = peek()
        if not t then error("Unexpected EOF") end

        if t.type == "(" then
            consume("(")
            local node = parseExpr()
            consume(")")
            return node

        elseif t.type == "term" then
            consume()
            return { kind = "term", raw = t.value }

        else
            error("Unexpected token in primary: "..t.type)
        end
    end

    local function parseFactor()
        local negations = 0
        while peek() and peek().type == "op" and peek().value == "NOT" do
            consume("op")  
            negations = negations + 1
        end

        local node = parsePrimary()
        if negations % 2 == 1 then
            node = { kind = "not", child = node }
        end
        return node
    end

    local function parseTermRule()
        local node = parseFactor()
        while peek() and peek().type == "op" and peek().value == "AND" do
            consume("op")
            node = { kind = "and", left = node, right = parseFactor() }
        end
        return node
    end

    function parseExpr()
        local node = parseTermRule()
        while peek() and peek().type == "op" and peek().value == "OR" do
            consume("op")
            node = { kind = "or", left = node, right = parseTermRule() }
        end
        return node
    end

    local tree = parseExpr()
    if pos <= #tokens then
        error("Unexpected extra token: "..tokens[pos].value)
    end
    return tree
end

local function matchTerm(msg, raw)

    if raw:sub(1,1) == "\\" then
        raw = raw:sub(2)
        return msg.message:lower():find(raw:lower(),1,true) ~= nil
    end

    local pfx = raw:sub(1,1)
    local term = raw:sub(2):lower()
    if     pfx == "%" then
        return msg.teamName:lower():find(term,1,true)
    elseif pfx == "?" then
        local pl = msg.playerName:lower()
        local dn = msg.displayName:lower()
        return pl:match("^"..term) or dn:match("^"..term)
    elseif pfx == "*" then

        return msg.message:lower():find("%f[%w]"..term.."%f[%W]")
    else

        term = raw:lower()
        return msg.message:lower():find(term,1,true)
    end
end

local function eval(node, msg)
    if node.kind == "term" then
        return matchTerm(msg, node.raw)
    elseif node.kind == "not" then
        return not eval(node.child, msg)
    elseif node.kind == "and" then
        return eval(node.left, msg) and eval(node.right, msg)
    elseif node.kind == "or" then
        return eval(node.left, msg) or eval(node.right, msg)
    else
        error("Unknown AST node: "..tostring(node.kind))
    end
end

local function applyFilters(searchText)

    if searchText:match("^%s*$") then
        FilteredMessages = {}
        for _, msg in ipairs(ChatMessages) do
            table.insert(FilteredMessages, msg)
        end
        return
    end

    local ok, tree = pcall(function()
        local toks = tokenize(searchText)
        return parseExpression(toks)
    end)
    if not ok then

        FilteredMessages = {}
        return
    end

    FilteredMessages = {}
    for _, msg in ipairs(ChatMessages) do
        if eval(tree, msg) then
            table.insert(FilteredMessages, msg)
        end
    end
end

local displayedWrappers = {}

local function updateMessageDisplay()

    local passesFilter = {}
    for _, msg in ipairs(FilteredMessages) do
        passesFilter[msg] = true
    end

    for idx, msgData in ipairs(ChatMessages) do
        local wrapper = displayedWrappers[msgData]
        if not wrapper then
            wrapper = createMessageElement(msgData)
            wrapper.Parent = ChatLogScrollFrame
            displayedWrappers[msgData] = wrapper

            if not msgData.tweened then
                local inner = wrapper:FindFirstChild("InnerFrame")
                TweenService:Create(inner, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Position = UDim2.new(0,0,0,0),
                }):Play()
                msgData.tweened = true
            end
        end

        wrapper.LayoutOrder = idx

        local inner = wrapper:FindFirstChild("InnerFrame")
        local indicator = inner:FindFirstChild("TeamColorIndicator")
        if indicator then
            indicator.Visible = colorCodingEnabled
        end

        local label = inner:FindFirstChild("PlayerAndMessage")
        if label then
            local xOffset = colorCodingEnabled and 53 or 45
            label.Position = UDim2.new(0, xOffset, 0, 2)
        end

        if highlightEnabled then

            wrapper.Visible = true
            if passesFilter[msgData] then
                inner.BackgroundTransparency = 0.8
                inner.BackgroundColor3 = Color3.fromRGB(255,255,0)
            else
                inner.BackgroundTransparency = 1
            end
        else

            inner.BackgroundTransparency = 1
            wrapper.Visible = passesFilter[msgData] == true
        end
    end

    for msgData, wrapper in pairs(displayedWrappers) do
        if not table.find(ChatMessages, msgData) then
            wrapper:Destroy()
            displayedWrappers[msgData] = nil
        end
    end

    ChatLogScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    if shouldAutoScroll then
        local y = math.max(0, UIListLayout.AbsoluteContentSize.Y - ChatLogScrollFrame.AbsoluteSize.Y)
        ChatLogScrollFrame.CanvasPosition = Vector2.new(0, y)
    end
end

local function toggleHelpPanel()
    HelpPanel.Visible = not HelpPanel.Visible
    ChatLogScrollFrame.Visible = not HelpPanel.Visible
    SearchBarFrame.Visible = not HelpPanel.Visible

    if HelpPanel.Visible then

        for _, child in pairs(HelpScrollFrame:GetChildren()) do
            if child:IsA("Frame") then
                child:Destroy()
            end
        end
        populateHelpContent()
    end
end

local function copyChatsToClipboard()
    local textToCopy = ""

    if colorCodingEnabled then
        for _, msgData in ipairs(FilteredMessages) do
            textToCopy = textToCopy .. string.format("[%s] [%s] [%s]: %s\n", 
                msgData.timeStamp, 
                msgData.teamName, 
                msgData.playerName, 
                msgData.message)
        end
    else 
        for _, msgData in ipairs(FilteredMessages) do
            textToCopy = textToCopy .. string.format("[%s] [%s]: %s\n", 
                msgData.timeStamp,  
                msgData.playerName, 
                msgData.message)
        end
    end

    if textToCopy == "" then
        textToCopy = "No messages to copy."
    end

    pcall(function()
        setclipboard(textToCopy)
    end)

    local originalColor = CopyButton.BackgroundColor3
    CopyButton.Text = "Copied!"
    task.wait(0.5)
    CopyButton.Text = "Copy Chat"
end

local function toggleHighlight()
    highlightEnabled = not highlightEnabled
    HighlightButton.Text = "Highlight: " .. (highlightEnabled and "ON" or "OFF")
    updateMessageDisplay()
end

local function toggleColorCoding()
    colorCodingEnabled = not colorCodingEnabled
    ColorToggleButton.Text = "Colors: " .. (colorCodingEnabled and "ON" or "OFF")

    for _, wrapper in pairs(displayedWrappers) do
        local inner = wrapper:FindFirstChild("InnerFrame")
        local teamIndicator = inner and inner:FindFirstChild("TeamColorIndicator")
        if teamIndicator then
            teamIndicator.Visible = colorCodingEnabled
        end

        local label = inner and inner:FindFirstChild("PlayerAndMessage")
        if label then
            local xOffset = colorCodingEnabled and 53 or 45
            label.Position = UDim2.new(0, xOffset, 0, 2)
        end
    end
end

local function initChatLogger()
    track(TextChatService.MessageReceived:Connect(function(textChatMessage)
        local player = Players:GetPlayerByUserId(textChatMessage.TextSource.UserId)
        if player then
            local teamColor = player.Team and player.Team.TeamColor.Color or Color3.fromRGB(200, 200, 200)
            createChatMessageEntry(player, textChatMessage.Text, teamColor)

            applyFilters(SearchBar.Text)
            updateMessageDisplay()
        end
    end))

    track(SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
        applyFilters(SearchBar.Text)
        updateMessageDisplay()
    end))

    track(ChatLogScrollFrame.Changed:Connect(function(property)
        if property == "CanvasPosition" then
            local scrollPos = ChatLogScrollFrame.CanvasPosition.Y
            local canvasSize = ChatLogScrollFrame.CanvasSize.Y.Offset
            local frameSize = ChatLogScrollFrame.AbsoluteSize.Y
            if canvasSize <= frameSize or (canvasSize - (scrollPos + frameSize)) < 20 then
                shouldAutoScroll = true
            else
                shouldAutoScroll = false
            end
        end
    end))

    local mouse = LocalPlayer:GetMouse()

    track(CloseButton.MouseEnter:Connect(function()
        mouse.Icon = "rbxasset://SystemCursors/PointingHand"
    end))

    track(CloseButton.MouseLeave:Connect(function()
        mouse.Icon = ""
    end))

    CloseButton.MouseButton1Click:Connect(function()
        for _, conn in ipairs(connections) do
            conn:Disconnect()
        end
        ChatLoggerGui:Destroy()
        ChatMessages = {}
        FilteredMessages = {}
        connections = {}
    end)

    track(HelpButton.MouseEnter:Connect(function()
        mouse.Icon = "rbxasset://SystemCursors/PointingHand"
    end))

    track(HelpButton.MouseLeave:Connect(function()
        mouse.Icon = ""
    end))

    track(HelpButton.MouseButton1Click:Connect(toggleHelpPanel))

    track(ColorToggleButton.MouseButton1Click:Connect(toggleColorCoding))

    track(CopyButton.MouseButton1Click:Connect(copyChatsToClipboard))

    track(HighlightButton.MouseButton1Click:Connect(toggleHighlight))

    local buttons = {ColorToggleButton, CopyButton, HighlightButton}
    for _, button in ipairs(buttons) do
        track(button.MouseEnter:Connect(function()
            mouse.Icon = "rbxasset://SystemCursors/PointingHand"
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(70, 70, 72)
            }):Play()
        end))

        track(button.MouseLeave:Connect(function()
            mouse.Icon = ""
            TweenService:Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 52)
            }):Play()
        end))
    end

    local dragging = false
    local dragStart
    local startPos

    track(TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end))

    track(UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end))

    track(UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and dragging then
            dragging = false
        end
    end))

    track(UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end

        if input.KeyCode == Enum.KeyCode.B and UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            ChatLoggerGui.Enabled = not ChatLoggerGui.Enabled

            if ChatLoggerGui.Enabled and HelpPanel.Visible then
                toggleHelpPanel()
            end
        end
    end))

    ChatLoggerGui.Parent = CoreGui
end

initChatLogger()
