--[[ Running this script on a turtle with saplings in slot 1, bone-meal in slot 2 and coal in slot 16 and a chest behind the turtle for the wood drop off point will create an automatic tree farm. combining this with a chest to the left of the turtle for sapling replenishment and chest to the right for coal replenishment will ensure a long running automated process.]]
 
-- This function lays saplings and applies bone-meal
function plant()
    turtle.select(1)                --selects sapling
    turtle.place()                  --places sapling
    turtle.select(2)                --selects bone-meal
    turtle.place()                  --fertilizes sapling
end

function bonemeal() -- bonemeals the tree (if a sapling is already there but not grown)
    turtle.select(2)
    turtle.place()
end
 
-- This function checks fuel level and refuels
function fuel()
    if turtle.getFuelLevel() < 50 then      --checks fuel level and refuels
        turtle.select(16)
        turtle.refuel(5)            --picks up any saplings that have fallen
    end
    print( turtle.getFuelLevel() .. " fuel left.")  --displays fuel level to user
end

function chop() -- chops the tree
    while turtle.detect() == true do
        turtle.dig()
    end
    --collect()
end

function replenishFuel() -- replenishes bone meal (bone meal chest placed to the right of the turtle)
    if turtle.getItemCount(2) < 16 then
        turtle.turnRight()
        turtle.select(2)
        turtle.suck()
        turtle.turnLeft()
    end
end
    

function replenishSaplings() -- replenishes saplings (sapling chest placed behind turtle)
    if turtle.getItemCount(1) < 16 then
        turtle.turnRight()
        turtle.turnRight()
        turtle.select(1)
        turtle.suck()
        turtle.turnLeft()
        turtle.turnLeft()
    end
end

function replenish()
    replenishFuel()
    replenishSaplings()
end

-- This function empties all collected wood into chest
function empty()
    turtle.turnLeft() 
    for j = 3, 15 do                -- empty slots 3 to 15 into chest
        turtle.select(j)
        turtle.drop()
    end
    turtle.turnRight()
    replenish()
end

-- This function checks to see if the sapling has been fertilized into a full tree
function compare()
    turtle.select(1)
    if turtle.compare() == true then
        return true -- false could indicate that there is no bonemeal or saplings
    else
        return false  
    end
end
 
-- This block triggers the appropriate functions in the correct order.
repeat                          --start loop
    fuel()                      --check fuel
    plant()                     --plant and fertilize tree
    fuel()                      --check fuel again
    
    if compare() == false then          --if tree has grown cut down tree
        chop()
        replenish()
    else                        --if tree hasn't grown display error
        print("tree has not grown, we bone meal again")
        bonemeal()
    end
until 1 > 2                     -- always false creating infinite loop

