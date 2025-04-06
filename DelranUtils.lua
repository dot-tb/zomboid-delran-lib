local DelranUtils = {}

---Is the passed InventoryItem a bag ?
---@param item InventoryItem
function DelranUtils.IsBackpack(item)
    return item:IsInventoryContainer() and item:canBeEquipped() == "Back";
end

function DelranUtils.IsMouseOverUI()
    local uis = UIManager.getUI()
    for i = 0, uis:size() - 1 do
        local ui = uis:get(i)
        if ui:isMouseOver() then
            return true;
        end
    end
    return false;
end

---comment
---@param moduleName string
function DelranUtils.GetDebugPrint(moduleName)
    return function(...)
        if isDebugEnabled() then
            print(moduleName, " ", ...);
        end
    end
end

return DelranUtils
