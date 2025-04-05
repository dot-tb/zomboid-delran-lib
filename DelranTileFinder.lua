---@class DelranTileFinder
local DelranTileFinder = {}

---@param player IsoPlayer
function DelranTileFinder:New(player)
    self.player = player;
    return self;
end

---@param directionsToTest IsoDirections[]
---@param destionationSquare IsoGridSquare
function DelranTileFinder.TestAdjacentSquares(directionsToTest, destionationSquare, results)
    for _, direction in ipairs(directionsToTest) do
        local square = destionationSquare:getAdjacentSquare(direction);
        -- for each of them, test that square then if it's 'adjacent' then add it to the table for picking.
        if square:isFree(false) and AdjacentFreeTileFinder.privTrySquare(destionationSquare, square, {}) then
            table.insert(results, square);
        end
    end
end

---comment
---@param destionationSquare IsoGridSquare
---@return IsoGridSquare|nil
function DelranTileFinder:Find(destionationSquare)
    ---@type IsoGridSquare[]
    local choices = {};
    ---@type IsoDirections[]
    local directions = { IsoDirections.W, IsoDirections.E, IsoDirections.N, IsoDirections.S };
    self.TestAdjacentSquares(directions, destionationSquare, choices);

    -- only do diags if no other choices.
    if table.isempty(choices) then
        -- now do diags.
        directions = { IsoDirections.NW, IsoDirections.NE, IsoDirections.SW, IsoDirections.SE }
        self.TestAdjacentSquares(directions, destionationSquare, choices);
    end

    -- if we have multiple choices, pick the one closest to the player
    if not table.isempty(choices) then
        local lowestdist = 100000;
        local distchoice = nil;

        for _, possibleSquare in ipairs(choices) do
            local dist = possibleSquare:DistToProper(self.player);
            if dist < lowestdist and possibleSquare:canReachTo(destionationSquare) then
                lowestdist = dist;
                distchoice = possibleSquare;
            end
        end

        return distchoice;
    end
    return nil;
end

---@param square IsoGridSquare
---@return boolean
function DelranTileFinder:IsNextToSquare(square)
    square = luautils.getCorrectSquareForWall(self.player, square);
    local diffX = math.abs(square:getX() + 0.5 - self.player:getX());
    local diffY = math.abs(square:getY() + 0.5 - self.player:getY());
    if diffX <= 1.6 and diffY <= 1.6 and self.player:getSquare():canReachTo(square) then
        return true;
    end
    return false;
end

return DelranTileFinder
