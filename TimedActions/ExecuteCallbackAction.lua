---@class ExecuteCallbackAction: ISBaseTimedAction
---@field callback function
ExecuteCallbackAction = ISBaseTimedAction:derive("ExecuteCallbackAction");

---Execute function even when queue is canceled
---@param character IsoPlayer
---@param callback function
---@return ISBaseTimedAction
function ExecuteCallbackAction:new(character, callback)
    local o = ISBaseTimedAction.new(self, character);
    ---@type function
    o.callback = callback;
    o.stopOnWalk = false;
    o.stopOnRun = false;
    o.maxTime = -1;
    return o
end

function ExecuteCallbackAction:isValid()
    return true
end

function ExecuteCallbackAction:update()
    self:perform()
end

function ExecuteCallbackAction:perform()
    self.callback();
    ISBaseTimedAction.perform(self);
end

function ExecuteCallbackAction:forceCancel()
    self.callback();
end
