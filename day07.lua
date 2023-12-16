---@class Hand
---@field cards string[]
---@field bet number

---@field table
---@return number
function count(items)
    local i = 0
    for _, _ in pairs(items) do
        i = i + 1
    end
    return i
end

---@field items table
---@return table
function to_array(items)
    local arr = {}
    for _, value in pairs(items) do
        table.insert(arr, value)
    end
    table.sort(arr)
    return arr
end

---@field cards string[]
---@return table
function group_cards(cards)
    local labels = {}
    for i = 1, #cards do
        if labels[cards[i]] then
            labels[cards[i]] = labels[cards[i]] + 1
        else
            labels[cards[i]] = 1
        end
    end
    return labels
end

---@field cards string[]
---@return number
function get_type_score(cards)
    local group = group_cards(cards)
    local unique_count = count(group)
    local arr = to_array(group)

    if unique_count == 1 then
        return 7
    end

    if unique_count == 2 and arr[1] == 1 then
        return 6
    end

    if unique_count == 2 and arr[1] == 2 then
        return 5
    end

    if arr[#arr] == 3 then
        return 4
    end

    if unique_count == 3 and arr[2] == 2 and arr[3] == 2 then
        return 3
    end

    if arr[#arr] == 2 and arr[#arr - 1] == 1 then
        return 2
    end

    if unique_count == 5 then
        return 1
    end

    return 0
end

---@field card string
---@return number
function to_value(card)
    if card == "A" then
        return 14
    end
    if card == "K" then
        return 13
    end
    if card == "Q" then
        return 12
    end
    if card == "J" then
        return 11
    end
    if card == "T" then
        return 10
    end

    local card_num = tonumber(card)
    if card_num then
        return card_num
    end

    error("unexpected card value: " .. card)
end

---@field hand1 string[]
---@field hand2 string[]
---@return number
function get_highest_hand(hand1, hand2)
    for i = 1, #hand1 do
        if hand1[i] ~= hand2[i] then
            if to_value(hand1[i]) > to_value(hand2[i]) then
                return 1
            else
                return 2
            end
        end
    end
    return 0
end

---@type Hand[]
local hands = {}

for line in io.lines("input/day07") do
    local words = string.gmatch(line, "%w+")
    local cards = words()
    ---@type Hand
    local hand = {
        cards = {},
        bet = tonumber(words()),
    }
    for i = 1, #cards do
        table.insert(hand.cards, cards:sub(i, i))
    end
    table.insert(hands, hand)
end

table.sort(hands, function(a, b)
    local score_a = get_type_score(a.cards)
    local score_b = get_type_score(b.cards)
    if score_a ~= score_b then
        return score_a < score_b
    end
    local high = get_highest_hand(a.cards, b.cards)
    if high == 1 then
        return false
    end
    if high == 2 then
        return true
    end
    return false
end)

local sum1 = 0

for i, hand in ipairs(hands) do
    sum1 = sum1 + (i * hand.bet)
end

print("[01] sum:", sum1)