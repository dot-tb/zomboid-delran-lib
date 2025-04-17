local DelranUtils = {}

local debugEnabled = isDebugEnabled();

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
        if debugEnabled then
            print(moduleName, " ", ...);
        end
    end
end

---@param config {[string]: any}
function DelranUtils.ExtractModOptions(config)
    ---@param self ModOptions.Options
    return function(self)
        for k, v in pairs(self.dict) do
            if v.type == "multipletickbox" then
                for i = 1, #v.values do
                    config[(k .. "_" .. tostring(i))] = v:getValue(i)
                end
            elseif v.type == "button" then
                -- do nothing
            else
                config[k] = v:getValue()
            end
        end
    end
end

return DelranUtils
