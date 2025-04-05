local DelranUtils = {}

---Is the passed InventoryItem a bag ?
---@param item InventoryItem
function DelranUtils.IsBackpack(item)
    -- Patchwork solution to filter InventoryItems that are bags.
    return item:IsInventoryContainer() and item:canBeEquipped() == "Back";
end

return DelranUtils
